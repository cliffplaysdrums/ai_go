function [lval,l_index]=left(i,j,mat)
    k=j;
    l_index=-1;
    if k==1
        lval=-1;      %this value is set if edge is encountered
    else 
        k=k-1;
        while(1)
            if (mat(i,k)==0)
                k=k-1;
            else
                lval=mat(i,k);  %Left element has a value then return that
                l_index=k;
                break;    
            end    
            if k<1   %if edge is reached while traversing left
                lval=-2;
                break;
            end  
        end
    end
 end