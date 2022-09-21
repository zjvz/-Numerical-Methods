%Aproksymacja średniokwadratowa
close all; clear; clc
x = [-2,-1,0,1,2];
y = [4,1,0,1,4];
x3 = [-3 ,  -2,    -1,     0 ,    1,     2,     3];
y3 = [-13.5092,   15.0143,   15.6399,   11.9732,    2.1204,    7.1199,   22.1617];
[m] = aprok_sred(x,y,2)
[m3] = aprok_sred(x3,y3,3)
%%
% Aproksymacja trygonometryczna
close all; clear; clc
x1 = [0    1.5708    3.1416    4.7124];
y1 = [0     3     4     1];
T1=2*pi;

x = [0    0.7854    1.5708    2.3562    3.1416    3.9270    4.7124    5.4978];
y= [4.0000    1.2929   -1.0000    1.2929    4.0000    2.7071    1.0000    2.7071];
T=2*pi;

[A01, A1, B1] = aproksymacja_trygonometryczna(x1,y1, T1)
[A0, A, B] = aproksymacja_trygonometryczna(x,y, T)
%%
function [m] = aprok_sred(x,y,stop)
N=length(x);
G=zeros(N,stop+1);
m=zeros(stop+1,1);
G(:,1)=1;
for j=2:stop+1
    for i=1:N
        G(i,j)=x(i)^(j-1);
    end
end
d=y';
m=inv(G'*G)*(G'*d);
end

function [A0, A, B] = aproksymacja_trygonometryczna(x,y, T)
N=length(x);
w=2*pi/T;
if rem(N,2)==0
    m=(N-2)/2;
else
    m=(N-1)/2;
end
A0=0;
A=zeros(m,1);
B=zeros(m,1);
for i=1:N
    A0=A0+y(i);
end
A0=1/N*A0;
for i=1:m
    suma=0;
    for j=1:N
        suma=suma+y(j)*cos(2*pi/N*(j-1)*i);
    end
    A(i,1)=suma*2/N;
end

for i=1:m
    suma=0;
    for j=1:N
        suma=suma+y(j)*sin(2*pi/N*(j-1)*i);
    end
    B(i,1)=suma*2/N;
end
end