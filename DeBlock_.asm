    * = $0400
      
    lda #$10         
    sta $026B        
    lda #$02         
    sta $026C        
    jsr $CCCE             ; ClrScr       
    lda #$0B         
    sta $026A        
    lda #<String1     
    sta Data2       
    ldy #>String1         
    jsr $CCB0             ; $CCB0  
    lda #<String2     
    ldy #>String2         
    jsr $CCB0             ; $CCB0  
    lda #$B0         
    ldy #$BD         
    sta $027A        
    sty $027B        
    lda #$D8         
    ldy #$BD         
    sta $0278        
    sty $0279        
    lda #$0C         
    sta $027E        
    lda #$E0         
    ldy #$01         
    sta $027c        
    sty $027D        
    jsr $CCCE       
;    jmp L0453        
;    nop              
;    nop              
;    sta $02F5        
;    nop              
;    nop              
L0453:                  ;$1453
    lda #$00         
    sta Data2                   ; $16FF
    jsr MFast         ; $0600   ; $1600      
    jsr MAuto         ; $0618   ; $1618
    jsr WriteBELL     ; $0630   ; $1630
    jsr BellOFF       ; $0648   ; $1648       
    lda #$01         
    sta Data1        
    lda #$00         
    sta $024D        
    lda #$80         
    sta $02AD        
Loop1:
    lda #<TEXTCommands         
    ldy #>TEXTCommands         
    jsr $CCB0  
    lda #<LISTCommands         
    ldy #>LISTCommands 
    jsr $CCB0  
Loop2:
    lda #<Text1       ; $0481 
    ldy #>Text1       
    jsr $CCB0  
    jsr ReadKey       
    cmp #"H"          ; T0uche 'H' Display C0MMandS again     
    beq Loop1         ; $0473        
    cmp #"A"          ; T0uche 'A' AUT0 mode
    bne KeyZ          ; $049E        
    lda #$80         
    sta $02AD        
    jsr MAuto         ; $0618        
    jmp Loop2         ; $0481        
KeyZ:
    cmp #"Z"          ; T0uchee 'Z' F0r ST0P m0de
    bne KeyB          ; $04AD        
    lda #$00         
    sta $02AD        
    jsr MStop         ; $0624        
    jmp Loop2         ; $0481        
KeyB:
    cmp #"B"        
    bne KeyN          ; $04BC        
    lda #$00         
    sta Data1         ; $06FE        
    jsr BellON        ; $063C        
    jmp Loop2         ; $0481        
KeyN:
    cmp #"N"         
    bne KeyF          ; $04CB        
    lda #$80         
    sta Data1         ; $06FE        
    jsr BellOFF       ; $0648        
    jmp Loop2         ; $0481        
KeyF:
    cmp #"F"         
    bne KeyS          ; $04DA        
    lda #$00         
    sta $024D        
    jsr MFast         ; $0600        
    jmp Loop2         ; $0481        
KeyS:
    cmp #"S"        
    bne KeyQ          ; $04E9        
    lda #$80         
    sta $024D        
    jsr MSlow         ; $060C        
    jmp Loop2         ; $0481        
KeyQ:
    cmp #"Q"         
    bne KeyV          ; $04f0        
    jmp $F9C9         ; SetupText    
KeyV:
    cmp #"V"         
    bne KeyY          ; $04f7        
    jmp MVerify       ; $05EE        
KeyY:
    cmp #"Y"         
    bne KeyL          ; $04fE        
    jmp Saving        ; $05E6        
KeyL:
    cmp #"L"        
    bne IllegalCommand     ; $0505        
    jmp Loading          ; $0A01        
IllegalCommand:
    lda #<TextIllegalCommand         
    ldy #>TextIllegalCommand
    jsr $CCB0  
    jmp Loop2         ; $0481        
L050F:
    jsr $E735         ; trouver la bande ammorce
L0512:
    jsr $E6C9         ; GetTapeByte   
    cmp #$24         
    bne L0512         ; $0512        
    ldx #$09         
L051B:
    jsr $E6C9         ; GetTapeByte   
    sta $02A7,X      
    dex              
    bne L051B         ; $051B        
    jsr L05BB         ; $05BB    Ecrire nom    
    lda $02AE         ; entête AUTO (si non nul)
    bne L0532         ; $0532        
    jsr L06E8         ; $06E8        
    jmp L0535         ; $0535        
L0532:
    jsr L09EB         ; ecrit 'CODE'
L0535:
    jsr L06AB         ; ecrit adresse début $06AB        
    jsr L06C0         ; ecrit adresse fin  $06C0        
L053B:
    lda $02A9        
    ldy $02AA        
    sta $68          
    sty $69          
    sta $6E          
    sty $6F          
    lda $02AB        
    ldy $02AC        
    sta $6A          
    sty $6B          
    rts
L0554:                    
    lda $6C          
    ldy $6D          
    sta $66          
    sty $67          
    rts 
L055D:                   
    php              
    jsr $E76A         ; SetupTape    
    jsr $E57D         ; PrintSearching
    jmp L0AE0         ; $0AE0        
L0567:
    lda #$00         
    ldy #$0B         
    sta $6C          
    sty $6D          
    lda $02AB        
    ldy $02AC        
    sta $6A          
    sty $6B          
    ldy #$00         
L057B:
    jsr $E6C9         ; GetTapeByte      ldx $025B        
    bne L0588         ; $0588       ; $157E 
    sta ($6C),Y      
    jmp L0594         ; $0594        
L0588:
    cmp ($6C),Y      
    beq L0594         ; $0594        
    inc $025C        
    rts              
;    nop              
;    nop              
;    nop              
;    nop              
L0594:
    jsr L059D         ; $059D        
    bcc L057B         ; $057B        
    rts              
;    jsr L06D5         ; $06D5        
L059D:
    inc $6C          
    bne L05A3         ; $05A3        
    inc $6D          
L05A3:
    lda $68          
    cmp $02AB        
    lda $69          
    sbc $02AC        
    inc $68          
    bne L05B3         ; $05B3        
    inc $69          
L05B3:
    rts              
ReadKey:
    jsr $C5E8         ; 05B4  20 E8 C5  ReadKey
    jsr $F7E4         ; 05b7 PrintA
    rts              
L05BB:                ; recherche nom du programme
    jsr $E6C9         ; GetTapeByte   
    beq L05D0         ; $05D0        
    sta $0293,X      
    sta $BCCA,X       ;ecrit nom programme à l'écran
    inx              
    cpx #$10         
    bne L05BB         ; $05BB        
L05CB:
    jsr $E6C9         ; GetTapeByte   
    bne L05CB         ; $05CB        
L05D0:
    jsr L05F9         ; $05F9        
    rts              
L05D4:
    lda #<TextNoFileLoaded         
    ldy #>TextNoFileLoaded
    jsr $CCB0  
    jmp Loop2         ; $0481        
L05DE:
    lda Data2         ; $06FF         
    beq L05D4         ; $05D4        
    jmp L09F7         ; $09F7        
Saving:               ; $05E6
    lda Data2         ; $06FF         
    beq L05D4         ; $05D4        
    jmp Loop2 ;jmp Save          ; $0A93        
MVerify:
    lda #$00         
    sta $025C        
    sta $025D        
;    jmp Loop2
    jmp L05DE         ; $05DE        
L05F9:
    sta $0293,X      
    sta $BCCA,X      
    rts              
MFast:
    ldx #$04         
L0602:
    lda TextFAST,X      
    sta $BFBE,X      
    dex              
    bne L0602         ; $0602        
    rts              
MSlow:
    ldx #$04         
L060E:
    lda TextSLOW,X      
    sta $BFBE,X      
    dex              
    bne L060E         ; $060E        
    rts              
MAuto:
    ldx #$04         
L061A:
    lda TextAUTO,X      
    sta $BFC7,X      
    dex              
    bne L061A         ; $061A        
    rts              
MStop:
    ldx #$04         
L0626:
    lda TextSTOP,X      
    sta $BFC7,X      
    dex              
    bne L0626         ; $0626        
    rts              
WriteBELL:
    ldx #$05         
L0632:
    lda TextBELL,X      
    sta $BFD2,X      
    dex              
    bne L0632         ; $0632        
    rts              
BellON:
    ldx #$03         
L063E:
    lda TextBellON,X      
    sta $BFD8,X      
    dex              
    bne L063E         ; $063E        
    rts              
BellOFF:
    ldx #$04         
L064A:
    lda TextBellOFF,X      
    sta $BFD8,X      
    dex              
    bne L064A         ; $064A        
    rts 
L0654:
    tax              
    and #$0F         
    jsr L067D         ; $067D        
    sta L09EA        
    tya              
    and #$0F         
    jsr L067D         ; $067D        
    sta L09E8        
    tya              
    and #$F0         
    jsr L0679         ; $0679        
    sta L09E7        
    txa              
    and #$F0         
    jsr L0679         ; $0679        
    sta L09E9        
    rts              
L0679:
    lsr              
    lsr              
    lsr              
    lsr              
L067D:
    cmp #$0A         
    bcs L0684         ; $0684        
    adc #$30         
    rts 
L0684:
    clc              
    adc #$37         
    rts 
L0688:                 
    ldx #$11         
L068A:
    lda $0292,X      
    sta $027E,X      
    dex              
    bne L068A          ; $068A        
    rts              
    ldx #$00         
L0696:
    inx              
    lda $0292,X      
    sta $bcc9,X      
    bne L0696         ; $0696        
    rts              
L06A0:
    lda Data1         ; $06FE        
    bne L0481         ; $06A8        
    jsr $FA9F         ; PING         
L0481:
    jmp Loop2         ; $0481        
L06AB:                  ; bit de START
    lda $02A9        
    ldy $02AA        
    jsr L0654         ; $0654        
    ldx #$04         
L06B6:
    lda L09E6,X      
    sta $BD1D,X       ; ecrit bit START
    dex              
    bne L06B6         ; $06B6        
    rts              
L06C0:                ; bit de END
    lda $02AB        
    ldy $02AC        
    jsr L0654         ; $0654        
    ldx #$04         
L06CB:
    lda L09E6,X       ; $09E6
    sta $BD45,X       ; ecrit bit de END
    dex              
    bne L06CB         ; $06CB        
    rts
L06D5:
    lda $33          
    ldy $34          
    jsr L0654         ; $0654        
    ldx #$04         
L06DE:
    lda TextCODE,X      
    sta $BD55,X      
    dex              
    bne L06DE         ; $06DE        
    rts              
L06E8:          ; $16D4
    ldx #$05         
L06EA:
    lda TextBASIC,X   ; $09DC 
    sta $BD2d,X       
    dex              
    bne L06EA         ; $06EA
    rts
L06F4:
    jsr L0554         ; $0554        
    jsr L0879        
    jmp L0A76         ; $0A76        
    nop
Data1:
      .db $01
Data2: 
      .db $00
String1  ; $0700
      .db $0A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$04,$1B,$41,$1B,$4A,$44,$45,$42,$4C,$4f,$43,$4B,$20
      .db $31,$2e,$31,$1b,$42,$04,$0d,$0a,$0a,$0a,$0a,$1b,$44,$1b,$44,$20,$20,$50,$61,$72,$1b,$46,$20,$1b,$4c
      .db "Gliou12.02.2024"
      .db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20
      .db $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d
      .db $2d,$2d,$2d,$2d,$2d,$20,$20,$20,$20,$20,$20,$0a,$0d,$1b,$46,$4e,$41,$4d,$45,$20,$3a,$20,$20,$2d
      .db $0a,$0d,$0d,$20,$1b,$44,$2a,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2a,$2d,$2d,$2d
      .db $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2a,$0d,$0a,$20,$1b,$44,$7c,$20,$1b,$42,$53,$54,$41,$52
      .db $54,$3a,$20,$30,$30,$30,$30,$1b,$44,$20,$7c,$1b,$42,$20,$54,$59,$50,$45,$20,$3a,$20,$20,$2d,$20,$20,$20,$1b
      .db $44,$7c,$0d,$0a,$20,$1b,$44,$7c,$1b,$42,$20,$20,$45,$4e,$44,$20,$3a,$20,$30,$30,$30,$30,$20,$1b,$44
      .db $7c,$1b,$42,$20,$43,$4f,$55,$4e,$54,$3a,$20,$30,$30,$30,$30,$1b,$44,$20,$7c
      .db 00

String2 ; 07F8
      .db $0d,$0a,$20,$1b,$44,$2a,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2a,$2d,$2d,$2d
      .db $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2a,$0d,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
      .db $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d
      .db $2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d,$2d 
      .db 00

TextNoFileLoaded
      .db $1b,$41,"-",$20,"NO",$20,"FILE",$20,"LOADED."
      .db 00

TextIllegalCommand:
      .db $1b,$44,"-",$20,"ILLEGAL",$20,"COMMAND."
      .db 00
L0879:
    dec $66
    ldx $66
    cpx #$FF
    bne L0883
    dec $67
L0883:
    rts        
;              0884  C1 CD     CMP ($CD,X)      
;              0886  A0 A6     ldy #$A6         
;              0888  A0 CA     ldy #$CA         
;              088A  D0 D3     BNE $085F        
;              088C  AE 00 
Text1: ; 088E
      .db $0d,$0a,$3E,$00
TextOK: ; 0892
      .db $1b,$43,"- OK",$00
TextFAST: ; 0899
      .db $00,$c6,$c1,$d3,$d4
TextSLOW: ; 089D
      .db $00,$d3,$cc,$cf,$d7
TextAUTO: ; 08A1
      .db $00,$c1,$d5,$d4,$cf
TextSTOP: ; 08A5
      .db $00,$d3,$d4,$cf,$d0
TextBELL: ; 08A9
      .db $00,$c2,$c5,$cc,$cc
Text2Points:
      .db  ":" ; 08AD
TextBellON: ; 08AE
      .db $20,"ON"
TextBellOFF:
      .db $2e,"OFF" 
TEXTCommands:
      .db $0d,$0a,$0a,$1b,$46,$20,$20,$20,$20,$2d,$43,$4f,$4d,$4d,$41,$4e,$44,$53,$3a,$0d,$0a,$0a,$1b,$41,$4c,$1b,$45,$54
      .db $4f,$20,$4c,$4f,$41,$44,$20,$41,$20,$46,$49,$4c,$45,$2e,$0d,$0a,$1b,$41,$59,$1b,$45,$54,$4f,$20,$53,$41,$56
      .db $45,$20,$41,$20,$46,$49,$4c,$45,$2e,$20,$20,$0d,$0a,$1b,$41,$56,$1b,$42,$54,$4f,$20,$56,$45,$52,$49,$46,$59,$20,$41
      .db $20,$46,$49,$4c,$45,$2e,$0d,$0a,$1b,$41,$42,$1b,$43,$54,$4f,$20,$50,$55,$54,$20,$54,$48,$45,$20,$42,$45,$4c,$4c,$20,$4f
      .db $4e,$2e,$20,$0d,$0a,$1b,$41,$4e,$1b,$43,$54,$4f,$20,$50,$55,$54,$20,$54,$48,$45,$20,$42,$45,$4c,$4c,$20,$4f,$46,$46,$2e
      .db 00
LISTCommands:
      .db $0d,$0a,$1b,$41,$20,$08,$20,$08,$48,$1b,$44,$54,$4f,$20,$44,$49,$53,$50,$4c,$41,$59,$20,$43,$4f,$4d,$4d,$41,$4e,$44,$53
      .db $20,$41,$47,$41,$49,$4e,$2e,$0d,$0a,$1b,$41,$51,$1b,$44,$54,$4f,$20,$51,$55,$49,$54,$20,$54,$48,$49,$53,$20,$50,$52
      .db $4f,$47,$52,$41,$4d,$2e,$0d,$0a,$1b,$41,$46,$1b,$42,$46,$4f,$52,$20,$46,$41,$53,$54,$20,$4d,$4f,$44,$45,$20,$4f,$52
      .db $1b,$41,$53,$1b,$42,$46,$4f,$52,$20,$53,$4c,$4f,$57,$20,$4d,$4f,$44,$45,$2e,$0d,$0a,$1b,$41,$41,$1b,$42,$46,$4f,$52,$20
      .db $41,$55,$54,$4f,$20,$4d,$4f,$44,$45,$20,$4f,$52,$1b,$41,$5A,$1b,$42,$46,$4f,$52,$20,$53,$54,$4f,$50,$20,$4d,$4f,$44,$45,$2e
      .db 00
TextBASIC ; 09DD
    .db 0,"BASIC"
TextCODE:
    .db 0,"CODE"
L09E6:
    .db $20
L09E7:      
    .db $30
L09E8:
    .db $45
L09E9:
    .db $33
L09EA:
    .db $30
L09EB:
    ldx #$05         
L09ED:
    lda TextCODE,X      
    sta $BD2D,X      
    dex              
    bne L09ED        
    rts              
L09F7:  
    lda #$80         
    sta $025B        
    jmp L055D        
    nop              
    nop              
Loading:    ; $19EC     ; $0A01
    lda #$00         
    sta $025B        
    php              
    jsr $E76A   ; SetupTape 
    jsr $E57D   ; PrintSearching
    jsr L050F        
    jmp L0A37        
L0A13:
    jsr $E6C9         ; GetTapeByte   
    beq L0A27        
    cmp $0293,X      
    bne L0A32        
    inx              
    cpx #$10         
    bne L0A13        
L0A22:
    jsr $E6C9         ; GetTapeByte   
    bne L0A22        
L0A27:
    lda $0293,X      
    bne L0A32        
    jsr L053B        
    jmp L0A37        
L0A32:
    jmp L0A85
L0A35:        
    nop              
    nop              
L0A37: ; $1A22
    jsr $E59B         ; affiche 'LOADING' ou 'VERIFYNG' et le nom du prog
    jsr L0567        
    jsr $E93D         ; reconfigure le VIA
    plp               ; $1a40
    lda $025B        
    bne L0A4E        
    jsr L0688        
    nop               ; $1A28
    nop              
    jmp L06F4        
L0A4E:
    lda $025C        
    beq L0A5D        
    lda #<TextERRORFOUND   
    ldy #>TextERRORFOUND   
    jsr $CCB0  
    jmp L06A0        
L0A5D:
    lda #<TextOK         
    ldy #>TextOK       
    jsr $CCB0  
    jmp L06A0        

TextERRORFOUND:
    .db $1B,$41,"ERROR",$20,"FOUND",$2E
    .db 00

L0A76:
    lda #$80       
    sta Data2         ; $06FF 
    lda #<TextOK          
    ldy #>TextOK         
    jsr $CCB0  
    jmp L06A0        
L0A85:                      ;1A7A
    lda #<TextERRORFOUND   
    ldy #>TextERRORFOUND   
    jsr $CCB0  
    jsr $E93D        
    plp              
    jmp L06A0        
L0AE0:                  ; 1A88
    jsr $E735           ;SyncTape
L0AE3:                  
    jsr $E6C9         ; GetTapeByte   
    cmp #$24         
    bne L0AE3        
    ldx #$09         
L0AEC:
    jsr $E6C9         ; GetTapeByte   
    cmp $02A7,X      
    bne L0AFA        
    dex              
    bne L0AEC        
    jmp L0A13        
L0AFA:
    jmp L0A85        