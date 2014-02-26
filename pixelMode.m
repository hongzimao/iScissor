function out = pixelMode(in)
[X, Y, RGB] = size(in);
out = uint8(zeros(3*X, 3*Y, RGB));
for i=1:X
    for j=1:Y
        for k=1:RGB
            out(3*i-1, 3*j-1, k) = in(i, j, k);
        end
    end
end
end