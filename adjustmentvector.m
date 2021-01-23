function A = adjustmentvector(pi,P,S,Spi)
    A = [0 0];
    ave1plus = [];
    ave1minus = [];
    ave1zero = [];
    
    ave2plus = [];
    ave2minus = [];
    ave2zero = [];
    for i = 1:length(P(:,1))
        if (P(i,1) > pi(1)) 
            ave1plus = [ave1plus S(i)];
        elseif (P(i,1) < pi(1)) 
            ave1minus = [ave1minus S(i)];
        else
            ave1zero = [ave1zero S(i)];
        end
        
        if (P(i,2) > pi(2)) 
            ave2plus = [ave2plus S(i)];
        elseif (P(i,2) < pi(2)) 
            ave2minus = [ave2minus S(i)];
        else
            ave2zero = [ave2zero S(i)];
        end

    end
    ave1zero = [ave1zero Spi];
    ave2zero = [ave2zero Spi];
    
    ave1plus = mean(ave1plus) ;
    ave1minus = mean(ave1minus) ;
    ave1zero = mean(ave1zero) ;
    ave2plus = mean(ave2plus) ;
    ave2minus = mean(ave2minus);
    ave2zero = mean(ave2zero) ;
    
       if (isnan(ave1plus)) 
        ave1plus = 0;
       end
       if (isnan(ave1minus)) 
        ave1minus = 0;
       end
       if (isnan(ave1zero)) 
        ave1zero = 0;
       end
       if (isnan(ave2plus)) 
        ave2plus = 0;
       end
       if (isnan(ave2minus)) 
        ave2minus = 0;
       end
       if (isnan(ave2zero)) 
        ave2zero = 0;
       end

    if (ave1zero >= ave1plus && ave1zero >= ave1minus)
        A(1) = 0;
    else 
        A(1) = ave1plus - ave1minus;
    end
    
    if (ave2zero >= ave2plus && ave2zero >= ave2minus)
        A(2) = 0;
    else 
        A(2) = (ave2plus - ave2minus);
    end
    
    Amag = sqrt(A(1)^2 + A(2)^2);
    if (Amag ~= 0)
        A = A/Amag;
    end
end

