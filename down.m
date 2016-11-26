
function [dval,d_index]=down(i,j,mat,n)
    k=i;
    d_index=-1;
    if k==n
        dval=-1;      %this value is set if edge is encountered
    else 
        k=k+1;
        while(1)
            if (mat(k,j)==0)
                k=k+1;
            else
                dval=mat(k,j);  %top element has a value then return that
                d_index=k;
                break;    
            end    
            if k>n   %if edge is reached while traversing top
                dval=-2;
                break;
            end  
        end
    end
 end