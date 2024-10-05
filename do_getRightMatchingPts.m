function match_pt_R = do_getRightMatchingPts(r_L, c_L, d_L_Pt, linesR_BW, d_R, CAR_th)


th = 1000;
disp_rang = [-20, 85];
match_pt_R = [nan, nan];  
[rows, cols] = size(linesR_BW);
zero_M = zeros(rows, cols);
sch_rag = disp_rang + c_L;
if sch_rag(1) < 1
    sch_rag(1) = 1;
end
if sch_rag(2) > cols
    sch_rag(2) = cols;
end
zero_M(r_L, sch_rag(1):sch_rag(2)) = 1;
zero_M_1 = zero_M & linesR_BW;  
[rows_epp, cols_epp] = find(zero_M_1);  
pts_num_R = length(rows_epp);
dist_phow = nan(pts_num_R, 2); 
if pts_num_R ~= 0   
    for j = 1 : pts_num_R
        r_R = rows_epp(j);
        c_R = cols_epp(j);
        d_R_Pt = d_R(:, rows*(c_R-1) + r_R);  
        dist_j = pdist([d_L_Pt'; d_R_Pt'], 'euclidean');  
        dist_phow(j, 1) = c_R;
        dist_phow(j, 2) = dist_j;
    end
    if pts_num_R == 1
        if dist_phow(2) < th
            match_pt_R(2) = dist_phow(1);  
            match_pt_R(1) = r_L;  
        end
    else
     
        dis_sort = sortrows(dist_phow, 2);  
        if dis_sort(1, 2) < th && dis_sort(1, 2)/dis_sort(2, 2) < CAR_th
            match_pt_R(1) = r_L;            
            match_pt_R(2) = dis_sort(1, 1);  
        end
        
    end
end
end