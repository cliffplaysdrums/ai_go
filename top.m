%Description
%This function is for score check. It checks the element on north of 
%current Zero value
%
%Input: Board size and board state
%
%Output: Returns code for north value of matrix until either edge or a
%non-zero value is reached
%
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