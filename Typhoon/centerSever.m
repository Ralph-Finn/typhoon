clear;
clc;
while(1)
tong=tcpip('localhost', 4002, 'NetworkRole', 'server');% ����tcp����,��������4002�˿�
fopen(tong);  % ��tcpͨ������û����ҳ���󣬸�ģ�齫��������
mess = 'start connection'
cmd = '0';
try
    data = fread(tong,512);%����buff�е���Ϣ��
    %data = fscanf(tong,'%f',[1,512])
    cmd = data(1);
catch
    cmd = '0';
end
cmd
%data =fread(t,50);
if cmd == '1'
    %�ڴ�ע�ʹ�д��Ҫ�ļ������ĺ���%
    time = csvread('inputData.csv');
    Typhoon_Fault_Model(time); %̨��������
    mess = 'Typhoon Success'
    %�����ݷ��ظ��������ݵ�ҳ��
end
if cmd == '2'
    Section_Identification();
    mess ='Section Sucess'
end
fprintf(tong,cmd); %��ʾ�������н��������ظ�client������
cmd = '0';
pause(1);
end