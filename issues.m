function [ u ] = issues( u )
%issues avoids possible problems that might occur when trying to do a quiver
%plot of the given input data u.
%   
%   NaN and inf values are set to zero.
%   In case of complex numbers - replacement by absolute value
% 
%   INPUT:
%       u - scalar value or array of arbitrary dimensions
% 
%   OUTPUT:
%       u - scalar value or array of arbitrary dimensions
% 
narginchk(1,1);
try
    u(isnan(u)) = 0;
    u(isinf(u)) = 0;
    if ~isreal(u)
        u = abs(u);
    end
catch
    error('Unable to perform operations on input data.');
end
end
