function [lineX, lineY] = getLineSegament(preNode, x, y)
lineX=[];
lineY=[];
while true
    prePt = preNode(x, y, :);
    if prePt(1)==-1 
        break;
    end
    x = prePt(1);
    y = prePt(2);
    lineX = [x lineX];
    lineY = [y lineY];
end
end