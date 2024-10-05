function [label_mat, slope] = do_line_points(lin_pts, img)


show_FLAG = 0;
[rr, cc] = size(img);

lines_pts = ceil(lin_pts);  

lines_pts(1, lines_pts(1,:) > cc) = cc;  
lines_pts(2, lines_pts(2,:) > cc) = cc;  

lines_pts(3, lines_pts(3,:) > rr) = rr;  
lines_pts(4, lines_pts(4,:) > rr) = rr;  

lines_pts(lines_pts == 0) = 1;  
line_num = size(lines_pts, 2);
label_mat = zeros(size(img));
slope = nan(line_num, 1);  
K = nan;                  
for i = 1 : line_num
    x1 = lines_pts(1, i);
    x2 = lines_pts(2, i);
    y1 = lines_pts(3, i);
    y2 = lines_pts(4, i);
    if y1 > y2
        tmp_y = y1;
        tmp_x = x1;
        y1 = y2;
        x1 = x2;
        y2 = tmp_y;
        x2 = tmp_x;
    end

    if x2-x1 == 0 
        label_mat(y1:y2, x1) = i;
        K = nan;
    else
        K = (y2-y1)/(x2-x1); 
  
        if abs(K) > 1
          
            y = y1;
            while y <= y2
                x = ceil(x1 + (1/K)*(y-y1));
                label_mat(y, x) = i;
                y = y + 1;
            end
        else
            
            if x1 > x2
                tmp_y = y1;
                tmp_x = x1;
                y1 = y2;
                x1 = x2;
                y2 = tmp_y;
                x2 = tmp_x;
            end
            x = x1;
            while x <= x2
                y = ceil(y1 + K*(x-x1));
                label_mat(y, x) = i;
                x = x + 1;
            end
        end
    end
    slope(i) = K; 
end

if show_FLAG
    show_lines(label_mat, img);  
end

end
