for i = 1:size(Elem,1)
    cen = elem_centroid(i,:);
    switch g_index
        case 1
            % circle
        cond = ((cen(1))^2 + (cen(2))^2 <= 1);
        case 2
            % cross
        cond = ( -1 <= cen(1) && cen(1) <= 1 && -0.5 <= cen(2) && cen(2) <= 0.5 )||...
                   (-1 <= cen(2) && cen(2) <= 1 && -0.5 <= cen(1) && cen(1)<= 0.5 );
        case 3
            cond = ( 0 <= cen(1) && cen(1) <= 1/2 && -1 <= cen(2) && cen(2) <= 1 )||...
                  ((cen(1) + 1/4)^2 + cen(2)^2 <= 25/16 && cen(1) >= 1/2);
        case 4
            cond = (0 <= cen(1)) && (0.5^2 <= cen(1)^2 + cen(2)^2) && (cen(1)^2 + cen(2)^2 <= 1);
    end
    
%cond = ((cen(1) + 1)^2 + (cen(2) + 1)^2 <= 1/4) || ((cen(1) + 1)^2 + (cen(2) - 1)^2 <= 1/4) ||...
%        ((cen(1) - 1)^2 + (cen(2) + 1)^2 <= 1/4) || ((cen(1) - 1)^2 + (cen(2) - 1)^2 <= 1/4);
%  square
%      cond = ( -1 <= cen(1) && cen(1) <= 1 && -0.5 <= cen(2) && cen(2) <= 0.5 )||...
%                    (-1 <= cen(2) && cen(2) <= 1 && -0.5 <= cen(1) && cen(1)<= 0.5 );
               
    if cond == 1
        vol_frac(i,1) = 0.8;
    end
    
    if g_index == 5
        % assigns volume fraction in the case of irregular geometry
        irregular_vfac_assign;
    end
end

