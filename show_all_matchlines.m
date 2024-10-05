function show_all_matchlines(matchLines, leftBody, rightBody, str)


lines_L = leftBody.lines;  % 线段
lines_R = rightBody.lines;

f1 = figure;
imshow(leftBody.img);
hold on;

num_lines = size(matchLines, 1);

for i = 1 : num_lines
    if matchLines(i, 1) ~= 0 && matchLines(i, 2) ~= 0

        i_L = matchLines(i, 1);
        plot(lines_L(1:2, i_L), lines_L(3:4, i_L), 'LineWidth', 1, 'Color', [1, 0, 0]);
        label = num2str(i_L);
        x = lines_L(1, i_L)+2;
        y = lines_L(3, i_L)+2;
        text(x, y, label, 'Color', 'green', 'FontSize', 8);
    end
end

hold off;
nameStr_l = [str 'left-' num2str(num_lines, '%03d') '-lines.png'];
exportgraphics(gcf, nameStr_l, 'Resolution', 300);
close(f1);

f2 = figure;
imshow(rightBody.img);
hold on;
num_lines = size(matchLines, 1);

for i = 1 : num_lines
    
    if matchLines(i, 1) ~= 0 && matchLines(i, 2) ~= 0
        i_L = matchLines(i, 1);
        i_R = matchLines(i, 2);
        plot(lines_R(1:2, i_R), lines_R(3:4, i_R), 'LineWidth', 1, 'Color', [1, 0, 0]);
        label = num2str(i_L);
        x = lines_R(1, i_R)+2;
        y = lines_R(3, i_R)+2;
        text(x, y, label, 'Color', 'green', 'FontSize', 8);
    end
end
hold off;
nameStr_r = [str 'right-' num2str(num_lines, '%03d') '-lines.png'];
exportgraphics(gcf, nameStr_r, 'Resolution', 300);
close(f2);


end