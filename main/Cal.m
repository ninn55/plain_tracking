function [Center, BBox] = Cal(A, Center)
%calculate the center and boundingbox of the object;
%the object is a small object positioned around the center of the image.
%A is the only input argument, which is supposed to be a greyscale
%image,preferd binery image;
%Center is a 1*2 array with the center of the image;
%can be plotted by plot(Center(1), Center(2));
%BBox is the boundingbox of the small object
%can be plotted by rectangle('position',BBox).
%Cneter is the Center of the previous frame a 2 dimention array.

 F = regionprops('table', A, 'centroid', 'boundingbox', 'Area');

switch nargin
    case 1
        flag = (abs(F.Centroid(:, 1) - 240) + abs(F.Centroid(:, 2) - 160)) > 30;
    case 2
        flag = (abs(F.Centroid(:, 1) - Center(1)) + abs(F.Centroid(:, 2) - Center(2))) > 20;
    otherwise
        error('input not valid')
end
flag_2 = F.Area > 1000; flag_3 = F.Area < 1; 
flag = flag | flag_2 | flag_3;

F(flag, :) = [];
B = F.BoundingBox;
C = F.Centroid;
S = F.Area;

Center = zeros(2, 1);
Center(1) = sum(C(:, 1) .* S) / sum(S);
Center(2) = sum(C(:, 2) .* S) / sum(S);

%{
B_1 = min(B(:, 1:2));
B_2 = max(B(:, 1:2) + B(:, 3:4));
BBox = [B_1, B_2 - B_1];
%}

BBox = [Center(1) - 20, Center(2) - 20, 40, 40];