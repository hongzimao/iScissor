function drawMask(contourX, contourY, img)
[m, n, RGB] = size(img);
mask = zeros(m, n, RGB);
maskWithImg = zeros(m, n, RGB);
[~, s] = size(contourX);
for i = 1:s
   mask(contourX(i), contourY(i), :) = [255, 255, 255];
end

mask = im2bw(mask);
mask = imfill(mask,'holes');
figure(2);
imshow(mask);

for i = 1:m
    for j = 1:n
        if mask(i,j)==1
            maskWithImg(i,j,:) = img(i, j, :);
        end
    end
end


maskWithImg = uint8(maskWithImg);
figure(3);
imshow(maskWithImg);
end