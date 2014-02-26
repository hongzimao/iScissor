function displayCostGraph(node, in)
[X, Y, ~] = size(node);
img = uint8(zeros(3*X, 3*Y ,1));
pixel = sum(in(:,:,:),3)/3;
for i=1:X
    for j=1:Y
        img(3*i-1, 3*j-1, 1) = uint8(pixel(i, j));
        img(3*i, 3*j-2, 1)   = uint8(node(i, j, 1));
        img(3*i-1, 3*j-2, 1) = uint8(node(i, j, 2));
        img(3*i-2, 3*j-2, 1) = uint8(node(i, j, 3));
        img(3*i-2, 3*j-1, 1) = uint8(node(i, j, 4));
        img(3*i-2, 3*j, 1)   = uint8(node(i, j, 5));
        img(3*i-1, 3*j, 1)   = uint8(node(i, j, 6));
        img(3*i, 3*j, 1)     = uint8(node(i, j, 7));
        img(3*i, 3*j-1, 1)   = uint8(node(i, j, 8));
    end
end
imshow(255-img);
end