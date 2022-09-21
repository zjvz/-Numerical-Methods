%transformacja Householdera
close all; clear; clc
A=[-1 -1 1; 1 3 3; -1 -1 5; 1 3 7];
[Q R]  = qr_ht(A)
%%
%metoda Grana-Schmidta
close all; clear; clc
A=[-1 -1 1; 1 3 3; -1 -1 5; 1 3 7];
[Q R]  = qr_gs(A)
%%
%Dokładność i czas wykonania dekompozycji QR
close all; clear; clc
rng(42)
nX=[15,30,75,150,300,750];
nY=[10,30,50,100,200,500];

time_qr_gs=zeros(6,1);
err_qr_gs=zeros(6,1);
time_qr_ht=zeros(6,1);
err_qr_ht=zeros(6,1);

for i=1:6
    A=randi([-500,500], nX(i), nY(i) );
    tic; [Q,R] = qr_gs(A); time_qr_gs(i) = toc;
    err_qr_gs(i) = sum(sum(Q*R-A));
    tic; [Q,R] = qr_ht(A); time_qr_ht(i) = toc;
    err_qr_ht(i) = sum(sum(Q*R-A));
end

%plot(time_qr)
%plot(err_gr)
subplot(2,2,1); plot(time_qr_gs,'o')
subplot(2,2,2); plot(err_qr_gs,'o')
subplot(2,2,3); plot(time_qr_ht,'o')
subplot(2,2,4); plot(err_qr_ht,'o')
%%
function [Q R]  = qr_ht(A)
    kk=length(A(1,:)); %ile kolumn
    n=length(A(:,1)); %ile wierszy
    %R=A;
    Q=eye(n,n);
    %i=0;
    for k=1:kk
        Ak=A(k:n, k:kk);
        a=Ak(:,1);
        a_norm=norm(a);
        v=a+sign(A(k,k))*a_norm*eye(n-k+1,1);
        H=eye(n,n);
        H_1=eye(n-k+1,n-k+1)-2*v*v'/(v'*v);
        H(k:n,k:n)=H_1;
        A=H*A;
        Q=Q*H;
     end
     R=A;
     Q;
end

function [Q R]  = qr_gs(A)
[n,m]=size(A);
Q=zeros(n,m);
R=zeros(m);
q_1=A(:,1);
R(1,1)=norm(q_1);
q=1/R(1,1)*q_1;
Q(:,1)=q;
for k=1:m
    for i=1:k-1
       R(i,k)=Q(:,i)'*A(:,k);
    end
    suma=0;
    for j=1:k-1
        suma=suma+R(j,k)*Q(:,j);
    end
    q_1=A(:,k)-suma;
    R(k,k)=norm(q_1);
    q=1/R(k,k)*q_1;
    Q(:,k)=q;
end
end