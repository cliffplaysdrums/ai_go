%Description
%This function is for score check. It checks the element on west of 
%current Zero value
%
%Input: Board size and board state
%
%Output: Returns code for west value of matrix until either edge or a
%non-zero value is reached
%
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