function show_curLines(im_L, im_R, lineLab_L, lineLab_R, labL, labR, result_dir)
[rows, cols] = size(im_L);
if labL ~= 0 && labR ~= 0
    lineMat_L = lineLab_L == labL;
    lineMat_R = lineLab_R == labR;
    SE = strel('square',3);
    lineMat_L = imdilate(lineMat_L,SE);
    lineMat_R = imdilate(lineMat_R,SE);
    redLine_L = do_redLine(im_L, lineMat_L, lineLab_L);
    redLine_R = do_redLine(im_R, lineMat_R, lineLab_R);
    img_double(:, 1:cols, :) = redLine_L;
    img_double(:, cols+1:2*cols, :) = redLine_R;
    f2 = figure;
    imshow(img_double);
    labL_str = num2str(labL, '%03d');
    nameStr = ['Left line label:' labL_str];
    title(nameStr); 
    waitforbuttonpress;  
    close(f2);
    imwrite(img_double, [result_dir labL_str '-l.png']);
end
end