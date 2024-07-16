.MODEL SMALL
.STACK 100H
.DATA
    E_M DB "ERROR ! DIGIT ENTERED $", 0DH, 0AH, "$"
.CODE
MAIN PROC
    
    MOV AH,01
    INT 21H
    MOV BL,AL
    
    
    CMP BL,'0'
    JL CHECK_ALPHA
    CMP BL,'9'
    JG CHECK_ALPHA
    
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV AH,2
    MOV DL,0AH
    INT 21H
    
    
    MOV DX, OFFSET E_M
    MOV AH,09
    INT 21H
    JMP EXIT
    
    
    CHECK_ALPHA:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV AH,2
    MOV DL,0AH
    INT 21H
    
    CMP BL,'a'
    JGE SMALL_TO_BIG
    
    BIG_TO_SMALL:
    ADD BL, 32
    MOV AH,02
    MOV DL, BL
    INT 21H
    JMP NEWLINE
    
    SMALL_TO_BIG:
    SUB BL,32
    MOV AH,02
    MOV DL,BL
    INT 21H
    
    NEWLINE:
    MOV AH,02
    MOV DL,0DH
    INT 21H
    MOV AH,02
    MOV DL,0AH
    INT 21H
    
    
    
    EXIT:
    MAIN ENDP
END MAIN