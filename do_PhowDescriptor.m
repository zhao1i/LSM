% 本函数实现：获取坐标点的PHOW描述子
% -------------------------------------------------------------------------
function [f_all, d_all] = do_PhowDescriptor(img)

[rows, cols] = size(img);
f_all = zeros(4, rows * cols);
d_all = zeros(128, rows * cols);

rr_list = [4, 6, 8, 10];
for i = 1 : length(rr_list)
    r = rr_list(i);
    edgeLen = r/2 * 3;  
    imgEdge = Phow_PreProcess(img, edgeLen);  
    [f_r, d_r] = vl_phow(im2single(imgEdge), r);  
    f_r(1:2, :) = f_r(1:2, :) - edgeLen; 
    w = 4 / r;            
    d_all = d_all + d_r*w;  
    f_all(1:2, :) = f_r(1:2, :);
    f_all(3, :) = f_all(3, :) + f_r(3, :);
end


end