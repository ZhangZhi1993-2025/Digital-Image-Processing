clear;
image=imread('F:\Nanjing Normal University\CS\digital image processing\Homework\homework0\p1.jpg','jpg');
[height,width]=size(image);
width=width/3;
filter=245;
for k=1:3
    for i=1:height
        for j=1:width
            if(image(i,j,k)<filter)
                image(i,j,k)=0;
            end
        end
    end
end
imshow(image);