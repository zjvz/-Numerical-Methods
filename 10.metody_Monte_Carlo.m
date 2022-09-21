%Generatory liczb pseudolosowych
close all; clear; clc
X=zeros(11,10);
X(1,:)=1;
for i=2:11
    for a=1:10
        X(i,a)=mod(a*X(i-1,a),11);
    end
end  
X
subplot(4,1,1);plot(X(1:9,2),X(2:10,2),'.b')
subplot(4,1,2);plot(X(1:9,8),X(2:10,8),'.r')

x_15=zeros(1,10001);
x_15(1)=15;
for i=2:10001
    x_15(i)=mod(3*x_15(i-1),31);
end
x_15=x_15/31;
a_n=x_15(10001)

x_1=ones(1,10001);
for i=2:10001
    x_1(i)=mod(7^5*x_1(i-1),(2^31-1));
end
x_1=x_1/(2^31-1);
b_n=x_1(10001)

subplot(4,1,3);plot(x_15(1:10000),x_15(2:10001),'.b')
subplot(4,1,4);plot(x_1(1:10000),x_1(2:10001),'.r')
%%
%Monte Carlo - liczba pi
close all; clear; clc
pi100_000=double(przyblizenie(100000))
%Monte Carlo - całka
f=@(x) 4-x.^2

int10_000=calka(f,-2,2,10000)
%%
function [p]=przyblizenie(N)
    rng(42)
    No=0
    xx=zeros(1,N);
    yy=zeros(1,N);
    xxx=zeros(1,N);
    yyy=zeros(1,N);
    for i=1:N
        x = rand();
        y = rand();
        xx(i)=x;
        yy(i)=y;
        if (x-1/2)*(x-1/2)+(y-1/2)*(y-1/2)<=1/2*1/2
            No=1+No;
            xxx(i)=x;
            yyy(i)=y;
        end
    end
    p=4*No/N
    plot(xx,yy,'.g',xxx,yyy,'.r')
end
function I=calka(fun,a,b,N)
    k=0;
    z=a:0.01:b;
    rng(42)
    xx=zeros(1,N);
    yy=zeros(1,N);
    xxx=zeros(1,N);
    yyy=zeros(1,N);
    for i=1:N
        x=a+(b-a).*rand();
        d=max(fun(a:b));
        y=d.*rand();
        xx(i)=x;
        yy(i)=y;
        if y<fun(x)
            k=k+1;
            xxx(i)=x;
            yyy(i)=y;
            end
    end
    I=k/N*(b-a)*d
    plot(xx,yy,'.g',xxx,yyy,'.r',z,fun(z),'b')
end