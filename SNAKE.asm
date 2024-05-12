.MODEL SMALL
 ORG  100H
.DATA
; TOA DO TU DAU DEN CUOI CON RAN
SNAKE DW 50DH,50CH,50BH,50AH, 10 DUP(?)   

; CHIEU DAI RAN    
S_SIZE  DB     4, 0 
                                  
;TOA DO DUOI                                                                          
TAIL    DW      ?       

; CAC HANG SO CUA HUONG 
LEFT    EQU     4BH
RIGHT   EQU     4DH
UP      EQU     48H
DOWN    EQU     50H 

; HUONG HIEN TAI CUA RAN
CUR_DIR DB      RIGHT

; HUONG TRUOC DO CUA RAN
OLD_DIR DB      RIGHT

; TOA DO BUA AN
MEALX  DB  ?
MEALY  DB  ?

; SCORE
SCORE DB '0','0','$'

; LOI NHAN BAT DAU
MSGSTART DB 3 DUP(0AH),  
 DB 15 DUP(20H),"  _______ _             _____             _           ", 0DH,0AH   
 DB 15 DUP(20H)," |__   __| |           / ____|           | |          ", 0DH,0AH       
 DB 15 DUP(20H),"    | |  | |__   ___  | (___  _ __   __ _| | _____    ", 0DH,0AH
 DB 15 DUP(20H),"    | |  | '_ \ / _ \  \___ \| '_ \ / _` | |/ / _ \   ", 0DH,0AH
 DB 15 DUP(20H),"    | |  | | | |  __/  ____) | | | | (_| |   <  __/   ", 0DH,0AH
 DB 15 DUP(20H),"    |_|  |_| |_|\___| |_____/|_| |_|\__,_|_|\_\___|   ", 0DH,0AH
 DB 15 DUP(20H),"              / ___\                     | |          ", 0DH,0AH
 DB 15 DUP(20H),"             | |  __  __ _ _ __ ___   ___| |          ", 0DH,0AH
 DB 15 DUP(20H),"             | | |_ |/ _` | '_ ` _ \ / _ \ |          ", 0DH,0AH
 DB 15 DUP(20H),"             | |__| | (_| | | | | | |  __/_|          ", 0DH,0AH
 DB 15 DUP(20H),"              \_____|\__,_|_| |_| |_|\___(_)          ", 0DH,0AH,0AH
 DB 15 DUP(20H),"     BAI TAP LON KIEN TRUC MAY TINH NHOM 5.0          ", 0DH,3 DUP(0AH)
 DB 15 DUP(20H),"SU DUNG MUI TEN ", 18H, 19H, 1AH, 1BH, " DE DI CHUYEN.", 0AH, 0DH
 DB 15 DUP(20H),"HAY THUONG THUC 5 MOI DE CHIEN THANG. CHUC MAY MAN!", 0DH, 0AH
 DB 15 DUP(20H),"NHAN ENTER DE BAT DAU...$"    

; LOI NHAN KET THUC
MSGOVER DB 10 DUP(0AH),15 DUP(20H)
 DB              "  ___   __   _  _  ____     __   _  _  ____  ____ ", 0DH,0AH 
 DB  15 DUP(20H)," / __) / _\ ( \/ )(  __)   /  \ / )( \(  __)(  _ \", 0DH,0AH 
 DB  15 DUP(20H),"( (_ \/    \/ \/ \ ) _)   (  O )\ \/ / ) _)  )   /", 0DH,0AH 
 DB  15 DUP(20H)," \___/\_/\_/\_)(_/(____)   \__/  \__/ (____)(__\_)", 0DH,0AH,0AH,0AH                                                  
 DB  25 DUP(20H),"   DIEM CUA BAN LA: $", 0DH,0AH

;LOI NHAN CHIEN THANG
MSGWINNER DB 8 DUP(0AH), 0DH,
 DB  15 DUP(20H)," ___      __      ___ _                          _   ", 0DH, 0AH
 DB  15 DUP(20H)," \  \    /  \    /  /(_)                        | |  ", 0DH, 0AH
 DB  15 DUP(20H),"  \  \  /    \  /  /  _  _ __   _ __   ___  _ _ | |  ", 0DH, 0AH
 DB  15 DUP(20H),"   \  \/  /\  \/  /  | || '_ \ | '_ \ / _ \| '_)| |  ", 0DH, 0AH
 DB  15 DUP(20H),"    \    /  \    /   | || | | || | | |  __/| |  |_|  ", 0DH, 0AH
 DB  15 DUP(20H),"     \__/    \__/    |_||_| |_||_| |_|\___||_|  (_) $", 0DH, 0AH 

MSGSCORE DB 0DH, 32 DUP(20H), "DIEM: $"
                                                    
; ------ PHAN CODE ------

 
.CODE
IN_LOI_CHAO:
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, MSGSTART  
    MOV AH, 9                   
    INT 21H                     
    MOV AX, 40H  
    MOV ES, AX                  

WAIT_FOR_ENTER:
    MOV AH, 00H          
    INT 16H              
    CMP AL,0DH           
    JNE WAIT_FOR_ENTER   
                         
    MOV AL, 1               
    MOV AH, 05H          
    INT 10H              
    
    LEA DX, MSGSCORE     
    MOV AH, 09H
    INT 21H              
    
    LEA DX, SCORE        
    MOV AH,09H            
    INT 21H               

; -- VE VIEN --    
BORDER: 
    
    MOV AH,06H 
    MOV AL,0   
    MOV BH,0FFH
    
    MOV CH,1   
    MOV CL,0   
    MOV DH,1   
    MOV DL,79  
    INT 10H    
  
    MOV CH,2   
    MOV CL,0
    MOV DH,24
    MOV DL,0
    INT 10H
   
    MOV CH,24  
    MOV CL,0
    MOV DH,24
    MOV DL,79
    INT 10H
    
    MOV CH,1   
    MOV CL,79
    MOV DH,24
    MOV DL,79
    INT 10H 
; KET THUC NHAN BORDER    
    
    CALL RANDOMIZEMEAL     

;RAN XUAT HIEN VA CAP NHAT HUONG DI
GAME_LOOP:
 
    CALL SHOWNEWHEAD 
    
; ====== KIEM TRA CON RAN TU CAN CHINH MINH?                
    MOV DX,SNAKE[0]
    MOV SI,W.S_SIZE  
    ADD SI,W.S_SIZE 
    SUB SI,2         
    MOV CX,W.S_SIZE  
    SUB CX,4         
    JZ NO_DEATH 
         
  
DEATHLOOP:                    
    CMP DX,SNAKE[SI]  
    JE GAME_OVER      
    SUB SI,2          
    DEC CX            
    JNZ DEATHLOOP

; CAP NHAT TOA DO DUOI VA DO DAI        
NO_DEATH: 
    MOV SI,W.S_SIZE   
    ADD SI,W.S_SIZE   
    SUB SI,2          
    MOV AX, SNAKE[SI] 
    MOV TAIL, AX     ; Luu dia chi duoi vao TAIL  
                      
    CALL MOVE_SNAKE 
      
; === KIEM TRA RAN CO DUOC AN KHONG 
ATE:
    MOV DX,SNAKE[0]   
    MOV AL,MEALX
    MOV AH,MEALY      
    CMP AX,DX
    JNE HIDE_OLD_TAIL  

;=== CAP NHAT NEU DUOC AN    
NO_HIDE_OLD_TAIL:
    INC S_SIZE[0]     
    MOV AX,TAIL       
    MOV BH,0          
    MOV BL,S_SIZE
    ADD BL,S_SIZE
    SUB BL,2          
    MOV SNAKE[BX],AX
    
      
    CALL SCOREPLUS
    CALL RANDOMIZEMEAL
    JMP UPDATE_DIR
    
    

; === AN DUOI CU
HIDE_OLD_TAIL:     
    MOV     DX, TAIL 
    MOV     AH, 02H
    INT     10H      
    MOV     AL, ' ' 
    MOV     AH, 09H 
    MOV     BL, 0FH 
    MOV     CX, 1   
    INT     10H     

; === NHAP HUONG DI
UPDATE_DIR:
    MOV     AH, 01H    
    INT     16H        
    JZ      GAME_LOOP     
    
    MOV     AH, 00H    
    INT     16H        
    MOV     CUR_DIR,AH 
    JMP     GAME_LOOP

; === IN LOI NHAN GAMEOVER VA SO DIEM
GAME_OVER:
    XOR DX,DX             
    MOV AH, 02H           
    INT 10H               
    MOV AL, 2             
    MOV AH, 05H           
    INT 10H
    LEA DX, MSGOVER
    MOV AH,09H            
    INT 21H
    LEA DX, SCORE          
    MOV AH,09H            
    INT 21H               
    JMP KT

; === IN LOI NHAN WINNER    
WIN:
    MOV AL, 2                   
    MOV AH, 05H                 
    INT 10H           
    XOR DX,DX         
    MOV AH, 02H       
    INT 10H 
    LEA DX, MSGWINNER      
    MOV AH,09H             
    INT 21H                
    JMP KT

; ------ FUNCTIONS ------


; === CAP NHAT HUONG DI VA TOA DO CHO CAC PHAN TU CUA RAN
MOVE_SNAKE PROC  
    MOV   DI,W.S_SIZE     
    ADD DI,W.S_SIZE
    SUB DI,2              
    MOV CX,W.S_SIZE
    DEC CX

;=== CAP NHAT TOA DO
MOVE_ARRAY:
    MOV     AX, SNAKE[DI-2]   
    MOV     SNAKE[DI], AX         
    SUB     DI, 2                 
    LOOP    MOVE_ARRAY            

;=== CAP NHAT HUONG DI
GETDIR:
    CMP     CUR_DIR, LEFT
      JE    MOVE_LEFT
    CMP     CUR_DIR, RIGHT
      JE    MOVE_RIGHT
    CMP     CUR_DIR, UP
      JE    MOVE_UP
    CMP     CUR_DIR, DOWN
      JE    MOVE_DOWN
      
;=== CAP NHAT HUONG MOI = HUONG CU
GETOLDDIR:                   
    MOV     AL,OLD_DIR
    MOV     CUR_DIR,AL       
    JMP     GETDIR                

;=== KIEM TRA RAN CHET HAY KHONG VA CAP NHAT HUONG
MOVE_LEFT:
  CMP OLD_DIR,RIGHT
  JE GETOLDDIR          
  DEC B.SNAKE[0]        
  CMP   B.SNAKE[0], 0   
  JNE   STOP_MOVE       
  JMP GAME_OVER

MOVE_RIGHT:
  CMP   OLD_DIR,LEFT
  JE    GETOLDDIR        
  MOV   AL, B.SNAKE[0]   
  INC   AL               
  MOV   B.SNAKE[0], AL       
  CMP   AL, 79    
  JB    STOP_MOVE        
  JMP GAME_OVER

MOVE_UP:
  CMP OLD_DIR,DOWN
  JE GETOLDDIR           
  MOV   AL, B.SNAKE[1]   
  DEC   AL               
  MOV   B.SNAKE[1], AL   
  CMP   AL, 1            
  JNE   STOP_MOVE        
  JMP GAME_OVER

MOVE_DOWN:
  CMP OLD_DIR,UP
  JE GETOLDDIR
  MOV   AL, B.SNAKE[1]   
  INC   AL               
  MOV   B.SNAKE[1], AL                 
  CMP   AL, 24     
  JB   STOP_MOVE        
  JMP GAME_OVER

; === CAP NHAT HUONG CU = HUONG MOI
STOP_MOVE:               
  MOV AL,CUR_DIR         
  MOV OLD_DIR,AL
  RET
MOVE_SNAKE ENDP

;=== TAO BUA AN
RANDOMIZEMEAL PROC    
RERANDOMIZE:
    MOV AH, 00H 
    INT 1AH     
    MOV AX, DX  
    XOR DX, DX  
    MOV CX, 22  
    DIV CX      
    ADD DL, 2   
    MOV MEALY,DL

    MOV AH, 00H 
    INT 1AH     
    MOV AX, DX  
    XOR DX, DX  
    MOV CX,78   
    DIV CX      
    ADD DL, 1   
    MOV MEALX,DL                  
    MOV DH,MEALY

    MOV CX,W.S_SIZE 
    XOR BX,BX       

;=== KIEM TRA TOA DO DO AN CO TRUNG VOI RAN HAY KHONG    
NO_OVERWRITE_SNAKE:
    CMP DX,SNAKE[BX]
    JE RERANDOMIZE   
    ADD BX,2        
    DEC CX
    JNZ NO_OVERWRITE_SNAKE    
    MOV AH, 02H         
    MOV BH,01H          
    INT 10H             
    MOV AL, 4FH         
    MOV BL, 0B9H        
    MOV CX, 1      
    MOV AH, 09H    
    INT 10H        
    RET            
RANDOMIZEMEAL ENDP   

;=== TANG DIEM

SCOREPLUS PROC       
    MOV AL,SCORE[1]    
    INC AL
    MOV SCORE[1], AL
    CMP AL,'4'         
    JG WIN             
     
    XOR DX, DX
    MOV AH, 02H      
    MOV BH, 1
    INT 10H
    LEA DX, MSGSCORE         
    MOV AH, 09H
    INT 21H
    
    LEA DX, SCORE
    MOV     AH, 09H 
    INT     21H     
    RET   
SCOREPLUS ENDP

;; ==== HIEN THI PHAN DAU MOI
SHOWNEWHEAD PROC
    MOV     DX, SNAKE[0]
    MOV     AH, 02H     
    INT     10H         
    MOV     AL, 'O'     
    MOV     AH, 09H     
    MOV     BL, 0F5H    
    MOV     BH,01H      
    MOV     CX, 1       
    INT     10H         
    RET                 
SHOWNEWHEAD ENDP
            
;KET THUC CHUONG TRINH
KT:
    MOV AH, 4CH
    INT 21H

END               