clear;
image=imread('F:\Nanjing Normal University\CS\digital image processing\Homework\homework0\p1.jpg','jpg');
[height,width]=size(image);
width=width/3;
hash=zeros(3,256);
for k=1:3
    for i=1:height
        for j=1:width
            pixel=image(i,j,k);
            hash(k,pixel+1) = hash(k,pixel+1)  + 1;
        end
    end
end
%bar(hash(1,:));
%hist(hash(1,:));
plot(hash(1,:));