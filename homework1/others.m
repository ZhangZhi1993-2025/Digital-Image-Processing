source=imread('F:\Nanjing Normal University\CS\digital image processing\Homework\homework0\1.jpg','jpg');
gray=rgb2gray(source);
imwrite(gray,'F:\Nanjing Normal University\CS\digital image processing\Homework\homework0\2.jpg','jpg');
count=zeros(1,256);
for i=0:255
  count(i+1)=length(find(gray==i));
end
hist(count);
plot(count);