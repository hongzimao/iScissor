function drawRemoveableLine(canvas, img)
ppt = canvas.ppt;
   if ppt(1) ~= -1
        pt = get(gca, 'CurrentPoint');
        x = round(pt(1,1));
        y = round(pt(1,2));
        if dotInRange(x, y, img.X, img.Y)==1
            [lineY, lineX] = getLineSegament(canvas.preNode, y, x);
            set(canvas.line, 'XData', lineX, 'YData', lineY);
        end
   end
end