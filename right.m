
function [rval,r_index]=right(i,j,mat,n)
    k=j;
    r_index=-1;
    if k==n
        rval=-1;      %this value is set if edge is encountered
    else 
        k=k+1;
        while(1)
            if (mat(i,k)==0)
                k=k+1;
            else
                rval=mat(i,k); %Right element has a value then return that
                r_index=k;
                break;    
            end    
            if k>n   %if edge is reached while traversing right
                rval=-2;
                break;
            end  
        end
    end
 end