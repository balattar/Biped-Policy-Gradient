function P = generatePolicy(pi,e,n)
    P = [];
    for i = 1:n
         r1 = rand(1);
         r2 = rand(1);
         if (r1 < 0.3333) 
             P(i,1) = pi(1) + e(1);
         elseif (r1 < 0.66666) 
             P(i,1) = pi(1) - e(1);
         else
             P(i,1) = pi(1);
         end 
         
         if (r2 < 0.3333) 
             P(i,2) = pi(2) + e(2);
         elseif (r2 < 0.66666) 
             P(i,2) = pi(2) - e(2);
         else
             P(i,2) = pi(2);
         end 
    end
end

