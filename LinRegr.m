function LinRegr

hMainGui       =  getappdata(0,'hMainGui');

y1             =  str2double(getappdata(hMainGui,'MeanValueSet1'));
y2             =  str2double(getappdata(hMainGui,'MeanValueSet2'));
y3             =  str2double(getappdata(hMainGui,'MeanValueSet3'));
y4             =  str2double(getappdata(hMainGui,'MeanValueSet4'));
y              =  [y1 y2 y3 y4];

xNominal       =  str2double(getappdata(hMainGui,'NominalVoltage'));
x1             =  getappdata(hMainGui,'ValueSet1Voltage');
x2             =  getappdata(hMainGui,'ValueSet2Voltage');
x3             =  getappdata(hMainGui,'ValueSet3Voltage');
x4             =  getappdata(hMainGui,'ValueSet4Voltage');

x              =  [x1 x2 x3 x4];
xInd           =  find(x==xNominal);
yNominal       =  y(xInd);

YnomByYmeas    =  yNominal./y;   
XnomByXmeas    =  (xNominal^2)./(x.^2);

[xData, yData] =  prepareCurveData( XnomByXmeas, YnomByYmeas );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[Ksfitresult, gof, J] = fit( xData, yData, ft );

eq = formula(Ksfitresult); %Formula of fitted equation
parameters = coeffnames(Ksfitresult); % Parameter names
values = coeffvalues(Ksfitresult); % Parameter values
for idx = 1:numel(parameters)
      param = parameters{idx};
      l = length(param);
      loc = regexp(eq, param); 
      while ~isempty(loc)     
          eq = [eq(1:loc-1) num2str(values(idx)) eq(loc+l:end)];
          loc = regexp(eq, param);
      end
end

str_flipped = eq(end:-1:1);  
str_flipped = deblank(str_flipped);  
str = str_flipped(end:-1:1); 

Nstr = strrep(str,'^','.^');
fun = str2func(['@(x)',Nstr]);

setappdata(hMainGui,'KsFitResult',Ksfitresult);
setappdata(hMainGui,'KsFitFunc',fun);
setappdata(hMainGui,'Ksgof',gof);
setappdata(hMainGui,'KsXdata',xData);
setappdata(hMainGui,'KsYdata',yData);

CI = confint(Ksfitresult,0.95);
setappdata(hMainGui,'KsCI',CI);

Jc=J.Jacobian;
covB = inv(Jc'*Jc)*(gof.rmse)^2;
exch = covB(2,2);
covB(2,2) = covB(1,1);
covB(1,1) = exch;
setappdata(hMainGui,'KscovB',covB);





