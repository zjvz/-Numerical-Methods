% Interpolacja funkcjami sklejanymi stopnia trzeciego
close all; clear; clc
x=[-1 0 1 2 3];
y=[1 -1 -2 0 -1];
k1=pi/4;
k2=pi/2+pi/4;
x2=-1:0.1:3;
[f] = splain(x,y,k1,k2,x2)
f_09=f(2)
%%
% przykład Rungego
close all; clear; clc
a=1;
b=-5;
c=6;

x=(-5:0.01:5);
f=1./(1+x.^2);

X2=zeros(1,2);
X4=zeros(1,4);
X6=zeros(1,6);
X8=zeros(1,8);
X10=zeros(1,10);
Y2=zeros(1,2);
Y4=zeros(1,4);
Y6=zeros(1,6);
Y8=zeros(1,8);
Y10=zeros(1,10);

for i=0:2
    X2(i+1)=-5+i*10/2;
    Y2(i+1)=1/(1+X2(i+1)^2);
end

for i=0:4
    X4(i+1)=-5+i*10/4;
    Y4(i+1)=1/(1+X4(i+1)^2);
end

for i=0:6
    X6(i+1)=-5+i*10/6;
    Y6(i+1)=1/(1+X6(i+1)^2);
end

for i=0:8
    X8(i+1)=-5+i*10/8;
    Y8(i+1)=1/(1+X8(i+1)^2);
end

for i=0:10
    X10(i+1)=-5+i*10/10;
    Y10(i+1)=1/(1+X10(i+1)^2);
end
[igrek2] = interp_lagrange(X2,Y2,x);
[igrek4] = interp_lagrange(X4,Y4,x);
[igrek6] = interp_lagrange(X6,Y6,x);
[igrek8] = interp_lagrange(X8,Y8,x);
[igrek10] = interp_lagrange(X10,Y10,x);
subplot(2,3,1) 
plot(x,f,'b');
subplot(2,3,2) 
plot(x,igrek2,'r',X2,Y2,'o');
subplot(2,3,3) 
plot(x,igrek4,'r',X4,Y4,'o');
subplot(2,3,4) 
plot(x,igrek6,'r',X6,Y6,'o');
subplot(2,3,5) 
plot(x,igrek8,'r',X8,Y8,'o');
subplot(2,3,6) 
plot(x,igrek10,'r',X10,Y10,'o');

k1=0;
k2=0;

[f1] = splain(X2,Y2,k1,k2,x);
[f2] = splain(X4,Y4,k1,k2,x);
[f3] = splain(X6,Y6,k1,k2,x);
[f4] = splain(X8,Y8,k1,k2,x);
[f5] = splain(X10,Y10,k1,k2,x);
figure;
subplot(2,3,1) 
plot(x,f,'b');
subplot(2,3,2) 
plot(x,f1,'r',X2,Y2,'o');
subplot(2,3,3) 
plot(x,f2,'r',X4,Y4,'o');
subplot(2,3,4) 
plot(x,f3,'r',X6,Y6,'o');
subplot(2,3,5) 
plot(x,f4,'r',X8,Y8,'o');
subplot(2,3,6) 
plot(x,f,'r',X10,Y10,'o');
%%
function[f]=splain(x,y,k1,k2,x2)
n=length(x);
G=zeros(n+2,n+2);
d=zeros(n+2,1);
m=zeros(n+2,1);
G(1:n,1)=1;
G(n+1:n+2,2)=1;
G(n+1,3)=2*x(1);
G(n+2,3)=2*x(n);
G(n+1,4)=3*x(1)^2;
G(n+2,4)=3*x(n)^2;
for i=1:n
    for j=2:4
        G(i,j)=x(i)^(j-1);
    end
    for j=5:n+2
            if((x(i)-x(j-3))>0)
                G(i,j)=(x(i)-x(j-3))^3;
            end
    end
end 
for j=5:n+2
    if(x(1)-x(j-3)>0)
            G(n+1,j)=3*(x(1)-x(j-3))^2; 
    end
end 
for j=5:n+2
    if(x(n)-x(j-3)>0)
            G(n+2,j)=3*(x(n)-x(j-3))^2; 
    end
end
d(1:n,1)=y;
d(n+1,1)=tan(k1);
d(n+2,1)=tan(k2);
m=inv(G)*d;

i=1;
f=zeros(size(x2));
for x3=x2
    suma=0;
    k=2;
    while x3>x(k)
        suma=suma+m(k+3)*(x3-x(k))^3;
        k=k+1;
    end
    f(i)=m(1)+m(2)*x3+m(3)*x3*x3+m(4)*x3^3+suma;
    i=i+1;
end

plot(x2,f,'r',x,y,'bo')
end

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
igrek=suma;
end