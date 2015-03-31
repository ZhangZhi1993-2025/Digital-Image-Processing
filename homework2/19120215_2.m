X=round(100*rand(100,2));  
n=100;           

Y=[30 30;30 60;30 90;60 30;60 60; 60 90; 90 30; 90 60; 90 90];       
N=9;           

MAX=30;           %最大迭代次数
m=1;            %当前迭代次数
e=0.0001;       %失真控制门限
d=zeros(MAX,n);   %最小距离值
s=zeros(N,2);   %所有码本的累加
d_D=zeros(MAX,1); %存放每次迭代后的失真
k=zeros(N,1);   %各个集合中码本的个数
d_z=zeros(N,1); %暂时存放
D0=10;          %设置总失真
x=X;
y=Y;
dlt=1;          %相对失真改进量
 
while (m<=MAX)&&(dlt>e)   %设置循环限定条件
    for i=1:n
        for j=1:N      %计算码本到各个集合的距离
            d_z(j,1)=sqrt((x(i,1)-y(j,1))^2+(x(i,2)-y(j,2))^2);
        end
        [d(m,i) index]=min(d_z); %求出最小距离及其所属的集合
        for p=1:N                %计算各个集合的码本个数
            if index==p
                k(p,1)=k(p,1)+1;
                p=p+1; 
            end
        end
        s(index,1)=s(index,1)+x(i,1); %每个集合所有码本的累加
        s(index,2)=s(index,2)+x(i,2);
    end
    for q=1:N                 %求新的码字
        y(q,1)=s(q,1)/k(q,1);
        y(q,2)=s(q,2)/k(q,1);
    end
    d_D(m,1)=sum(d(m,:));     %求失真
    if m==1                   %求相对失真改进量
        dlt=abs(d_D(m,1)-D0)/d_D(m,1);
    else
        dlt=abs(d_D(m,1)-d_D(m-1,1))/d_D(m,1);
    end
    m=m+1;
end  
%作图
%subplot(1,2,1),
plot(x(:,1),x(:,2),'*')         %用*表示初始码本  
hold on
plot(Y(:,1),Y(:,2),'o','MarkerFaceColor','g')   %用○表示初始码本
plot(y(:,1),y(:,2),'s', 'MarkerFaceColor','r')  %用□表示最优码本
hold off
xlabel('x')
ylabel('y')
