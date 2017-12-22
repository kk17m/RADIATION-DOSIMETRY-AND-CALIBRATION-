[file, path] = uigetfile('*.csv');
filePath=fullfile(path,file);
if path~=0
    rdtbl = readtable(filePath);
end
fclose('all');

N=size(rdtbl,1);           % number of positive valued bins
n= 0:1:N-1;

hMainGui = getappdata(0,'hMainGui');
Enrgy = table2array(rdtbl(:,2))'; % Col-1 = Channel, Col-2 = Energy, Col-3 = Counts
if any(Enrgy(:,1)<0) 
   fprintf('Please ensure that the energy values are nonnegative. \n');
   setappdata(hMainGui,'ErrorText','ERROR: Please ensure that the energy values are nonnegative.');
   Error;
end
E_max = max(Enrgy);    % eV
E_min = min(Enrgy(Enrgy>0));  % eV
Del_E = (E_max-E_min)/(N-1);  % eV energy bin
E_n = E_min+ n*Del_E;  
E = E_min:Del_E:E_max;

for n = 1:1:N
    for num = 1:1:length(E);
        if  abs(E(num) - E_n(n)) > Del_E
            Phi_n(n,num)= 0;
        else if (E_n(n) - Del_E <= E(num)) && (E(num) <= E_n(n))
                Phi_n(n,num)= 1 + (E(num) - E_n(n))/Del_E;
            else if (E_n(n) <= E(num)) && (E(num) <= E_n(n) + Del_E)
                    Phi_n(n,num)= 1 - (E(num) - E_n(n))/Del_E;
                end
            end
        end
    end
end

density = 1.225*10^-3; % g/cm^3
mass_att_coeff  = PhotonAttenuation('AIR', E./10^6, 'mac'); % mu/rho cm^2/g, Input: energy eV
mu_E =  mass_att_coeff.*density; % (mu/rho)*rho 1/cm
for n = 1:1:N
    A_mn(1,n) = sum(Phi_n(n,:));
end

% Initial coeff c^(0)_n assumption
% Inner product <a,b> = sum(a_i*b_i), Matlab equivalent: sum(a.*b) or a*b'
% Where both a, b are nx1 dimensional.

S=table2array(rdtbl(:,3));

% Ax=b in phi basis
coeff_phi = Phi_n'\S;                 % c^(0)_n
S_phi_check = (coeff_phi'*Phi_n)';

c_n=coeff_phi;

e = sum(A_mn, 1).';
k = 100;  % Iterations
d =  1176138.15; % ICRestimated*RealTime or Best: ICR*RealTime, Units: IC counts

for i = 1 : k
    c_n = c_n .* (A_mn.' * (d ./ (A_mn * c_n)) ./ e);
end

c_n(isnan(c_n))=0;

sss=c_n'*Phi_n;
sss=sss';
plot(E,sss,'b',E,S,'ko')