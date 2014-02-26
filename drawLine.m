function [newPt, preNode, seedX, seedY, contourX, contourY, close]= drawLine(canvas, img)
pt = get(gca, 'CurrentPoint');
x=round(pt(1,1));
y=round(pt(1,2));
ppt = canvas.ppt;
    if dotInRange(pt(1,1),pt(1,2), img.X, img.Y)==1
        preNode=costPath(canvas.node, img.X, img.Y, y, x);
        if ppt(1)== -1
            seedX = x;
            seedY = y;
            contourX = [];
            contourY = [];
            scatter(x, y,70,'red','fill');
            newPt =[pt(1,1) pt(1,2)];
            close = 0;
        else
            scatter(x, y,20,'red','fill');
            [lineX, lineY] = getLineSegament(canvas.preNode, y, x);
            line(lineY, lineX);
            
            contourX = [canvas.contourX lineX];
            contourY = [canvas.contourY lineY];
            
            seedX = canvas.seedX;
            seedY = canvas.seedY;
            
            newPt = [x y];
            
            if abs(x-seedX) + abs(y-seedY) < 10
                close = 1;
                [lineX, lineY] = getLineSegament(preNode, seedY, seedX);
                line(lineY, lineX);
                contourX = [contourX lineX];
                contourY = [contourY lineY];
            else
                close = 0;
            end
            
        end
    end
end