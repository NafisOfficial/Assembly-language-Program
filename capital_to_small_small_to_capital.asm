.MODEL SMALL
.STACK 100H
.DATA
    ERR_MSG DB 'Error: Digit entered!', 0DH, 0AH, '$'  ; Error message for digits
.CODE
MAIN PROC
    MOV AH,01
    INT 21H         ; Read a character from the keyboard
    MOV BL,AL       ; Store the character in BL
    CMP BL, '0'     ; Check if the character is a digit (0-9)
    JL CHECK_ALPHA  ; If less than '0', it's not a digit
    CMP BL, '9'
    JG CHECK_ALPHA  ; If greater than '9', it's not a digit
    
    ; Line break before displaying error message
    MOV AH,02
    MOV DL,0DH
    INT 21H         ; Carriage return
    MOV AH,02
    MOV DL,0AH
    INT 21H         ; Line feed

    MOV DX, OFFSET ERR_MSG
    MOV AH,09
    INT 21H         ; Display the error message
    JMP EXIT        ; Exit the program

CHECK_ALPHA:
    MOV AH,02
    MOV DL,0DH
    INT 21H         ; Carriage return
    MOV AH,02
    MOV DL,0AH
    INT 21H         ; Line feed
    CMP BL, 'a'
    JGE SMALL_TO_BIG ; Check if the character is a lowercase letter

BIG_TO_SMALL:
    ADD BL, 32      ; Convert to lowercase
    MOV AH,02
    MOV DL,BL
    INT 21H
    JMP NEWLINE

SMALL_TO_BIG:
    SUB BL, 32      ; Convert to uppercase
    MOV AH,02
    MOV DL,BL
    INT 21H

NEWLINE:
    MOV AH,02
    MOV DL,0DH
    INT 21H         ; Carriage return
    MOV AH,02
    MOV DL,0AH
    INT 21H         ; Line feed

EXIT:
    MOV AH,4CH
    INT 21H         ; Exit the program
MAIN ENDP
END MAIN