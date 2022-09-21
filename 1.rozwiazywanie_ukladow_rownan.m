%Eliminacja Gaussa - wyznacznik macierzy
close all; clear; clc
c=[1 4 2 -2; 1 6 1 -1; -1 0 0 5; 3 6 9 8];
n=4;
for s=1:n-1
    for i=s+1:n
        for j=s+1:n
            c(i,j)=c(i,j)-c(i,s)/c(s,s)*c(s,j);
        end
    end
end
detA=c(1,1)*c(2,2)*c(3,3)*c(4,4)

rng(42);
B=randi([-3,3],6,6)
n=6;
for s=1:n
    for i=s+1:n
        for j=s+1:n
            B(i,j)=B(i,j)-B(i,s)/B(s,s)*B(s,j);
        end
    end
end
detB=B(1,1)*B(2,2)*B(3,3)*B(4,4)*B(5,5)*B(6,6)
%%
%Eliminacja Gaussa - rozwiązywanie równań liniowych
close all; clear; clc
A=[-1 2 1; 1 -3 -2; 3 -1 -1];
b=[-1 -1 4]';
n=length(A);
for j=1:(n-1)
    for i=n:-1:j+1
        m=A(i,j)/A(j,j);
        A(i,:)=A(i,:)-m*A(j,:);
        b(i)=b(i)-m*b(j);
    end
end
x=zeros(n,1);
x(n)=b(n)/A(n,n);
for i=n-1:-1:1
    suma=0;
    for j=i+1:n
        suma=suma+A(i,j)*x(j);
    end
    x(i)=(b(i)-suma)/A(i,i);
end
x

rng(42);
G=randi([-30,30],6,6);
d=randi([-78,78],6,1);
n=length(G);
for j=1:(n-1)
    for i=n:-1:j+1
        m=G(i,j)/G(j,j);
        G(i,:)=G(i,:)-m*G(j,:);
        d(i)=d(i)-m*d(j);
    end
end
x=zeros(n,1);
x(n)=d(n)/G(n,n);
suma=0;
for i=n-1:-1:1
    suma=0;
    for j=i+1:n
        suma=suma+G(i,j)*x(j);
    end
    x(i)=(d(i)-suma)/G(i,i);
end
x
%%
%Dekompozycja LU
close all; clear; clc
A=[1 4 2 -2; 1 6 1 -1; -1 0 0 5; 3 6 9 8];
m=length(A);
L=zeros(m,m);
U=zeros(m,m);

for i=1:m
    for k=1:(i-1)
        L(i,k)=A(i,k);
        for j=1:(k-1)
            L(i,k)=L(i,k)-L(i,j)*U(j,k);
        end
        L(i,k)=L(i,k)/U(k,k);
    end
    for k=i:m
        U(i,k)=A(i,k);
        for j=1:(i-1)
            U(i,k)=U(i,k)-U(j,k)*L(i,j);
        end
    end
end

for i=1:m
    L(i,i)=1;
end
L
U