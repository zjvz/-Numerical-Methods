%Interpolacja Lagrange'a
close all; clear; clc
x=[1 2 3];
y=[0 1 4];
iks=[1, 1.5];
iksCheck=2:0.1:4;
[igrek] = interp_lagrange(x,y,iks)
[igrekCkeck] = interp_lagrange(x,y,iksCheck)
%%
%Interpolacja Newtona
close all; clear; clc
x=[0 2 3 4 6];
y=[1 3 2 5 7];
iks=[1, 1.5];
iksCheck=2:0.1:4;
[igrek] = interp_newton(x,y,iks)
[igrekCkeck] = interp_newton(x,y,iksCheck)
%%
%Interpolacja Lagrange'a - cd
%close all; clear; clc
%daneG = load('G.txt');
%daneH=load('H.txt');

%plot(daneG(1,:), daneG(2,:), 'ro', daneH(1,:), daneH(2,:), 'bs')
%legend

%iks=-9:0.1:9;
%[igrekG] = interp_lagrange(daneG(1,:),daneG(2,:),iks)
%[igrekH] = interp_lagrange(daneH(1,:),daneH(2,:),iks)

%plot(daneG(1,:), daneG(2,:), 'ro', daneH(1,:), daneH(2,:), 'bs', iks, igrekG, 'r.', iks, igrekH, 'b.')
%legend
%%
function [igrek] = interp_lagrange(x,y,iks)
n=length(x);
suma=0;
for i=1:n
    iloczyn1=1;
    iloczyn2=1;
    for k=1:n
        if(k~=i)
            iloczyn1=iloczyn1.*(iks-x(k));
            iloczyn2=iloczyn2.*(x(i)-x(k));
        end
    end
    suma=suma+y(i)*iloczyn1/iloczyn2;
end
igrek=suma
end

function [igrek] = interp_newton(x,y,iks)
n=length(x);
p=zeros(n,n-1);
for k=1:n-1
    p(k,1)=(y(k+1)-y(k))/(x(k+1)-x(k));
end
for i=2:n
    for k=1:n-i
        p(k,i)=(p(k+1,i-1)-p(k,i-1))/(x(k+i)-x(k));
    end
end
suma=y(1);
iloczyn=1;
for i=1:n-1
    iloczyn=iloczyn.*(iks-x(i));
    suma=suma+p(1,i).*iloczyn;
end
igrek=suma
end    