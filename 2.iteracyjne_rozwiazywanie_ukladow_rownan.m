%Rozwiązywanie równań liniowych metodą iteracji prostej
close all; clear; clc
%format rat
A=[6 4 1; 1 -3 -1; 1 -1 -4];
B=[11 -3 -4]';
n=3;
D=zeros(n,n);
D_od=zeros(n,n);
R=zeros(n,n);
for i=1:n
    for j=1:n
        if i==j
            D(i,j)=A(i,j);
            D_od(i,j)=1/A(i,j);
        else
            R(i,j)=A(i,j);
        end
    end
end
W=-1*D_od*R;
Z=D_od*B;
max=0;
for i=1:n
    suma=0;
    for j=1:n
        suma=suma+abs(W(i,j));
    end
    if(suma>max) 
        max=suma;
    end
end
w1=max;
max=0;
for j=1:n
    suma=0;
    for i=1:n
        suma=suma+abs(W(i,j));
    end
    if(suma>max) 
        max=suma;
    end
end
w2=max;
suma=0;
for j=1:n
    for i=1:n
        suma=suma+W(i,j)*W(i,j);
    end
end
w3=sqrt(suma);
X_0=[2;0;-2];
X_1=W*X_0+Z;
i=1;
while abs(X_1(1)-X_0(1))>=0.001 || abs(X_1(2)-X_0(2))>=0.001 || abs(X_1(3)-X_0(3))>=0.001
    X_0=X_1;
    X_1=W*X_0+Z;
    i=i+1;
end
i
X_1
%%
%Iteracja prosta - kryterium stopu
close all; clear; clc
A=[6 4 1; 1 -3 -1; 1 -1 -4];
B=[11 -3 -4]';
n=3;
eps1=0.0000000001;
X_00=[2;0;-2];

[X, il_iteracji, roznica]=it_prosta(A,B,X_00,eps1)

function [X, il_iteracji, roznica]=it_prosta(A,B,X_00,eps1)
n=size(A,1);
D=zeros(n,n);
D_od=zeros(n,n);
R=zeros(n,n);
%W=zeros(n,n);
%Z=zeros(1,n);
for i=1:n
    for j=1:n
        if i==j
            D(i,j)=A(i,j);
            D_od(i,j)=1/A(i,j);
        else
            R(i,j)=A(i,j);
        end
    end
end
W=-1*D_od*R;
Z=D_od*B;
max=0;
for i=1:n
    suma=0;
    for j=1:n
        suma=suma+abs(W(i,j));
    end
    if(suma>max) 
        max=suma;
    end
end
w1=max;
max=0;
for j=1:n
    suma=0;
    for i=1:n
        suma=suma+abs(W(i,j));
    end
    if(suma>max) 
        max=suma;
    end
end
w2=max;
suma=0;
for j=1:n
    for i=1:n
        suma=suma+W(i,j)*W(i,j);
    end
end
w3=sqrt(suma);
X_0=X_00;
X_1=W*X_0+Z;
k=1;
eps=0.1;
while eps>=eps1
    X_0=X_00;
    X_1=W*X_0+Z;
    i=1;
    while abs(X_1(1)-X_0(1))>=eps || abs(X_1(2)-X_0(2))>=eps || abs(X_1(3)-X_0(3))>=eps
        X_0=X_1;
        X_1=W*X_0+Z;
        i=i+1;
    end
    il_iteracji(k)=i;
    eps=eps/10;
    k=k+1;
end
k;
X=X_1;
roznica=X_1-X_0;
il_iteracji
end