function [ Tbest,Epbest ] = fuzzycluster( NB,P,e )
%transmission sections : fuzzy cluster;
T = 2;%����������ʼ������Ϊ2��
Tmax = ceil(sqrt(NB)) - 1;%����������
[L,N] = size(P);
s = zeros(NB,1);
 for j = 1 : L
     for i = 1 : N
      s(j) = s(j) + P(j,i);
     end
 end
smax = max(s);
smin = min(s);
while T < Tmax
%���㵱ǰ�������ģ�
alpha = zeros(NB,1);%��·��һ��ģ��ֵ��
for j = 1 : NB
    alpha(j) = (T-1)*(s(j)-smin)/(smax-smin) + 1;
end
%���࣬�������ʼ�������ģ�
c = zeros(T,1);
Nt = zeros(T,1);
for j = 1 : NB
    if ceil(alpha(j))-alpha(j) <= 0.5
        c(ceil(ahpha(j))) = c(ceil(ahpha(j))) + s(j);
        Nt(ceil(ahpha(j))) = Nt(ceil(ahpha(j))) + 1;
    else
        c(ceil(ahpha(j))-1) = c(ceil(ahpha(j)-1)) + s(j);
        Nt(ceil(ahpha(j))-1) = Nt(ceil(ahpha(j))-1) + 1;
    end
end
c = c ./ Nt;
%���������ȣ�
U = zeros(NB,T);%�����Ⱦ���
m = 2;
for j = 1 : NB
    for t = 1 : T
        a = 0;
        for r = 1 : T
            a = a + (norm(s(j)-c(t))/norm(s(j)-c(r))) ^ (2/(m-1));
        end
        U(j,t) = 1 / a;
    end
end
c0 = c;
ca = 0;
cb = 0;
for j = 1 : NB
    ca = ca + (U(j,t)^m)*s(j);
    cb = cb + U(j,t)^m;
end
c = ca / cb;
%���¾������ģ�
while abs(c(:)-c0(:)) >= e %eΪ��ֵ��
    for j = 1 : NB
    for t = 1 : T
        a = 0;
        for r = 1 : T
            a = a + (norm(s(j)-c(t))/norm(s(j)-c(r))) ^ (2/(m-1));
        end
        U(j,t) = 1 / a;
    end
    end
    c0 = c;
    ca = 0;
    cb = 0;
    for j = 1 : NB
       ca = ca + (U(j,t)^m)*s(j);
       cb = cb + U(j,t)^m;
    end
    c = ca / cb;
end
%���㻮����ָ����
Ep = 0;
for j = 1 : NB
    for t = 1 : T
        Ep = Ep + U(j,t)*log(U(j,t));
    end
end
Ep = (-Ep)/NB;
Eprem(T) = Ep;
    
 T = T + 1;   
end
%�������ʣ��ҵ���ѷ��ࣻ
K = zeros(Tmax,1);
for i = 1 : Tmax
    K(i) = abs(Eprem(i))/((1+Eprem(i)^2)^1.5);
end
Kmax = max(K);
Tbest = find(K==Kmax);
Epbest = Eprem(Tbest);

end

