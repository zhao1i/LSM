
clear;
close all;
addpath(genpath('./'));
vl_setup;       

res_fig_dir = './Results/';
phow_th = 0.8;
CAR_th = 0.5;
imL_rect = imread('./data/rectified_ref.png'); 
imR_rect = imread('./data/rectified_sec.png');  
lines = load('./data/lines.mat'); 
phow = load('./data/PHOW.mat');  
load( './data/asift_matches.txt', '-ascii');

fprintf('Start Algorithm: \n');
lines_l = lines.lines_l;    
lines_r = lines.lines_r;    

fprintf('Preprocessing ...\n');

fprintf('Generating line points ...\n');
[lines_l_label, slope_L] = do_line_points(lines_l, imL_rect);
[lines_r_label, slope_R] = do_line_points(lines_r, imR_rect);

fprintf('Generating line structures ...\n');
leftBody = do_struct(imL_rect, lines_l, lines_l_label, slope_L);
rightBody = do_struct(imR_rect, lines_r, lines_r_label, slope_R);

fprintf('Generating voronoi structures ...\n');
[asift_l, asift_r, voro_labMat] = do_voronoi(asift_matches, imL_rect, res_fig_dir);

fprintf('Matching lines ...\n');
matchLines = do_lineMatching(leftBody, rightBody, phow, phow_th, CAR_th, asift_l, asift_r, voro_labMat);

fprintf('Showing lines ...\n');

show_all_matchlines(matchLines, leftBody, rightBody, res_fig_dir);

fprintf('=============  Game over!  =============\n');

