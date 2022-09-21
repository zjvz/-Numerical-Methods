%Dekompozycja SVD
close all; clear; clc
A=[1 1; 0 1; 1 0];
B=[2 1 -2];
C=[2 2 2 2; 17/10 1/10 -17/10 -1/10; 3/5 9/5 -3/5 -9/5];

[Ua, Sa, Va]=svd(A)
[Ub, Sb, Vb]=svd(B)
[U, S, V]=svd(C)
[Uo, So, Vo]=svd(C,'econ')
%%
%Zastosowanie SVD do rozwiązywania układów równań liniowych
close all; clear; clc
p=load('punkty.txt');
N=length(p);
G=ones(20,2);
G(:,1)=p(:,1);
d=p(:,2);
[U, S, V]=svd(G,'econ')
m=V*inv(S)*U'*d;
a=m(1,1)
b=m(2,1)
p2=ones(N,2);
p2(:,1)=a*p(:,1)+b
p2(:,2)=p(:,2)

plot(p(:,1),p(:,2),'.b',p(:,1),p(:,2),'ro')

%%
%Kompresja stratna obrazu
close all; clear; clc
A=magic(5);
rng(42);
B=randi([1,12],18,17);
[Ua,Sa,Va]=svd(A,'econ');
[Ub,Sb,Vb]=svd(B,'econ');
%figure()
subplot(2,1,1);plot(diag(Sa),'ro')
subplot(2,1,2);plot(diag(Sb),'bo')

mars=double(imread('mars.jpg'));
colormap(gray(256));
[U,S,V]=svd(mars,'econ');

%figure()
subplot(2,1,1);image(mars)
subplot(2,1,2);plot(diag(S),'bo')

mars200=U(:,1:200)*S(1:200,1:200)*V(:,1:200)';
mars100=U(:,1:100)*S(1:100,1:100)*V(:,1:100)';
mars25=U(:,1:25)*S(1:25,1:25)*V(:,1:25)';

%figure()
subplot(2,2,1);image(mars) 
subplot(2,2,2);image(mars200)
subplot(2,2,3);image(mars100)
subplot(2,2,4);image(mars25)

[U200,S200,V200]=svd(mars200);
[U100,S100,V100]=svd(mars100);
[U25,S25,V25]=svd(mars25);

nfull=nnz(U)+nnz(S)+nnz(V)
n200=nnz(U(:,1:200))+nnz(S(1:200,1:200))+nnz(V(:,1:200))
n100=nnz(U(:,1:100))+nnz(S(1:100,1:100))+nnz(V(:,1:100))
n25=nnz(U(:,1:25))+nnz(S(1:25,1:25))+nnz(V(:,1:25))