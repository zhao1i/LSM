function lab = do_searchMatchingLines(cur_l_bw, match_pts, lines_r_lab, curK_l, K_r, CAR_th, asift_l, asift_r, voro_labMat)


lab = 0;  
pts_num = size(match_pts, 1);
line_labs = zeros(pts_num, 1);
for i = 1 : pts_num
    r_i = match_pts(i, 3);
    c_i = match_pts(i, 4);
    line_labs(i) = lines_r_lab(r_i, c_i);
end
line_tab = tabulate(line_labs);     
dis_sort = sortrows(line_tab, -2);  
lab_R = dis_sort((dis_sort(:, 3)>10), 1);   
% lab_R = do_voronoi_heuristic(cur_l_bw, lab_R, lines_r_lab, asift_l, asift_r, voro_labMat);
if isnan(curK_l)               
    for j = 1 : length(lab_R)
        lab_R_j = lab_R(j);    
        K_R_j = K_r(lab_R_j); 
        if isnan(K_R_j)
            lab = lab_R_j;    
            break;
        end
    end
else 
    for j = 1 : length(lab_R)
        lab_R_j = lab_R(j);  
        K_R_j = K_r(lab_R_j); 
        interAng = do_interAngle(curK_l, K_R_j);
        interAng_pi = (interAng/180)*pi;
        p2j = sin(pi/2 - 3*interAng_pi);
%         fprintf('line label: %d, intersaction angle = %f\n', lab_R_j, interAng);
        if isnan(interAng) ||  p2j < CAR_th
            continue;  
        else
            lab = lab_R_j;
            break;    
        end
    end
end
end