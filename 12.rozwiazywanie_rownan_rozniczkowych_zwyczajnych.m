%Metody samostartujące
close all; clear; clc
fun=@(x,y) y-x.^2
f2=@(x)x^2+2*x-exp(x)+2
an_19=f2(1.9)
a=0;
b=2;
h=0.1;
x0=0;
y0=1;
[eu] = rrz_euler(fun, a,b,h,x0,y0);
[tr] = rrz_trapez(fun, a,b,h,x0,y0);
[rk] = rrz_rk(fun, a,b,h,x0,y0);
eu_19=eu(20)
tr_19=tr(20)
rk_19=rk(20)
%%
%Metoda Adamsa - Bashfortha
close all; clear; clc
fun=@(x,y) y-x.^2
f2=@(x)x^2+2*x-exp(x)+2
a=0;
b=2;
h=0.1;
x0=0;
y0=1;
[y1] = rrz_ab(fun, a,b,h,x0,y0,1);
[y2] = rrz_ab(fun, a,b,h,x0,y0,2);
[y3] = rrz_ab(fun, a,b,h,x0,y0,3);
[y4] = rrz_ab(fun, a,b,h,x0,y0,4);
ab1_19=y1(20)
ab2_19=y2(20)
ab3_19=y3(20)
ab4_19=y4(20)
%%
function [y] = rrz_euler(fun, a,b,h,x0,y0)
    x=a:h:b;
    y=zeros(1,length(x));
    y(1)=y0;
    for k=2:length(x)
        y(k)=y(k-1)+h*fun(x(k-1),y(k-1));
    end
end

function [tra] = rrz_trapez(fun, a,b,h,x0,y0)
    x=a:h:b;
    tra=zeros(1,length(x));
    tra(1)=y0;
    for k=2:length(x)
        tra(k)=tra(k-1)+h/2*(fun(x(k-1),tra(k-1))+fun(x(k),tra(k-1)+h*fun(x(k-1),tra(k-1))));
    end
end

function [rk] = rrz_rk(fun, a,b,h,x0,y0)
    x=a:h:b;
    rk=zeros(1,length(x));
    rk(1)=y0;
    for k=2:length(x)
        k1=h*fun(x(k-1),rk(k-1));
        k2=h*fun(x(k-1)+h/2,rk(k-1)+k1/2);
        k3=h*fun(x(k-1)+h/2,rk(k-1)+k2/2);
        k4=h*fun(x(k-1)+h,rk(k-1)+k3);
        rk(k)=rk(k-1)+1/6*(k1+2*k2+2*k3+k4);
    end
end

function [y] = rrz_ab(fun, a,b,h,x0,y0,s)
    x=a:h:b;
    y=zeros(1,length(x));
    if s==1
        [rk] = rrz_rk(fun, a,b,h,x0,y0);
        y(1:2)=rk(1:2);
        for k=3:length(x)
            y(k)=y(k-1)+h/2*(-fun(x(k-2),y(k-2))+3*fun(x(k-1),y(k-1)));
        end
    elseif s==2
        [rk] = rrz_rk(fun, a,b,h,x0,y0);
        y(1:3)=rk(1:3);
        for k=4:length(x)
            y(k)=y(k-1)+h/12*(5*fun(x(k-3),y(k-3))-16*fun(x(k-2),y(k-2))+23*fun(x(k-1),y(k-1)));
        end
    elseif s==3
        [rk] = rrz_rk(fun, a,b,h,x0,y0);
        y(1:4)=rk(1:4);
        for k=5:length(x)
            y(k)=y(k-1)+h/24*(-9*fun(x(k-4),y(k-4))+37*fun(x(k-3),y(k-3))-59*fun(x(k-2),y(k-2))+55*fun(x(k-1),y(k-1)));
        end  
    else
        [rk] = rrz_rk(fun, a,b,h,x0,y0);
        y(1:5)=rk(1:5);
        for k=6:length(x)
            y(k)=y(k-1)+h/720*(251*fun(x(k-5),y(k-5))-1274*fun(x(k-4),y(k-4))+2616*fun(x(k-3),y(k-3))-2774*fun(x(k-2),y(k-2))+1901*fun(x(k-1),y(k-1)));
        end
    end
end