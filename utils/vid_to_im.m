%This function take a video and make its frames into seperate image.
%Then name it "recordi.bmp"."i" means the number of frame.

function vid_to_im(file)
    num = 0;

    if nargin ~= 1
        error('Input not valid!')
    else
        if exist(file, 'file') == 2
            v = VideoReader(file);
        else
            eroor('Input is not a diractory!')
            return
        end
    end
    
    while hasFrame(v)
        num = num + 1;
        frame = readFrame(v);
        imwrite(frame, ['assets\record', num2str(num), '.bmp'])
    end
end