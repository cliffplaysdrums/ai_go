%Description
%This function generates the GO score at the end of the game.
%The game can end when there are no possible moves or when the same user 
%presses 'Pass' for two times.
%
%Input: Board state and board size
%
%Output: Generates individual score for both players and upon comparison
%displays who Won the game
%
%Submodules: left(i,j,mat)
%            right(i,j,mat,n)
%            top(i,j,mat)
%            down(i,j,mat,n)
%
function Go_score(capturedIndices,n)
disp(capturedIndices);
for rows=1:n    %n represents the size
    for cols=1:n
        if strcmp(capturedIndices(rows,cols),'n')
            mat(rows,cols)=0;
        elseif strcmp(capturedIndices(rows,cols),'b') 
            mat(rows,cols)=1;
        elseif strcmp(capturedIndices(rows,cols),'w')
            mat(rows,cols)=2;
        end
    end
end

% count = 0
runCount=1
while(runCount<=2)    %Run two times
 for i=1:n
     for j=1:n
         if mat(i,j)==0
            
            %Call Top_check function to check upper values
            [tval,t_index]=top(i,j,mat); 

            %Call Down_check function to check bottom values
            [dval,d_index]=down(i,j,mat,n);   
            
            %Call Right_check function to check right values
            [rval,r_index]=right(i,j,mat,n);
            
            %Call Left_check function to check left values
            [lval,l_index]=left(i,j,mat);
            
     %       This condition is to check if all values are same i.e. either
     %       BLACK or WHITE; replace the value of that in the matrix for
     %       that zero
             if ((tval==dval) & (dval==rval) & (rval==lval)) 
                 mat(i,j)=tval;
                 disp('Bingo');
     %###############################################            
     %HANDLE THIS CONDITION
     %########################################
                 
     %       This condition is to check if all values except lval are -1
     %       Hence Zero is replaced by LEFT VALUE
             elseif ((tval==dval) & (dval==rval) & (rval==-1)) 
                 mat(i,j)=lval; 

     %       This condition is to check if all values except lval are -1
     %       Hence Zero is replaced by RIGHT VALUE                 
             elseif ((tval==dval) & (dval==lval) & (lval==-1)) 
                 mat(i,j)=rval;   
                 
     %       This condition is to check if all values except lval are -1
     %       Hence Zero is replaced by TOP VALUE
             elseif ((rval==dval) & (dval==lval) & (lval==-1)) 
                 mat(i,j)=tval;  
                 
     %       This condition is to check if all values except lval are -1
     %       Hence Zero is replaced by BOTTOM VALUE
             elseif ((tval==rval) & (rval==lval) & (lval==-1)) 
                 mat(i,j)=dval; 
                 
             elseif ((tval==rval) & (rval==lval) & (lval==-1)) 
                 mat(i,j)=dval;                
                 
             elseif ((tval==-1) & (rval==-1) & (dval==lval))   
                 mat(i,j)=dval;
             
             elseif ((tval==-1) & (lval==-1) & (dval==rval))   
                 mat(i,j)=dval;    
             
             elseif ((dval==-1) & (rval==-1) & (tval==lval))   
                 mat(i,j)=tval; 
             
             elseif ((dval==-1) & (lval==-1) & (tval==rval))   
                 mat(i,j)=tval; 
             
             elseif ((tval==-1) & (dval==-1) & (lval==rval))   
                 mat(i,j)=lval;   
             
             elseif ((rval==-1) & (lval==-1) & (tval==dval))   
                 mat(i,j)=tval;    
     
    %Case with three values are same and one is edge             
             elseif ((rval==lval) & (lval==tval) & (dval==-1))   
                 mat(i,j)=tval;     
             
             elseif ((rval==lval) & (lval==dval) & (tval==-1))   
                 mat(i,j)=dval;    
             
             elseif ((rval==tval) & (tval==dval) & (lval==-1))   
                 mat(i,j)=rval;    
                 
             elseif ((lval==tval) & (tval==dval) & (rval==-1))   
                 mat(i,j)=lval;     
    
             end    
             disp(mat);
         end
     end
 end
 runCount=runCount+1;
 end
 
 %Once details of all areas belonging to either White or Black is obtained
 %then score is calculated as
 %Score_Black = Number of black coins (including played pieces and area
 %belonging to black) - Captured_Black_pieces
 
 %Score_White = Number of black coins (including played pieces and area
 %belonging to black) + 7.5 points (Komi rule for white to start second) 
 % - Captured_White_pieces 
 
     number_search=[0;1;2];
     mat_number_count = [number_search,histc(mat(:),number_search)];

     black_score=mat_number_count(2,2)   %-captured_pieces
     white_score=(mat_number_count(3,2))+7.5  %-captured_pieces

     scoreBlack=sprintf('         The score for Black is %4.2f',black_score);
     scoreWhite=sprintf('         The score for White is %4.2f',white_score);

     %Display the final score
     if black_score > white_score
        prompt = '     Congratulations, Black won the game !';

     elseif black_score < white_score  
        prompt = '     Congratulations, White won the game !';

     else
        prompt = '     Its a tie !                          ';
     end   
 
    [myicon,map] = imread('GO.jpg');
    data=sprintf('%s\n%s\n\n%s',scoreBlack,scoreWhite,prompt)
    prompt={data};
    h = msgbox(prompt);

    set(h, 'position', [100 300 400 120]); %makes box bigger
    ah = get( h, 'CurrentAxes' );
    ch = get( ah, 'Children' );
    set( ch, 'FontSize', 15 ); %makes text bigger

end