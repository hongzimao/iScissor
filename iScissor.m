function iScissor()
input=imread('cs5421.png');


[img.X, img.Y, img.RGB] = size(input);
canvas.figure= figure;
imshow(input);
hold on

canvas.ppt = [-1 -1];
canvas.line = line([0 0], [0 0]);
canvas.node = setNodeStruct(input);
canvas.preNode = zeros(img.X, img.Y, 2);
canvas.close = 0;

set(canvas.figure, 'WindowButtonDownFcn', @DrawLine);
set(canvas.figure, 'WindowButtonMotionFcn', @DrawRemovableLine);

    function DrawRemovableLine(varargin)
        if canvas.close == 0
            drawRemoveableLine(canvas, img);
        end
    end

    function DrawLine(varargin)
        if canvas.close == 0
            [canvas.ppt, canvas.preNode, canvas.seedX, canvas.seedY, canvas.contourX, canvas.contourY, canvas.close]= drawLine(canvas, img);
            if canvas.close == 1
                drawMask(canvas.contourX, canvas.contourY, input);
            end
        end
    end

end