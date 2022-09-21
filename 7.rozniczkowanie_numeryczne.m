%pierwsza pochodna funkcji
close all; clear; clc
f=@(x) 1/3*x.^2.*sin(3*x)
x=-2*pi():0.01:2*pi;
plot(x,f(x),'g')

h1=0.5;
h2=0.1;

y1=myfirst_2order(f,x,h1)
y11=myfirst_2order(f,x,h2)
y2=myfirst_4order(f,x,h1)
y22=myfirst_4order(f,x,h2)

subplot(2,1,1);plot(x,f(x),'g',x,y1,'or',x,y2,'.r')
subplot(2,1,2);plot(x,f(x),'g',x,y11,'or',x,y22,'.r')

p_2=myfirst_2order(f,-5.5,h1)
p_4=myfirst_4order(f,-5.5,h1)
p_a=(-5.5)^2*cos(3*(-5.5))+2/3*(-5.5)*sin(3*(-5.5))
%%
%druga pochodna funkcji
close all; clear; clc
f=@(x) 1/3*sin(3*x).*exp(-x.^2)
x=-2*pi():0.01:2*pi;
plot(x,f(x),'g')

h1=0.5;
h2=0.1;

y1=mysecond_2order(f,x,h1)
y11=mysecond_2order(f,x,h2)
y2=mysecond_4order(f,x,h1)
y22=mysecond_4order(f,x,h2)

subplot(2,1,1);plot(x,f(x),'g')
hold on
plot(x,y1,'or','MarkerSize',2)
plot(x,y2,'.b','MarkerSize',1)
subplot(2,1,2);plot(x,f(x),'g',x,y11,'or',x,y22,'.r')

pp_2=mysecond_2order(f,0.35,h2)
pp_4=mysecond_4order(f,0.35,h2)
pp_a=1/3*exp(-0.35^2)*((4*0.35^2-11)*sin(3*0.35)-12*0.35*cos(3*0.35))
%%
function y = myfirst_2order(f,x,h)
    y=(f(x+h)-f(x-h))/2/h
end
function y = myfirst_4order(f,x,h)
    y=1/12/h*(f(x-2*h)-8*f(x-h)+8*f(x+h)-f(x+2*h))
end 
function y = mysecond_2order(f,x,h)
    y=(f(x+h)-2*f(x)+f(x-h))/h/h
end
function y = mysecond_4order(f,x,h)
    y=1/12/h/h*(-f(x-2*h)+16*f(x-h)-30*f(x)+16*f(x+h)-f(x+2*h))
end 