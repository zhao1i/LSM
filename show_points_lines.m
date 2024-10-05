function show_points_lines(img_L, img_R, linesL, linesR, match_pts, labL, result_dir)

[rows, cols] = size(img_L);
img2 = [img_L img_R];
f1 = figure;
imshow(img2);
hold on;
num_linesL = size(linesL, 2);
for i = 1 : num_linesL
    plot(linesL(1:2, i), linesL(3:4, i), 'LineWidth', 1, 'Color', [0, 0, 1]);
end

num_linesR = size(linesR, 2);
for i = 1 : num_linesR
    plot(linesR(1:2, i)+cols, linesR(3:4, i), 'LineWidth', 1, 'Color', [0, 0, 1]);
end
P1(:, 1) = match_pts(:,2);
P1(:, 2) = match_pts(:,1);
P2(:, 1) = match_pts(:,4);
P2(:, 2) = match_pts(:,3);

numPts = size(P1, 1);
t = 1;
for j = 1: 1: numPts
    
    dot1 = plot(P1(j,1), P1(j,2), '.', 'MarkerEdgeColor', 'r', 'markersize', 10);
    dot2 = plot(P2(j,1)+cols, P2(j,2), '.', 'MarkerEdgeColor', 'g', 'markersize', 10);

%     line([P1(j,1) P2(j,1)+cols], ...
%         [P1(j,2) P2(j,2)], 'Color', 'y');
    t = t + 1;
%     d = P2(j,1) - P1(j,1)
end

hold off;
% waitforbuttonpress;  
labL_str = num2str(labL, '%03d');
nameStr = ['Left line label:' labL_str];
title(nameStr); 
exportgraphics(gcf, [result_dir labL_str '-p.png'], 'Resolution', 300);
close(f1);

end