function [X Y y] = LBG(n,N,e)
X = zeros(n,2);
for i = 1:n
    X(i,1) = rand*10-5;
    X(i,2) = rand*10-5;
end
Y = zeros(N,2);
for i = 1:N
    Y(i,1) = rand*10-5;
    Y(i,2) = rand*10-5;
end
L = 100;
d = zeros(L,n);   %最小距离值 
s = zeros(N,2);   %码本和
d_D = zeros(L,1); %失真 
k = zeros(N,1);   %码本的个数 
d_z = zeros(N,1);
D0 = 10;
l = 1; 
x = X; 
y = Y; 
dlt = 1;          
 
while (l <= L) && ( dlt > e)   
    for i = 1:n 
        for j = 1:N      
            d_z(j,1) = sqrt((x(i, 1) - y(j, 1)) ^ 2 + (x(i, 2) - y(j, 2)) ^ 2); 
        end 
        [d(m, i) index] = min(d_z); 
                
        k(index, 1) = k(index, 1) + 1; 
        s(index, 1) = s(index, 1) + x(i, 1);
        s(index, 2) = s(index, 2) + x(i, 2); 
    end 
    for q = 1:N
        y(q, 1) = s(q, 1) / k(q, 1); 
        y(q, 2) = s(q, 2) / k(q, 1); 
    end 
    d_D(m, 1) = sum(d(m,:));  
    if m == 1 
        dlt = abs(d_D(m, 1) - D0) / d_D(m, 1); 
    else 
        dlt = abs(d_D(m, 1) - d_D(m-1, 1)) / d_D(m, 1); 
    end 
    m = m + 1; 
end   
end