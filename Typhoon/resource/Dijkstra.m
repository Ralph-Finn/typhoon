function [ Time,Path ] = Dijkstra ( W,N,st,en )
%�Զ������Dijkstra�㷨�����·��Ѱ���Ӻ���
st=find(N==st);                         %�ڵ��ű任
en=find(N==en);

n=length(W);                            %�ڵ���  
D=W(st,:);  
Visit=ones(1,n); 
Visit(st)=0;  
Parent=zeros(1,n);                      %��¼ÿ���ڵ����һ���ڵ�  
  
path =[];  
  
for i=1:n-1  
    temp = [];  
    
    %��������������̾������һ���㣬ÿ�β����ظ�ԭ���Ĺ켣������Visit�жϽڵ��Ƿ����  
    for j=1:n  
       if Visit(j)                     %��j��δ������
           temp =[temp D(j)];  
       else  
           temp =[temp Inf];  
       end     
    end  
      
    [~,index] = min(temp);   
    Visit(index)=0;                    %����ѡ�еĵ���0
      
    %���� �������index�ڵ㣬����㵽ÿ���ڵ��·�����ȸ�С������£���¼ǰ���ڵ㣬����������ѭ��  
    for k=1:n  
        if D(k)>D(index)+W(index,k)  
           D(k) = D(index)+W(index,k);  
           Parent(k)=index;  
        end  
    end         
end

Time=D(en);%��̾���

%���ݷ�  ��β����ǰѰ������·��  
t=en;  
while t~=st && t>0  
    path=[t,path];  
    p=Parent(t);
    t=p;   
end  
path =[st,path];                       %���·��  

for i=1:length(path)                   %�ڵ��ŷ��任
    Path(i)=N(path(i));
end

end  

