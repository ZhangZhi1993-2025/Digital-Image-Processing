imdata=imread('F:\Nanjing Normal University\CS\digital image processing\Homework\homework0\1.jpg','jpg');
grayim=rgb2gray(imdata);

a = tabulate(grayim(:));

[counts,x]=imhist(grayim,256);
%stem(x,counts);

[M,N]=size(grayim);
counts=counts/M/N;
%stem(x,counts);

x=zeros();
for i=1:size(grayim,1)
    for j=1:size(grayim,2)-1
        a=grayim(i,j+1)-grayim(i,j);
        if a>10
            x(i,j)=a;
        end
    end
end