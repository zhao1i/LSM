function do_homography_model(pt_l, pt_r, matching_pts_l, matching_pts_r)

movingPoints = matching_pts_r; 
fixedPoints = matching_pts_l; 

fixed_point1 = pt_l;
moving_point1 = pt_r;

num_trials = 1000;
max_distance = 1.5;
min_inliers = 0;
best_tform = [];
best_inliers = [];

num_points = size(movingPoints, 1);

for i = 1:num_trials
    
    random_indices = randperm(num_points - 1, 3) + 1;
    fixed_sample = [fixed_point1; fixedPoints(random_indices, :)];
    moving_sample = [moving_point1; movingPoints(random_indices, :)];
    tform = fitgeotrans(moving_sample, fixed_sample, 'projective');
    transformed_points = transformPointsForward(tform, movingPoints);
    distances = sqrt(sum((transformed_points - fixedPoints).^2, 2));
    inliers = distances < max_distance;
    num_inliers = sum(inliers);
    if num_inliers > min_inliers
        min_inliers = num_inliers;
        best_tform = tform;
        best_inliers = inliers;
    end
end

disp(best_tform.T);
disp(['内点数: ', num2str(min_inliers)]);
figure;
plot(movingPoints(best_inliers, 1), movingPoints(best_inliers, 2), 'go'); hold on;
plot(fixedPoints(best_inliers, 1), fixedPoints(best_inliers, 2), 'ro');
legend('Moving Points Inliers', 'Fixed Points Inliers');
title('RANSAC 内点匹配');

end