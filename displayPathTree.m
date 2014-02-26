function displayPathTree(preNode)
[X, Y, ~] = size(preNode);
img = uint8(zeros(3*X, 3*Y ,3));
for i=1:X
    for j=1:Y
        if preNode(i,j,1) == -1
            img(3*i-1, 3*j-1,:) = [255, 0, 0];
        else
            img(3*i-1, 3*j-1,:) = [0, 76, 153];
            prenode(1:2) = preNode(i, j, :);
            pos = [3*i-1, 3*j-1] + prenode - [i, j];
            img(pos(1), pos(2),:)=[153,255,51];
        end 
    end 
end
imshow(img);
end