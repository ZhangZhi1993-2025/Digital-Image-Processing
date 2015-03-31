data = imread('data.jpg');
data_r = data(:,:,1);
gray = rgb2gray(data);
x = zeros(255,1);
for i = 1:size(gray,1)
    for j = 1:size(gray,2)
        x(gray(i,j))=x(gray(i,j))+1;
    end
end
X=1:255;

plot(X,x);
bar(X,x);
for i = 1:size(gray,1)
    for j = 1:size(gray,2) - 1
        d(i,j) = abs(gray(i,j) - gray(i,j+1));
    end
end
figure;
imshow(gray);
imshow(d);