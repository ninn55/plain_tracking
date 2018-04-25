function T = grey_thrush(A, T_1)
%calculate the grey thrushhold of the input image useing iteration algorithm;

switch nargin
    case 1
        T_1 = 150;
    case 2
        1 + 1;
    otherwise
        T = 150;
        return;
end

A = double(A); thrush = T_1;
while 1
    backgd = A < thrush;
    foregd = A >= thrush;
    E_1 = sum(sum(backgd .* A)) / sum(sum(backgd));
    E_2 = sum(sum(foregd .* A)) / sum(sum(foregd));
    temp = mean([E_1, E_2]);
    flag = abs(temp - thrush);
    if flag < 3
        break
    end
    thrush = temp;
end

T = thrush;
end
