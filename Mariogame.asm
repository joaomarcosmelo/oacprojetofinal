
.model small
.stack
.data
;--------------Starting Screen Variables-------------------------;
super_mario db "!!! SUPER MARIO GAME !!!"
start_str db "Press Enter to start"
space_bar db "Press Space bar for instruction"
username_str db "Enter your user name"
instruction1 db "In Super Mario,the character Mario sets off on an adventure to save the Kingdom"
instruction2 db "Mario will start running from the right side of the screen towards the flag and jump over the hurdles"
instruction3 db "Mario runs using left-right arrow keys  and jumps using up arrow key"
instruction4 db "There are total three levels in the game"
instruction5 db "In Level2, There will be enemies betweenthe hurdles and collission will make youlose"
instruction6 db "In Level3, There will be a monster whichthrows objects to stop mario"

;-------------Level Complete Screen Variables----------------------;
level1_str1 db "LEVEL 1 COMPLETED"
level1_str2 db "Press Enter to start Level2" 
score1_str db "Your Score is 100 points" 

level2_str1 db "LEVEL 2 COMPLETED"
level2_str2 db "Press Enter to start Level3"
score2_str  db "Your Score is 200 points"

cong_str db "CONGRATULATIONS!!!"
won_str db "You Have Won the Game"
score3_str db "Your Score is 300 points"

quit_str db "Press Q to Quit Game"
gameover_str db "GAME OVER" 
lose_str db "You Have Lost the Game"

;--------------Create Square Function Variables----------------------;
temp word ?
temp2 word ?
squarewidth word ?
squarelength word ?
row word ?
column word ?
rowcoordinate word ?
columncoordinate word ?
rowcounter word ?
columncounter word ?
squarecolor byte ?

;-------------Create Mario Function Variables----------------------;
;----These are the starting values of mario-------;
row_coordinates word 157,166,170,188,188,170,170
col_coordinates word 14,16,10,13,21,5,27

mario_ground_row word 157,166,170,188,188,170,170

;----These are the starting coordinates of enemy1-------;
E1_row word 187,197,197,189,189
E1_col word 76,76,83,77,83 
;----These are the starting coordinates of enemy2-------;
E2_row word 187,197,197,189,189
E2_col word 156,156,163,157,163

;----These are the starting variables of monster-----;
M_row word 6,0,0,10,10,10,10,16 
M_col word 270,275,287,262,293,277,287,281

;---These are the starting variables of bomb-----;
B_row word 26
B_col word 282

;---------------Border test variables--------------;
leftbordercoordinate word 3
rightbordercoordinate word 300 
borderreturn word 0 ;used as the return parameter

;coordinates of mario's arms
leftarmcheck word 0
rightarmcheck word 0

flagcheck word 0
kingdomreturn word 0
;----------------Collision test variables-------------;

;;;;;;;Enemy Collision;;;;;

enemycollide word 0

;;;;
marioleftarmcolumn word 0
mariorightarmcolumn	word 0

hurdleleftreturn word 0
hurdlerightreturn word 0


;;;;;;;;;;;;;

hurdleoneleftreturn word 0
hurdleonerightreturn word 0
hurdleonetopreturn word 0


hurdletwoleftreturn word 0
hurdletworightreturn word 0
hurdletwotopreturn word 0


hurdlethreeleftreturn word 0
hurdlethreerightreturn word 0
hurdlethreetopreturn word 0

;;;;;;;;;;;

;--------------Jumping Variables-------------------;
jumpinglooptemp word 0
jumpfactor word 0
jumprightcheck word 0
jumpleftcheck word 0

;------------Additional Variables-------------------;
enemymovetemp word 0
enemyturncheck word 0
enemymovementcheck word 0
leveltwocheck word 0
levelthreecheck word 0
monstermovementcheck word 0
bombonecheck word 0
bombtwocheck word 0
bombthreecheck word 0

.code
START:
mov ax,@data 
mov ds,ax 
jmp main 
                ;;;;;;;;;;;;;    Clears screen in text mode     ;;;;;;;;;;;;;
	clearscreen_textmode PROC
		mov al,02
		int 10h 
		ret 
	clearscreen_textmode ENDP
	             ;;;;;;;;;;;     Clears screen in graphics mode  ;;;;;;;;;;;;;;
	clearscreen_graphicsmode PROC 
		mov ax,0600h    ;06 to scroll
		mov bh,0h     	;black color 
		mov cx,0000h    ;starting coordinate
		mov dx,184Fh    ;ending coordinate
		int 10h
		ret 
	clearscreen_graphicsmode ENDP
	
	                    ;;;;;;;;;; First Screen Appears ;;;;;;;;;;;;;;;;;;;
	screen1 PROC   
		;;;;;;Displaying name of game in color;;;;;;;;
		mov ax,@data
		mov ds,ax
		mov es,ax        ;For this es should point to ax 
		call clearscreen_textmode
     
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET super_mario  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,4                   ;4 for red color 
		mov cx,24                  ;length of string 
		mov dh,6                   ;Row 
		mov dl,6                   ;Column
		int 10h
        
		mov ax,0
		mov bp,OFFSET start_str   ;bp points to text
		mov ah,13h                ;writes the string 
		mov al,01h 
		mov bh,0                  ;VideoPage 0 
		mov bl,6                  ;6 for brown color 
		mov cx,20                 ;length of string 
		mov dh,10                 ;Row 
		mov dl,8                  ;Column
		int 10h
		
		mov ax,0
		mov bp,OFFSET space_bar ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                  ;VideoPage 0 
		mov bl,6                  ;6 for brown color 
		mov cx,31                 ;length of string 
		mov dh,14                 ;Row 
		mov dl,4                  ;Column
		int 10h
		
		input:
		mov ah,07h
		int 21h  
		cmp al,13      ;if enter key is pressed 
		je exitfunc
		cmp al,32      ;if space bar is pressed 
		je L1
		jne input      ;till enter key isnt pressed 
	
	L1: call instruction_screen
		call clearscreen_graphicsmode
		mov ax,0
		mov bp,OFFSET start_str    ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,6                   ;6 for brown color 
		mov cx,20                  ;length of string 
		mov dh,10                  ;Row 
		mov dl,8                   ;Column
		int 10h
	input1:
		mov ah,07h
		int 21h  
		cmp al,13      ;if enter key is pressed 
		je clearscreen_graphicsmode
		jne input1    ;till enter key isnt pressed
	exitfunc:
	call clearscreen_graphicsmode	
	ret 
	screen1 ENDP 
	
			;;;;;;;;;;    Second screen appears     ;;;;;;;;;;;
	screen2 PROC 
		mov ax,@data 
		mov ds,ax
		mov es,ax     ;es should point to data segement for displaying the coloured strings in this mode 
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET username_str ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,6                   ;6 for brown color 
		mov cx,20                  ;length of string 
		mov dh,6                   ;Row 
		mov dl,8                   ;Column
		int 10h

		L1:                        ;This sets the cursor position 
		mov ah,02h
		mov bh,0
		mov dh,8
		mov dl,12
		int 10h 
        mov cx,0 
		
		L2:                        ;This takes input of username until enter key is pressed 
			mov ah,01h
			int 21h                ;input character is stored in al 
			cmp al,13 
			je return
			mov ah,09h             ;Writes character at cursor position 
			mov bh,0 
			mov bl,1               
			int 10h
		jmp L2 
		
		; start_level1:
		; call clearscreen_graphicsmode
		; call firstlevel
		
		return : ret 
	screen2 ENDP 
	
	instruction_screen PROC 
		call clearscreen_graphicsmode
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET instruction1 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,14                  ;14 for yellow color 
		mov cx,79                  ;length of string 
		mov dh,3                   ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov bp,OFFSET instruction2 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,1                   ;1 for blue color 
		mov cx,101                 ;length of string 
		mov dh,6                   ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov bp,OFFSET instruction3 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,8                   ;8 for Dark Gray color 
		mov cx,68                  ;length of string 
		mov dh,10                  ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov bp,OFFSET instruction4 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,9                   ;8 for Dark Gray color 
		mov cx,40                  ;length of string 
		mov dh,13                  ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov bp,OFFSET instruction5 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,13                  ;13 for Light Magenta color 
		mov cx,84                  ;length of string 
		mov dh,15                  ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov bp,OFFSET instruction6 ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,11                  ;11 for Light Cyan color 
		mov cx,68                  ;length of string 
		mov dh,19                  ;Row 
		mov dl,0                   ;Column
		int 10h
		
		mov ah,00h    ;get any key 
		int 16h 
	ret 
	instruction_screen ENDP

	level1_complete_screen PROC 
		mov ax,@data 
		mov ds,ax
		mov es,ax     ;es should point to data segement for displaying the coloured strings in this mode 
		call clearscreen_graphicsmode
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET level1_str1  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,2                   ;2 for green color 
		mov cx,17                  ;length of string 
		mov dh,6                   ;Row 
		mov dl,11                   ;Column
		int 10h
		
		mov bp,OFFSET score1_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,2                   ;2 for green color 
		mov cx,24                  ;length of string 
		mov dh,8                   ;Row 
		mov dl,8                   ;Column
		int 10h
		
		mov bp,OFFSET level1_str2  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,2                   ;2 for green color 
		mov cx,27                  ;length of string 
		mov dh,10                  ;Row 
		mov dl,6                   ;Column
		int 10h
		
		mov bp,OFFSET quit_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,2                   ;2 for green color 
		mov cx,20                  ;length of string 
		mov dh,12                  ;Row 
		mov dl,9                   ;Column
		int 10h
		
		input:
			mov ah,07h
			int 21h
			cmp al,13   ;when enter is pressed it moves to level2 function 
			je L2 
			cmp al,113
			je E 
		jne input 
		L2:
		jmp return 
		E:
		jmp EXIT
	
	return: ret
	level1_complete_screen ENDP

	level2_complete_screen PROC 
		mov ax,@data 
		mov ds,ax
		mov es,ax     ;es should point to data segement for displaying the coloured strings in this mode 
		call clearscreen_graphicsmode
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET level2_str1  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,1                   ;1 for blue color 
		mov cx,17                  ;length of string 
		mov dh,6                   ;Row 
		mov dl,11                   ;Column
		int 10h
		
		mov bp,OFFSET score2_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,1                   ;1 for blue color 
		mov cx,24                  ;length of string 
		mov dh,8                   ;Row 
		mov dl,8                   ;Column
		int 10h
		
		mov bp,OFFSET level2_str2  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,1                   ;1 for blue color 
		mov cx,27                  ;length of string 
		mov dh,10                  ;Row 
		mov dl,6                  ;Column
		int 10h
		
		mov bp,OFFSET quit_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,1                   ;1 for blue color 
		mov cx,20                  ;length of string 
		mov dh,12                  ;Row 
		mov dl,9                   ;Column
		int 10h
		
		input:
			mov ah,07h
			int 21h
			cmp al,13   ;when enter is pressed it moves to level2 function 
			je L2 
			cmp al,113
			je E 
		jne input 
		L2:
			
		jmp return 
		E:
		jmp EXIT
	
	return:
	call clearscreen_graphicsmode
	ret 
	level2_complete_screen ENDP 
	
	level3_complete_screen PROC 
		mov ax,@data 
		mov ds,ax
		mov es,ax     ;es should point to data segement for displaying the coloured strings in this mode 
		call clearscreen_graphicsmode
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET cong_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,14                  ;14 for yellow color 
		mov cx,18                  ;length of string 
		mov dh,6                   ;Row 
		mov dl,11                  ;Column
		int 10h
		
		mov bp,OFFSET won_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,14                  ;14 for yellow color 
		mov cx,21                  ;length of string 
		mov dh,8                   ;Row 
		mov dl,10                  ;Column
		int 10h
		
		mov bp,OFFSET score3_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,14                  ;14 for yellow color 
		mov cx,24                  ;length of string 
		mov dh,10                  ;Row 
		mov dl,8                   ;Column
		int 10h
		
		mov ax,00h    ;wait till key is pressed 
		int 16h 
	return: ret
	level3_complete_screen ENDP 
	
	gameover_screen PROC 
		mov ax,@data 
		mov ds,ax
		mov es,ax     ;es should point to data segement for displaying the coloured strings in this mode 
		call clearscreen_graphicsmode
		mov ax,0       ;Graphics mode is Set 
		mov ah,0h
		mov al,13h
		int 10h 
		
		mov bp,OFFSET gameover_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,4                   ;4 for red color 
		mov cx,9                  ;length of string 
		mov dh,8                   ;Row 
		mov dl,14                 ;Column
		int 10h
		
		mov bp,OFFSET lose_str  ;bp points to text
		mov ah,13h                 ;writes the string 
		mov al,01h 
		mov bh,0                   ;VideoPage 0 
		mov bl,4                   ;4 for red color 
		mov cx,22                  ;length of string 
		mov dh,10                   ;Row 
		mov dl,8                  ;Column
		int 10h

		mov ax,00h     ;get any key, this is to stay on screen till key is pressed 
		int 16h 
		jmp EXIT
	
	return: ret
	gameover_screen ENDP

	createsquare PROC 
		mov bp,sp
		mov ax,[bp+8]
		mov row,ax
		
		mov ax,[bp+6]
		mov column,ax
		
		mov ax,[bp+4]
		mov rowcoordinate,ax
		
		mov ax,[bp+2]
		mov columncoordinate,ax
		
		mov ax,[bp+10]
		mov ah,0
		mov squarecolor,al 

		mov bx,0
		mov rowcounter,bx
		mov cx,row
		square:
			;prints pixel lines row by row to create a square
		
			mov temp2,cx
			mov bx,0
			mov columncounter,bx
			mov cx,column
		innersquare:
			;draws horizontal line acoording to columns length
		
			mov temp,cx
			mov ah,0Ch
			mov al,squarecolor
			mov cx,columncoordinate  ;column starting
			mov dx,rowcoordinate	 ;row  starting	
			add cx,columncounter
			add dx,rowcounter
			int 10h
				
			mov cx,temp
			inc columncounter
		loop innersquare
			
		inc rowcounter
		mov cx,temp2
	
	loop square
	ret 10	
	createsquare ENDP

	createMario PROC
		mov SI,offset row_coordinates
		mov DI,offset col_coordinates
		;---------------Forming face of Mario-------------;
		mov ax,0		;squarecolor 
		mov al,0Eh   	;0E for yellow  
		push ax 
		
		mov ax,9  		;rows
		push ax

		mov ax,9		;columns
		push ax

		mov ax,[SI]  	;row coordinate
		push ax

		mov ax,[DI]		;col coordinate
		push ax
		
		call createsquare
		
		;--------------Forming neck of Mario----------------;
		mov ax,0    	;squarecolor 
		mov al,03   	;03 for cyan 
		push ax
		
		mov ax,4  		;rows 
		push ax
		
		mov ax,4   		;columns 
		push ax 
		
		mov ax,[SI+2] 	;row coordinate 
		push ax 
		
		mov ax,[DI+2]   ;column coordinate 
		push ax 
		
		call createsquare
		
		;--------------Forming body of Mario---------------;
		mov ax,0    	;squarecolor 
		mov al,01   	;01 for blue   
		push ax
		
		mov ax,18  		;rows 
		push ax
		
		mov ax,17  		;columns 
		push ax 
		
		mov ax,[SI+4] 	;row coordinate 
		push ax 
		
		mov ax,[DI+4]   ;column coordinate 
		push ax 
		
		call createsquare
		
		;-------------Forming Legs of Mario-------------;
		;;;Left leg 
		mov ax,0    	;squarecolor 
		mov al,03   	;03 for cyan   
		push ax
		
		mov ax,12  		;rows 
		push ax
		
		mov ax,4  		;columns 
		push ax 
		
		mov ax,[SI+6] 	;row coordinate 
		push ax 
		
		mov ax,[DI+6]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;Right leg 
		mov ax,0    	;squarecolor 
		mov al,03   	;03 for cyan   
		push ax
		
		mov ax,12  		;rows 
		push ax
		
		mov ax,4  		;columns 
		push ax 
		
		mov ax,[SI+8] 	;row coordinate 
		push ax 
		
		mov ax,[DI+8]   ;column coordinate 
		push ax 
		
		call createsquare
		;-----------Forming arms of mario---------------;
		;;;Left arm 
		mov ax,0    	;squarecolor 
		mov al,03   	;03 for cyan   
		push ax
		
		mov ax,3  		;rows 
		push ax
		
		mov ax,5  		;columns 
		push ax 
		
		mov ax,[SI+10] 	;row coordinate 
		push ax 
		
		mov ax,[DI+10]  ;column coordinate 
		push ax 
		
		call createsquare
		;;;Right arm 
		mov ax,0    	;squarecolor 
		mov al,03   	;03 for cyan   
		push ax
		
		mov ax,3  		;rows 
		push ax
		
		mov ax,5  		;columns 
		push ax 
		
		mov ax,[SI+12] 	;row coordinate 
		push ax 
		
		mov ax,[DI+12]  ;column coordinate 
		push ax 
		
		call createsquare
	ret 
	createMario ENDP 

	createhurdles PROC 

		hurdle1:
		
		;prints the lower hurdle box
		
		mov ax,4
		push ax
		mov ax,20   ;height
		push ax
		mov ax,15	;width
		push ax
		mov ax,180  ;row coordinate
		push ax
		mov ax,60	;col coordinate
		push ax
		call createsquare

		;prints the upper hurdle box
		
		mov ax,4
		push ax
		mov ax,10   ;height
		push ax
		mov ax,25	;width
		push ax
		mov ax,170  ;row coordinate
		push ax
		mov ax,55	;col coordinate
		push ax
		call createsquare

		;similar printing pattern followed in hurdle 2 and 3

		hurdle2:
		
		mov ax,4
		push ax
		mov ax,30   ;height
		push ax
		mov ax,15	;width
		push ax
		mov ax,170  ;row coordinate
		push ax
		mov ax,140	;col coordinate
		push ax
		call createsquare

		mov ax,4
		push ax
		mov ax,10   ;height
		push ax
		mov ax,25	;width
		push ax
		mov ax,160  ;row coordinate
		push ax
		mov ax,135	;col coordinate
		push ax
		call createsquare

		hurdle3:
		mov ax,4
		push ax
		mov ax,40   ;height
		push ax
		mov ax,15	;width
		push ax
		mov ax,160  ;row coordinate
		push ax
		mov ax,220	;col coordinate
		push ax
		call createsquare

		mov ax,4
		push ax
		mov ax,10   ;height
		push ax
		mov ax,25	;width
		push ax
		mov ax,150  ;row coordinate
		push ax
		mov ax,215	;col coordinate
		push ax
		call createsquare	

	ret

	createhurdles ENDP 

	createflag PROC 
		;making the rod
		
		rod:
		mov ax,15
		push ax
		mov ax,190  ;height
		push ax
		mov ax,5	;width
		push ax
		mov ax,10   ;row coordinate
		push ax
		mov ax,310	;col coordinate
		push ax
		call createsquare

		
		;making the flag
		flag:
		mov ax,2
		push ax
		mov ax,40   ;height
		push ax
		mov ax,60	;width
		push ax
		mov ax,10   ;row coordinate
		push ax
		mov ax,245	;col coordinate
		push ax
		call createsquare
		
		;;Code for creating moon in the flag using squares 
		moon:    
		;;;;Square1 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,17  ;row coordinate 
		push ax 
		
		mov ax,280 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square2
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,21  ;row coordinate 
		push ax 
		
		mov ax,284 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square3 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,25  ;row coordinate 
		push ax 
		
		mov ax,288 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square4 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,29  ;row coordinate 
		push ax 
		
		mov ax,292 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square5 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,33  ;row coordinate 
		push ax 
		
		mov ax,288 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square6 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,37  ;row coordinate 
		push ax 
		
		mov ax,284 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square7 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,41  ;row coordinate 
		push ax 
		
		mov ax,280 ;column coordinate 
		push ax 
		
		call createsquare
		
		;;;This code forms star in the flag using squares 
		star:
		;;;;Square1
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,25  ;row coordinate 
		push ax 
		
		mov ax,265 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square2
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,29  ;row coordinate 
		push ax 
		
		mov ax,269 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square3
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,33  ;row coordinate 
		push ax 
		
		mov ax,265 ;column coordinate 
		push ax 
		
		call createsquare
		;;;;Square4 
		mov ax,0
		mov al,0Fh     ;0F for white       
		push ax
		
		mov ax,4  	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,29  ;row coordinate 
		push ax 
		
		mov ax,261 ;column coordinate 
		push ax 
		
		call createsquare

	ret
	createflag ENDP 
	
	createEnemies PROC 
		;----------------------Forming Enemy 1--------------------;
		mov SI,offset E1_row
		mov DI,offset E1_col
		;;;Face of Enemy1
		mov ax,0
		mov al,08  	;08 for dark gray    
		push ax
		
		mov ax,10  	;rows 
		push ax
		
		mov ax,10  	;columns 
		push ax 
		
		mov ax,[SI] ;row coordinate 
		push ax 
		
		mov ax,[DI] ;column coordinate 
		push ax 
		
		call createsquare
		;;;left leg of Enemy1
		mov ax,0
		mov al,0Dh 	;0D for magenta      
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+2] ;row coordinate 
		push ax 
		
		mov ax,[DI+2] ;column coordinate 
		push ax 
		
		call createsquare
		;;;right leg of Enemy1
		mov ax,0
		mov al,0Dh  ;0D for magenta      
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+4] ;row coordinate 
		push ax 
		
		mov ax,[DI+4] ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of Enemy1 
		mov ax,0
		mov al,0  	;0 for black      
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+6] ;row coordinate 
		push ax 
		
		mov ax,[DI+6] ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of Enemy1 
		mov ax,0
		mov al,0  ;0 for black      
		push ax
		
		mov ax,2  ;rows 
		push ax
		
		mov ax,2  ;columns 
		push ax 
		
		mov ax,[SI+8] ;row coordinate 
		push ax 
		
		mov ax,[DI+8] ;column coordinate 
		push ax 
		
		call createsquare
		
		;----------------------Forming Enemy 2--------------------;
		mov SI,offset E2_row
		mov DI,offset E2_col
		;;;Face of Enemy2
		mov ax,0
		mov al,08  ;08 for dark gray    
		push ax
		
		mov ax,10  ;rows 
		push ax
		
		mov ax,10  ;columns 
		push ax 
		
		mov ax,[SI] ;row coordinate 
		push ax 
		
		mov ax,[DI] ;column coordinate 
		push ax 
		
		call createsquare
		;;;left leg of Enemy2
		mov ax,0
		mov al,0Dh 	;0D for magenta      
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+2] ;row coordinate 
		push ax 
		
		mov ax,[DI+2] ;column coordinate 
		push ax 
		
		call createsquare
		;;;right leg of Enemy2
		mov ax,0
		mov al,0Dh	;0D for magenta      
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+4] ;row coordinate 
		push ax 
		
		mov ax,[DI+4] ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of Enemy2 
		mov ax,0
		mov al,0	;0 for black      
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+6] ;row coordinate 
		push ax 
		
		mov ax,[DI+6] ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of Enemy2 
		mov ax,0
		mov al,0  ;0 for black      
		push ax
		
		mov ax,2  ;rows 
		push ax
		
		mov ax,2  ;columns 
		push ax 
		
		mov ax,[SI+8] ;row coordinate 
		push ax 
		
		mov ax,[DI+8] ;column coordinate 
		push ax 
		
		call createsquare
	ret 
	createEnemies ENDP 

	createKingdom PROC
		;-----------BOX 1----------;
		mov ax,0
		mov al,08  ;08 for dark gray      
		push ax
		
		mov ax,20  ;rows 
		push ax
		
		mov ax,42  ;columns 
		push ax 
		
		mov ax,180 	;row coordinate 
		push ax 
		
		mov ax,275  ;column coordinate 
		push ax 
		
		call createsquare
		;;;Windows in Box1
		;left window 
		mov ax,0
		mov al,0     ;0 for black       
		push ax
		
		mov ax,8  	  ;rows 
		push ax
		
		mov ax,8 	  ;columns 
		push ax 
		
		mov ax,186 	  ;row coordinate 
		push ax 
		
		mov ax,280   ;column coordinate 
		push ax 
		
		call createsquare
		;mid window 
		mov ax,0
		mov al,0      ;0 for black       
		push ax
		
		mov ax,8  	  ;rows 
		push ax
		
		mov ax,8 	  ;columns 
		push ax 
		
		mov ax,186 	  ;row coordinate 
		push ax 
		
		mov ax,293   ;column coordinate 
		push ax 
		
		call createsquare
		;right window 
		mov ax,0
		mov al,0     ;0 for black      
		push ax
		
		mov ax,8  	 ;rows 
		push ax
		
		mov ax,8 	 ;columns 
		push ax 
		
		mov ax,186 	 ;row coordinate 
		push ax 
		
		mov ax,305   ;column coordinate 
		push ax 
		
		call createsquare
		;-----------BOX 2----------;
		mov ax,0
		mov al,08     ;08 for dark gray     
		push ax
		
		mov ax,18  	  ;rows 
		push ax
		
		mov ax,32 	  ;columns 
		push ax 
		
		mov ax,162 	  ;row coordinate 
		push ax 
		
		mov ax,280    ;column coordinate 
		push ax 
		
		call createsquare
		;;;Windows in Box 2
		;left window 
		mov ax,0
		mov al,0      ;0 for black   
		push ax
		
		mov ax,8  	  ;rows 
		push ax
		
		mov ax,8 	  ;columns 
		push ax 
		
		mov ax,167 	  ;row coordinate 
		push ax 
		
		mov ax,285    ;column coordinate 
		push ax 
		
		call createsquare
		;right window 
		mov ax,0
		mov al,0    ;0 for black      
		push ax
		
		mov ax,8  	;rows 
		push ax
		
		mov ax,8 	;columns 
		push ax 
		
		mov ax,167 	;row coordinate 
		push ax 
		
		mov ax,300  ;column coordinate 
		push ax 
		
		call createsquare
		;---------BOX 3--------;
		mov ax,0
		mov al,08   ;08 for dark gray      
		push ax
		
		mov ax,14  	;rows 
		push ax
		
		mov ax,22 	;columns 
		push ax 
		
		mov ax,148 	;row coordinate 
		push ax 
		
		mov ax,285  ;column coordinate 
		push ax 
		
		call createsquare
		;;;Window 
		mov ax,0
		mov al,0    ;0 for black  
		push ax
		
		mov ax,8 	;rows 
		push ax
		
		mov ax,8 	;columns 
		push ax 
		
		mov ax,151	;row coordinate 
		push ax 
		
		mov ax,292  ;column coordinate 
		push ax 
		
		call createsquare
	return: ret 
	createKingdom ENDP
	
	createmonster PROC
		mov SI,offset M_row
		mov DI,offset M_col 
		;;;Big Box of Monster;;;
		mov ax,0
		mov al,01    ;01 for blue      
		push ax
		
		mov ax,17  	 ;rows 
		push ax
		
		mov ax,27 	 ;columns 
		push ax 
		
		mov ax,[SI]	 ;row coordinate 
		push ax 
		
		mov ax,[DI]  ;column coordinate 
		push ax 
		
		call createsquare
		;;;top left horn of monster 
		mov ax,0
		mov al,04  	;04 for red      
		push ax
		
		mov ax,6  	;rows 
		push ax
		
		mov ax,6   ;columns 
		push ax 
		
		mov ax,[SI+2]	;row coordinate 
		push ax 
		
		mov ax,[DI+2]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;top right horn of monster 
		mov ax,0
		mov al,04   ;04 for red      
		push ax
		
		mov ax,6  	;rows 
		push ax
		
		mov ax,6 	;columns 
		push ax 
		
		mov ax,[SI+4]	;row coordinate 
		push ax 
		
		mov ax,[DI+4]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;Left wing of monster 
		mov ax,0
		mov al,03   ;03 for cyan       
		push ax
		
		mov ax,8 	;rows 
		push ax
		
		mov ax,13 	;columns 
		push ax 
		
		mov ax,[SI+6]	;row coordinate 
		push ax 
		
		mov ax,[DI+6]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right wing of monster 
		mov ax,0
		mov al,03   ;03 for cyan       
		push ax
		
		mov ax,8 	;rows 
		push ax
		
		mov ax,13 	;columns 
		push ax 
		
		mov ax,[SI+8]	;row coordinate 
		push ax 
		
		mov ax,[DI+8]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of monster
		mov ax,0
		mov al,0   ;0 for black        
		push ax
		
		mov ax,4 	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,[SI+10]	 ;row coordinate 
		push ax 
		
		mov ax,[DI+10]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of monster
		mov ax,0
		mov al,0    ;0 for black        
		push ax
		
		mov ax,4 	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,[SI+12]	 ;row coordinate 
		push ax 
		
		mov ax,[DI+12]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;Mouth of monster 
		mov ax,0
		mov al,0   ;0 for black        
		push ax
		
		mov ax,3   ;rows 
		push ax
		
		mov ax,7   ;columns 
		push ax 
		
		mov ax,[SI+14]	 ;row coordinate 
		push ax 
		
		mov ax,[DI+14]   ;column coordinate 
		push ax 
		
		call createsquare
	ret
	createmonster ENDP
	
	
	createbomb PROC 
		mov SI,offset B_row
		mov DI,offset B_col
		
		mov ax,0
		mov al,0Ch  ;0C for light red         
		push ax
		
		mov ax,8	;rows 
		push ax
		
		mov ax,8 	;columns 
		push ax 
		
		mov ax,[SI]	  ;row coordinate 
		push ax 
		
		mov ax,[DI]   ;column coordinate 
		push ax 
		
		call createsquare
	ret 
	createbomb ENDP 
	

createArenalevelthree PROC
	call clearscreen_graphicsmode
	
	call createhurdles
	call createKingdom
ret
createArenalevelthree ENDP


	
createArena PROC
	call createhurdles
	call createflag	
	ret 
createArena ENDP

	;-----------------------delay code------------------;

	delayforjump proc
		push ax
		push bx
		push cx
		push dx

		mov cx,1000
		mydelay:
		
		mov bx,50   ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
		mydelay1:
		dec bx
		jnz mydelay1
		loop mydelay

		pop dx
		pop cx
		pop bx
		pop ax

	ret
	delayforjump endp


	delayforenemies proc
		push ax
		push bx
		push cx
		push dx

		mov cx,1000
		mydelay:
		mov bx,50     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
		mydelay1:
		dec bx
		jnz mydelay1
		loop mydelay

		pop dx
		pop cx
		pop bx
		pop ax

	ret
	delayforenemies endp


	;--------Codes for clearing moving object---------------;
		
	clearenemies PROC
		
		;----------------------Clearing Enemy 1--------------------;
		mov SI,offset E1_row
		mov DI,offset E1_col
		;;;Face of Enemy1
		mov ax,0
		    
		push ax
		
		mov ax,10   ;rows 
		push ax
		
		mov ax,10   ;columns 
		push ax 
		
		mov ax,[SI] ;row coordinate 
		push ax 
		
		mov ax,[DI]  ;column coordinate 
		push ax 
		
		call createsquare
		;;;left leg of Enemy1
		mov ax,0
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+2] 	;row coordinate 
		push ax 
		
		mov ax,[DI+2]    ;column coordinate 
		push ax 
		
		call createsquare
		;;;right leg of Enemy1
		mov ax,0
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+4] 	;row coordinate 
		push ax 
		
		mov ax,[DI+4]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of Enemy1 
		mov ax,0
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+6] 	;row coordinate 
		push ax 
		
		mov ax,[DI+6]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of Enemy1 
		mov ax,0
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+8] 	;row coordinate 
		push ax 
		
		mov ax,[DI+8]   ;column coordinate 
		push ax 
		
		call createsquare
		
		;----------------------Clearing Enemy 2--------------------;
		mov SI,offset E2_row
		mov DI,offset E2_col
		;;;Face of Enemy2
		mov ax,0
		push ax
		
		mov ax,10  	;rows 
		push ax
		
		mov ax,10  	;columns 
		push ax 
		
		mov ax,[SI] 	;row coordinate 
		push ax 
		
		mov ax,[DI]   	;column coordinate 
		push ax 
		
		call createsquare
		;;;left leg of Enemy2
		mov ax,0
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+2] 	;row coordinate 
		push ax 
		
		mov ax,[DI+2]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right leg of Enemy2
		mov ax,0
		push ax
		
		mov ax,3  	;rows 
		push ax
		
		mov ax,3  	;columns 
		push ax 
		
		mov ax,[SI+4] 	;row coordinate 
		push ax 
		
		mov ax,[DI+4]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of Enemy2 
		mov ax,0
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+6] 	;row coordinate 
		push ax 
		
		mov ax,[DI+6]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of Enemy2 
		mov ax,0
		push ax
		
		mov ax,2  	;rows 
		push ax
		
		mov ax,2  	;columns 
		push ax 
		
		mov ax,[SI+8] 	;row coordinate 
		push ax 
		
		mov ax,[DI+8]   ;column coordinate 
		push ax 
		
		call createsquare
	ret 
	clearenemies ENDP	
		
		
	clearmario PROC
		mov SI,offset row_coordinates
		mov DI,offset col_coordinates
		;---------------Clearing face of Mario-------------;
		mov ax,0    ;square color 
		push ax 
				
		mov ax,9  	;rows
		push ax

		mov ax,9	;columns
		push ax

		mov ax,[SI]  	;row coordinate
		push ax

		mov ax,[DI]		;col coordinate
		push ax
				
		call createsquare
				
		;--------------Clearing neck of Mario----------------;
		mov ax,0    ;squarecolor 
		push ax
				
		mov ax,4  	;rows 
		push ax
				
		mov ax,4   	;columns 
		push ax 
				
		mov ax,[SI+2] 	;row coordinate 
		push ax 
				
		mov ax,[DI+2]   ;column coordinate 
		push ax 
				
		call createsquare
				
		;--------------Clearing body of Mario---------------;
		mov ax,0    ;squarecolor 
		push ax
				
		mov ax,18  	;rows 
		push ax
				
		mov ax,17  	;columns 
		push ax 
				
		mov ax,[SI+4] 	;row coordinate 
		push ax 
				
		mov ax,[DI+4]   ;column coordinate 
		push ax 
				
		call createsquare
				
		;-------------Clearing Legs of Mario-------------;
		;;;Left leg 
		mov ax,0    ;squarecolor 
		push ax
				
		mov ax,12  	;rows 
		push ax
				
		mov ax,4  	;columns 
		push ax 
				
		mov ax,[SI+6] 	;row coordinate 
		push ax 
				
		mov ax,[DI+6]   ;column coordinate 
		push ax 
				
		call createsquare
		;;;Right leg 
		mov ax,0    ;squarecolor 
		push ax
				
		mov ax,12  	;rows 
		push ax
				
		mov ax,4  	;columns 
		push ax 
				
		mov ax,[SI+8] 	;row coordinate 
		push ax 
				
		mov ax,[DI+8]   ;column coordinate 
		push ax 
				
		call createsquare
		;-----------Clearing arms of mario---------------;
		;;;Left arm 
		mov ax,0    ;squarecolor 	   
		push ax
				
		mov ax,3  	;rows 
		push ax
				
		mov ax,5  	;columns 
		push ax 
				
		mov ax,[SI+10] 	;row coordinate 
		push ax 
				
		mov ax,[DI+10]  ;column coordinate 
		push ax 
				
		call createsquare
		;;;Right arm 
		mov ax,0  	;squarecolor 
		push ax
				
		mov ax,3  	;rows 
		push ax
				
		mov ax,5  	;columns 
		push ax 
				
		mov ax,[SI+12] 	;row coordinate 
		push ax 
				
		mov ax,[DI+12]  ;column coordinate 
		push ax 
				
		call createsquare
	ret
	clearmario ENDP
	
	clearmonster PROC
		;for clearing the monster, making all colours black 
		mov SI,offset M_row
		mov DI,offset M_col 
		;;;Big Box of Monster;;;
		mov ax,0
		mov al,0   	;0 for black      
		push ax
		
		mov ax,17  	;rows 
		push ax
		
		mov ax,27 	;columns 
		push ax 
		
		mov ax,[SI]	  ;row coordinate 
		push ax 
		
		mov ax,[DI]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;top left horn of monster 
		mov ax,0
		mov al,0  	;0 for black 
		push ax 
		
		mov ax,6  	;rows 
		push ax
		
		mov ax,6 	;columns 
		push ax 
		
		mov ax,[SI+2]	;row coordinate 
		push ax 
		
		mov ax,[DI+2]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;top right horn of monster 
		mov ax,0
		mov al,0    ;0 for black      
		push ax
		
		mov ax,6  	;rows 
		push ax
		
		mov ax,6 	;columns 
		push ax 
		
		mov ax,[SI+4]	;row coordinate 
		push ax 
		
		mov ax,[DI+4]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;Left wing of monster 
		mov ax,0
		mov al,0   	;0 for black       
		push ax
		
		mov ax,8 	;rows 
		push ax
		
		mov ax,13 	;columns 
		push ax 
		
		mov ax,[SI+6]	 ;row coordinate 
		push ax 
		
		mov ax,[DI+6]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right wing of monster 
		mov ax,0
		mov al,0   	;0 for black    
		push ax
		
		mov ax,8 	;rows 
		push ax
		
		mov ax,13 	;columns 
		push ax 
		
		mov ax,[SI+8]	;row coordinate 
		push ax 
		
		mov ax,[DI+8]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;left eye of monster
		mov ax,0
		mov al,0   	;0 for black        
		push ax
		
		mov ax,4 	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,[SI+10]	  ;row coordinate 
		push ax 
		
		mov ax,[DI+10]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;right eye of monster
		mov ax,0
		mov al,0   	;0 for black        
		push ax
		
		mov ax,4 	;rows 
		push ax
		
		mov ax,4 	;columns 
		push ax 
		
		mov ax,[SI+12]	 ;row coordinate 
		push ax 
		
		mov ax,[DI+12]   ;column coordinate 
		push ax 
		
		call createsquare
		;;;Mouth of monster 
		mov ax,0
		mov al,0   	;0 for black        
		push ax
		
		mov ax,3 	;rows 
		push ax
		
		mov ax,7 	;columns 
		push ax 
		
		mov ax,[SI+14]	  ;row coordinate 
		push ax 
		
		mov ax,[DI+14]   ;column coordinate 
		push ax 
		
		call createsquare
	ret
	clearmonster ENDP
	
	clearbomb PROC
		mov SI,offset B_row
		mov DI,offset B_col
		
		mov ax,0
		mov al,0   	;0 for black        
		push ax
		
		mov ax,8	;rows 
		push ax
		
		mov ax,8 	;columns 
		push ax 
		
		mov ax,[SI]	  ;row coordinate 
		push ax 
		
		mov ax,[DI]   ;column coordinate 
		push ax 
		
		call createsquare
	ret 
	clearbomb ENDP 

	;----------Codes for collision check--------;
	
	
	;kingdom check, checks wether mario has entered the kingdom after completing the thirdlevel
	kingdomcheck PROC
		mov kingdomreturn ,0
	
		mov si,offset col_coordinates
		add si,12         ;;Right arm of mario
		mov ax,[si]
		
		collision:
			cmp ax,275    ;starting coordinate of kingdom
			jbe funcexit
			mov kingdomreturn,1

		funcexit:
		ret
	kingdomcheck ENDP


	;hurdle one,two,three checks are a combination of left right and top border of the hurdles
	; they determine mario's collision
	hurdleonechecks PROC
	
		mov hurdleonetopreturn,0
		mov hurdleoneleftreturn,0
		mov hurdleonerightreturn,0
		mov si,offset row_coordinates
		add si,8
		mov ax,[si]   ;moving mario's right leg row
	
			;hurdle top connects to mario right leg by the values given below, therefore ensuring contact
		
		.IF ax<160
			.IF ax>150
			mov hurdleonetopreturn,1
			.ENDIF
		.ENDIF		
	
		mov si,offset col_coordinates
		add si,12
		mov ax,[si]
		mov mariorightarmcolumn,ax
			
		;codes below determine contact with the left and right sides of hurdles
			
		hurdleoneleftside:
			mov ax,mariorightarmcolumn
			cmp ax,45
			jbe hurdleonerightside
			cmp ax,100
			jae hurdleonerightside
			mov hurdleoneleftreturn,1

		hurdleonerightside:
			mov ax,mariorightarmcolumn
			cmp ax,95
			jbe exithurdleonecheck 
			cmp ax,105
			jae exithurdleonecheck
			mov ax,1
			mov hurdleonerightreturn,ax
				
		exithurdleonecheck:
		ret
	hurdleonechecks ENDP
	
	
	;;;;;;;;;;Hurdle two checks and three checks are same as explained in hurdle one check
	
	
	hurdletwochecks PROC
	
		mov hurdletwotopreturn,0
		mov hurdletwoleftreturn,0
		mov hurdletworightreturn,0
		mov si,offset row_coordinates
		add si,8
		mov ax,[si]   ;moving mario's right leg row
	
		.IF ax<150
			.IF ax>140
			mov hurdletwotopreturn,1
			.ENDIF
		.ENDIF		
	
		mov si,offset col_coordinates
		add si,12
		mov ax,[si]
		mov mariorightarmcolumn,ax
				
		hurdletwoleftside:
			mov ax,mariorightarmcolumn
			cmp ax,125
			jbe hurdletworightside
			cmp ax,180
			jae hurdletworightside
			mov hurdletwoleftreturn,1

		hurdletworightside:
			mov ax,mariorightarmcolumn
			cmp ax,185
			jbe exithurdletwocheck 
			cmp ax,190
			jae exithurdletwocheck
			mov ax,1
			mov hurdletworightreturn,ax
				
		exithurdletwocheck:
		ret
	hurdletwochecks ENDP
	
	hurdlethreechecks PROC
		
		mov hurdlethreetopreturn,0
		mov hurdlethreeleftreturn,0
		mov hurdlethreerightreturn,0
		mov si,offset row_coordinates
		add si,8
		mov ax,[si]   ;moving mario's right leg row
		
		.IF ax<140
			.IF ax>130
			mov hurdlethreetopreturn,1
			.ENDIF
		.ENDIF		
		
		mov si,offset col_coordinates
		add si,12
		mov ax,[si]
		mov mariorightarmcolumn,ax
					
		hurdlethreeleftside:
			mov ax,mariorightarmcolumn
			cmp ax,205
			jbe hurdlethreerightside
			cmp ax,260
			jae hurdlethreerightside
			mov hurdlethreeleftreturn,1

		hurdlethreerightside:
			mov ax,mariorightarmcolumn
			cmp ax,260
			jbe exithurdlethreecheck 
			cmp ax,280
			jae exithurdlethreecheck
			mov ax,1
			mov hurdlethreerightreturn,ax
					
		exithurdlethreecheck:
		ret
	hurdlethreechecks ENDP
	
	
	;hurdle left checks include the combination of all left sides of hurdles, it's useful in moving mario
	
	
	hurdleleftcheck PROC
		mov hurdleleftreturn,0
		mov si,offset col_coordinates
		add si,12
		mov ax,[si]
		mov mariorightarmcolumn,ax
				
		hurdleoneleftside:
			mov ax,mariorightarmcolumn
			cmp ax,45
			jbe hurdletwoleftside
			cmp ax,100
			jae hurdletwoleftside
			mov hurdleleftreturn,1
							
				
		hurdletwoleftside:
			mov ax,mariorightarmcolumn
			cmp ax,125
			jbe hurdlethreeleftside
			cmp ax,185
			jae hurdlethreeleftside
			mov hurdleleftreturn,1
					
		hurdlethreeleftside:
			mov ax,mariorightarmcolumn
			cmp ax,202
			jbe exithurdleleftcheck
			cmp ax,260
			jae exithurdleleftcheck
			mov hurdleleftreturn,1
					
		exithurdleleftcheck:
		ret
	hurdleleftcheck ENDP
		
	;hurdle right check is same as hurdle left check

		
	hurdlerightcheck PROC
		mov hurdlerightreturn,0
		mov si, offset col_coordinates
		add si,12
		mov ax,[si]
		mov mariorightarmcolumn,ax		
		
		hurdleonerightside:
			mov ax,mariorightarmcolumn
			cmp ax,100
			jbe hurdletworightside 
			cmp ax,110
			jae hurdletworightside
			mov ax,1
			mov hurdlerightreturn,ax
			
		hurdletworightside:
			mov ax,mariorightarmcolumn
			cmp ax,180
			jbe hurdlethreerightside 
			cmp ax,190
			jae hurdlethreerightside
			mov ax,1
			mov hurdlerightreturn,ax
			
		hurdlethreerightside:
			mov ax,mariorightarmcolumn
			cmp ax,260
			jbe exithurdlerightcheck 
			cmp ax,270
			jae exithurdlerightcheck
			mov ax,1
			mov hurdlerightreturn,ax
			
		exithurdlerightcheck:
		ret
	hurdlerightcheck ENDP


	;below are codes to check collision with the borders of the screen


	rightbordercollisioncheck PROC
		mov borderreturn,0
		mov flagcheck,0
					
		mov si, offset col_coordinates
		add si,12
		mov ax,[si]
		mov rightarmcheck,ax	;right arm of mario
					
		rightbordercheck:
			mov ax,rightarmcheck
			cmp ax,rightbordercoordinate
			jbe exitrightbordercheck
							
			mov borderreturn,1
			mov flagcheck,1	   ;;When mario reaches the right border, it shows that it touches the flag rod and hence flagcheck is set 1	
					
		exitrightbordercheck:	
			ret 
	rightbordercollisioncheck ENDP

	leftbordercollisioncheck PROC
		mov borderreturn,0
		mov si,offset col_coordinates
		add si,10
		mov ax,[si]
		mov leftarmcheck,ax   ;right arm of mario 
					
		leftbordercheck:
			mov ax,leftarmcheck
			cmp ax,leftbordercoordinate
			jae exitleftbordercheck
							
			mov borderreturn,1
							
		exitleftbordercheck:
		ret
	leftbordercollisioncheck ENDP


	; Enemy collide code determines wether mario came into contact with the enemies
	; it takes the row coordinate of mario in order to determine wether mario is at ground or the jump is high enough to escape the enemy

	enemycollision PROC
		mov enemycollide ,0
		
		mov si,offset row_coordinates
		add si,8
		mov ax,[si]
		
		cmp ax,170
		jbe exitfunc
	
		enemyonecollide:
		
			mov di,offset E1_col
			mov si,offset col_coordinates
		
			mov bx,[di]
		
			add si,8
			mov ax,[si]
		
			add ax,5   ;testing right leg collision
		
		
		;if else condition below tests if enemy is within bounds of left and right leg
		
		.IF bx <= ax
			sub ax,26    ;testing left leg collision
			.IF bx >=ax
				call gameover_screen
			.ENDIF			
		.ENDIF

		enemytwocollide:

			mov di,offset E2_col
			mov si,offset col_coordinates
		
			mov bx,[di]
		
			add si,8
			mov ax,[si]
		
			add ax,5
	
		.IF bx <= ax
			sub ax,26
			.IF bx >=ax
				call gameover_screen
			.ENDIF			
		.ENDIF

		exitfunc:
		ret
	enemycollision ENDP



	;bomb collision determines wether the bombs dropped by the dragon come into contact with mario
	; upon contact its game over, same as enemy collision

	bombcollision PROC	
		;head contact
		
		mov si,offset row_coordinates
		mov ax,[si]
		
		mov di,offset B_row
		mov bx,[di]
		
		add bx,15  ;checking if bomb is equal or below the head row coordinate
		.IF bx>=ax
			
			mov si,offset col_coordinates
			mov ax,[si]
			mov di,offset B_col
			mov bx,[di]
				
			;code below tests the range of column for contact	
				
			.IF bx>=ax
				add ax,10
				.IF bx<=ax
					jmp gameover_screen	
				.ENDIF	
			.ENDIF
				
			.IF bx<=ax
				sub ax,10
				.IF bx>=ax
					jmp gameover_screen	
				.ENDIF		
			.ENDIF
						
		.ENDIF
	
		;body contact
		mov si,offset row_coordinates
		mov ax,[si]
		
		mov di,offset B_row
		mov bx,[di]

				
		;testing body row with bomb row coordinate
		.IF bx>=ax
			
			mov si,offset col_coordinates
			mov ax,[si]
			mov di,offset B_col
			mov bx,[di]
				
			;code below tests the column range 
				
			.IF bx>=ax
				add ax,20
				.IF bx<=ax
					jmp gameover_screen	
				.ENDIF
					
			.ENDIF
				
			.IF bx<=ax
				sub ax,20
				.IF bx>=ax
					jmp gameover_screen	
				.ENDIF
					
			.ENDIF
				
		.ENDIF
		exitfunc:
		ret
	bombcollision ENDP

	;---------Code for movement-----------;

	movemarioright PROC
		
		;checking border conditions
		
		testingborders1:
			call rightbordercollisioncheck
			mov ax,0
			cmp borderreturn,ax
			jne exitmovemarioright 
		
			
			;checking if mario reached kingdom in level3
			call kingdomcheck
			
			;determining collision during movement	
			call bombcollision
			call enemycollision	

			; the following code determines wether mario is either at ground or high enough to pass over the hurdle
			
			call hurdleleftcheck
			mov ax,1
			cmp hurdleleftreturn,ax
			jne resumerightmove		
			
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			je resumerightmove
			
			call hurdletwochecks
			mov ax,1
			cmp hurdletwotopreturn,ax
			je resumerightmove
			
			call hurdlethreechecks
			mov ax,1
			cmp hurdlethreetopreturn,ax
			je resumerightmove	
			
			jmp exitmovemarioright
			
		resumerightmove:
			
			;the following code determines mario jumping down after exiting the hurdle's premises
			
			call hurdleleftcheck
			mov ax,0
			cmp hurdleleftreturn,ax
			jne skipdown
			
			call hurdlerightcheck
			mov ax,1
			cmp hurdlerightreturn,ax
			jne skipdown
			
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			jne skipto2
			
			call jumpdown
			
			skipto2:
				call hurdletwochecks
				mov ax,1
				cmp hurdletwotopreturn,ax
				jne skipto3
			
			call jumpdown
			
			skipto3:
				call hurdlethreechecks
				mov ax,1
				cmp hurdlethreetopreturn,ax
				jne skipdown
	
			call jumpdown
		
			skipdown:
				call clearmario
				mov si,offset col_coordinates
				mov cx,7
		
		;code to increase mario's cols according to movement
		
		increasecolcoordinate:
			mov ax,[si]
			add ax,5
			
			mov [si],ax
			add si,2
			loop increasecolcoordinate
			
		call createMario
	
		exitmovemarioright:
		ret
	movemarioright ENDP


	;move mario left is same as move mario right 

	movemarioleft PROC
			
		testingborders2:
			call leftbordercollisioncheck
			mov ax,0
			cmp borderreturn,ax
			jne exitmovemarioleft
			
				
			call enemycollision	
			call bombcollision	
						
			call hurdlerightcheck
			mov ax,1
			cmp hurdlerightreturn,ax
			jne resumeleftmove
			
			
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			je resumeleftmove
			
			call hurdletwochecks
			mov ax,1
			cmp hurdletwotopreturn,ax
			je resumeleftmove
			
			call hurdlethreechecks
			mov ax,1
			cmp hurdlethreetopreturn,ax
			je resumeleftmove	
			
			jmp exitmovemarioleft
		
		resumeleftmove:
		
			call hurdleleftcheck
			mov ax,0
			cmp hurdleleftreturn,ax
			jne skipdown
			
			call hurdlerightcheck
			mov ax,0
			cmp hurdlerightreturn,ax
			jne skipdown
			
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			jne skipto2
			
			call jumpdown
			
			skipto2:
				call hurdletwochecks
				mov ax,1
				cmp hurdletwotopreturn,ax
				jne skipto3
			
			call jumpdown
			
			skipto3:
				call hurdlethreechecks
				mov ax,1
				cmp hurdlethreetopreturn,ax
				jne skipdown
			
			call jumpdown
		
			skipdown:
				call clearmario
				mov si,offset col_coordinates
				mov cx,7
		
		decreasecolcoordinate:
			mov ax,[si]
			sub ax,5
			mov [si],ax
			add si,2
		loop decreasecolcoordinate
			
		call createMario
						
		exitmovemarioleft:	
		ret		
	movemarioleft ENDP


	;this jump down function determines wether mario is jumping down from a hurdle or after jumping up in the air
	
	
	jumpdown PROC
		
		; in order to reduce the game delay for enemy movement and monster movement this level two and three check was placed 	
		mov ax,leveltwocheck
		cmp ax,1
		jne checkmonster
		call enemymovement
				
		checkmonster:
			mov ax,levelthreecheck
			cmp ax,1
			jne resumedownjump
			call monstermovement	
				
			jmp resumedownjump2
				
			resumedownjump:
				call delayforjump
				
			resumedownjump2:	
				mov cx,100
			
			
		; this jumping down bring mario to the ground by comparing it to the stored ground coordinates for mario	
		jumpingdowntransition:
			mov jumpinglooptemp,cx
			mov si,offset row_coordinates
			mov di,offset mario_ground_row
					
			mov cx,7
			comparsion:
				mov ax,[si]
				mov bx,[di]
					
				cmp ax,bx
				jne continuedown
					
				
				loop comparsion
				jmp exitdownjump
		
			continuedown:	
				call clearmario	
				mov cx,7
			
			increaserowcoordinate:
				mov ax,[si]
				add ax,6
				mov [si],ax
				add si,2
			loop increaserowcoordinate
									
			call createmario	
				
			mov ax,leveltwocheck
			cmp ax,1
			jne skip	
				
			skip:	
				mov cx,jumpinglooptemp		
		loop jumpingdowntransition
			
	exitdownjump:
	ret
	jumpdown ENDP

	jumpmario PROC    ;;Mario jumps up 
		;such that other movements dont completely stop during jump function because it has delay			
		mov ax,leveltwocheck
		cmp ax,1
		jne checkmonster
		call enemymovement
				
		checkmonster:
			mov ax,levelthreecheck
			cmp ax,1
			jne skipenemymovement
			call monstermovement	
				
		skipenemymovement:
			; jump factor is used to determine the height of the jump need to be taken
			; jumping over hurdles
			mov jumpfactor,4	
		
			; the following code disable's mario's ability to jump up while standing on the hurdle as it leads to code distortion and it isn't required as per project instructions 
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			je exitjumpmariofunc	

		call hurdletwochecks
		mov ax,1
		
		cmp hurdletwotopreturn,ax
		je exitjumpmariofunc
	
		call hurdlethreechecks
		mov ax,1
		
		cmp hurdlethreetopreturn,ax
		je exitjumpmariofunc	
		
		mov cx,5
		add cx,jumpfactor
		; jumping mario up and right in order for to jump onto hurdles and pass enemies
		 
		jumpinguptransition:
			mov jumpinglooptemp,cx
			call clearmario
			mov si,offset row_coordinates
			mov di,offset col_coordinates
			mov cx,7
			
		decreasecoordinates:
			mov ax,[si]
			sub ax,6
			mov [si],ax
			mov ax,[di]
			add ax,1
			mov [di],ax
			add di,2
			add si,2
		loop decreasecoordinates
				
		call createmario	
			
			; the code below determines whether mario jumped in the vicinity of the hurdle's left side as that would allow it to jump over it
			
		call hurdleonechecks
		mov ax,1
		cmp hurdleoneleftreturn,ax
		jne skiptosecond
			
		mov ax,1
		cmp hurdleonetopreturn,ax
		jne skip
			
		jmp exitjumpup1
			
		skiptosecond:
			call hurdletwochecks
			
			mov ax,1
			cmp hurdletwoleftreturn,ax
			jne skiptothird
			
			mov ax,1
			cmp hurdletwotopreturn,ax
			jne skip
			
			jmp exitjumpup2
		skiptothird:
			call hurdlethreechecks
			
			mov ax,1
			cmp hurdlethreeleftreturn,ax
			jne skip
			
			mov ax,1
			cmp hurdlethreetopreturn,ax
			jne skip
			
			jmp exitjumpup3
		
		skip:		
			mov cx,jumpinglooptemp		
								
		loop jumpinguptransition
		call jumpdown
		jmp exitjumpmariofunc
		
		
		; the move right label move's the mario slightly right such that it is placed on the hurdle
		
		exitjumpup1:
			
			
			
		call clearmario
		mov si,offset col_coordinates
		mov cx,7
		
		moveright:
			mov ax,[si]
			add ax,7
			mov [si],ax
			add si,2
					
			loop moveright
			
			call createMario
			
			call hurdleonechecks
			mov ax,1
			cmp hurdleonetopreturn,ax
			je exitjumpmariofunc
			
			call jumpdown
			
			exitjumpup2:
				call clearmario
				mov si,offset col_coordinates
				mov cx,7
			
			moveright1:
				mov ax,[si]
				add ax,7
				mov [si],ax
				add si,2
					
				loop moveright1
			
			call createMario			
			
			call hurdletwochecks
			mov ax,1
			cmp hurdletwotopreturn,ax
			je exitjumpmariofunc

			call jumpdown
						
			exitjumpup3:
				call clearmario
				mov si,offset col_coordinates
				mov cx,7
			
			moveright2:
				mov ax,[si]
				add ax,7
				mov [si],ax
				add si,2
					
			loop moveright2
			
			call createMario			
			call hurdlethreechecks
			
			mov ax,1
			cmp hurdlethreetopreturn,ax
			je exitjumpmariofunc
			
			call jumpdown
		exitjumpmariofunc:	
		ret		
	jumpmario ENDP


	; level one movement has a key detect and it exits when mario touches the flag
	
	levelonemovement PROC
			
		keydetect:
			mov ah,0
			int 16h
					
			cmp ah,4Bh ; left key
			jne skipmarioleft		
			call movemarioleft
			skipmarioleft:
	
			cmp ah,4Dh ; right key
			jne skipmarioright
			call movemarioright
			skipmarioright:	
									
			cmp ah,48h ;up key
			jne skipjumpmario
			call jumpmario
			skipjumpmario:
			
			cmp flagcheck,1
			je exitmovement
						
		jmp keydetect

		exitmovement:	
		ret
	levelonemovement ENDP
		
	
	;level two movement is the same as level one movement with a difference that it has an extra loop to keep running enemies despite key presses
	
	
	leveltwomovement PROC
		keydetect:
		
			loopmovement:
				call enemymovement
				mov ah,1
				int 16h

				cmp ah,4Bh
				je resume
				
				cmp ah,4Dh
				je resume
			
				cmp ah,48h
				je resume
				
			jmp loopmovement
			
			resume:	
				mov ah,0
				int 16h
					
			cmp ah,4Bh ; left key
			jne skipmarioleft		
			call movemarioleft
			skipmarioleft:
	
	
			cmp ah,4Dh ; right key
			jne skipmarioright
			call movemarioright
			skipmarioright:	
					
					
			cmp ah,48h ;up key
			jne skipjumpmario
			call jumpmario
			skipjumpmario:
			
			cmp flagcheck,1
			je exitmovement
						
		jmp keydetect
			
		exitmovement:	
		ret
	leveltwomovement ENDP
	
	
	
	;level three movement is same as level two it just includes monster movement and it exits with contact with kingdom
	
	levelthreemovement PROC
		
		keydetect:
			loopmovement:
				call enemymovement
				call monstermovement
		
				mov ah,1
				int 16h

		
				cmp ah,4Bh
				je resume
				
				cmp ah,4Dh
				je resume
			
				cmp ah,48h
				je resume

			jmp loopmovement
					
			resume:	
			mov ah,0
			int 16h
					
			cmp ah,4Bh ; left key
			jne skipmarioleft		
			call movemarioleft
			skipmarioleft:
	
			cmp ah,4Dh ; right key
			jne skipmarioright
			call movemarioright
			skipmarioright:	
						
			cmp ah,48h ;up key
			jne skipjumpmario
			call jumpmario
			skipjumpmario:
						
			cmp kingdomreturn,1
			je exitmovement			
						
		jmp keydetect
			
		exitmovement:
		ret
	levelthreemovement ENDP	


	;following monster moves right and left 

	monstermoveright PROC
	
		call clearmonster		
		mov si, offset M_col
		mov cx,8
		rightmovement:
			mov ax,[si]
			add ax,2
			mov [si],ax
			add si,2
			loop rightmovement
			
			call createmonster
			call delayforenemies

	ret
	monstermoveright ENDP

	monstermoveleft PROC
		call clearmonster		
		mov si, offset M_col
		mov cx,8
		leftmovement:
			mov ax,[si]
			sub ax,2
			mov [si],ax
			add si,2
			loop leftmovement
			
			call createmonster	
			call delayforenemies
	
	ret
	monstermoveleft ENDP
			
	
	;following moves enemy left and right
	
	enemymoveright PROC
	
		call clearenemies
		
		mov si, offset E1_col
		mov di, offset E2_col
				
		mov cx,5
		rightmovement:
			mov ax,[si]
			add ax,1
			mov [si],ax
					
			mov ax,[di]
			add ax,1
			mov [di],ax
					
			add si,2
			add di,2
		loop rightmovement
			
		call createEnemies

		mov ax,0
		cmp levelthreecheck,ax
		jne skip
		call delayforenemies
				
	skip:
	ret
	enemymoveright ENDP
	
	enemymoveleft PROC
	
		call clearenemies
		
		mov si, offset E1_col
		mov di, offset E2_col
				
		mov cx,5
		leftmovement:
			mov ax,[si]
			sub ax,1
			mov [si],ax
					
			mov ax,[di]
			sub ax,1
			mov [di],ax
					
			add si,2
			add di,2
		loop leftmovement
						
		call createEnemies
				
		mov ax,0
		cmp levelthreecheck,ax
		jne skip
		call delayforenemies
		
	skip:
	ret
	enemymoveleft ENDP
	
	;following three drop bombs drop the bomb from the monster
	;three functions are the same just termianting conditions are slightly different according to where bomb is dropped
	
	dropbombone PROC
		
		call clearbomb
		
		mov di,offset b_col
		mov ax,75	
		mov [di],ax
		
		mov si,offset B_row
		mov ax,[si]
		
		cmp ax,160
		jae skip
		
		add ax,5
		mov [si],ax
			
		call createbomb
		
		jmp exitfunc
		
		skip:
			mov bombonecheck,0
			mov ax,26
			mov [si],ax
		
		exitfunc:
		ret
	dropbombone ENDP
		
	dropbombtwo PROC
		call clearbomb
		
		mov di,offset b_col
		mov ax,140	
		mov [di],ax
		
		mov si,offset B_row
		mov ax,[si]
		
		cmp ax,150
		jae skip
		
		add ax,5
		mov [si],ax
	
		call createbomb
		
		jmp exitfunc
		skip:
			mov bombtwocheck,0
			mov ax,26
			mov [si],ax
		
		exitfunc:
		ret
	dropbombtwo ENDP
		
	dropbombthree PROC
		call clearbomb
		
		mov di,offset b_col
		mov ax,220	
		mov [di],ax
		
		mov si,offset B_row
		mov ax,[si]
		
		cmp ax,140
		jae skip
		
		add ax,5
		mov [si],ax
		
		call createbomb
		
		jmp exitfunc
		skip:
			mov bombthreecheck,0
			mov ax,26
			mov [si],ax
		
		exitfunc:
		ret
	dropbombthree ENDP
	

	;the following code determines the movement of monster right and left and it turns the monster when it touches the border

	monstermovement PROC
		
		call bombcollision		
		mov si,offset M_col
		mov ax,[si]
		
		.IF ax==70
			mov bombonecheck,1
		.ENDIF	
		
		.IF ax==130
			mov bombtwocheck,1
		.ENDIF
		
		.IF ax==210
			mov bombthreecheck,1
		.ENDIF
	
		cmp bombonecheck,1
		jne skipbomb1
		call dropbombone
	
		skipbomb1:
			cmp bombtwocheck,1
			jne skipbomb2
			call dropbombtwo
		
		skipbomb2:
			cmp bombthreecheck,1
			jne skipbomb3
			call dropbombthree
		
		skipbomb3:
			mov si,offset M_col
			mov ax,[si]
		
		.IF ax==270
			mov monstermovementcheck,1
		.ENDIF

		.IF ax==10
			mov monstermovementcheck,0
		.ENDIF
		
		mov ax,1
		cmp monstermovementcheck,ax
		jne skip
		call monstermoveleft
		jmp exitfunc
		
		skip:
			mov ax,0
			cmp monstermovementcheck,ax
			jne exitfunc
		call monstermoveright
		
		exitfunc:
		ret
	monstermovement ENDP



	;enemy movement moves both the enemies within a border and the conditions help switch the movement of enemies when in contact with their borders

	enemymovement PROC
			
		call enemycollision
			
		mov si,offset E1_col
		mov ax,[si]
			
		.IF ax==127     ;;Enemies in contact with the right border 
			mov enemymovementcheck,1	
		.ENDIF
			
		.IF ax==76     ;;Enemies in contact with the left border 
			mov enemymovementcheck,0
		.ENDIF
			
		;;The following code determines whether enemies move left or right based upon their contact with border 	
		mov ax,1
		cmp enemymovementcheck,ax
		jne skip
			
		call enemymoveleft
		jmp exitfunc
			
		skip:
			mov ax,0
			cmp enemymovementcheck,ax
			jne exitfunc
			
			call enemymoveright

		exitfunc:
		ret
	enemymovement ENDP
	
   ;-----------------RESET GAME----------------;
   ;;For placing mario again at the start of the screen in next level 
	resetmario PROC
		call clearmario
	
		mov si, offset col_coordinates
		mov di, offset row_coordinates
	
		mov ax,14
		mov [si],ax
		mov ax,16
		mov [si+2],ax
		mov ax,10
		mov [si+4],ax
		mov ax,13
		mov [si+6],ax
		mov ax,21
		mov [si+8],ax
		mov ax,5
		mov [si+10],ax
		mov ax,27
		mov [si+12],ax

			
		mov ax,157
		mov [di],ax
		mov ax,166
		mov [di+2],ax
		mov ax,170
		mov [di+4],ax
		mov ax,188
		mov [di+6],ax
		mov ax,188
		mov [di+8],ax
		mov ax,170
		mov [di+10],ax
		mov ax,170
		mov [di+12],ax	
			
		ret
	resetmario ENDP

;----------------Level 1------------------;

	firstlevel PROC
	
		mov leveltwocheck,0 ;this variable ensures that enemy collision doesn't interupt on firstlevel
		mov levelthreecheck,0 ; this disbales features used for level three
		
		call resetmario
	
		call createArena
		call createmario
	
		call levelonemovement
		call level1_complete_screen
		ret
	firstlevel ENDP
;---------------LEVEl 2--------------------;

	secondlevel PROC
		call clearscreen_graphicsmode
		call resetmario
	
		call createArena
		call createmario
		call createEnemies
		call delayforjump
	
	
		mov leveltwocheck,1 ;enabling level two features
		mov levelthreecheck,0
		call leveltwomovement
		call level2_complete_screen
		ret
	secondlevel ENDP

;--------------------LEVEL 3-------------------;
	
	thirdlevel PROC
	; using all the features in the game
	mov leveltwocheck,1  
	mov levelthreecheck,1
	
	
	call clearscreen_graphicsmode
	call resetmario
	
	call clearscreen_graphicsmode
	call createArenalevelthree ;special arena for level three including the kingdom
	call createmario
	call createEnemies
	call createmonster
	call delayforjump
	
	call levelthreemovement
	call level3_complete_screen
	
	ret 
	thirdlevel ENDP 

main PROC
	call screen1
	call screen2

	call clearscreen_graphicsmode	
	
	mov ah,0
	mov al,0Dh
	int 10h
	
	call firstlevel
	call secondlevel
	call thirdlevel
	
	;;Waits for a key at the end before exiting 
	mov ax,00h
	int 16h
main ENDP

exit:
call clearscreen_graphicsmode
mov ah,04ch
int 21h
end START 
