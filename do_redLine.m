function imgRGB = do_redLine(img, curLine, allLineLab)

curLine_0 = uint8(~curLine);
curLine_1 = uint8(~curLine_0);

allLines_0 = uint8(~allLineLab);
allLines_1 = uint8(~allLines_0);

otherLines_1 = allLines_1 - curLine_1;


imgRGB(:, :, 1) = img .* allLines_0 + curLine_1 .* 255;
imgRGB(:, :, 2) = img .* allLines_0;
imgRGB(:, :, 3) = img .* allLines_0 + otherLines_1 .* 255;
% figure, imshow(uint8(imgRGB));

end