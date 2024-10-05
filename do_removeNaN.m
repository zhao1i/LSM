function mat_clean = do_removeNaN(matchLines, num1, num2)

[~, idx] = unique(matchLines(:,1), 'rows', 'first');

mat_unique = matchLines(sort(idx), :);
matchLines = mat_unique;
mat_unique = matchLines;
mat_unique(mat_unique(:,1) > num1, 1) = NaN;
mat_unique(mat_unique(:,2) > num2, 2) = NaN;
nan_rows = isnan(mat_unique(:,1)) | isnan(mat_unique(:,2));

mat_clean = mat_unique(~nan_rows, :);

end