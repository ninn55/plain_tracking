%this script and the 2 following function is use to track a small object in
%the middle of the frame. it is tested useing specificly 'the plane' video.

clear; close all; clc;

v = VideoWriter('try.avi');
open(v)

num = 1;
filepath = strcat('assets\record', num2str(num), '.bmp');
A = imread(filepath); A = double(A);
T = grey_thrush(A);
A = A < T;
[Center, BBox] = Cal(A);
A = imread(filepath);

figure()
imshow(A)
hold on
rectangle('position', BBox, 'edgecolor', 'r');
plot(Center(1), Center(2), 'xr')

W = getframe;
writeVideo(v, W.cdata)
close all;

for num = 2:400
    %if T > 180, T = 160; end
    filepath = strcat('record', num2str(num), '.bmp'); 
    A = imread(filepath); A = double(A);
    %T = grey_thrush(A(round(BBox(2) - 5) : round(BBox(2) + BBox(4) + 5), round(BBox(1) - 5) : round(BBox(1) + BBox(3)) + 5), T);
    %T = grey_thrush(A(round(BBox(2)) : round(BBox(2) + BBox(4)), round(BBox(1)) : round(BBox(1) + BBox(3))), T);
    %T = graythresh(A(round(BBox(2)) : round(BBox(2) + BBox(4)), round(BBox(1)) : round(BBox(1) + BBox(3))));
    T = grey_thrush(A(round(Center(2) - 30 : Center(2) + 30), round(Center(1) - 30 : Center(1) + 30)), T);
    A = A < T;
    [Center, BBox] = Cal(A, Center);
    A = imread(filepath);
    if isnan(Center(1)), [Center, BBox] = Cal(A);end

    figure()
    imshow(A)
    hold on
    rectangle('position', BBox, 'edgecolor', 'r');
    plot(Center(1), Center(2), 'xr')
    
    W = getframe;
    writeVideo(v, W.cdata)
    close all;
end

close(v)