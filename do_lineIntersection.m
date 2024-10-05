function do_lineIntersection(matchLines, leftBody, rightBody)

linesL_lab = leftBody.lineLabel; 
linesR_lab = rightBody.lineLabel;

lineNum = size(matchLines, 1);
for i = 1 : lineNum
    lab_L = matchLines(i, 1);
    lab_R = matchLines(i, 2);
    if lab_L ~= 0 && lab_R ~= 0  
        [rows_L, cols_L] = find(linesL_lab == lab_L);  
        [rows_R, cols_R] = find(linesR_lab == lab_R);  
        [int_rows, IL, IR] = intersect(rows_L, rows_R);
        inter_cols_L = cols_L(IL);
        inter_cols_R = cols_R(IR);
        
        
        

    end
end



end