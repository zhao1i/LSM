function do_GT_LSM(imL_rect, imR_rect, lines, res_dir, img_dir_name)

save_dir = [res_dir img_dir_name];
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
    disp(['文件夹 "' save_dir '" 已创建。']);
else
    disp(['文件夹 "' save_dir '" 已存在。']);
end

img_two = [imL_rect imR_rect];
[rows_l, cols_l] = size(imL_rect);
line_r = lines.lines_r;
line_l = lines.lines_l;

f1 = figure;
imshow(img_two);
hold on;
num_line_r = length(line_r);
for r = 1 : num_line_r
    x1 = line_r(1, r)+cols_l;
    x2 = line_r(2, r)+cols_l;
    y1 = line_r(3, r);
    y2 = line_r(4, r);
    plot([x1, x2], [y1, y2], 'LineWidth', 2, 'Color', [1, 0, 0]);
end
num_line_l = length(line_l);
for l = 1 : num_line_l
    x1 = line_l(1, l);
    x2 = line_l(2, l);
    y1 = line_l(3, l);
    y2 = line_l(4, l);
    line_plot = plot([x1, x2], [y1, y2], 'LineWidth', 2, 'Color', [1, 0, 0]);
    label = num2str(l, '%03d');
    % text(x1+5, y1+5, label, 'Color', 'green', 'FontSize', 5, 'FontWeight', 'bold');
    name_str = ['/line_label_' label '.png'];
    exportgraphics(gcf, [save_dir name_str], 'Resolution', 300);
    delete(line_plot);
end
hold off;
close(f1);
end