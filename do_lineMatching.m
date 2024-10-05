function matchLines = do_lineMatching(leftBody, rightBody, phow, phow_th, CAR_th, asift_l, asift_r, voro_labMat)

show_point_FLAG = 0; 
show_line_FLAG = 0;  
img_l = leftBody.img;  
img_r = rightBody.img;
lines_l = leftBody.lines;  
lines_r = rightBody.lines;
lines_l_lab = leftBody.lineLabel;  
lines_r_lab = rightBody.lineLabel;
K_l = leftBody.slope;  
K_r = rightBody.slope;
[rows, cols] = size(img_l);
lines_r_BW = double(~(~lines_r_lab)); 

%% 
d_l = phow.d_L;
d_r = phow.d_R;

%% 
lineNum_l = size(lines_l, 2);
matchLines = zeros(lineNum_l, 2);  

for i = 1 : lineNum_l              
    % fprintf('------Computing the %dth left line ...\n', i);
    curlab_l = i;                   
    curK_l = K_l(curlab_l);         
    cur_l_bw = lines_l_lab == curlab_l;
    [rows_i, cols_i] = find(cur_l_bw);  

    % fprintf('------ Matching points ------\n');
    pts_num = length(rows_i);
    match_pts_i = [];
    t = 1;
    for i_p = 1 : pts_num                     
        r_l = rows_i(i_p);
        c_l = cols_i(i_p);
        d_l_Pt = d_l(:, rows*(c_l-1) + r_l); 
        
        match_pt_R = do_getRightMatchingPts(r_l, c_l, d_l_Pt, lines_r_BW, d_r, phow_th);
        if ~isnan(match_pt_R)
            match_pts_i(t, 1:2) = [r_l, c_l];
            match_pts_i(t, 3:4) = match_pt_R;
            t = t + 1;
        end
    end
    if ~isempty(match_pts_i)
        if show_point_FLAG
            show_points_lines(img_l, img_r, lines_l, lines_r, match_pts_i, curlab_l, result_dir);
        end
        lab_r = do_searchMatchingLines(cur_l_bw, match_pts_i, lines_r_lab, curK_l, K_r, CAR_th, asift_l, asift_r, voro_labMat);
        if lab_r ~= 0 
            matchLines(i, 1) = curlab_l; 
            matchLines(i, 2) = lab_r;   
            if show_line_FLAG
                show_curLines(img_l, img_r, lines_l_lab, lines_r_lab, curlab_l, lab_r, result_dir);
            end
           
            cur_r_BW = double(lines_r_lab == lab_r);
            lines_r_BW = lines_r_BW - cur_r_BW;  
        end
    end
end
matchLines = matchLines(matchLines(:,1) ~= 0 & matchLines(:,2) ~= 0, :);

end