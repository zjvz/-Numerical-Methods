%metoda prostokatow i trapezow
close all; clear; clc
f=@(x) x.^2-4
%f=@(x) x.^2
t04=integral_trapeze(f,0,4,0.01)
p24=integral_rectangle(f,2,4,0.01)
%p1=integral_rectangle(f,0,10,2)
%p=integral_trapeze(f,0,10,2)

function [suma] = integral_rectangle(fun,a,b,h)
    n=a:h:b;
    suma=0;
    for i=1:length(n)-1
        suma=suma+fun(n(i));
    end
    suma=suma*h
end

function [suma] = integral_trapeze(fun,a,b,h)
    n=a:h:b;
    suma=h/2*(fun(n(1))+fun(n(length(n))));
    suma2=0;
    for i=2:length(n)-1
        suma2=suma2+fun(n(i));
    end
    suma=suma+h*suma2
end