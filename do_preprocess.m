% 本函数实现：对图像预处理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function img_adj = do_preprocess(img)

aa = 255 / max(max(img));
tmp = uint8(img .* aa);
img_adj = imadjust(tmp);

end