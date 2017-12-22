function EndEffLinRegr

hMainGui       =  getappdata(0,'hMainGui');

DetRespData    = getappdata(hMainGui,'DetRespData');

if isempty(DetRespData)
       fprintf('Detector response data is missing. Make sure no field in this section is left empty\n');
       setappdata(hMainGui,'ErrorText','ERROR: Detector response data is missing. Make sure no field in this section is left empty.');
       Error;
end
 
DetRespDataxData = DetRespData(1:ceil(end/2));
DetRespDatayData = DetRespData((ceil(end/2)+1):end);
 
[xData, yData] =  prepareCurveData( DetRespDataxData, DetRespDatayData );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[EndEfffitresult, gof, J] = fit( xData, yData, ft );

eq = formula(EndEfffitresult); %Formula of fitted equation
parameters = coeffnames(EndEfffitresult); %All the parameter names
values = coeffvalues(EndEfffitresult); %All the parameter values
for idx = 1:numel(parameters)
      param = parameters{idx};
      l = length(param);
      loc = regexp(eq, param); %Location of the parameter within the string
      while ~isempty(loc)     
          %Substitute parameter value
          eq = [eq(1:loc-1) num2str(values(idx)) eq(loc+l:end)];
          loc = regexp(eq, param);
      end
end

str_flipped = eq(end:-1:1);  %flip the string
str_flipped = deblank(str_flipped);  %remove trailing spaces of the flipped string
str = str_flipped(end:-1:1);  %flip the string back

%fun =@(x)477.5143*exp(-((x-8396.1661)/266.8847).^2) + 412.0656*exp(-((x-9669.5404)/340.3511).^2) +                50.8748*exp(-((x-11180.8614)/384.8118).^2) + 25.9198*exp(-((x-13071.6811)/4983.6562).^2) +                46.2824*exp(-((x-8404.9403)/2084.6962).^2) + 9.8746*exp(-((x-19926.7649)/8826.3528).^2); 
Nstr = strrep(str,'^','.^');
fun = str2func(['@(x)',Nstr]);

setappdata(hMainGui,'EndEffFitResult',EndEfffitresult);
setappdata(hMainGui,'EndEffFitFunc',fun);
setappdata(hMainGui,'EndEffgof',gof);
setappdata(hMainGui,'EndEffXdata',xData);
setappdata(hMainGui,'EndEffYdata',yData);

CI = confint(EndEfffitresult,0.95);
setappdata(hMainGui,'EndEffCI',CI);

Jc=J.Jacobian;
covB = inv(Jc'*Jc)*(gof.rmse)^2;
exch = covB(2,2);
covB(2,2) = covB(1,1);
covB(1,1) = exch;
setappdata(hMainGui,'EndEffcovB',covB);





