function [asift_ll, asift_rr, labelMatrix] = do_voronoi(asift_matches, img_l, result_dir)

show_FLAG = 0;  
LEN = 3000;
asift_l = ceil(asift_matches(:,1:2));  
asift_r = ceil(asift_matches(:,3:4));
if length(asift_r) > LEN
    asift_l = asift_l(1:LEN, :);
    asift_r = asift_r(1:LEN, :);
end


[~, ia, ic] = unique(asift_l, 'rows', 'stable');
asift_ll = asift_l(ia, :);
asift_rr = asift_r(ia, :);

n = length(ia);

x = asift_ll(:, 1);
y = asift_ll(:, 2);

x_r = asift_rr(:, 1);
y_r = asift_rr(:, 2);


imgSize = size(img_l);

labelMatrix = zeros(imgSize);  

[X, Y] = meshgrid(1:imgSize(2), 1:imgSize(1));

distances = zeros([imgSize, n]); 

for k = 1:n
 
    distances(:, :, k) = sqrt((X - x(k)).^2 + (Y - y(k)).^2);
end


[~, labelMatrix] = min(distances, [], 3);


if show_FLAG
   
    f1 = figure;
    h = voronoi(x, y, 'r');
    tri = delaunay(x, y);  
    hold on;
    plot(x, y, 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'r');  
    triplot(tri, x, y, 'b');
    str_l = '-Voronoi图-l';
    % title(str1);
    set(gca, 'XTick', [], 'YTick', []);
    hold off;
    exportgraphics(gcf, [result_dir str_l '.png'], 'Resolution', 300);
    close(f1);

    f1 = figure;
    h = voronoi(x_r, y_r, 'r');
    tri = delaunay(x_r, y_r); 
    hold on;
    plot(x_r, y_r, 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'r');  % 种子
    triplot(tri, x_r, y_r, 'b');
    str_r = '-Voronoi图-r';
    set(gca, 'XTick', [], 'YTick', []);
    hold off;
    exportgraphics(gcf, [result_dir str_r '.png'], 'Resolution', 300);
    close(f1);

    f2 = figure;
    imagesc(labelMatrix);
    colormap(jet);
    colorbar;
    str2 = '-Voronoi图的标签矩阵';
    % title(str2);
    % hold on;
    % plot(x, y, 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'b');
    % plot(x, y, '+', 'MarkerSize', 7, 'LineWidth', 1, 'MarkerFaceColor', [0,0,1]);
    set(gca, 'XTick', [], 'YTick', []);
    % hold off;
    exportgraphics(gcf, [result_dir str2 '.png'], 'Resolution', 300); 
    close(f2);


    f3 = figure;
    imshow(labelMatrix, []);
    str3 = '-Voronoi图的标签gray';
    % title(str2);
    % plot(x, y, 'o', 'MarkerSize', 3, 'MarkerFaceColor', 'b');
    % plot(x, y, '+', 'MarkerSize', 7, 'LineWidth', 1, 'MarkerFaceColor', [0,0,1]);
    set(gca, 'XTick', [], 'YTick', []);
    exportgraphics(gcf, [result_dir str3 '.png'], 'Resolution', 300);  
    close(f3);
end
end