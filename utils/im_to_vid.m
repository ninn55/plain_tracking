%This function take all the image from a folder and make it into a video.

function im_to_vid(folder)
    v = VideoWriter('plain.avi');
    
    if nargin ~= 1 && nargin ~= 0
        error('Input not valid!')
    elseif nargin == 0
        file = list_bmp();
    else
        if exist(folder, 'dir') == 7
            file = list_bmp(folder);
        else
            eroor('Input is not a diractory!')
            return
        end
    end
    
    open(v)
    
    for i = 1:size(file, 1)
        temp = imread([folder, file{i}]);
        writeVideo(v, temp);
    end
    
    close(v)
end