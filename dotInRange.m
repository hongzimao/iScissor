function v = dotInRange(x, y, imgX, imgY)
    if x>=0 && x<imgY && y>=0 && y<imgX
        v=1;
    else
        v=0;
    end
end