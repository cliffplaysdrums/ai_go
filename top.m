
function [tval,t_index]=top(i,j,mat)
    k=i;
    t_index=-1;
    if k==1
        tval=-1;      %this value is set if edge is encountered
    else 
        k=k-1;
        while(1)
            if (mat(k,j)==0)
                k=k-1;
            else
                tval=mat(k,j);  %top element has a value then return that
                t_index=k;
                break;    
            end    
            if k==0   %if edge is reached while traversing top
                tval=-2;
                break;
            end  
        end
    end
 end