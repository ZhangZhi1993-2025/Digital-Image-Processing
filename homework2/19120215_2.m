X=round(100*rand(100,2));  
n=100;           

Y=[30 30;30 60;30 90;60 30;60 60; 60 90; 90 30; 90 60; 90 90];       
N=9;           

MAX=30;           %����������
m=1;            %��ǰ��������
e=0.0001;       %ʧ���������
d=zeros(MAX,n);   %��С����ֵ
s=zeros(N,2);   %�����뱾���ۼ�
d_D=zeros(MAX,1); %���ÿ�ε������ʧ��
k=zeros(N,1);   %�����������뱾�ĸ���
d_z=zeros(N,1); %��ʱ���
D0=10;          %������ʧ��
x=X;
y=Y;
dlt=1;          %���ʧ��Ľ���
 
while (m<=MAX)&&(dlt>e)   %����ѭ���޶�����
    for i=1:n
        for j=1:N      %�����뱾���������ϵľ���
            d_z(j,1)=sqrt((x(i,1)-y(j,1))^2+(x(i,2)-y(j,2))^2);
        end
        [d(m,i) index]=min(d_z); %�����С���뼰�������ļ���
        for p=1:N                %����������ϵ��뱾����
            if index==p
                k(p,1)=k(p,1)+1;
                p=p+1; 
            end
        end
        s(index,1)=s(index,1)+x(i,1); %ÿ�����������뱾���ۼ�
        s(index,2)=s(index,2)+x(i,2);
    end
    for q=1:N                 %���µ�����
        y(q,1)=s(q,1)/k(q,1);
        y(q,2)=s(q,2)/k(q,1);
    end
    d_D(m,1)=sum(d(m,:));     %��ʧ��
    if m==1                   %�����ʧ��Ľ���
        dlt=abs(d_D(m,1)-D0)/d_D(m,1);
    else
        dlt=abs(d_D(m,1)-d_D(m-1,1))/d_D(m,1);
    end
    m=m+1;
end  
%��ͼ
%subplot(1,2,1),
plot(x(:,1),x(:,2),'*')         %��*��ʾ��ʼ�뱾  
hold on
plot(Y(:,1),Y(:,2),'o','MarkerFaceColor','g')   %�á��ʾ��ʼ�뱾
plot(y(:,1),y(:,2),'s', 'MarkerFaceColor','r')  %�á���ʾ�����뱾
hold off
xlabel('x')
ylabel('y')
