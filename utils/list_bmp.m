%This function return a cell with ranked name of all file with extension
%".bmp".

%Referenses
%https://www.mathworks.com/matlabcentral/answers/275412-how-to-check-if-a-directory-folder-exists
%https://www.mathworks.com/help/matlab/ref/return.html
%https://www.mathworks.com/matlabcentral/answers/298215-how-to-get-ascii-value-of-characters-stored-in-an-array
%https://en.wikipedia.org/wiki/ASCII
%https://www.mathworks.com/help/matlab/ref/char.html


function ls = list_bmp(folder)
    %Build a init cell then rerank
    ls = {};
    
    if nargin ~= 1 && nargin ~= 0
        error('Input not valid!')
    elseif nargin == 0
        file = dir();
    else
        if exist(folder, 'dir') == 7
            file = dir(folder);
        else
            eroor('Input is not a diractory!')
            return
        end
    end
    
    for i = 1:size(file, 1)
        temp = file(i).name;
        if endsWith(temp, '.bmp')
            ls = [ls; temp];
        end
    end
    
    ls = rerank(ls);
end

function out = rerank(in)
    %Rerank the cell.
    temp = cell(size(in));
    out = cell(size(in));
    
    for i = 1:size(in, 1)
        temp{i} = find_num(in{i});
    end
    [~, ii] = sort(cell2mat(temp));
    for j = 1:size(in, 1)
        out{j} = in{ii(j)};
    end
end

function num = find_num(str)
    %Find the number in a str.
    %It makes scence if the number is continouse
    temp = double(str);
    num = [];
    for i = 1:size(temp, 2)
        if temp(i) >= 48 && temp(i) <= 57
            num = [num, char(temp(i))];
        end
    end
    num = str2double(num);
end