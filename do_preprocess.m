% ������ʵ�֣���ͼ��Ԥ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function img_adj = do_preprocess(img)

aa = 255 / max(max(img));
tmp = uint8(img .* aa);
img_adj = imadjust(tmp);

end