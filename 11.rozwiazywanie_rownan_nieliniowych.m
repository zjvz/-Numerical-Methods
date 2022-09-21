%Metoda bisekcji
close all; clear; clc
f=@(x) x.^3-3
[x1, iter] = regula_bisekcji(f, 0, 4, 0.01)
x=0:0.001:8;
plot(x,f(x),'b',x1,f(x1),'.r')
%%
%Metoda regula falsi
close all; clear; clc
%f=@(x) x.^3-3
%[x1, iter] = regula_falsi(f, 0, 8, 0.1)
f=@(x) exp(-x)+sin(2*x+pi/3)
[x1, iter] = regula_falsi(f, 0, 4, 0.01)
x=0:0.01:4;
%x=0:0.001:8;
plot(x,f(x),'b',x1,f(x1),'.r')
%%
%Metoda stycznych
close all; clear; clc
%f=@(x) x.^3-3
%x=0:0.001:8;
%pochodna=myfirst_4order(f,x,0.1)
%[x1, iter, x_all] = stycznych(f, pochodna, 0, 8, 0.1, 8)

f=@(x) exp(-x)+sin(2*x+pi/3)
x=0:0.01:4;
%pochodna=myfirst_4order(f,x,0.1);
%pochodna
[x1, iter, x_all] = stycznych(f, 0, 4, 0.01,4)

plot(x,f(x),'b',x1,f(x1),'.r')
%%
function [x1, iter] = regula_bisekcji(fun, a, b, eps)
    iter=1;
    x1=(a+b)/2;
    while abs(fun(x1))>=eps
        if fun(a)*fun(x1)>0
            a=x1;
        else
            b=x1;
        end
        x1=(a+b)/2;
        iter=iter+1;
    end
end

function [x1, iter] = regula_falsi(fun, a, b, eps)
    iter=1;
    x1=a-fun(a)*(b-a)/(fun(b)-fun(a));
    while abs(fun(x1))>=eps
        if fun(a)*fun(x1)>0
            a=x1;
        else
            b=x1;
        end
        x1=a-fun(a)*(b-a)/(fun(b)-fun(a));
        iter=iter+1;
    end
end

function y = myfirst_4order(f,x,h)
    y=1/12/h*(f(x-2*h)-8*f(x-h)+8*f(x+h)-f(x+2*h));
end 

function [x1, iter, x_all] = stycznych(fun, a , b, eps, x0)
    x_all=[];
    iter=1;
    x_all(iter)=x0-fun(x0)/myfirst_4order(fun,x0,0.1);
    while abs(fun(x_all(iter)))>eps
        x_all(iter+1)=x_all(iter)-fun(x_all(iter))/myfirst_4order(fun,x_all(iter),0.1);
        iter=iter+1;
    end
    x1=x_all(iter)
end