;       A1      PC Z80
;       A4      SP Z80
;       D0      IXxF
;       D1      IYxA
;       D2      xBxC
;       D3      xDxE
;       D4      xHxL

;Флаговый регистр
; Bit  Обозначение   Комментарии
;        Z80  M68K

;  0      C    C     Флаг переноса
;  1     P/V   V     Флаг четности/переполнения
;  2      Z    Z     Флаг нуля
;  3      S    N     Флаг знака
;  4      3          *Недокументированный флаг
;  5      5          *Недокументированный флаг
;  6      N          *Флаг сложения/вычитания
;  7      H          *Флаг полупереноса

_00     ;NOP
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_01     ;LD BC,NN
                move.b  (a1)+,d2
                swap    d2
                move.b  (a1)+,d2
                swap    d2
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_02     ;LD (BC),A
                move.l  a4,d7
                move.b  d2,d6           ;C
                swap    d2
                move.b  d2,-(a7)           ;B
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d2
                move.b  d6,d7           ;d7=BC
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _02wp
                move.b  d1,(a0)
_02wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_03     ;INC BC
                ext.w   d2
                addq.l  #1,d2
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_04     ;INC B *
                swap    d2
                addq.b  #1,d2
                move.w  sr,d7           ;6
                and.b   #%00001110,d7   ;4+4
                and.b   #%10110001,d0   ;4+4
                or.b    d7,d0           ;4+0 Итого 26
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_05     ;DEC B *
                swap    d2
                subq.b  #1,d2
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_06     ;LD B,N
;                move.l  #$06,d7
;                bra     no_instr

                swap    d2
                move.b  (a1)+,d2
                swap    d2
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_07     ;RLCA *
                rol.b   #1,d1           ;8
                scs.b   d7              ;4/6
                and.b   #%1,d7          ;4+4
                and.b   #%111110,d0     ;4+4
                or.b    d7,d0           ;4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_08     ;EX AF,AF'
                lea     reg_af(a5),a0
                move.b  (a0),d6
                move.b  d1,(a0)+
                move.b  d6,d1
                move.b  (a0),d6
                move.b  d0,(a0)
                move.b  d6,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_09     ;ADD HL,BC *
                add.b   d2,d4
                swap    d2
                swap    d4
                addx.b  d2,d4
                scs.b   d7              ;4/6
                and.b   #1,d7           ;4+4
                and.b   #%11111110,d0   ;4+4
                or.b    d7,d0           ;4   всего 24 (CY=0) или 26 тактов
                swap    d2
                swap    d4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_0A     ;LD A,(BC)
                move.l  a4,d7
                move.b  d2,d6
                swap    d2
                move.b  d2,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d2
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d1
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_0B     ;DEC BC
                ext.w   d2
                subq.l  #1,d2
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_0C     ;INC C
                addq.b  #1,d2
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_0D     ;DEC C *
                subq.b  #1,d2
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_0E     ;LD C,N
                move.b  (a1)+,d2
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_0F     ;RRCA *
                ror.b   #1,d1           ;8
                scs.b   d7              ;4/6
                and.b   #%1,d7          ;4+4
                and.b   #%111110,d0     ;4+4
                or.b    d7,d0           ;4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_10     ;DJNZ S
                swap    d2
                subq.b  #1,d2
                bne     _10nz
                swap    d2
                addq.l  #1,a1
                addq.w  #8,d5    ;b=0 нет перехода
                bcc     kernel
                bra     interrupt
_10nz           swap    d2
                move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a1
                add.w   #13,d5   ;b<>0 идем по ссылке
                bcc     kernel
                bra     interrupt
_11     ;LD DE,NN
                move.b  (a1)+,d3
                swap    d3
                move.b  (a1)+,d3
                swap    d3
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_12     ;LD (DE),A
                move.l  a4,d7
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d3
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7      ;movie?
;                bcs     _12wp          ;
                move.b  d1,(a0)
_12wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_13     ;INC DE
                ext.w   d3
                addq.l  #1,d3
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_14     ;INC D *
                swap    d3
                addq.b  #1,d3
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_15     ;DEC D *
                swap    d3
                subq.b  #1,d3
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_16     ;LD D,N
                swap    d3
                move.b  (a1)+,d3
                swap    d3
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_17     ;RLA *
                move.b  d0,d7          ;4
                lsr.b   #1,d7          ;6+2*1
                roxl.b  #1,d1
                scs.b   d7
                and.b   #1,d7
                and.b   #%00111110,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_18     ;JR S
                move.l  a4,d7
                move.b  (a1)+,d6
                move.w  a1,d7
                ext.w   d6
                add.w   d6,d7
                move.l  d7,a1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_19     ;ADD HL,DE *
                add.b   d3,d4
                swap    d3
                swap    d4
                addx.b  d3,d4
                scs.b   d7
                and.b   #1,d7
                and.b   #%11111110,d0
                or.b    d7,d0
                swap    d3
                swap    d4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_1A     ;LD A,(DE)
                move.l  a4,d7
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d3
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d1
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_1B     ;DEC DE
                ext.w   d3
                subq.l  #1,d3
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_1C     ;INC E *
                addq.b  #1,d3
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_1D     ;DEC E *
                subq.b  #1,d3
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_1E     ;LD E,N
                move.b  (a1)+,d3
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_1F     ;RRA *
                move.b  d0,d7          ;4
                lsr.b   #1,d7          ;6+2*1
                roxr.b  #1,d1
                scs.b   d7
                and.b   #1,d7
                and.b   #%00111110,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_20     ;JR NZ,S
                move    d0,ccr
                bne     _20jr
                move.b  (a1)+,d7
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_20jr           move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_21     ;LD HL,NN
                move.b  (a1)+,d4
                swap    d4
                move.b  (a1)+,d4
                swap    d4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_22     ;LD (NN),HL
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _22wp1
                move.b  d4,(a0)+ ;wp без плюса
;_22wp1          addq    #1,a0
;                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _22wp2
                swap    d4
                move.b  d4,(a0)
                swap    d4
_22wp2          add.w   #16,d5
                bcc     kernel
                bra     interrupt
_23     ;INC HL
                ext.w   d4
                addq.l  #1,d4
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_24     ;INC H *
                swap    d4
                addq.b  #1,d4
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_25     ;DEC H *
                swap    d4
                subq.b  #1,d4
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_26     ;LD H,N
                swap    d4
                move.b  (a1)+,d4
                swap    d4
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_27     ;DAA
;                trap    #8

                move.b  d1,d7
                move.b  DAA(a5),d1
                btst    #0,d0
                beq     _27nc
                sub.b   d1,d7
                bcc     _27s
_27a            move    #4,ccr
                abcd    d7,d1
                move.w  sr,d7
                and.b   #%00000101,d7
                and.b   #%11111010,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_27nc           sub.b   d1,d7
                bcc     _27a
_27s            neg.b   d7
                move    #4,ccr
                sbcd    d7,d1
                move.w  sr,d7
                and.b   #%00000101,d7
                and.b   #%11111010,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_28     ;JR Z,S
                move    d0,ccr
                beq     _28jr
                move.b  (a1)+,d7
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_28jr           move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_29     ;ADD HL,HL *
                add.b   d4,d4
                swap    d4
                addx.b  d4,d4
                scs.b   d7
                and.b   #1,d7
                and.b   #%11111110,d0
                or.b    d7,d0
                swap    d4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_2A     ;LD HL,(NN)
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d6
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d4
                swap    d4
                move.b  (a0),d4
                swap    d4
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_2B     ;DEC HL
                ext.w   d4
                subq.l  #1,d4
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_2C     ;INC L *
                addq.b  #1,d4
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_2D     ;DEC L *
                subq.b  #1,d4
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_2E     ;LD L,N
                move.b  (a1)+,d4
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_2F     ;CPL
                not.b   d1
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_30     ;JR NC,S
                move    d0,ccr
                bcc     _30jr
                move.b  (a1)+,d7
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_30jr           move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_31     ;LD SP,NN       ;@
                move.l  a4,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d6
                move.b  d6,d7
                move.l  d7,a4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_32     ;LD (NN),A
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d6
                move.b  d6,d7
;                cmp.w   #$4000,d7
;                bcs     _32wp
                move.l  d7,a0
                move.b  d1,(a0)
_32wp           add.w   #13,d5
                bcc     kernel
                bra     interrupt
_33     ;INC SP
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_34     ;INC (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                swap    d7
                move.b  (a0),d6
                addq.b  #1,d6
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
;                swap    d7
;                cmp.w   #$4000,d7
;                bcs     _34wp
                move.b  d6,(a0)
_34wp           add.w   #11,d5
                bcc     kernel
                bra     interrupt
_35     ;DEC (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                swap    d7
                move.b  (a0),d6
                subq.b  #1,d6
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
;                swap    d7
;                cmp.w   #$4000,d7
;                bcs     _35wp
                move.b  d6,(a0)
_35wp           add.w   #11,d5
                bcc     kernel
                bra     interrupt
_36     ;LD (HL),N
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a1)+,d6
;                cmp.w   #$4000,d7
;                bcs     _36wp
                move.b  d6,(a0)
_36wp           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_37     ;SCF
                bset    #0,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_38     ;JR C,S
                move    d0,ccr
                bcs     _38jr
                move.b  (a1)+,d7
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_38jr           move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_39     ;ADD HL,SP
                move.w  a4,d7
                add.b   d7,d4
                swap    d4
                rol.w   #8,d7
                addx.b  d7,d4
                scs.b   d7
                and.b   #1,d7
                and.b   #%11111110,d0
                or.b    d7,d0
                swap    d4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_3A     ;LD A,(NN)
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d6
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d1
                add.w   #13,d5
                bcc     kernel
                bra     interrupt
_3B     ;DEC SP
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4                
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_3C     ;INC A *
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                addq.b  #1,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_3D     ;DEC A *
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                subq.b  #1,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_3E     ;LD A,N
                move.b  (a1)+,d1
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_3F     ;CCF
                bchg    #0,D0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_40     ;LD B,B
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_41     ;LD B,C
                move.b  d2,d6
                swap    d2
                move.b  d6,d2
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_42     ;LD B,D
                swap    d2
                swap    d3
                move.b  d3,d2
                swap    d2
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_43     ;LD B,E
                swap    d2
                move.b  d3,d2
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_44     ;LD B,H
                swap    d2
                swap    d4
                move.b  d4,d2
                swap    d2
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_45     ;LD B,L
                swap    d2
                move.b  d4,d2
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_46     ;LD B,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                swap    d2
                move.b  (a0),d2
                swap    d2
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_47     ;LD B,A
                swap    d2
                move.b  d1,d2
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_48     ;LD C,B
                swap    d2
                move.b  d2,d6
                swap    d2
                move.b  d6,d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_49     ;LD C,C
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_4A     ;LD C,D
                swap    d3
                move.b  d3,d2
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_4B     ;LD C,E
                move.b  d3,d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_4C     ;LD C,H
                swap    d4
                move.b  d4,d2
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_4D     ;LD C,L
                move.b  d4,d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_4E     ;LD C,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d2
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_4F     ;LD C,A
                move.b  d1,d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_50     ;LD D,B
                swap    d3
                swap    d2
                move.b  d2,d3
                swap    d3
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_51     ;LD D,C
                swap    d3
                move.b  d2,d3
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_52     ;LD D,D
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_53     ;LD D,E
                move.b  d3,d6
                swap    d3
                move.b  d6,d3
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_54     ;LD D,H
                swap    d3
                swap    d4
                move.b  d4,d3
                swap    d3
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_55     ;LD D,L
                swap    d3
                move.b  d4,d3
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_56     ;LD D,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                swap    d3
                move.b  (a0),d3
                swap    d3
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_57     ;LD D,A
                swap    d3
                move.b  d1,d3
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_58     ;LD E,B
                swap    d2
                move.b  d2,d3
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_59     ;LD E,C
                move.b  d2,d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_5A     ;LD E,D
                swap    d3
                move.b  d3,d6
                swap    d3
                move.b  d6,d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_5B     ;LD E,E
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_5C     ;LD E,H
                swap    d4
                move.b  d4,d3
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_5D     ;LD E,L
                move.b  d4,d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_5E     ;LD E,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d3
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_5F     ;LD E,A
                move.b  d1,d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_60     ;LD H,B
                swap    d2
                swap    d4
                move.b  d2,d4
                swap    d2
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_61     ;LD H,C
                swap    d4
                move.b  d2,d4
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_62     ;LD H,D
                swap    d3
                swap    d4
                move.b  d3,d4
                swap    d3
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_63     ;LD H,E
                swap    d4
                move.b  d3,d4
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_64     ;LD H,H
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_65     ;LD H,L
                move.b  d4,d6
                swap    d4
                move.b  d6,d4
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_66     ;LD H,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                swap    d4
                move.b  (a0),d4
                swap    d4
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_67     ;LD H,A
                swap    d4
                move.b  d1,d4
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_68     ;LD L,B
                swap    d2
                move.b  d2,d4
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_69     ;LD L,C
                move.b  d2,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_6A     ;LD L,D
                swap    d3
                move.b  d3,d4
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_6B     ;LD L,E
                move.b  d3,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_6C     ;LD L,H
                swap    d4
                move.b  d4,d6
                swap    d4
                move.b  d6,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_6D     ;LD L,L
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_6E     ;LD L,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d4
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_6F     ;LD L,A
                move.b  d1,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_70     ;LD (HL),B
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _70wp
                swap    d2
                move.b  d2,(a0)
                swap    d2
_70wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_71     ;LD (HL),C
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _71wp
                move.b  d2,(a0)
_71wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_72     ;LD (HL),D
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _72wp
                swap    d3
                move.b  d3,(a0)
                swap    d3
_72wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_73     ;LD (HL),E
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _73wp
                move.b  d3,(a0)
_73wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_74     ;LD (HL),H
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _74wp
                swap    d4
                move.b  d4,(a0)
                swap    d4
_74wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_75     ;LD (HL),L
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _75wp
                move.b  d4,(a0)
_75wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_76     ;HALT
;                move.l  #0-69888,d5
;                move.w  #(0-34944),d5

;                move.l  #$1ffff,d5      ;в верхней половине 1, в нижней 
;                addq.w  #4,d5
;                bcc     kernel
;                bra     interrupt

;                move.b  IM(a5),d7
;                cmp.b   #2,d7
;                bne     _76_no_im2
;		adda.l	#1,a1

_76_no_im2      move.l  #$10000,d5      ;в верхней половине 1, в нижней 
                bra     interrupt



_77     ;LD (HL),A
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _77wp
                move.l  d7,a0
                move.b  d1,(a0)
_77wp           addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_78     ;LD A,B
                swap    d2
                move.b  d2,d1
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_79     ;LD A,C
                move.b  d2,d1
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_7A     ;LD A,D
                swap    d3
                move.b  d3,d1
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_7B     ;LD A,E
                move.b  d3,d1
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_7C     ;LD A,H
                swap    d4
                move.b  d4,d1
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_7D     ;LD A,L
                move.b  d4,d1
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_7E     ;LD A,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d1
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_7F     ;LD A,A
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_80     ;ADD A,B
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d2
                add.b   d2,d1
                move.w  sr,d7
                swap    d2
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_81     ;ADD A,C
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                add.b   d2,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_82     ;ADD A,D
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d3
                add.b   d3,d1
                move.w  sr,d7
                swap    d3
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_83     ;ADD A,E
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                add.b   d3,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_84     ;ADD A,H
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d4
                add.b   d4,d1
                move.w  sr,d7
                swap    d4
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_85     ;ADD A,L
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                add.b   d4,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_86     ;ADD A,(HL)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_87     ;ADD A,A
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                add.b   d1,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_88     ;ADC A,B
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d2
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d2,d1
                move.w  sr,d7
                swap    d2
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_89     ;ADC A,C
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d2,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_8A     ;ADC A,D
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d3
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d3,d1
                move.w  sr,d7
                swap    d3
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_8B     ;ADC A,E
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d3,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_8C     ;ADC A,H
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d4
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d4,d1
                move.w  sr,d7
                swap    d4
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_8D     ;ADC A,L
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d4,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_8E     ;ADC A,(HL)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_8F     ;ADC A,A
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d1,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_90     ;SUB B
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d2
                sub.b   d2,d1
                move.w  sr,d7
                swap    d2
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_91     ;SUB C
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                sub.b   d2,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_92     ;SUB D
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d3
                sub.b   d3,d1
                move.w  sr,d7
                swap    d3
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_93     ;SUB E
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                sub.b   d3,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_94     ;SUB H
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d4
                sub.b   d4,d1
                move.w  sr,d7
                swap    d4
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_95     ;SUB L
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                sub.b   d4,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_96     ;SUB (HL)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_97     ;SUB A
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                sub.b   d1,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_98     ;SBC A,B
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d2
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d2,d1
                move.w  sr,d7
                swap    d2
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_99     ;SBC A,C
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d2,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_9A     ;SBC A,D
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d3
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d3,d1
                move.w  sr,d7
                swap    d3
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_9B     ;SBC A,E
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d3,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_9C     ;SBC A,H
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d4
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d4,d1
                move.w  sr,d7
                swap    d4
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_9D     ;SBC A,L
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d4,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_9E     ;SBC A,(HL)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_9F     ;SBC A,A
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d1,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A0     ;AND B
                swap    d2
                and.b   d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A1     ;AND C
                and.b   d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A2     ;AND D
                swap    d3
                and.b   d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A3     ;AND E
                and.b   d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A4     ;AND H
                swap    d4
                and.b   d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A5     ;AND L
                and.b   d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A6     ;AND (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_A7     ;AND A
                and.b   d1,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A8     ;XOR B
                swap    d2
                eor.b   d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_A9     ;XOR C
                eor.b   d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_AA     ;XOR D
                swap    d3
                eor.b   d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_AB     ;XOR E
                eor.b   d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_AC     ;XOR H
                swap    d4
                eor.b   d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_AD     ;XOR L
                eor.b   d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_AE     ;XOR (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_AF     ;XOR A
                eor.b   d1,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B0     ;OR B
                swap    d2
                or.b    d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d2
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B1     ;OR C
                or.b    d2,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B2     ;OR D
                swap    d3
                or.b    d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d3
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B3     ;OR E
                or.b    d3,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B4     ;OR H
                swap    d4
                or.b    d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                swap    d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B5     ;OR L
                or.b    d4,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B6     ;OR (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_B7     ;OR A
                or.b    d1,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B8     ;CP B
                swap    d2
                move.b  d1,d6
                sub.b   d2,d6
                move.w  sr,d7
                swap    d2
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_B9     ;CP C
                move.b  d1,d6
                sub.b   d2,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_BA     ;CP D
                swap    d3
                move.b  d1,d6
                sub.b   d3,d6
                move.w  sr,d7
                swap    d3
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_BB_    ;CP E
                move.b  d1,d6
                sub.b   d3,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_BC     ;CP H
                swap    d4
                move.b  d1,d6
                sub.b   d4,d6
                move.w  sr,d7
                swap    d4
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_BD     ;CP L
                move.b  d1,d6
                sub.b   d4,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_BE     ;CP (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_BF     ;CP A
                move.b  d1,d6
                sub.b   d1,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_C0     ;RET NZ @
                move.w  d0,ccr
                beq     _C0z
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_C0z            addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_C1     ;POP BC
                move.b  (a4),d2
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d2
                move.b  (a4),d2
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d2
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_C2     ;JP NZ,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                beq     _C2z
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_C2z            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_C3     ;JP NN
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_C4     ;CALL NZ,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                beq     _C4z
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C4wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_C4wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C4wp2
                move.w  a1,d7
                move.b  d7,(a4)
_C4wp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_C4z            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_C5     ;PUSH BC
                swap    d2
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C5wp1
                move.b  d2,(a4)
_C5wp1          swap    d2
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C5wp2
                move.b  d2,(a4)
_C5wp2          add.w   #11,d5
                bcc     kernel
                bra     interrupt
_C6     ;ADD A,N
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  (a1)+,d6
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0

;                or.b    #%110000,d0        ;Для Ghost'N'Goblins

                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_C7     ;RST 0
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C7wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
          
_C7wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _C7wp2
                move.w  a1,d7
                move.b  d7,(a4)
_C7wp2          move.w  #$0,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_C8     ;RET Z
                move.w  d0,ccr
                bne     _C8nz
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_C8nz           addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_C9     ;RET 
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_CA     ;JP Z,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bne     _CAnz
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_CAnz           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_CB     ;PREFIX
                move.w  #$100,d6
                move.b  (a1)+,d6
                add.w   d6,d6
                move.w  (a2,d6.w),d7
                jmp     (a3,d7.w)
_CC     ;CALL Z,NN ;ВОзможно здесь накосячил
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bne     _CCnz
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _CCwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_CCwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _CCwp2
                move.w  a1,d7
                move.b  d7,(a4)
_CCwp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_CCnz           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_CD     ;CALL NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6

                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

;                cmp.w   #$4000,d7
;                bcs     _CDwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_CDwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _CDwp2
                move.w  a1,d7
                move.b  d7,(a4)
_CDwp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_CE     ;ADC A,N
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  (a1)+,d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_CF     ;RST #08
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _CFwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
          
_CFwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _CFwp2
                move.w  a1,d7
                move.b  d7,(a4)
_CFwp2          move.w  #$8,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D0     ;RET NC
                move.w  d0,ccr
                bcs     _D0c
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D0c            addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_D1     ;POP DE
                move.b  (a4),d3
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d3
                move.b  (a4),d3
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d3
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_D2     ;JP NC,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bcs     _D2c
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_D2c            add.w   #10,d5
                bcc     kernel
                bra     interrupt

;                data
;SndCommandPtr           dc.b    1,0     ;Команда sndCmdFreqDurationAmp и ноль
;                        dc.l    10000       ;Частота Hz
;                        dc.w    1    ;Длительность ms
;                        dc.w    64      ;Громкость
;                code


_D3     ;OUT (N),A

;                trap    #8
                
                move.b  (a1)+,d6
                btst.l  #0,d6
                bne     _D3no_fe
                
                tst.b   sound_flag(a5)
                beq     _D3_sound

;                movem.l d0-d2/a0-a1,-(a7)
;                trap    #8
;                systrap SndDoCmd (#0.l,&SndCommandPtr(a5),#0.b)
;                movem.l (a7)+,d0-d2/a0-a1

                btst    #4,d1
                beq     _D3_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _D3_sound
_D3_no_sound    move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_D3_sound
                move.b  d1,d6
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_D3no_fe        add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D4     ;CALL NC,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bcs     _D4c
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D4wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_D4wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D4wp2
                move.w  a1,d7
                move.b  d7,(a4)
_D4wp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_D4c            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_D5     ;PUSH DE
                swap    d3
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D5wp1
                move.b  d3,(a4)
_D5wp1          swap    d3
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D5wp2
                move.b  d3,(a4)
_D5wp2          add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D6     ;SUB N
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  (a1)+,d6
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_D7     ;RST #10
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D7wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
          
_D7wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _D7wp2
                move.w  a1,d7
                move.b  d7,(a4)
_D7wp2          move.w  #$10,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D8     ;RET C
                move.w  d0,ccr
                bcc     _D8nc
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_D8nc           addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_D9     ;EXX
                lea     reg_bc(a5),a0
                move.l  (a0),d7
                move.l  d2,(a0)+
                move.l  d7,d2
                move.l  (a0),d7
                move.l  d3,(a0)+
                move.l  d7,d3
                move.l  (a0),d7
                move.l  d4,(a0)
                move.l  d7,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_DA     ;JP C,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bcc     _DAnc
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_DAnc           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_DB     ;IN A,(N)
                move.b  d1,d7
                swap    d7
                move.b  (a1)+,d7

                btst.l  #5,d7
                bne     _DBno_kemp
                move.b  kempston(a5),d1                
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DBno_kemp
                cmp.b   #$fe,d7
                bne     _DBno_in1
                swap    d7
                move.b  d7,d6
                swap    d7
                move.b  #0,d1
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n11
                or.b    (a0),d1
n11             addq    #1,a0
                add.b   d6,d6
                bcs     n12
                or.b    (a0),d1
n12             addq    #1,a0
                add.b   d6,d6
                bcs     n13
                or.b    (a0),d1
n13             addq    #1,a0
                add.b   d6,d6
                bcs     n14
                or.b    (a0),d1
n14             addq    #1,a0
                add.b   d6,d6
                bcs     n15
                or.b    (a0),d1
n15             addq    #1,a0
                add.b   d6,d6
                bcs     n16
                or.b    (a0),d1
n16             addq    #1,a0
                add.b   d6,d6
                bcs     n17
                or.b    (a0),d1
n17             addq    #1,a0
                add.b   d6,d6
                bcs     n18
                or.b    (a0),d1
n18             and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _DBno_in2
                or.b    port(a5),d1
_DBno_in2       not.b   d1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DBno_in1       cmp.b   #$fb,d7
                bne     _DBno_in3
                move.w  #$ff,d1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DBno_in3       move.w  #0,d1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DC     ;CALL C,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bcc     _DCnc
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DCwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_DCwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DCwp2
                move.w  a1,d7
                move.b  d7,(a4)
_DCwp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_DCnc           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_DD     ;BEFORE IX
                move.w  #$300,d6
                move.b  (a1)+,d6
                add.w   d6,d6
                move.w  (a2,d6.w),d7
                jmp     (a3,d7.w)
_DE     ;SBC A,N
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  (a1)+,d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_DF     ;RST 18
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DFwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_DFwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DFwp2
                move.w  a1,d7
                move.b  d7,(a4)
_DFwp2          move.w  #$18,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_E0     ;RET PO
                move.w  d0,ccr
                bvs     _E0pe
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_E0pe           addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_E1     ;POP HL
                move.b  (a4),d4
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d4
                move.b  (a4),d4
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                swap    d4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_E2     ;JP PO,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bvs     _E2pe
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_E2pe           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_E3     ;EX (SP),HL
                move.l  d4,d7
                move.b  (a4),d4
;                move.w  a4,d6           ;ROM write protect
;                cmp.w   #$4000,d6       ;ROM write protect
;                bcs     _E3wp1          ;ROM write protect
                move.b  d7,(a4)
          
_E3wp1          move.l  a4,d6
                                addq.w  #1,d6
                                move.l  d6,a4

                swap    d4
                swap    d7
                move.b  (a4),d4
;                cmp.w   #$4000,d6       ;ROM write protect
;                bcs     _E3wp2          ;ROM write protect
                move.b  d7,(a4)
_E3wp2          swap    d4

                                move.l  a4,d7
                                subq.w  #1,d7
                move.l  d7,a4

                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_E4     ;CALL PO,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bvs     _E4pe
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E4wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_E4wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E4wp2
                move.w  a1,d7
                move.b  d7,(a4)
_E4wp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_E4pe           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_E5     ;PUSH HL
                swap    d4
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E5wp1
                move.b  d4,(a4)
_E5wp1          swap    d4
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E5wp2
                move.b  d4,(a4)
_E5wp2          add.w   #11,d5
                bcc     kernel
                bra     interrupt
_E6     ;AND N
                move.b  (a1)+,d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_E7     ;RST 20
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E7wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
          

_E7wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _E7wp2
                move.w  a1,d7
                move.b  d7,(a4)
_E7wp2          move.w  #$20,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_E8     ;RET PE
                move.w  d0,ccr
                bvc     _E8po
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_E8po           addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_E9     ;JP (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a1
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_EA     ;JP PE,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bvc     _EApo
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_EApo           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_EB     ;EX DE,HL
                move.l  d3,d7
                move.l  d4,d3
                move.l  d7,d4
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_EC     ;CALL PE,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bvc     _ECpo
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _ECwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_ECwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _ECwp2
                move.w  a1,d7
                move.b  d7,(a4)
_ECwp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_ECpo           add.w   #10,d5
                bcc     kernel
                bra     interrupt
_ED     ;PREFIX
                move.w  #$200,d6
                move.b  (a1)+,d6
                add.w   d6,d6
                move.w  (a2,d6.w),d7
                jmp     (a3,d7.w)
_EE     ;XOR N
                move.b  (a1)+,d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%00110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_EF     ;RST 28
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _EFwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_EFwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _EFwp2
                move.w  a1,d7
                move.b  d7,(a4)
_EFwp2          move.w  #$28,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_F0     ;RET P
                move.w  d0,ccr
                bmi     _F0m
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_F0m            addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_F1     ;POP AF
                lea     pop_af(a5),a0
                move.b  (a4),d0
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.b  (a0,d0),d0
                move.b  (a4),d1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_F2     ;JP P,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bmi     _F2m
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_F2m            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_F3     ;DI
                move.b  #0,IFF(a5)
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_F4     ;CALL P,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bmi     _F4m
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _F4wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_F4wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _F4wp2
                move.w  a1,d7
                move.b  d7,(a4)
_F4wp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_F4m            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_F5     ;PUSH AF
                lea     push_af(a5),a0
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _F5wp1
                move.b  d1,(a4)
_F5wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _F5wp2
                move.b  (a0,d0),d6
                move.b  d6,(a4)
_F5wp2          add.w   #11,d5
                bcc     kernel
                bra     interrupt
_F6     ;OR N
                move.b  (a1)+,d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%00110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_F7     ;RST 30
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

;                cmp.w   #$4000,d7
;                bcs     _F7wp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
          
_F7wp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _F7wp2
                move.w  a1,d7
                move.b  d7,(a4)
_F7wp2          move.w  #$30,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_F8     ;RET M
                move.w  d0,ccr
                bpl     _F8p
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_F8p            addq.w  #5,d5
                bcc     kernel
                bra     interrupt
_F9     ;LD SP,HL
                move.b  d4,d7
                swap    d4
                move.b  d4,-(a7)
                swap    d4
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                move.w  d6,d7
                move.l  d7,a4
                addq.w  #6,d5
                bcc     kernel
                bra     interrupt
_FA     ;JP M,NN
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bpl     _FAp
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a1
_FAp            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_FB     ;EI
                move.b  #1,IFF(a5)
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_FC     ;CALL M,NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,d6
                move.w  d0,ccr
                bpl     _FCp
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _FCwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_FCwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

;                move.l  a1,d7
;                move.w  a4,d7
;                move.l  d7,a4


;                cmp.w   #$4000,d7
;                bcs     _FCwp2
                move.w  a1,d7
                move.b  d7,(a4)
_FCwp2          move.l  d6,a1
                add.w   #17,d5
                bcc     kernel
                bra     interrupt
_FCp            add.w   #10,d5
                bcc     kernel
                bra     interrupt
_FD     ;BEFORE IY
                move.w  #$400,d6
                move.b  (a1)+,d6
                add.w   d6,d6
                move.w  (a2,d6.w),d7
                jmp     (a3,d7.w)
_FE     ;CP N
                move.b  (a1)+,d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #7,d5
                bcc     kernel
                bra     interrupt
_FF     ;RST 38
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _FFwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)

_FFwp1          move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

;                cmp.w   #$4000,d7
;                bcs     _FFwp2
                move.w  a1,d7
                move.b  d7,(a4)
_FFwp2          move.w  #$38,d7
                move.l  d7,a1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_CB00   ;RLC B
                swap    d2
                rol.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB01   ;RLC C
                rol.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB02   ;RLC D
                swap    d3
                rol.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB03   ;RLC E
                rol.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB04   ;RLC H
                swap    d4
                rol.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB05   ;RLC L
                rol.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB06   ;RLC (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB06wp
                rol.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB06wp         rol.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB07   ;RLC A
                rol.b   #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB08   ;RRC B
                swap    d2
                ror.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB09   ;RRC C
                ror.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB0A   ;RRC D
                swap    d3
                ror.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB0B   ;RRC E
                ror.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB0C   ;RRC H
                swap    d4
                ror.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB0D   ;RRC L
                ror.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB0E   ;RRC (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB0Ewp
                ror.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB0Ewp         ror.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB0F   ;RRC A
                ror.b   #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB10   ;RL B
                swap    d2
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB11   ;RL C
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB12   ;RL D
                swap    d3
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB13   ;RL E
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB14   ;RL H
                swap    d4
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB15   ;RL L
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB16   ;RL (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB16wp
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB16wp         move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB17   ;RL A
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB18   ;RR B
                swap    d2
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB19   ;RR C
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB1A   ;RR D
                swap    d3
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB1B   ;RR E
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB1C   ;RR H
                swap    d4
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB1D   ;RR L
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB1E   ;RR (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB1Ewp
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB1Ewp         move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB1F   ;RR A
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB20   ;SLA B
                swap    d2
                asl.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB21   ;SLA C
                asl.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB22   ;SLA D
                swap    d3
                asl.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB23   ;SLA E
                asl.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB24   ;SLA H
                swap    d4
                asl.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB25   ;SLA L
                asl.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB26   ;SLA (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB26wp
                asl.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB26wp         asl.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB27   ;SLA A
                asl.b   #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB28   ;SRA B
                swap    d2
                asr.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB29   ;SRA C
                asr.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB2A   ;SRA D
                swap    d3
                asr.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB2B   ;SRA E
                asr.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB2C   ;SRA H
                swap    d4
                asr.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB2D   ;SRA L
                asr.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB2E   ;SRA (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB2Ewp
                asr.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB2Ewp         asr.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB2F   ;SRA A
                asr.b   #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB30   ;SLI B
                swap    d2
                lsl.b   #1,d2
                move.w  sr,d7
                or.b    #1,d2
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB31   ;SLI C
                lsl.b   #1,d2
                move.w  sr,d7
                or.b    #1,d2
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB32   ;SLI D
                swap    d3
                lsl.b   #1,d3
                move.w  sr,d7
                or.b    #1,d3
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB33   ;SLI E
                lsl.b   #1,d3
                move.w  sr,d7
                or.b    #1,d3
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB34   ;SLI H
                swap    d4
                lsl.b   #1,d4
                move.w  sr,d7
                or.b    #1,d4
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB35   ;SLI L
                lsl.b   #1,d4
                move.w  sr,d7
                or.b    #1,d4
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB36   ;SLI (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB36wp
                lsl.b   #1,d6
                move.w  sr,d7
                or.b    #1,d6
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB36wp         lsl.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB37   ;SLI A
                lsl.b   #1,d1
                move.w  sr,d7
                or.b    #1,d1
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB38   ;SRL B
                swap    d2
                lsr.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB39   ;SRL C
                lsr.b   #1,d2
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d2,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB3A   ;SRL D
                swap    d3
                lsr.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB3B   ;SRL E
                lsr.b   #1,d3
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d3,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB3C   ;SRL H
                swap    d4
                lsr.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB3D   ;SRL L
                lsr.b   #1,d4
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d4,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB3E   ;SRL (HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB3Ewp
                lsr.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB3Ewp         lsr.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB3F   ;SRL A
                lsr.b   #1,d1
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB40   ;BIT 0,B
                swap    d2
                btst.l  #0,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB41   ;BIT 0,C
                btst.l  #0,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB42   ;BIT 0,D
                swap    d3
                btst.l  #0,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB43   ;BIT 0,E
                btst.l  #0,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB44   ;BIT 0,H
                swap    d4
                btst.l  #0,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB45   ;BIT 0,L
                btst.l  #0,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB46   ;BIT 0,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #0,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB47   ;BIT 0,A
                btst.l  #0,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB48   ;BIT 1,B
                swap    d2
                btst.l  #1,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB49   ;BIT 1,C
                btst.l  #1,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB4A   ;BIT 1,D
                swap    d3
                btst.l  #1,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB4B   ;BIT 1,E
                btst.l  #1,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB4C   ;BIT 1,H
                swap    d4
                btst.l  #1,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB4D   ;BIT 1,L
                btst.l  #1,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB4E   ;BIT 1,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #1,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB4F   ;BIT 1,A
                btst.l  #1,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB50   ;BIT 2,B
                swap    d2
                btst.l  #2,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB51   ;BIT 2,C
                btst.l  #2,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB52   ;BIT 2,D
                swap    d3
                btst.l  #2,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB53   ;BIT 2,E
                btst.l  #2,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB54   ;BIT 2,H
                swap    d4
                btst.l  #2,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB55   ;BIT 2,L
                btst.l  #2,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB56   ;BIT 2,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #2,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB57   ;BIT 2,A
                btst.l  #2,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB58   ;BIT 3,B
                swap    d2
                btst.l  #3,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB59   ;BIT 3,C
                btst.l  #3,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB5A   ;BIT 3,D
                swap    d3
                btst.l  #3,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB5B   ;BIT 3,E
                btst.l  #3,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB5C   ;BIT 3,H
                swap    d4
                btst.l  #3,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB5D   ;BIT 3,L
                btst.l  #3,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB5E   ;BIT 3,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #3,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB5F   ;BIT 3,A
                btst.l  #3,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB60   ;BIT 4,B
                swap    d2
                btst.l  #4,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB61   ;BIT 4,C
                btst.l  #4,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB62   ;BIT 4,D
                swap    d3
                btst.l  #4,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB63   ;BIT 4,E
                btst.l  #4,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB64   ;BIT 4,H
                swap    d4
                btst.l  #4,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB65   ;BIT 4,L
                btst.l  #4,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB66   ;BIT 4,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #4,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB67   ;BIT 4,A
                btst.l  #4,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB68   ;BIT 5,B
                swap    d2
                btst.l  #5,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB69   ;BIT 5,C
                btst.l  #5,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB6A   ;BIT 5,D
                swap    d3
                btst.l  #5,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB6B   ;BIT 5,E
                btst.l  #5,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB6C   ;BIT 5,H
                swap    d4
                btst.l  #5,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB6D   ;BIT 5,L
                btst.l  #5,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB6E   ;BIT 5,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #5,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB6F   ;BIT 5,A
                btst.l  #5,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB70   ;BIT 6,B
                swap    d2
                btst.l  #6,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB71   ;BIT 6,C
                btst.l  #6,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB72   ;BIT 6,D
                swap    d3
                btst.l  #6,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB73   ;BIT 6,E
                btst.l  #6,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB74   ;BIT 6,H
                swap    d4
                btst.l  #6,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB75   ;BIT 6,L
                btst.l  #6,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB76   ;BIT 6,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #6,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB77   ;BIT 6,A
                btst.l  #6,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB78   ;BIT 7,B
                swap    d2
                btst.l  #7,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB79   ;BIT 7,C
                btst.l  #7,d2
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB7A   ;BIT 7,D
                swap    d3
                btst.l  #7,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB7B   ;BIT 7,E
                btst.l  #7,d3
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB7C   ;BIT 7,H
                swap    d4
                btst.l  #7,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB7D   ;BIT 7,L
                btst.l  #7,d4
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB7E   ;BIT 7,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
                btst.b  #7,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_CB7F   ;BIT 7,A
                btst.l  #7,d1
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10111011,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB80   ;RES 0,B
                swap    d2
                bclr    #0,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB81   ;RES 0,C
                bclr    #0,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB82   ;RES 0,D
                swap    d3
                bclr    #0,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB83   ;RES 0,E
                bclr    #0,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB84   ;RES 0,H
                swap    d4
                bclr    #0,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB85   ;RES 0,L
                bclr    #0,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB86   ;RES 0,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CB86wp
                bclr.b  #0,(a0)
_CB86wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB87   ;RES 0,A
                bclr    #0,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB88   ;RES 1,B
                swap    d2
                bclr    #1,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB89   ;RES 1,C
                bclr    #1,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB8A   ;RES 1,D
                swap    d3
                bclr    #1,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB8B   ;RES 1,E
                bclr    #1,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB8C   ;RES 1,H
                swap    d4
                bclr    #1,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB8D   ;RES 1,L
                bclr    #1,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB8E   ;RES 1,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CB8Ewp
                bclr.b  #1,(a0)
_CB8Ewp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB8F   ;RES 1,A
                bclr    #1,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB90   ;RES 2,B
                swap    d2
                bclr    #2,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB91   ;RES 2,C
                bclr    #2,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB92   ;RES 2,D
                swap    d3
                bclr    #2,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB93   ;RES 2,E
                bclr    #2,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB94   ;RES 2,H
                swap    d4
                bclr    #2,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB95   ;RES 2,L
                bclr    #2,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB96   ;RES 2,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CB96wp
                bclr.b  #2,(a0)
_CB96wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB97   ;RES 2,A
                bclr    #2,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB98   ;RES 3,B
                swap    d2
                bclr    #3,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB99   ;RES 3,C
                bclr    #3,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB9A   ;RES 3,D
                swap    d3
                bclr    #3,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB9B   ;RES 3,E
                bclr    #3,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB9C   ;RES 3,H
                swap    d4
                bclr    #3,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB9D   ;RES 3,L
                bclr    #3,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CB9E   ;RES 3,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CB9Ewp
                bclr.b  #3,(a0)
_CB9Ewp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CB9F   ;RES 3,A
                bclr    #3,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA0   ;RES 4,B
                swap    d2
                bclr    #4,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA1   ;RES 4,C
                bclr    #4,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA2   ;RES 4,D
                swap    d3
                bclr    #4,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA3   ;RES 4,E
                bclr    #4,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA4   ;RES 4,H
                swap    d4
                bclr    #4,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA5   ;RES 4,L
                bclr    #4,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA6   ;RES 4,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBA6wp
                bclr.b  #4,(a0)
_CBA6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBA7   ;RES 4,A
                bclr    #4,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA8   ;RES 5,B
                swap    d2
                bclr    #5,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBA9   ;RES 5,C
                bclr    #5,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBAA   ;RES 5,D
                swap    d3
                bclr    #5,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBAB   ;RES 5,E
                bclr    #5,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBAC   ;RES 5,H
                swap    d4
                bclr    #5,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBAD   ;RES 5,L
                bclr    #5,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBAE   ;RES 5,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBAEwp
                bclr.b  #5,(a0)
_CBAEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBAF   ;RES 5,A
                bclr    #5,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB0   ;RES 6,B
                swap    d2
                bclr    #6,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB1   ;RES 6,C
                bclr    #6,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB2   ;RES 6,D
                swap    d3
                bclr    #6,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB3   ;RES 6,E
                bclr    #6,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB4   ;RES 6,H
                swap    d4
                bclr    #6,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB5   ;RES 6,L
                bclr    #6,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB6   ;RES 6,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBB6wp
                bclr.b  #6,(a0)
_CBB6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBB7   ;RES 6,A
                bclr    #6,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB8   ;RES 7,B
                swap    d2
                bclr    #7,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBB9   ;RES 7,C
                bclr    #7,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBBA   ;RES 7,D
                swap    d3
                bclr    #7,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBBB   ;RES 7,E
                bclr    #7,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBBC   ;RES 7,H
                swap    d4
                bclr    #7,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBBD   ;RES 7,L
                bclr    #7,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBBE   ;RES 7,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBBEwp
                bclr.b  #7,(a0)
_CBBEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBBF   ;RES 7,A
                bclr    #7,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC0   ;SET 0,B
                swap    d2
                bset    #0,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC1   ;SET 0,C
                bset    #0,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC2   ;SET 0,D
                swap    d3
                bset    #0,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC3   ;SET 0,E
                bset    #0,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC4   ;SET 0,H
                swap    d4
                bset    #0,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC5   ;SET 0,L
                bset    #0,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC6   ;SET 0,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBC6wp
                bset.b  #0,(a0)
_CBC6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBC7   ;SET 0,A
                bset    #0,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC8   ;SET 1,B
                swap    d2
                bset    #1,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBC9   ;SET 1,C
                bset    #1,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBCA   ;SET 1,D
                swap    d3
                bset    #1,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBCB   ;SET 1,E
                bset    #1,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBCC   ;SET 1,H
                swap    d4
                bset    #1,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBCD   ;SET 1,L
                bset    #1,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBCE   ;SET 1,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBCEwp
                bset.b  #1,(a0)
_CBCEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBCF   ;SET 1,A
                bset    #1,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD0   ;SET 2,B
                swap    d2
                bset    #2,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD1   ;SET 2,C
                bset    #2,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD2   ;SET 2,D
                swap    d3
                bset    #2,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD3   ;SET 2,E
                bset    #2,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD4   ;SET 2,H
                swap    d4
                bset    #2,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD5   ;SET 2,L
                bset    #2,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD6   ;SET 2,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBD6wp
                bset.b  #2,(a0)
_CBD6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBD7   ;SET 2,A
                bset    #2,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD8   ;SET 3,B
                swap    d2
                bset    #3,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBD9   ;SET 3,C
                bset    #3,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBDA   ;SET 3,D
                swap    d3
                bset    #3,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBDB   ;SET 3,E
                bset    #3,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBDC   ;SET 3,H
                swap    d4
                bset    #3,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBDD   ;SET 3,L
                bset    #3,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBDE   ;SET 3,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBDEwp
                bset.b  #3,(a0)
_CBDEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBDF   ;SET 3,A
                bset    #3,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE0   ;SET 4,B
                swap    d2
                bset    #4,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE1   ;SET 4,C
                bset    #4,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE2   ;SET 4,D
                swap    d3
                bset    #4,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE3   ;SET 4,E
                bset    #4,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE4   ;SET 4,H
                swap    d4
                bset    #4,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE5   ;SET 4,L
                bset    #4,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE6   ;SET 4,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBE6wp
                bset.b  #4,(a0)
_CBE6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBE7   ;SET 4,A
                bset    #4,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE8   ;SET 5,B
                swap    d2
                bset    #5,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBE9   ;SET 5,C
                bset    #5,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBEA   ;SET 5,D
                swap    d3
                bset    #5,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBEB   ;SET 5,E
                bset    #5,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBEC   ;SET 5,H
                swap    d4
                bset    #5,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBED   ;SET 5,L
                bset    #5,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBEE   ;SET 5,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBEEwp
                bset.b  #5,(a0)
_CBEEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBEF   ;SET 5,A
                bset    #5,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF0   ;SET 6,B
                swap    d2
                bset    #6,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF1   ;SET 6,C
                bset    #6,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF2   ;SET 6,D
                swap    d3
                bset    #6,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF3   ;SET 6,E
                bset    #6,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF4   ;SET 6,H
                swap    d4
                bset    #6,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF5   ;SET 6,L
                bset    #6,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF6   ;SET 6,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBF6wp
                bset.b  #6,(a0)
_CBF6wp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBF7   ;SET 6,A
                bset    #6,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF8   ;SET 7,B
                swap    d2
                bset    #7,d2
                swap    d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBF9   ;SET 7,C
                bset    #7,d2
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBFA   ;SET 7,D
                swap    d3
                bset    #7,d3
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBFB   ;SET 7,E
                bset    #7,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBFC   ;SET 7,H
                swap    d4
                bset    #7,d4
                swap    d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBFD   ;SET 7,L
                bset    #7,d4
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_CBFE   ;SET 7,(HL)
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _CBFEwp
                bset.b  #7,(a0)
_CBFEwp         add.w   #15,d5
                bcc     kernel
                bra     interrupt
_CBFF   ;SET 7,A
                bset    #7,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED00   ;NOP
_ED01   ;NOP
_ED02   ;NOP
_ED03   ;NOP
_ED04   ;NOP
_ED05   ;NOP
_ED06   ;NOP
_ED07   ;NOP
_ED08   ;NOP
_ED09   ;NOP
_ED0A   ;NOP
_ED0B   ;NOP
_ED0C   ;NOP
_ED0D   ;NOP
_ED0E   ;NOP
_ED0F   ;NOP
_ED10   ;NOP
_ED11   ;NOP
_ED12   ;NOP
_ED13   ;NOP
_ED14   ;NOP
_ED15   ;NOP
_ED16   ;NOP
_ED17   ;NOP
_ED18   ;NOP
_ED19   ;NOP
_ED1A   ;NOP
_ED1B   ;NOP
_ED1C   ;NOP
_ED1D   ;NOP
_ED1E   ;NOP
_ED1F   ;NOP
_ED20   ;NOP
_ED21   ;NOP
_ED22   ;NOP
_ED23   ;NOP
_ED24   ;NOP
_ED25   ;NOP
_ED26   ;NOP
_ED27   ;NOP
_ED28   ;NOP
_ED29   ;NOP
_ED2A   ;NOP
_ED2B   ;NOP
_ED2C   ;NOP
_ED2D   ;NOP
_ED2E   ;NOP
_ED2F   ;NOP
_ED30   ;NOP
_ED31   ;NOP
_ED32   ;NOP
_ED33   ;NOP
_ED34   ;NOP
_ED35   ;NOP
_ED36   ;NOP
_ED37   ;NOP
_ED38   ;NOP
_ED39   ;NOP
_ED3A   ;NOP
_ED3B   ;NOP
_ED3C   ;NOP
_ED3D   ;NOP
_ED3E   ;NOP
_ED3F   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED40   ;IN B,(C)
                btst.l  #5,d2
                bne     _ED40no_kemp
                swap    d2
                move.b  kempston(a5),d2
                swap    d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED40no_kemp
                cmp.b   #$fe,d2
                bne     _ED40no_in1
                swap    d2
                move.b  d2,d6
                move.b  #0,d2
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n31
                or.b    (a0),d2
n31             addq    #1,a0
                add.b   d6,d6
                bcs     n32
                or.b    (a0),d2
n32             addq    #1,a0
                add.b   d6,d6
                bcs     n33
                or.b    (a0),d2
n33             addq    #1,a0
                add.b   d6,d6
                bcs     n34
                or.b    (a0),d2
n34             addq    #1,a0
                add.b   d6,d6
                bcs     n35
                or.b    (a0),d2
n35             addq    #1,a0
                add.b   d6,d6
                bcs     n36
                or.b    (a0),d2
n36             addq    #1,a0
                add.b   d6,d6
                bcs     n37
                or.b    (a0),d2
n37             addq    #1,a0
                add.b   d6,d6
                bcs     n38
                or.b    (a0),d2
n38             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED40no_in2
                or.b    port(a5),d2
_ED40no_in2     not.b   d2
                swap    d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED40no_in1     swap    d2
                move.w  #0,d2
                swap    d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED41   ;OUT (C),B

;                trap    #8

                btst.l  #0,d2
                bne     _ED41no_fe

                swap    d2
                tst.b   sound_flag(a5)
                beq     _ED41_sound
                btst    #4,d2
                beq     _ED41_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED41_sound
_ED41_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED41_sound
                move.b  d2,d6
                swap    d2
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED41no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED42   ;SBC HL,BC
                swap    d2
                ext.w   d2
                swap    d2
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d2
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                subx.l  d2,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d2     ;строка для корректной работы игры Movie
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED43   ;LD (NN),BC     ;@
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _ED43wp1
                move.b  d2,(a0)
_ED43wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _ED43wp2
                swap    d2
                move.b  d2,(a0)
                swap    d2
_ED43wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED44   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED45   ;RETN
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED46   ;IM 0
                move.b  #0,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED47   ;LD I,A
                move.b  d1,I(a5)
                add.w   #9,d5
                bcc     kernel
                bra     interrupt
_ED48   ;IN C,(C)
                btst.l  #5,d2
                bne     _ED48no_kemp
                move.b  kempston(a5),d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED48no_kemp
                cmp.b   #$fe,d2
                bne     _ED48no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                move.b  #0,d2
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n41
                or.b    (a0),d2
n41             addq    #1,a0
                add.b   d6,d6
                bcs     n42
                or.b    (a0),d2
n42             addq    #1,a0
                add.b   d6,d6
                bcs     n43
                or.b    (a0),d2
n43             addq    #1,a0
                add.b   d6,d6
                bcs     n44
                or.b    (a0),d2
n44             addq    #1,a0
                add.b   d6,d6
                bcs     n45
                or.b    (a0),d2
n45             addq    #1,a0
                add.b   d6,d6
                bcs     n46
                or.b    (a0),d2
n46             addq    #1,a0
                add.b   d6,d6
                bcs     n47
                or.b    (a0),d2
n47             addq    #1,a0
                add.b   d6,d6
                bcs     n48
                or.b    (a0),d2
n48             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED48no_in2
                or.b    port(a5),d2
_ED48no_in2     not.b   d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED48no_in1     move.w  #0,d2
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED49   ;OUT (C),C

;                trap    #8

                btst.l  #0,d2
                bne     _ED49no_fe

                tst.b   sound_flag(a5)
                beq     _ED49_sound
                btst    #4,d2
                beq     _ED49_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED49_sound
_ED49_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED49_sound
                move.b  d2,d6
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED49no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED4A   ;ADC HL,BC
                swap    d2
                ext.w   d2
                swap    d2
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d2
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                addx.l  d2,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED4B   ;LD BC,(NN)
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d2
                swap    d2
                move.b  (a0),d2
                swap    d2
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED4C   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED4D   ;RETI
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
;                move.b  #1,IFF(a5)
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED4E   ;IM 0/1
                move.b  #1,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED4F   ;LD R,A
;                trap    #8
                move.b  d1,R(a5)
                add.w   #9,d5
                bcc     kernel
                bra     interrupt
_ED50   ;IN D,(C)
                btst.l  #5,d2
                bne     _ED50no_kemp
                swap    d3
                move.b  kempston(a5),d3
                swap    d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED50no_kemp
                cmp.b   #$fe,d2
                bne     _ED50no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                swap    d3
                move.b  #0,d3
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n51
                or.b    (a0),d3
n51             addq    #1,a0
                add.b   d6,d6
                bcs     n52
                or.b    (a0),d3
n52             addq    #1,a0
                add.b   d6,d6
                bcs     n53
                or.b    (a0),d3
n53             addq    #1,a0
                add.b   d6,d6
                bcs     n54
                or.b    (a0),d3
n54             addq    #1,a0
                add.b   d6,d6
                bcs     n55
                or.b    (a0),d3
n55             addq    #1,a0
                add.b   d6,d6
                bcs     n56
                or.b    (a0),d3
n56             addq    #1,a0
                add.b   d6,d6
                bcs     n57
                or.b    (a0),d3
n57             addq    #1,a0
                add.b   d6,d6
                bcs     n58
                or.b    (a0),d3
n58             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED50no_in2
                or.b    port(a5),d3
_ED50no_in2     not.b   d3
                swap    d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED50no_in1     swap    d3
                move.w  #0,d3
                swap    d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED51   ;OUT (C),D

;                trap    #8

                btst.l  #0,d2
                bne     _ED51no_fe

                swap    d3
                tst.b   sound_flag(a5)
                beq     _ED51_sound
                btst    #4,d3
                beq     _ED51_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED51_sound
_ED51_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED51_sound
                move.b  d3,d6
                swap    d3
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED51no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED52   ;SBC HL,DE
                swap    d3
                ext.w   d3
                swap    d3
                swap    d4
                ext.w   d4
                swap    d4

                ext.w   d3
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                subx.l  d3,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED53   ;LD (NN),DE @
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _ED53wp1
                move.b  d3,(a0)
_ED53wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _ED53wp2
                swap    d3
                move.b  d3,(a0)
                swap    d3
_ED53wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED54   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED55   ;RETN
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED56   ;IM 1
                move.b  #1,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED57   ;LD A,I
                move.b  I(a5),d1
                move.w  sr,d7
                and.b   #%00001100,d7
                and.b   #%00110001,d0
                or.b    d7,d0
                move.b  IFF(a5),d6
                beq     _ED57_iff0
                or.b    #%10,d0
_ED57_iff0      add.w   #9,d5
                bcc     kernel
                bra     interrupt
_ED58   ;IN E,(C)
                btst.l  #5,d2
                bne     _ED58no_kemp
                move.b  kempston(a5),d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED58no_kemp
                cmp.b   #$fe,d2
                bne     _ED58no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                move.b  #0,d3
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n61
                or.b    (a0),d3
n61             addq    #1,a0
                add.b   d6,d6
                bcs     n62
                or.b    (a0),d3
n62             addq    #1,a0
                add.b   d6,d6
                bcs     n63
                or.b    (a0),d3
n63             addq    #1,a0
                add.b   d6,d6
                bcs     n64
                or.b    (a0),d3
n64             addq    #1,a0
                add.b   d6,d6
                bcs     n65
                or.b    (a0),d3
n65             addq    #1,a0
                add.b   d6,d6
                bcs     n66
                or.b    (a0),d3
n66             addq    #1,a0
                add.b   d6,d6
                bcs     n67
                or.b    (a0),d3
n67             addq    #1,a0
                add.b   d6,d6
                bcs     n68
                or.b    (a0),d3
n68             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED58no_in2
                or.b    port(a5),d3
_ED58no_in2     not.b   d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED58no_in1     move.w  #0,d3
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED59   ;OUT (C),E

;                trap    #8

                btst.l  #0,d2
                bne     _ED59no_fe

                tst.b   sound_flag(a5)
                beq     _ED59_sound
                btst    #4,d3
                beq     _ED59_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED59_sound
_ED59_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED59_sound
                move.b  d3,d6
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED59no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED5A   ;ADC HL,DE
                swap    d3
                ext.w   d3
                swap    d3
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d3
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                addx.l  d3,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED5B   ;LD DE,(NN)
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d3
                swap    d3
                move.b  (a0),d3
                swap    d3
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED5C   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED5D   ;RETI
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),d7
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
;                move.b  #1,IFF(a5)
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED5E   ;IM 2
                move.b  #2,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED5F   ;LD A,R
;                trap    #8
                move.b  R(a5),d1
                and.b   #$80,d1
                move.b  d5,d7
                lsr.b   #1,d7
                or.b    d7,d1
                move.w  sr,d7
                move.b  d1,R(a5)

                and.b   #%00001100,d7
                and.b   #%00110001,d0
                or.b    d7,d0
                move.b  IFF(a5),d6
                beq     _ED5F_iff0
                or.b    #%10,d0
_ED5F_iff0      add.w   #9,d5
                bcc     kernel
                bra     interrupt
_ED60   ;IN H,(C)
                btst.l  #5,d2
                bne     _ED60no_kemp
                swap    d4
                move.b  kempston(a5),d4
                swap    d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED60no_kemp
                cmp.b   #$fe,d2
                bne     _ED60no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                swap    d4
                move.b  #0,d4
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n71
                or.b    (a0),d4
n71             addq    #1,a0
                add.b   d6,d6
                bcs     n72
                or.b    (a0),d4
n72             addq    #1,a0
                add.b   d6,d6
                bcs     n73
                or.b    (a0),d4
n73             addq    #1,a0
                add.b   d6,d6
                bcs     n74
                or.b    (a0),d4
n74             addq    #1,a0
                add.b   d6,d6
                bcs     n75
                or.b    (a0),d4
n75             addq    #1,a0
                add.b   d6,d6
                bcs     n76
                or.b    (a0),d4
n76             addq    #1,a0
                add.b   d6,d6
                bcs     n77
                or.b    (a0),d4
n77             addq    #1,a0
                add.b   d6,d6
                bcs     n78
                or.b    (a0),d4
n78             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED60no_in2
                or.b    port(a5),d4
_ED60no_in2     not.b   d4
                swap    d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED60no_in1     swap    d4
                move.w  #0,d4
                swap    d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED61   ;OUT (C),H

;                trap    #8

                btst.l  #0,d2
                bne     _ED61no_fe

                swap    d4
                tst.b   sound_flag(a5)
                beq     _ED61_sound
                btst    #4,d4
                beq     _ED61_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED61_sound
_ED61_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED61_sound
                move.b  d4,d6
                swap    d4
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED61no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED62   ;SBC HL,HL
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                subx.l  d4,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED63   ;LD (NN),HL @
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _ED63wp1
                move.b  d4,(a0)
_ED63wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _ED63wp2
                swap    d4
                move.b  d4,(a0)
                swap    d4
_ED63wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED64   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED65   ;RETN
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED66   ;IM 0
                move.b  #0,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED67   ;RRD    Здесь впервые более оптимальный перегон рег. пары
                move.l  a1,d7
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7
                swap    d4
                move.b  d4,d7
                move.l  d7,a0
                move.b  d1,-(a7)
                move.w  (a7)+,d7
                move.b  (a0),d7
                lsr.w   #1,d7
                roxr.b  #1,d6
                lsr.w   #1,d7
                roxr.b  #1,d6
                lsr.w   #1,d7
                roxr.b  #1,d6
                lsr.w   #1,d7
                roxr.b  #1,d6
                lsr.b   #4,d6
                and.b   #$f0,d1
                or.b    d6,d1
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _ED67wp
                move.b  d7,(a0)
_ED67wp         move.w  sr,d7
                and.b   #%00001100,d7
                and.b   #%00110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #18,d5
                bcc     kernel
                bra     interrupt

_ED68   ;IN L,(C)
                btst.l  #5,d2
                bne     _ED68no_kemp
                move.b  kempston(a5),d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED68no_kemp
                cmp.b   #$fe,d2
                bne     _ED68no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                move.b  #0,d4
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n81
                or.b    (a0),d4
n81             addq    #1,a0
                add.b   d6,d6
                bcs     n82
                or.b    (a0),d4
n82             addq    #1,a0
                add.b   d6,d6
                bcs     n83
                or.b    (a0),d4
n83             addq    #1,a0
                add.b   d6,d6
                bcs     n84
                or.b    (a0),d4
n84             addq    #1,a0
                add.b   d6,d6
                bcs     n85
                or.b    (a0),d4
n85             addq    #1,a0
                add.b   d6,d6
                bcs     n86
                or.b    (a0),d4
n86             addq    #1,a0
                add.b   d6,d6
                bcs     n87
                or.b    (a0),d4
n87             addq    #1,a0
                add.b   d6,d6
                bcs     n88
                or.b    (a0),d4
n88             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED68no_in2
                or.b    port(a5),d4
_ED68no_in2     not.b   d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED68no_in1     move.w  #0,d4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED69   ;OUT (C),L

;                trap    #8

                btst.l  #0,d2
                bne     _ED69no_fe

                tst.b   sound_flag(a5)
                beq     _ED69_sound
                btst    #4,d4
                beq     _ED69_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED69_sound
_ED69_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED69_sound
                move.b  d4,d6
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED69no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED6A   ;ADC HL,HL
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d4
                move.b  d0,d7
                lsr.b   #1,d7
                addx.l  d4,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED6B   ;LD HL,(NN)
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d4
                swap    d4
                move.b  (a0),d4
                swap    d4
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED6C   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED6D   ;RETI
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
;                move.b  #1,IFF(a5)
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED6E   ;IM 0/1
                move.b  #1,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED6F   ;RLD
                move.l  a1,d7
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7
                swap    d4
                move.b  d4,d7
                move.l  d7,a0
                move.b  (a0),d7
                swap    d7
                move.b  (a0),d7
                asl.b   #4,d7
                move.b  d1,d6
                and.b   #$0f,d6
                or.b    d6,d7
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _ED6Fwp
                move.b  d7,(a0)
_ED6Fwp         swap    d7
                lsr.b   #4,d7
                and.b   #$f0,d1
                or.b    d7,d1
                move.w  sr,d7
                and.b   #%00001100,d7
                and.b   #%00110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #18,d5
                bcc     kernel
                bra     interrupt
_ED70   ;IN (C)
;                move.l  #$ed70,d7
;                bra     no_instr
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED71   ;OUT (C),0
         
;                trap    #8

                btst.l  #0,d2
                bne     _ED71no_fe

                tst.b   sound_flag(a5)
                beq     _ED71_sound
                move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED71_sound
                move.b  #0,border_color(a5)
_ED71no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED72   ;SBC HL,SP
                move.w  a4,d7
                lsr.w   #8,d7
                ext.w   d7
                swap    d7
                move.w  a4,d7
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d7
                ext.w   d4
                move.b  d0,d6
                lsr.b   #1,d6
                subx.l  d7,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED73   ;LD (NN),SP
                move.l  a4,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
;                cmp.w   #$4000,d7
;                bcs     _ED73wp1
                move.w  a4,d6
                move.b  d6,(a0)
_ED73wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _ED73wp2
                lsr.w   #8,d6
                move.b  d6,(a0)
_ED73wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_ED74   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED75   ;RETN
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED76   ;IM 1
                move.b  #1,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED77   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt

_ED78   ;IN A,(C)
                btst.l  #5,d2
                bne     _ED78no_kemp
                move.b  kempston(a5),d1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED78no_kemp
                cmp.b   #$fe,d2
                bne     _ED78no_in1
                swap    d2
                move.b  d2,d6
                swap    d2
                move.b  #0,d1
                lea     keys_matrix(a5),a0
                add.b   d6,d6
                bcs     n21
                or.b    (a0),d1
n21             addq    #1,a0
                add.b   d6,d6
                bcs     n22
                or.b    (a0),d1
n22             addq    #1,a0
                add.b   d6,d6
                bcs     n23
                or.b    (a0),d1
n23             addq    #1,a0
                add.b   d6,d6
                bcs     n24
                or.b    (a0),d1
n24             addq    #1,a0
                add.b   d6,d6
                bcs     n25
                or.b    (a0),d1
n25             addq    #1,a0
                add.b   d6,d6
                bcs     n26
                or.b    (a0),d1
n26             addq    #1,a0
                add.b   d6,d6
                bcs     n27
                or.b    (a0),d1
n27             addq    #1,a0
                add.b   d6,d6
                bcs     n28
                or.b    (a0),d1
n28             move.l  d2,d7
                and.l   #$ff00ff,d7
                or.l    #$ef0000,d7
                cmp.l   #$ef00fe,d7
                bne     _ED78no_in2
                or.b    port(a5),d1
_ED78no_in2     not.b   d1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED78no_in1     move.w  #0,d1
                add.w   #12,d5
                bcc     kernel
                bra     interrupt

_ED79   ;OUT (C),A

;                trap    #8

                btst.l  #0,d2
                bne     _ED79no_fe

                tst.b   sound_flag(a5)
                beq     _ED79_sound
                btst    #4,d1
                beq     _ED79_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _ED79_sound
_ED79_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_ED79_sound
                move.b  d1,d6
                and.b   #%111,d6
                move.b  d6,border_color(a5)
_ED79no_fe      add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED7A   ;ADC HL,SP
                move.w  a4,d7
                lsr.w   #8,d7
                ext.w   d7
                swap    d7
                move.w  a4,d7
                swap    d4
                ext.w   d4
                swap    d4
                ext.w   d7
                ext.w   d4
                move.b  d0,d6
                lsr.b   #1,d6
                addx.l  d7,d4
                move.w  sr,d7
                and.b   #%00001011,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                and.l   #$ff00ff,d4     ;для определения флага Z
                move.w  sr,d7           ;для определения флага Z
                and.b   #%00000100,d7   ;для определения флага Z
                or.b    d7,d0           ;для определения флага Z
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_ED7B   ;LD SP,(NN)
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                move.b  d7,d6
                move.l  a4,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d6
                move.b  (a0),-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d6
                move.b  d6,d7
                move.l  d7,a4
                add.w   #12,d5
                bcc     kernel
                bra     interrupt
_ED7C   ;NEG
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d1,d6
                move.w  #0,d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED7D   ;RETI
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
;                move.b  #1,IFF(a5)
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_ED7E   ;IM 2
                move.b  #2,IM(a5)
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_ED7F   ;NOP
_ED80   ;NOP
_ED81   ;NOP
_ED82   ;NOP
_ED83   ;NOP
_ED84   ;NOP
_ED85   ;NOP
_ED86   ;NOP
_ED87   ;NOP
_ED88   ;NOP
_ED89   ;NOP
_ED8A   ;NOP
_ED8B   ;NOP
_ED8C   ;NOP
_ED8D   ;NOP
_ED8E   ;NOP
_ED8F   ;NOP
_ED90   ;NOP
_ED91   ;NOP
_ED92   ;NOP
_ED93   ;NOP
_ED94   ;NOP
_ED95   ;NOP
_ED96   ;NOP
_ED97   ;NOP
_ED98   ;NOP
_ED99   ;NOP
_ED9A   ;NOP
_ED9B   ;NOP
_ED9C   ;NOP
_ED9D   ;NOP
_ED9E   ;NOP
_ED9F   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_EDA0   ;LDI
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0

                move.b  (a0),d6
                swap    d6

                move.l  a4,d7
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d3
                move.b  d6,d7
                move.l  d7,a0

;                cmp.w   #$4000,d7
;                bcs     _EDA0wp

                swap    d6
                move.b  d6,(a0)

_EDA0wp         ext.w   d4
                addq.l  #1,d4

                ext.w   d3
                addq.l  #1,d3

                ext.w   d2
                subq.l  #1,d2

                and.b   #%00111101,d0
                and.l   #$ff00ff,d2
                sne.b   d7             ;4/6
                and.b   #%00000010,d7  ;8
                or.b    d7,d0          ;4
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDA1   ;CPI
                move.b  d4,d7
                swap    d4
                move.b  d4,-(a7)
                swap    d4
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%01001100,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                ext.w   d4
                addq.l  #1,d4
                ext.w   d2
                subq.l  #1,d2
                and.l   #$ff00ff,d2
                beq     _EDA1_nz
                bset    #1,d0
_EDA1_nz        add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDA2
                move.l  #$eda2,d7
                bra     no_instr
_EDA3   ;OUTI
                btst.l  #0,d2
                bne     _EDA3no_fe
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0

                tst.b   sound_flag(a5)
                beq     _EDA3_sound
                move.b  (a0),d7
                btst    #4,d7
                beq     _EDA3_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _EDA3_sound
_EDA3_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_EDA3_sound
                move.b  (a0),border_color(a5)
_EDA3no_fe      ext.w   d4
                addq.l  #1,d4
                swap    d2
                subq.b  #1,d2
                move.w  sr,d7
                swap    d2

                and.b   #%00000100,d7
                and.b   #%11111011,d0
                or.b    d7,d0
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDA4   ;NOP
_EDA5   ;NOP
_EDA6   ;NOP
_EDA7   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_EDA8   ;LDD

                move.b  d4,d7           ;H
                swap    d4
                move.b  d4,-(a7)           ;L
                swap    d4
                move.w  (a7)+,d6        ;lsl.w   #8,d7
                move.b  d7,d6           ;d7=HL
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0),d6

                swap    d6

                move.b  d3,d7
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0

;                cmp.w   #$4000,d7
;                bcs     _EDA8wp
                swap    d6
                move.b  d6,(a0)

_EDA8wp         ext.w   d4
                subq.l  #1,d4

                ext.w   d3
                subq.l  #1,d3

                ext.w   d2
                subq.l  #1,d2

                and.b   #%00111101,d0
                and.l   #$ff00ff,d2
                sne.b   d7             ;4/6
                and.b   #%00000010,d7  ;8
                or.b    d7,d0          ;4

                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDA9

                move.l  #$eda9,d7
                bra     no_instr
_EDAA

                move.l  #$edaa,d7
                bra     no_instr
_EDAB   ;OUTD

;                bra     kernel
;                trap    #8

                btst.l  #0,d2
                bne     _EDABno_fe
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0

                tst.b   sound_flag(a5)
                beq     _EDAB_sound
                move.b  (a0),d7
                btst    #4,d7
                beq     _EDAB_no_sound
                move.w  #$110,d7      
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                move.w  #$ffff,d7
                dc.l    $31c7f502
                bra     _EDAB_sound
_EDAB_no_sound  move.w  #$110,d7  
                dc.l    $31c7f500
                move.w  #$fd,d7
                dc.l    $11c7f504
                moveq.l #$0000,d7
                dc.l    $31c7f502
_EDAB_sound
                move.b  (a0),border_color(a5)
_EDABno_fe      ext.w   d4
                subq.l  #1,d4
                swap    d2
                subq.b  #1,d2
                move.w  sr,d7
                swap    d2
 
                and.b   #%00000100,d7
                and.b   #%11111011,d0
                or.b    d7,d0
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDAC   ;NOP
_EDAD   ;NOP
_EDAE   ;NOP
_EDAF   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_EDB0   ;LDIR
                move.l  a4,d7
                move.b  d4,d6
                swap    d4
                move.b  d4,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d4
                move.b  d6,d7
                move.l  d7,a0

                move.b  (a0),d6
                swap    d6

                move.l  a4,d7
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                swap    d3
                move.b  d6,d7
                move.l  d7,a0

;                cmp.w   #$4000,d7
;                bcs     _EDB0wp
                swap    d6
                move.b  d6,(a0)

_EDB0wp         ext.w   d4
                addq.l  #1,d4

                ext.w   d3
                addq.l  #1,d3

                ext.w   d2
                subq.l  #1,d2

                and.l   #$ff00ff,d2
                beq     _EDB0z

                and.b   #%00111101,d0
                subq.l  #2,a1
                add.w   #21,d5
                bcc     kernel
                bra     interrupt

_EDB0z          or.b    #%00000010,d7
                and.b   #%00111111,d0
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDB1   ;CPIR
                move.b  d4,d7
                swap    d4
                move.b  d4,-(a7)
                swap    d4
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                beq     _EDB1_z

                move.w  sr,d7
                and.b   #%01001100,d7
                and.b   #%11110001,d0
                or.b    d7,d0

                ext.w   d4
                addq.l  #1,d4
                ext.w   d2
                subq.l  #1,d2
                beq     _EDB1_nz
                bset    #1,d0
                subq.l  #2,a1

                add.w   #21,d5
                bcc     kernel
                bra     interrupt

_EDB1_z         move.w  sr,d7
                and.b   #%01001100,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                ext.w   d4
                addq.l  #1,d4
                ext.w   d2
                subq.l  #1,d2
                beq     _EDB1_nz
                bset    #1,d0
_EDB1_nz        add.w   #16,d5
                bcc     kernel
                bra     interrupt


_EDB2

                move.l  #$edb2,d7
                bra     no_instr
_EDB3

                move.l  #$fdff,d7
                bra     no_instr
_EDB4   ;NOP
_EDB5   ;NOP
_EDB6   ;NOP
_EDB7   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_EDB8   ;LDDR
                move.b  d4,d7           ;H
                swap    d4
                move.b  d4,-(a7)
                swap    d4
                move.w  (a7)+,d6        ;lsl.w   #8,d7
                move.b  d7,d6           ;d7=HL
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0),d6

                swap    d6

                move.b  d3,d7
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0

;                cmp.w   #$4000,d7
;                bcs     _EDB8wp
                swap    d6
                move.b  d6,(a0)

_EDB8wp         ext.w   d4
                subq.l  #1,d4

                ext.w   d3
                subq.l  #1,d3

                ext.w   d2
                subq.l  #1,d2

                swap    d2
                move.b  d2,d6
                swap    d2

                or.b    d2,d6
                beq     _EDB8z
                and.b   #%00111101,d0
                subq.l  #2,a1
                add.w   #21,d5
                bcc     kernel
                bra     interrupt

_EDB8z          or.b    #%00000010,d7
                and.b   #%00111111,d0
                add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDB9	;CPDR
                move.b  d4,d7
                swap    d4
                move.b  d4,-(a7)
                swap    d4
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                beq     _EDB9_z

                move.w  sr,d7
                and.b   #%01001100,d7
                and.b   #%11110001,d0
                or.b    d7,d0

                ext.w   d4
                subq.l  #1,d4
                ext.w   d2
                subq.l  #1,d2
                beq     _EDB9_nz
                bset    #1,d0
                subq.l  #2,a1

                add.w   #21,d5
                bcc     kernel
                bra     interrupt

_EDB9_z         move.w  sr,d7
                and.b   #%01001100,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                ext.w   d4
                subq.l  #1,d4
                ext.w   d2
                subq.l  #1,d2
                beq     _EDB9_nz
                bset    #1,d0
_EDB9_nz        add.w   #16,d5
                bcc     kernel
                bra     interrupt
_EDBA

                move.l  #$edba,d7
                bra     no_instr
_EDBB

                move.l  #$edbb,d7
                bra     no_instr
_EDBC   ;NOP
_EDBD   ;NOP
_EDBE   ;NOP
_EDBF   ;NOP
_EDC0   ;NOP
_EDC1   ;NOP
_EDC2   ;NOP
_EDC3   ;NOP
_EDC4   ;NOP
_EDC5   ;NOP
_EDC6   ;NOP
_EDC7   ;NOP
_EDC8   ;NOP
_EDC9   ;NOP
_EDCA   ;NOP
_EDCB   ;NOP
_EDCC   ;NOP
_EDCD   ;NOP
_EDCE   ;NOP
_EDCF   ;NOP
_EDD0   ;NOP
_EDD1   ;NOP
_EDD2   ;NOP
_EDD3   ;NOP
_EDD4   ;NOP
_EDD5   ;NOP
_EDD6   ;NOP
_EDD7   ;NOP
_EDD8   ;NOP
_EDD9   ;NOP
_EDDA   ;NOP
_EDDB   ;NOP
_EDDC   ;NOP
_EDDD   ;NOP
_EDDE   ;NOP
_EDDF   ;NOP
_EDE0   ;NOP
_EDE1   ;NOP
_EDE2   ;NOP
_EDE3   ;NOP
_EDE4   ;NOP
_EDE5   ;NOP
_EDE6   ;NOP
_EDE7   ;NOP
_EDE8   ;NOP
_EDE9   ;NOP
_EDEA   ;NOP
_EDEB   ;NOP
_EDEC   ;NOP
_EDED   ;NOP
_EDEE   ;NOP
_EDEF   ;NOP
_EDF0   ;NOP
_EDF1   ;NOP
_EDF2   ;NOP
_EDF3   ;NOP
_EDF4   ;NOP
_EDF5   ;NOP
_EDF6   ;NOP
_EDF7   ;NOP
_EDF8   ;NOP
_EDF9   ;NOP
_EDFA   ;NOP
_EDFB   ;NOP
_EDFC   ;NOP
_EDFD   ;NOP
_EDFE   ;NOP
_EDFF   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD00
                move.l  #$dd00,d7
                bra     no_instr
_DD01
                move.l  #$dd01,d7
                bra     no_instr
_DD02
                move.l  #$dd02,d7
                bra     no_instr
_DD03
                move.l  #$dd03,d7
                bra     no_instr
_DD04
                move.l  #$dd04,d7
                bra     no_instr
_DD05
                move.l  #$dd05,d7
                bra     no_instr
_DD06
                move.l  #$dd06,d7
                bra     no_instr
_DD07
                move.l  #$dd07,d7
                bra     no_instr
_DD08

                move.l  #$dd08,d7
                bra     no_instr
_DD09   ;ADD IX,BC
                move.b  d2,d6
                swap    d2
                move.b  d2,-(a7)
                swap    d2
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                move.b  d6,d7
                swap    d0
                add.w   d7,d0
                move.w  sr,d7
                swap    d0
                and.b   #%00000001,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DD0A

                move.l  #$dd0a,d7
                bra     no_instr
_DD0B

                move.l  #$dd0b,d7
                bra     no_instr
_DD0C

                move.l  #$dd0c,d7
                bra     no_instr
_DD0D

                move.l  #$dd0d,d7
                bra     no_instr
_DD0E

                move.l  #$dd0e,d7
                bra     no_instr
_DD0F

                move.l  #$dd0f,d7
                bra     no_instr

_DD10

                move.l  #$dd10,d7
                bra     no_instr
_DD11

                move.l  #$dd11,d7
                bra     no_instr
_DD12

                move.l  #$dd12,d7
                bra     no_instr
_DD13

                move.l  #$dd13,d7
                bra     no_instr
_DD14

                move.l  #$dd14,d7
                bra     no_instr
_DD15

                move.l  #$dd15,d7
                bra     no_instr
_DD16

                move.l  #$dd16,d7
                bra     no_instr
_DD17

                move.l  #$dd17,d7
                bra     no_instr
_DD18

                move.l  #$dd18,d7
                bra     no_instr
_DD19   ;ADD IX,DE
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                move.b  d6,d7
                swap    d0
                add.w   d7,d0
                move.w  sr,d7
                swap    d0
                and.b   #%00000001,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DD1A

                move.l  #$dd1a,d7
                bra     no_instr
_DD1B

                move.l  #$dd1b,d7
                bra     no_instr
_DD1C

                move.l  #$dd1c,d7
                bra     no_instr
_DD1D

                move.l  #$dd1d,d7
                bra     no_instr
_DD1E

                move.l  #$dd1e,d7
                bra     no_instr
_DD1F

                move.l  #$dd1f,d7
                bra     no_instr

_DD20

                move.l  #$dd20,d7
                bra     no_instr
_DD21   ;LD IX,NN
                swap    d0
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d0        ;lsl.w   #8,d6
                move.b  d7,d0
                swap    d0
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_DD22   ;LD (NN),IX @
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
                swap    d0
                move.w  d0,d6
                swap    d0
;                cmp.w   #$4000,d7
;                bcs     _DD22wp1
                move.b  d6,(a0)
_DD22wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DD22wp2
                lsr.w   #8,d6
                move.b  d6,(a0)
_DD22wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DD23   ;INC IX
                swap    d0
                addq.w  #1,d0
                swap    d0
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_DD24   ;INC HX
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                addq.l  #1,d6
                move.w  sr,d7
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD25   ;DEC HX
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                subq.b  #1,d6
                move.w  sr,d7
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD26   ;LD HX,N
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DD27

                move.l  #$dd27,d7
                bra     no_instr
_DD28

                move.l  #$dd28,d7
                bra     no_instr
_DD29   ;ADD    IX,IX
                swap    d0
                add.w   d0,d0
                scs.b   d7
                swap    d0
                and.b   #1,d7
                and.b   #%11111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DD2A   ;LD IX,(NN)
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d6
                swap    d0
                move.b  (a0),-(a7)
                move.w  (a7)+,d0        ;lsl.w   #8,d6
                move.b  d6,d0
                swap    d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DD2B   ;DEC    IX
                swap    d0
                subq.w  #1,d0
                swap    d0
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_DD2C   ;INC LX
                swap    d0
                addq.b  #1,d0
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD2D   ;DEC LX
                swap    d0
                subq.b  #1,d0
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD2E   ;LD LX,N
                swap    d0
                move.b  (a1)+,d0
                swap    d0
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_DD2F

                move.l  #$dd2f,d7
                bra     no_instr

_DD30

                move.l  #$dd30,d7
                bra     no_instr
_DD31

                move.l  #$dd31,d7
                bra     no_instr
_DD32

                move.l  #$dd32,d7
                bra     no_instr
_DD33

                move.l  #$dd33,d7
                bra     no_instr
_DD34   ;INC (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                addq.b  #1,d7
                move.w  sr,d6
                and.b   #%00001110,d6
                and.b   #%11110001,d0
                or.b    d6,d0
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _DD34wp
                move.b  d7,(a0)
_DD34wp         add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DD35   ;DEC (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                subq.b  #1,d7
                move.w  sr,d6
                and.b   #%00001110,d6
                and.b   #%11110001,d0
                or.b    d6,d0
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _DD35wp
                move.b  d7,(a0)
_DD35wp         add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DD36   ;LD (IX+S),N
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                move.b  (a1)+,d6
                cmp.w   #$4000,d7      ;
                bcs     _DD36wp        ;
                move.b  d6,(a0)
_DD36wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD37

                move.l  #$dd37,d7
                bra     no_instr
_DD38

                move.l  #$dd38,d7
                bra     no_instr
_DD39   ;ADD IX,SP
                swap    d0
                add.w   a4,d0
                scs.b   d7
                swap    d0
                and.b   #1,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DD3A
                move.l  #$dd3a,d7
                bra     no_instr
_DD3B
                move.l  #$dd3b,d7
                bra     no_instr
_DD3C
                move.l  #$dd3c,d7
                bra     no_instr
_DD3D
                move.l  #$dd3d,d7
                bra     no_instr
_DD3E

                move.l  #$dd3e,d7
                bra     no_instr
_DD3F

                move.l  #$dd3f,d7
                bra     no_instr

_DD40

                move.l  #$dd40,d7
                bra     no_instr
_DD41

                move.l  #$dd41,d7
                bra     no_instr
_DD42

                move.l  #$dd42,d7
                bra     no_instr
_DD43

                move.l  #$dd43,d7
                bra     no_instr
_DD44   ;LD B,HX
                swap    d0
                swap    d2
                move.w  d0,d2
                lsr.w   #8,d2
                swap    d2
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD45   ;LD B,LX
                swap    d0
                swap    d2
                move.b  d0,d2
                swap    d2
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD46   ;LD B,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d2
                move.b  (a0),d2
                swap    d2
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD47

                move.l  #$dd47,d7
                bra     no_instr
_DD48

                move.l  #$dd48,d7
                bra     no_instr
_DD49

                move.l  #$dd49,d7
                bra     no_instr
_DD4A

                move.l  #$dd4a,d7
                bra     no_instr
_DD4B

                move.l  #$dd4b,d7
                bra     no_instr
_DD4C   ;LD C,HX
                swap    d0
                move.w  d0,d2
                lsr.w   #8,d2
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD4D   ;LD C,LX
                swap    d0
                move.b  d0,d2
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD4E   ;LD C,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d2
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD4F

                move.l  #$dd4f,d7
                bra     no_instr

_DD50

                move.l  #$dd50,d7
                bra     no_instr
_DD51

                move.l  #$dd51,d7
                bra     no_instr
_DD52

                move.l  #$dd52,d7
                bra     no_instr
_DD53

                move.l  #$dd53,d7
                bra     no_instr
_DD54   ;LD D,HX
                swap    d0
                swap    d3
                move.w  d0,d3
                lsr.w   #8,d3
                swap    d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD55   ;LD D,LX
                swap    d0
                swap    d3
                move.b  d0,d3
                swap    d0
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD56   ;LD D,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d3
                move.b  (a0),d3
                swap    d3
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD57

                move.l  #$dd57,d7
                bra     no_instr
_DD58

                move.l  #$dd58,d7
                bra     no_instr
_DD59

                move.l  #$dd59,d7
                bra     no_instr
_DD5A

                move.l  #$dd5a,d7
                bra     no_instr
_DD5B

                move.l  #$dd5b,d7
                bra     no_instr
_DD5C   ;LD E,HX
                swap    d0
                move.w  d0,d6
                swap    d0
                lsr.w   #8,d6
                move.b  d6,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD5D   ;LD E,LX
                swap    d0
                move.b  d0,d3
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD5E   ;LD E,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d3
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD5F

                move.l  #$dd5f,d7
                bra     no_instr

_DD60   ;LD HX,B
                swap    d2
                move.b  d2,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d2
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD61   ;LD HX,C
                move.b  d2,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD62   ;LD HX,D
                swap    d3
                move.b  d3,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d3
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD63   ;LD HX,E
                move.b  d3,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD64   ;LD HX,HX
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD65   ;LD HX,LX
                swap    d0
                move.b  d0,-(a7)
                move.w  (a7)+,d6
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD66   ;LD H,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d4
                move.b  (a0),d4
                swap    d4
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD67   ;LD HX,A
                move.b  d1,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d0
                move.b  d0,d6
                move.w  d6,d0
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD68   ;LD LX,B
                swap    d0
                swap    d2
                move.b  d2,d0
                swap    d2
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD69   ;LD LX,C
                swap    d0
                move.b  d2,d0
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD6A   ;LD LX,D
                swap    d0
                swap    d3
                move.b  d3,d0
                swap    d3
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD6B   ;LD LX,E
                swap    d0
                move.b  d3,d0
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD6C   ;LD LX,HX
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                move.b  d6,d0
                swap    d0
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_DD6D   ;LD LX,LX
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD6E   ;LD L,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d4
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD6F   ;LD LX,A
                swap    d0
                move.b  d1,d0
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD70   ;LD (IX+S),B
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7       ;
                bcs     _DD70wp         ;
                swap    d2
                move.b  d2,(a0)
                swap    d2
_DD70wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD71   ;LD (IX+S),C
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7      ;
                bcs     _DD71wp        ;
                move.b  d2,(a0)
_DD71wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD72   ;LD (IX+S),D
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7      ;
                bcs     _DD72wp        ;
                swap    d3
                move.b  d3,(a0)
                swap    d3
_DD72wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD73   ;LD (IX+S),E
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7      ;
                bcs     _DD73wp        ;
                move.b  d3,(a0)
_DD73wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD74   ;LD (IX+S),H
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7      ;
                bcs     _DD74wp        ;
                swap    d4
                move.b  d4,(a0)
                swap    d4
_DD74wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD75   ;LD (IX+S),L
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7      ;
                bcs     _DD75wp        ;
                move.b  d4,(a0)
_DD75wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD76

                move.l  #$dd76,d7
                bra     no_instr
_DD77   ;LD (IX+S),A
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                cmp.w   #$4000,d7 ;
                bcs     _DD77wp   ;
                move.b  d1,(a0)
_DD77wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD78

                move.l  #$dd78,d7
                bra     no_instr
_DD79

                move.l  #$dd79,d7
                bra     no_instr
_DD7A

                move.l  #$dd7a,d7
                bra     no_instr
_DD7B

                move.l  #$dd7b,d7
                bra     no_instr
_DD7C   ;LD A,HX
                swap    d0
                move.w  d0,d1
                lsr.w   #8,d1
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD7D   ;LD A,LX
                swap    d0
                move.b  d0,d1
                swap    d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD7E   ;LD A,(IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d1
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD7F

                move.l  #$dd7f,d7
                bra     no_instr

_DD80

                move.l  #$dd80,d7
                bra     no_instr
_DD81

                move.l  #$dd81,d7
                bra     no_instr
_DD82

                move.l  #$dd82,d7
                bra     no_instr
_DD83

                move.l  #$dd83,d7
                bra     no_instr
_DD84   ;ADD A,HX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                add.b   d6,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD85   ;ADD A,LX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                add.b   d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD86   ;ADD A,(IX+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD87

                move.l  #$dd87,d7
                bra     no_instr
_DD88

                move.l  #$dd88,d7
                bra     no_instr
_DD89

                move.l  #$dd89,d7
                bra     no_instr
_DD8A

                move.l  #$dd8a,d7
                bra     no_instr
_DD8B

                move.l  #$dd8b,d7
                bra     no_instr
_DD8C   ;ADC A,HX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                swap    d0
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD8D   ;ADC A,LX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                swap    d0
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD8E   ;ADC A,(IX+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD8F

                move.l  #$dd8f,d7
                bra     no_instr

_DD90

                move.l  #$dd90,d7
                bra     no_instr
_DD91

                move.l  #$dd91,d7
                bra     no_instr
_DD92

                move.l  #$dd92,d7
                bra     no_instr
_DD93

                move.l  #$dd93,d7
                bra     no_instr
_DD94   ;SUB HX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                sub.b   d6,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD95   ;SUB LX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                sub.b   d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD96   ;SUB (IX+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD97

                move.l  #$dd97,d7
                bra     no_instr
_DD98

                move.l  #$dd98,d7
                bra     no_instr
_DD99

                move.l  #$dd99,d7
                bra     no_instr
_DD9A

                move.l  #$dd9a,d7
                bra     no_instr
_DD9B

                move.l  #$dd9b,d7
                bra     no_instr
_DD9C   ;SBC A,HX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                swap    d0
                move.w  d0,d6
                lsr.w   #8,d6
                swap    d0
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD9D   ;SBC A,LX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                move.b  d0,d7
                swap    d0
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DD9E   ;SBC A,(IX+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DD9F
                move.l  #$dd9f,d7
                bra     no_instr

_DDA0
                move.l  #$dda0,d7
                bra     no_instr
_DDA1
                move.l  #$dda1,d7
                bra     no_instr
_DDA2

                move.l  #$dda2,d7
                bra     no_instr
_DDA3

                move.l  #$dda3,d7
                bra     no_instr
_DDA4   ;AND HX
                swap    d0
                move.w  d0,d6
                swap    d0
                lsr.w   #8,d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDA5   ;AND LX
                swap    d0
                and.b   d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDA6   ;AND (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DDA7

                move.l  #$dda7,d7
                bra     no_instr
_DDA8

                move.l  #$dda8,d7
                bra     no_instr
_DDA9

                move.l  #$dda9,d7
                bra     no_instr
_DDAA

                move.l  #$ddaa,d7
                bra     no_instr
_DDAB

                move.l  #$ddab,d7
                bra     no_instr
_DDAC   ;XOR HX
                swap    d0
                move.w  d0,d6
                swap    d0
                lsr.w   #8,d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDAD   ;XOR LX
                swap    d0
                eor.b   d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDAE   ;XOR (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DDAF

                move.l  #$ddaf,d7
                bra     no_instr

_DDB0

                move.l  #$ddb0,d7
                bra     no_instr
_DDB1

                move.l  #$ddb1,d7
                bra     no_instr
_DDB2

                move.l  #$ddb2,d7
                bra     no_instr
_DDB3

                move.l  #$ddb3,d7
                bra     no_instr
_DDB4   ;OR HX
                swap    d0
                move.w  d0,d6
                swap    d0
                lsr.w   #8,d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDB5   ;OR LX
                swap    d0
                or.b    d0,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDB6   ;OR (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DDB7

                move.l  #$ddb7,d7
                bra     no_instr
_DDB8

                move.l  #$ddb8,d7
                bra     no_instr
_DDB9

                move.l  #$ddb9,d7
                bra     no_instr
_DDBA

                move.l  #$ddba,d7
                bra     no_instr
_DDBB

                move.l  #$ddbb,d7
                bra     no_instr
_DDBC   ;CP HX
                swap    d0
                move.w  d0,d7
                lsr.w   #8,d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDBD   ;CP LX
                swap    d0
                move.b  d1,d6
                sub.b   d0,d6
                move.w  sr,d7
                swap    d0
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDBE   ;CP (IX+S)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_DDBF

                move.l  #$ddbf,d7
                bra     no_instr

_DDC0

                move.l  #$ddc0,d7
                bra     no_instr
_DDC1

                move.l  #$ddc1,d7
                bra     no_instr
_DDC2

                move.l  #$ddc2,d7
                bra     no_instr
_DDC3

                move.l  #$ddc3,d7
                bra     no_instr
_DDC4

                move.l  #$ddc4,d7
                bra     no_instr
_DDC5

                move.l  #$ddc5,d7
                bra     no_instr
_DDC6

                move.l  #$ddc6,d7
                bra     no_instr
_DDC7

                move.l  #$ddc7,d7
                bra     no_instr
_DDC8

                move.l  #$ddc8,d7
                bra     no_instr
_DDC9

                move.l  #$ddc9,d7
                bra     no_instr
_DDCA

                move.l  #$ddca,d7
                bra     no_instr
_DDCB   ;PREFIX
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a0
                move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a0
                move.w  #$500,d7
                move.b  (a1)+,d7
                add.w   d7,d7
                move.w  (a2,d7.w),d7
                jmp     (a3,d7.w)
_DDCC

                move.l  #$ddcc,d7
                bra     no_instr
_DDCD   ;CALL NN
                move.l  a1,d6
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6

                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

;                cmp.w   #$4000,d7
;                bcs     _DDCDwp1
                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)
_DDCDwp1        move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DDCDwp2
                move.w  a1,d7
                move.b  d7,(a4)
_DDCDwp2        move.l  d6,a1
                add.w   #21,d5
                bcc     kernel
                bra     interrupt
_DDCE

                move.l  #$ddce,d7
                bra     no_instr
_DDCF

                move.l  #$ddcf,d7
                bra     no_instr

_DDD0

                move.l  #$ddd0,d7
                bra     no_instr
_DDD1

                move.l  #$ddd1,d7
                bra     no_instr
_DDD2

                move.l  #$ddd2,d7
                bra     no_instr
_DDD3

                move.l  #$ddd3,d7
                bra     no_instr
_DDD4

                move.l  #$ddd4,d7
                bra     no_instr
_DDD5

                move.l  #$ddd5,d7
                bra     no_instr
_DDD6

                move.l  #$ddd6,d7
                bra     no_instr
_DDD7

                move.l  #$ddd7,d7
                bra     no_instr
_DDD8

                move.l  #$ddd8,d7
                bra     no_instr
_DDD9

                move.l  #$ddd9,d7
                bra     no_instr
_DDDA

                move.l  #$ddda,d7
                bra     no_instr
_DDDB

                move.l  #$dddb,d7
                bra     no_instr
_DDDC

                move.l  #$dddc,d7
                bra     no_instr
_DDDD

                move.l  #$dddd,d7
                bra     no_instr
_DDDE

                move.l  #$ddde,d7
                bra     no_instr
_DDDF

                move.l  #$dddf,d7
                bra     no_instr

_DDE0

                move.l  #$dde0,d7
                bra     no_instr
_DDE1   ;POP IX
                swap    d0
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.b  (a4),-(a7)
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.w  (a7)+,d0        ;lsl.w   #8,d6
                move.b  d6,d0
                swap    d0
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_DDE2

                move.l  #$dde2,d7
                bra     no_instr
_DDE3   ;EX (SP),IX
                swap    d0
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.b  d0,d6
                lsr.w   #8,d0
;                move.w  a4,d6
;                cmp.w   #$4000,d6
;                bcs     _DDE3wp1
                move.b  d0,(a4)
_DDE3wp1        move.w  d7,d0
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DDE3wp2
                move.b  d6,(a4)
_DDE3wp2        swap    d0
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDE4

                move.l  #$dde4,d7
                bra     no_instr
_DDE5   ;PUSH IX
                swap    d0
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DDE5wp1
                move.w  d0,d6
                lsr.w   #8,d6
                move.b  d6,(a4)
_DDE5wp1        move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _DDE5wp2
                move.w  d0,d6
                lsr.w   #8,d6
                move.b  d0,(a4)
_DDE5wp2        swap    d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DDE6

                move.l  #$dde6,d7
                bra     no_instr
_DDE7

                move.l  #$dde7,d7
                bra     no_instr
_DDE8

                move.l  #$dde8,d7
                bra     no_instr
_DDE9   ;JP (IX)
                swap    d0
                move.l  a4,d7
                move.w  d0,d7
                swap    d0
                move.l  d7,a1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDEA

                move.l  #$ddea,d7
                bra     no_instr
_DDEB   ;EX DE,IX
                swap    d0
                move.w  d0,d7
                lsr.w   #8,d7
                swap    d7
                move.b  d0,d7
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d0
                move.b  d3,d0
                swap    d0
                move.l  d7,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_DDEC

                move.l  #$ddec,d7
                bra     no_instr
_DDED

                move.l  #$dded,d7
                bra     no_instr
_DDEE

                move.l  #$ddee,d7
                bra     no_instr
_DDEF

                move.l  #$ddef,d7
                bra     no_instr

_DDF0

                move.l  #$ddf0,d7
                bra     no_instr
_DDF1

                move.l  #$ddf1,d7
                bra     no_instr
_DDF2

                move.l  #$ddf2,d7
                bra     no_instr
_DDF3

                move.l  #$ddf3,d7
                bra     no_instr
_DDF4

                move.l  #$ddf4,d7
                bra     no_instr
_DDF5

                move.l  #$ddf5,d7
                bra     no_instr
_DDF6

                move.l  #$ddf6,d7
                bra     no_instr
_DDF7

                move.l  #$ddf7,d7
                bra     no_instr
_DDF8

                move.l  #$ddf8,d7
                bra     no_instr
_DDF9   ;LD SP,IX
                move.l  a4,d7
                swap    d0
                move.w  d0,d7
                swap    d0
                move.l  d7,a4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_DDFA

                move.l  #$ddfa,d7
                bra     no_instr
_DDFB

                move.l  #$ddfb,d7
                bra     no_instr
_DDFC

                move.l  #$ddfc,d7
                bra     no_instr
_DDFD

                move.l  #$ddfd,d7
                bra     no_instr
_DDFE

                move.l  #$ddfe,d7
                bra     no_instr
_DDFF

                move.l  #$ddff,d7
                bra     no_instr

_FD00   ;NOP
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt

                move.l  #$fd00,d7
                bra     no_instr
_FD01

                move.l  #$fd01,d7
                bra     no_instr
_FD02

                move.l  #$fd02,d7
                bra     no_instr
_FD03

                move.l  #$fd03,d7
                bra     no_instr
_FD04

                move.l  #$fd04,d7
                bra     no_instr
_FD05

                move.l  #$fd05,d7
                bra     no_instr
_FD06

                move.l  #$fd06,d7
                bra     no_instr
_FD07

                move.l  #$fd07,d7
                bra     no_instr
_FD08

                move.l  #$fd08,d7
                bra     no_instr
_FD09   ;ADD IY,BC
                move.b  d2,d6
                swap    d2
                move.b  d2,-(a7)
                swap    d2
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                move.b  d6,d7
                swap    d1
                add.w   d7,d1
                move.w  sr,d7
                swap    d1
                and.b   #%00000001,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_FD0A

                move.l  #$fd0a,d7
                bra     no_instr
_FD0B

                move.l  #$fd0b,d7
                bra     no_instr
_FD0C

                move.l  #$fd0c,d7
                bra     no_instr
_FD0D   ;DEC C
                addq.w  #4,d5
                bra     _0D
_FD0E

                move.l  #$fd0e,d7
                bra     no_instr
_FD0F

                move.l  #$fd0f,d7
                bra     no_instr

_FD10

                move.l  #$fd10,d7
                bra     no_instr
_FD11

                move.l  #$fd11,d7
                bra     no_instr
_FD12

                move.l  #$fd12,d7
                bra     no_instr
_FD13

                move.l  #$fd13,d7
                bra     no_instr
_FD14

                move.l  #$fd14,d7
                bra     no_instr
_FD15

                move.l  #$fd15,d7
                bra     no_instr
_FD16

                move.l  #$fd16,d7
                bra     no_instr
_FD17

                move.l  #$fd17,d7
                bra     no_instr
_FD18

                move.l  #$fd18,d7
                bra     no_instr
_FD19   ;ADD IY,DE
                move.b  d3,d6
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d7        ;lsl.w   #8,d7
                move.b  d6,d7
                swap    d1
                add.w   d7,d1
                move.w  sr,d7
                swap    d1
                and.b   #%00000001,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_FD1A

                move.l  #$fd1a,d7
                bra     no_instr
_FD1B

                move.l  #$fd1b,d7
                bra     no_instr
_FD1C

                move.l  #$fd1c,d7
                bra     no_instr
_FD1D

                move.l  #$fd1d,d7
                bra     no_instr
_FD1E

                move.l  #$fd1e,d7
                bra     no_instr
_FD1F

                move.l  #$fd1f,d7
                bra     no_instr

_FD20

                move.l  #$fd20,d7
                bra     no_instr
_FD21   ;LD IY,NN
                swap    d1
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d1        ;lsl.w   #8,d6
                move.b  d7,d1
                swap    d1
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_FD22   ;LD (NN),IY @
                move.l  a1,d7
                move.b  (a1)+,d6
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a0
                swap    d1
                move.w  d1,d6
                swap    d1
;                cmp.w   #$4000,d7
;                bcs     _FD22wp1
                move.b  d6,(a0)
_FD22wp1        addq    #1,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD22wp2
                lsr.w   #8,d6
                move.b  d6,(a0)
_FD22wp2        add.w   #20,d5
                bcc     kernel
                bra     interrupt
_FD23   ;INC IY
                swap    d1
                addq.w  #1,d1
                swap    d1
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_FD24   ;INC HY
                swap    d1
                move.w  d1,d6
                lsr.w   #8,d6
                addq.l  #1,d6
                move.w  sr,d7
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD25   ;DEC HY
                swap    d1
                move.w  d1,d6
                lsr.w   #8,d6
                subq.b  #1,d6
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                move.b  d6,-(a7)
                move.w  (a7)+,d6
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD26   ;LD HY,N
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_FD27

                move.l  #$fd27,d7
                bra     no_instr
_FD28

                move.l  #$fd28,d7
                bra     no_instr
_FD29   ;ADD    IY,IY
                swap    d1
                add.w   d1,d1
                scs.b   d7
                and.b   #1,d7
                and.b   #%11111110,d0
                or.b    d7,d0
                swap    d1
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_FD2A   ;LD IY,(NN)
                move.b  (a1)+,d7
                move.b  (a1)+,-(a7)
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                move.b  d7,d6
                move.l  a1,d7
                move.w  d6,d7
                move.l  d7,a0
                move.b  (a0)+,d6
                swap    d1
                move.b  (a0),-(a7)
                move.w  (a7)+,d1        ;lsl.w   #8,d6
                move.b  d6,d1
                swap    d1
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_FD2B   ;DEC IY
                swap    d1
                subq.w  #1,d1
                swap    d1
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_FD2C   ;INC LY
                swap    d1
                addq.b  #1,d1
                move.w  sr,d7
                swap    d1
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD2D   ;DEC LY
                swap    d1
                subq.b  #1,d1
                move.w  sr,d7
                swap    d1
                and.b   #%00001110,d7
                and.b   #%11110001,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_FD2E   ;LD LY,N
                swap    d1
                move.b  (a1)+,d1
                swap    d1
                add.w   #11,d5
                bcc     kernel
                bra     interrupt
_FD2F

                move.l  #$fd2f,d7
                bra     no_instr

_FD30

                move.l  #$fd30,d7
                bra     no_instr
_FD31

                move.l  #$fd31,d7
                bra     no_instr
_FD32

                move.l  #$fd32,d7
                bra     no_instr
_FD33

                move.l  #$fd33,d7
                bra     no_instr
_FD34   ;INC (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                addq.b  #1,d7
                move.w  sr,d6
                and.b   #%00001110,d6
                and.b   #%11110001,d0
                or.b    d6,d0
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _FD34wp
                move.b  d7,(a0)
_FD34wp         add.w   #23,d5
                bcc     kernel
                bra     interrupt
_FD35   ;DEC (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                subq.b  #1,d7
                move.w  sr,d6
                and.b   #%00001110,d6
                and.b   #%11110001,d0
                or.b    d6,d0
                move.w  a0,d6
;                cmp.w   #$4000,d6
;                bcs     _FD35wp
                move.b  d7,(a0)
_FD35wp         add.w   #23,d5
                bcc     kernel
                bra     interrupt
_FD36   ;LD (IY+S),N
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
                move.b  (a1)+,d6
;                cmp.w   #$4000,d7
;                bcs     _FD36wp
                move.b  d6,(a0)
_FD36wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD37

                move.l  #$fd37,d7
                bra     no_instr
_FD38

                move.l  #$fd38,d7
                bra     no_instr
_FD39   ;ADD IY,SP
                swap    d1
                add.w   a4,d1
                scs.b   d7
                swap    d1
                and.b   #1,d7
                and.b   #%10111110,d0
                or.b    d7,d0
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_FD3A

                move.l  #$fd3a,d7
                bra     no_instr
_FD3B

                move.l  #$fd3b,d7
                bra     no_instr
_FD3C

                move.l  #$fd3c,d7
                bra     no_instr
_FD3D

                move.l  #$fd3d,d7
                bra     no_instr
_FD3E

                move.l  #$fd3e,d7
                bra     no_instr
_FD3F

                move.l  #$fd3f,d7
                bra     no_instr

_FD40

                move.l  #$fd40,d7
                bra     no_instr
_FD41

                move.l  #$fd41,d7
                bra     no_instr
_FD42
                move.l  #$fd42,d7
                bra     no_instr
_FD43
                move.l  #$fd43,d7
                bra     no_instr
_FD44   ;LD B,HY
                swap    d1
                swap    d2
                move.w  d1,d2
                lsr.w   #8,d2
                swap    d2
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD45   ;LD B,LY
                swap    d1
                swap    d2
                move.b  d1,d2
                swap    d2
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD46   ;LD B,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d2
                move.b  (a0),d2
                swap    d2
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD47

                move.l  #$fd47,d7
                bra     no_instr
_FD48

                move.l  #$fd48,d7
                bra     no_instr
_FD49

                move.l  #$fd49,d7
                bra     no_instr
_FD4A

                move.l  #$fd4a,d7
                bra     no_instr
_FD4B

                move.l  #$fd4b,d7
                bra     no_instr
_FD4C   ;LD C,HY
                swap    d1
                move.w  d1,d2
                lsr.w   #8,d2
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD4D   ;LD C,LY
                swap    d1
                move.b  d1,d2
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD4E   ;LD C,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d2
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD4F

                move.l  #$fd4f,d7
                bra     no_instr

_FD50

                move.l  #$fd50,d7
                bra     no_instr
_FD51

                move.l  #$fd51,d7
                bra     no_instr
_FD52

                move.l  #$fd52,d7
                bra     no_instr
_FD53

                move.l  #$fd53,d7
                bra     no_instr
_FD54   ;LD D,HY
                swap    d1
                swap    d3
                move.w  d1,d3
                lsr.w   #8,d3
                swap    d1
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD55   ;LD D,LY
                swap    d3
                swap    d1
                move.b  d1,d3
                swap    d1
                swap    d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD56   ;LD D,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d3
                move.b  (a0),d3
                swap    d3
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD57

                move.l  #$fd57,d7
                bra     no_instr
_FD58

                move.l  #$fd58,d7
                bra     no_instr
_FD59

                move.l  #$fd59,d7
                bra     no_instr
_FD5A

                move.l  #$fd5a,d7
                bra     no_instr
_FD5B

                move.l  #$fd5b,d7
                bra     no_instr
_FD5C   ;LD E,HY
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                move.b  d6,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD5D   ;LD E,LY
                swap    d1
                move.b  d1,d3
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD5E   ;LD E,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d3
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD5F

                move.l  #$fd5f,d7
                bra     no_instr

_FD60   ;LD HY,B
                swap    d2
                move.b  d2,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d2
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD61   ;LD HY,C
                move.b  d2,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD62   ;LD HY,D
                swap    d3
                move.b  d3,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d3
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD63   ;LD HY,E
                move.b  d3,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD64   ;LD HY,HY
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD65   ;LD HY,LY
                swap    d1
                move.b  d1,-(a7)
                move.w  (a7)+,d6
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD66   ;LD H,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                swap    d4
                move.b  (a0),d4
                swap    d4
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD67   ;LD HY,A
                move.b  d1,-(a7)        ;более быстрый аналог
                move.w  (a7)+,d6        ;lsl.w   #8,d6
                swap    d1
                move.b  d1,d6
                move.w  d6,d1
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD68   ;LD LY,B
                swap    d1
                swap    d2
                move.b  d2,d1
                swap    d2
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD69   ;LD LY,C
                swap    d1
                move.b  d2,d1
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD6A   ;LD LY,D
                swap    d1
                swap    d3
                move.b  d3,d1
                swap    d3
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD6B   ;LD LY,E
                swap    d1
                move.b  d3,d1
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD6C   ;LD LY,HY
                swap    d1
                move.w  d1,d6
                lsr.w   #8,d6
                move.b  d6,d1
                swap    d1
                addq    #8,d5
                bcc     kernel
                bra     interrupt
_FD6D   ;LD LY,LY
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD6E   ;LD L,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d4
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD6F   ;LD LY,A
                move.b  d1,d6
                swap    d1
                move.b  d6,d1
                swap    d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD70   ;LD (IY+S),B
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD70wp
                swap    d2
                move.b  d2,(a0)
                swap    d2
_FD70wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD71   ;LD (IY+S),C
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD71wp
                move.b  d2,(a0)
_FD71wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD72   ;LD (IY+S),D
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD72wp
                swap    d3
                move.b  d3,(a0)
                swap    d3
_FD72wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD73   ;LD (IY+S),E
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD73wp
                move.b  d3,(a0)
_FD73wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD74   ;LD (IY+S),H
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD74wp
                swap    d4
                move.b  d4,(a0)
                swap    d4
_FD74wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD75   ;LD (IY+S),L
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD75wp
                move.b  d4,(a0)
_FD75wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD76

                move.l  #$fd76,d7
                bra     no_instr
_FD77   ;LD (IY+S),A
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _FD77wp
                move.b  d1,(a0)
_FD77wp         add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD78

                move.l  #$fd78,d7
                bra     no_instr
_FD79

                move.l  #$fd79,d7
                bra     no_instr
_FD7A

                move.l  #$fd7a,d7
                bra     no_instr
_FD7B

                move.l  #$fd7b,d7
                bra     no_instr
_FD7C   ;LD A,HY
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                move.b  d6,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD7D   ;LD A,LY
                swap    d1
                move.b  d1,d7
                swap    d1
                move.b  d7,d1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD7E   ;LD A,(IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d1
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD7F

                move.l  #$fd7f,d7
                bra     no_instr

_FD80

                move.l  #$fd80,d7
                bra     no_instr
_FD81

                move.l  #$fd81,d7
                bra     no_instr
_FD82

                move.l  #$fd82,d7
                bra     no_instr
_FD83

                move.l  #$fd83,d7
                bra     no_instr
_FD84   ;ADD A,HX
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.w  d1,d6
                lsr.w   #8,d6
                swap    d1        
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD85   ;ADD A,LY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.b  d1,d6
                swap    d1        
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD86   ;ADD A,(IY+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                add.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD87

                move.l  #$fd87,d7
                bra     no_instr
_FD88

                move.l  #$fd88,d7
                bra     no_instr
_FD89

                move.l  #$fd89,d7
                bra     no_instr
_FD8A

                move.l  #$fd8a,d7
                bra     no_instr
_FD8B

                move.l  #$fd8b,d7
                bra     no_instr
_FD8C   ;ADC A,HY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD8D   ;ADC A,LY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.b  d1,d6
                swap    d1
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD8E   ;ADC A,(IY+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                addx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD8F

                move.l  #$fd8f,d7
                bra     no_instr

_FD90

                move.l  #$fd90,d7
                bra     no_instr
_FD91

                move.l  #$fd91,d7
                bra     no_instr
_FD92

                move.l  #$fd92,d7
                bra     no_instr
_FD93

                move.l  #$fd93,d7
                bra     no_instr
_FD94   ;SUB HY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.w  d1,d6
                lsr.w   #8,d6                
                swap    d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_FD95   ;SUB LY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.b  d1,d6
                swap    d1
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #4,d5
                bcc     kernel
                bra     interrupt
_FD96   ;SUB (IY+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                sub.b   d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD97

                move.l  #$fd97,d7
                bra     no_instr
_FD98

                move.l  #$fd98,d7
                bra     no_instr
_FD99

                move.l  #$fd99,d7
                bra     no_instr
_FD9A

                move.l  #$fd9a,d7
                bra     no_instr
_FD9B

                move.l  #$fd9b,d7
                bra     no_instr
_FD9C   ;SBC A,HY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD9D   ;SBC A,LY
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.b  d1,d6
                swap    d1
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%10110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FD9E   ;SBC A,(IY+S)
                move.b  d1,DAA(a5)     ;Для эмуляции DAA
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                move.b  d0,d7
                and.b   #1,d7
                lsr.b   #1,d7
                subx.b  d6,d1
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FD9F

                move.l  #$fd9f,d7
                bra     no_instr

_FDA0

                move.l  #$fda0,d7
                bra     no_instr
_FDA1

                move.l  #$fda1,d7
                bra     no_instr
_FDA2

                move.l  #$fda2,d7
                bra     no_instr
_FDA3

                move.l  #$fda3,d7
                bra     no_instr
_FDA4   ;AND HY
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDA5   ;AND LY
                swap    d1
                move.w  d1,d6
                swap    d1
                and.b   d6,d1
                move.w  sr,d7
                swap    d0
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDA6   ;AND (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                and.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FDA7

                move.l  #$fda7,d7
                bra     no_instr
_FDA8

                move.l  #$fda8,d7
                bra     no_instr
_FDA9

                move.l  #$fda9,d7
                bra     no_instr
_FDAA

                move.l  #$fdaa,d7
                bra     no_instr
_FDAB

                move.l  #$fdab,d7
                bra     no_instr
_FDAC   ;XOR HY
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDAD   ;XOR LY
                swap    d1
                move.b  d1,d6
                swap    d1
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDAE   ;XOR (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                eor.b   d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FDAF

                move.l  #$fdaf,d7
                bra     no_instr

_FDB0

                move.l  #$fdb0,d7
                bra     no_instr
_FDB1

                move.l  #$fdb1,d7
                bra     no_instr
_FDB2

                move.l  #$fdb2,d7
                bra     no_instr
_FDB3

                move.l  #$fdb3,d7
                bra     no_instr
_FDB4   ;OR HY
                swap    d1
                move.w  d1,d6
                swap    d1
                lsr.w   #8,d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDB5   ;OR LY
                swap    d1
                move.b  d1,d6
                swap    d1
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDB6   ;OR (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d6
                or.b    d6,d1
                move.w  sr,d7
                and.b   #%00001110,d7
                and.b   #%10110000,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d6           ;4    для ускорения эмуляции
                move.b  d1,d6           ;4    можно
                or.b    (a0,d6),d0      ;4+10 удалить
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FDB7

                move.l  #$fdb7,d7
                bra     no_instr
_FDB8

                move.l  #$fdb8,d7
                bra     no_instr
_FDB9

                move.l  #$fdb9,d7
                bra     no_instr
_FDBA

                move.l  #$fdba,d7
                bra     no_instr
_FDBB

                move.l  #$fdbb,d7
                bra     no_instr
_FDBC   ;CP HY
                swap    d1
                move.w  d1,d7
                swap    d1
                lsr.w   #8,d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDBD   ;CP LY
                swap    d1
                move.w  d1,d7
                swap    d1
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDBE   ;CP (IY+S)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d6
                ext.w   d6
                adda.w  d6,a0
                move.b  (a0),d7
                move.b  d1,d6
                sub.b   d7,d6
                move.w  sr,d7
                and.b   #%00001111,d7
                and.b   #%11110000,d0
                or.b    d7,d0
                add.w   #19,d5
                bcc     kernel
                bra     interrupt
_FDBF

                move.l  #$fdbf,d7
                bra     no_instr

_FDC0

                move.l  #$fdc0,d7
                bra     no_instr
_FDC1

                move.l  #$fdc1,d7
                bra     no_instr
_FDC2

                move.l  #$fdc2,d7
                bra     no_instr
_FDC3

                move.l  #$fdc3,d7
                bra     no_instr
_FDC4

                move.l  #$fdc4,d7
                bra     no_instr
_FDC5

                move.l  #$fdc5,d7
                bra     no_instr
_FDC6

                move.l  #$fdc6,d7
                bra     no_instr
_FDC7

                move.l  #$fdc7,d7
                bra     no_instr
_FDC8

                move.l  #$fdc8,d7
                bra     no_instr
_FDC9

                move.l  #$fdc9,d7
                bra     no_instr
_FDCA

                move.l  #$fdca,d7
                bra     no_instr
_FDCB   ;PREFIX
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a0
                move.b  (a1)+,d7
                ext.w   d7
                adda.w  d7,a0
                move.w  #$500,d7
                move.b  (a1)+,d7
                add.w   d7,d7
                move.w  (a2,d7.w),d7
                jmp     (a3,d7.w)
_FDCC

                move.l  #$fdcc,d7
                bra     no_instr
_FDCD

                move.l  #$fdcd,d7
                bra     no_instr
_FDCE

                move.l  #$fdce,d7
                bra     no_instr
_FDCF

                move.l  #$fdcf,d7
                bra     no_instr

_FDD0

                move.l  #$fdd0,d7
                bra     no_instr
_FDD1

                move.l  #$fdd1,d7
                bra     no_instr
_FDD2

                move.l  #$fdd2,d7
                bra     no_instr
_FDD3

                move.l  #$fdd3,d7
                bra     no_instr
_FDD4

                move.l  #$fdd4,d7
                bra     no_instr
_FDD5

                move.l  #$fdd5,d7
                bra     no_instr
_FDD6

                move.l  #$fdd6,d7
                bra     no_instr
_FDD7

                move.l  #$fdd7,d7
                bra     no_instr
_FDD8

                move.l  #$fdd8,d7
                bra     no_instr
_FDD9

                move.l  #$fdd9,d7
                bra     no_instr
_FDDA

                move.l  #$fdda,d7
                bra     no_instr
_FDDB

                move.l  #$fddb,d7
                bra     no_instr
_FDDC

                move.l  #$fddc,d7
                bra     no_instr
_FDDD

                move.l  #$fddd,d7
                bra     no_instr
_FDDE

                move.l  #$fdde,d7
                bra     no_instr
_FDDF

                move.l  #$fddf,d7
                bra     no_instr

_FDE0

                move.l  #$fde0,d7
                bra     no_instr
_FDE1   ;POP IY
                swap    d1
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.b  (a4),-(a7)
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.w  (a7)+,d1        ;lsl.w   #8,d6
                move.b  d6,d1
                swap    d1
                add.w   #14,d5
                bcc     kernel
                bra     interrupt
_FDE2

                move.l  #$fde2,d7
                bra     no_instr
_FDE3   ;EX (SP),IY
                swap    d1
                move.b  (a4),d6
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.b  d1,d6
                lsr.w   #8,d1
;                move.w  a4,d6
;                cmp.w   #$4000,d6
;                bcs     _FDE3wp1
                move.b  d1,(a4)
_FDE3wp1        move.w  d7,d1
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _FDE3wp2
                move.b  d6,(a4)
_FDE3wp2        swap    d1
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_FDE4
                move.l  #$fde4,d7
                bra     no_instr
_FDE5   ;PUSH IY
                swap    d1
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _FDE5wp1
                move.w  d1,d6
                lsr.w   #8,d6
                move.b  d6,(a4)
_FDE5wp1        move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4
;                cmp.w   #$4000,d7
;                bcs     _FDE5wp2
                move.w  d1,d6
                lsr.w   #8,d6
                move.b  d1,(a4)
_FDE5wp2        swap    d1
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_FDE6

                move.l  #$fde6,d7
                bra     no_instr
_FDE7

                move.l  #$fde7,d7
                bra     no_instr
_FDE8

                move.l  #$fde8,d7
                bra     no_instr
_FDE9   ;JP (IY)
                swap    d1
                move.l  a4,d7
                move.w  d1,d7
                swap    d1
                move.l  d7,a1
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDEA

                move.l  #$fdea,d7
                bra     no_instr
_FDEB   ;EX DE,IY
                swap    d1
                move.w  d1,d7
                lsr.w   #8,d7
                swap    d7
                move.b  d1,d7
                swap    d3
                move.b  d3,-(a7)
                swap    d3
                move.w  (a7)+,d1
                move.b  d3,d1
                swap    d1
                move.l  d7,d3
                addq.w  #8,d5
                bcc     kernel
                bra     interrupt
_FDEC

                move.l  #$fdec,d7
                bra     no_instr
_FDED

                move.l  #$fded,d7
                bra     no_instr
_FDEE   ;XOR N
                addq.w  #4,d5
                bra     _EE
_FDEF

                move.l  #$fdef,d7
                bra     no_instr

_FDF0

                move.l  #$fdf0,d7
                bra     no_instr
_FDF1

                move.l  #$fdf1,d7
                bra     no_instr
_FDF2

                move.l  #$fdf2,d7
                bra     no_instr
_FDF3

                move.l  #$fdf3,d7
                bra     no_instr
_FDF4

                move.l  #$fdf4,d7
                bra     no_instr
_FDF5

                move.l  #$fdf5,d7
                bra     no_instr
_FDF6

                move.l  #$fdf6,d7
                bra     no_instr
_FDF7

                move.l  #$fdf7,d7
                bra     no_instr
_FDF8

                move.l  #$fdf8,d7
                bra     no_instr
_FDF9   ;LD SP,IY
                move.l  a4,d7
                swap    d1
                move.w  d1,d7
                swap    d1
                move.l  d7,a4
                add.w   #10,d5
                bcc     kernel
                bra     interrupt
_FDFA

                move.l  #$fdfa,d7
                bra     no_instr
_FDFB

                move.l  #$fdfb,d7
                bra     no_instr
_FDFC

                move.l  #$fdfc,d7
                bra     no_instr
_FDFD   ;PREFIX
                addq.w  #4,d5
                bra     _FD                
_FDFE

                move.l  #$fdfe,d7
                bra     no_instr
_FDFF

                move.l  #$fdff,d7
                bra     no_instr
_DDCB00

                move.l  #$ddcb00,d7
                bra     no_instr
_DDCB01

                move.l  #$ddcb01,d7
                bra     no_instr
_DDCB02

                move.l  #$ddcb02,d7
                bra     no_instr
_DDCB03

                move.l  #$ddcb03,d7
                bra     no_instr
_DDCB04

                move.l  #$ddcb04,d7
                bra     no_instr
_DDCB05

                move.l  #$ddcb05,d7
                bra     no_instr
_DDCB06 ;RLC (IX+S)
                move.b  (a0),d6
;               еще нужно д7 получить!!!
;                cmp.w   #$4000,d7
;                bcs     _DDCB06wp
                rol.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB06wp       rol.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB07

                move.l  #$ddcb07,d7
                bra     no_instr
_DDCB08

                move.l  #$ddcb08,d7
                bra     no_instr
_DDCB09

                move.l  #$ddcb09,d7
                bra     no_instr
_DDCB0A

                move.l  #$ddcb0a,d7
                bra     no_instr
_DDCB0B

                move.l  #$ddcb0b,d7
                bra     no_instr
_DDCB0C

                move.l  #$ddcb0c,d7
                bra     no_instr
_DDCB0D

                move.l  #$ddcb0d,d7
                bra     no_instr
_DDCB0E ;RRC (IX+S)
                move.b  (a0),d6
;                move.l  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCB0Ewp
                ror.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB0Ewp       ror.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB0F

                move.l  #$ddcb0f,d7
                bra     no_instr

_DDCB10

                move.l  #$ddcb10,d7
                bra     no_instr
_DDCB11

                move.l  #$ddcb11,d7
                bra     no_instr
_DDCB12

                move.l  #$ddcb12,d7
                bra     no_instr
_DDCB13

                move.l  #$ddcb13,d7
                bra     no_instr
_DDCB14

                move.l  #$ddcb14,d7
                bra     no_instr
_DDCB15

                move.l  #$ddcb15,d7
                bra     no_instr
_DDCB16 ;RL (IX+S)
                move.b  (a0),d6
;               еще нужно д7 получить!!!
;                cmp.w   #$4000,d7
;                bcs     _DDCB16wp
                move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB16wp       move.b  d0,d7
                lsr.b   #1,d7
                roxl.b  #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB17

                move.l  #$ddcb17,d7
                bra     no_instr
_DDCB18

                move.l  #$ddcb18,d7
                bra     no_instr
_DDCB19

                move.l  #$ddcb19,d7
                bra     no_instr
_DDCB1A

                move.l  #$ddcb1a,d7
                bra     no_instr
_DDCB1B

                move.l  #$ddcb1b,d7
                bra     no_instr
_DDCB1C

                move.l  #$ddcb1c,d7
                bra     no_instr
_DDCB1D

                move.l  #$ddcb1d,d7
                bra     no_instr
_DDCB1E ;RR (IX+S)
                move.w  a0,d7
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _CB1Ewp
                move.b  d0,d7
                lsr.b   #1,d7
                roxr.b  #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB1F

                move.l  #$ddcb1f,d7
                bra     no_instr

_DDCB20

                move.l  #$ddcb20,d7
                bra     no_instr
_DDCB21

                move.l  #$ddcb21,d7
                bra     no_instr
_DDCB22

                move.l  #$ddcb22,d7
                bra     no_instr
_DDCB23

                move.l  #$ddcb23,d7
                bra     no_instr
_DDCB24

                move.l  #$ddcb24,d7
                bra     no_instr
_DDCB25

                move.l  #$ddcb25,d7
                bra     no_instr
_DDCB26 ;SLA (IX+S)
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _DDCB26wp
                asl.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DDCB26wp       asl.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB27

                move.l  #$ddcb27,d7
                bra     no_instr
_DDCB28

                move.l  #$ddcb28,d7
                bra     no_instr
_DDCB29

                move.l  #$ddcb29,d7
                bra     no_instr
_DDCB2A

                move.l  #$ddcb2a,d7
                bra     no_instr
_DDCB2B

                move.l  #$ddcb2b,d7
                bra     no_instr
_DDCB2C

                move.l  #$ddcb2c,d7
                bra     no_instr
_DDCB2D

                move.l  #$ddcb2d,d7
                bra     no_instr
_DDCB2E ;SRA (IX+S)
                move.b  (a0),d6
                ;d7 нужно получить
;                cmp.w   #$4000,d7
;                bcs     _DDCB2Ewp
                asr.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB2Ewp       asr.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB2F

                move.l  #$ddcb2f,d7
                bra     no_instr

_DDCB30

                move.l  #$ddcb30,d7
                bra     no_instr
_DDCB31

                move.l  #$ddcb31,d7
                bra     no_instr
_DDCB32

                move.l  #$ddcb32,d7
                bra     no_instr
_DDCB33

                move.l  #$ddcb33,d7
                bra     no_instr
_DDCB34

                move.l  #$ddcb34,d7
                bra     no_instr
_DDCB35

                move.l  #$ddcb35,d7
                bra     no_instr        
_DDCB36 ;SLI (IX+S)
                move.b  (a0),d6
;               d7 нужно еще получить
;                cmp.w   #$4000,d7
;                bcs     _DDCB36wp
                lsl.b   #1,d6
                move.w  sr,d7
                or.b    #1,d6
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB36wp       lsl.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB37

                move.l  #$ddcb37,d7
                bra     no_instr
_DDCB38

                move.l  #$ddcb38,d7
                bra     no_instr
_DDCB39

                move.l  #$ddcb39,d7
                bra     no_instr
_DDCB3A

                move.l  #$ddcb3a,d7
                bra     no_instr
_DDCB3B

                move.l  #$ddcb3b,d7
                bra     no_instr
_DDCB3C

                move.l  #$ddcb3c,d7
                bra     no_instr
_DDCB3D

                move.l  #$ddcb3d,d7
                bra     no_instr
_DDCB3E ;SRL (IX+S)
                move.w  a0,d7
                move.b  (a0),d6
;                cmp.w   #$4000,d7
;                bcs     _DDCB3Ewp
                lsr.b   #1,d6
                move.w  sr,d7
                move.b  d6,(a0)
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #15,d5
                bcc     kernel
                bra     interrupt
_DDCB3Ewp       lsr.b   #1,d6
                move.w  sr,d7
                and.b   #%00001101,d7
                and.b   #%00110000,d0
                or.b    d7,d0
                lea     parity(a5),a0   ;8    Установка флага четности
                moveq.l #0,d7           ;4    для ускорения эмуляции
                move.b  d6,d7           ;4    можно
                or.b    (a0,d7),d0      ;4+10 удалить
                add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB3F

                move.l  #$ddcb3f,d7
                bra     no_instr
_DDCB40

                move.l  #$ddcb40,d7
                bra     no_instr
_DDCB41

                move.l  #$ddcb41,d7
                bra     no_instr
_DDCB42

                move.l  #$ddcb42,d7
                bra     no_instr
_DDCB43

                move.l  #$ddcb43,d7
                bra     no_instr
_DDCB44

                move.l  #$ddcb44,d7
                bra     no_instr
_DDCB45

                move.l  #$ddcb45,d7
                bra     no_instr
_DDCB46 ;BIT 0,(IX+S)
                btst.b  #0,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB47

                move.l  #$ddcb47,d7
                bra     no_instr
_DDCB48

                move.l  #$ddcb48,d7
                bra     no_instr
_DDCB49

                move.l  #$ddcb49,d7
                bra     no_instr
_DDCB4A

                move.l  #$ddcb4a,d7
                bra     no_instr
_DDCB4B

                move.l  #$ddcb4b,d7
                bra     no_instr
_DDCB4C

                move.l  #$ddcb4c,d7
                bra     no_instr
_DDCB4D

                move.l  #$ddcb4d,d7
                bra     no_instr
_DDCB4E ;BIT 1,(IX+S)
                btst.b  #1,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB4F

                move.l  #$ddcb4f,d7
                bra     no_instr

_DDCB50

                move.l  #$ddcb50,d7
                bra     no_instr
_DDCB51

                move.l  #$ddcb51,d7
                bra     no_instr
_DDCB52

                move.l  #$ddcb52,d7
                bra     no_instr
_DDCB53

                move.l  #$ddcb53,d7
                bra     no_instr
_DDCB54

                move.l  #$ddcb54,d7
                bra     no_instr
_DDCB55

                move.l  #$ddcb55,d7
                bra     no_instr
_DDCB56 ;BIT 2,(IX+S)
                btst.b  #2,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB57

                move.l  #$ddcb57,d7
                bra     no_instr
_DDCB58

                move.l  #$ddcb58,d7
                bra     no_instr
_DDCB59

                move.l  #$ddcb59,d7
                bra     no_instr
_DDCB5A

                move.l  #$ddcb5a,d7
                bra     no_instr
_DDCB5B

                move.l  #$ddcb5b,d7
                bra     no_instr
_DDCB5C

                move.l  #$ddcb5c,d7
                bra     no_instr
_DDCB5D

                move.l  #$ddcb5d,d7
                bra     no_instr
_DDCB5E ;BIT 3,(IX+S)
                btst.b  #3,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB5F

                move.l  #$ddcb5f,d7
                bra     no_instr

_DDCB60

                move.l  #$ddcb60,d7
                bra     no_instr
_DDCB61

                move.l  #$ddcb61,d7
                bra     no_instr
_DDCB62

                move.l  #$ddcb62,d7
                bra     no_instr
_DDCB63

                move.l  #$ddcb63,d7
                bra     no_instr
_DDCB64

                move.l  #$ddcb64,d7
                bra     no_instr
_DDCB65

                move.l  #$ddcb65,d7
                bra     no_instr
_DDCB66 ;BIT 4,(IX+S)
                btst.b  #4,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB67

                move.l  #$ddcb67,d7
                bra     no_instr
_DDCB68

                move.l  #$ddcb68,d7
                bra     no_instr
_DDCB69

                move.l  #$ddcb69,d7
                bra     no_instr
_DDCB6A

                move.l  #$ddcb6a,d7
                bra     no_instr
_DDCB6B

                move.l  #$ddcb6b,d7
                bra     no_instr
_DDCB6C

                move.l  #$ddcb6c,d7
                bra     no_instr
_DDCB6D

                move.l  #$ddcb6d,d7
                bra     no_instr
_DDCB6E ;BIT 5,(IX+S)
                btst.b  #5,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB6F

                move.l  #$ddcb6f,d7
                bra     no_instr

_DDCB70

                move.l  #$ddcb70,d7
                bra     no_instr
_DDCB71

                move.l  #$ddcb71,d7
                bra     no_instr
_DDCB72

                move.l  #$ddcb72,d7
                bra     no_instr
_DDCB73

                move.l  #$ddcb73,d7
                bra     no_instr
_DDCB74

                move.l  #$ddcb74,d7
                bra     no_instr
_DDCB75

                move.l  #$ddcb75,d7
                bra     no_instr
_DDCB76 ;BIT 6,(IX+S)
                btst.b  #6,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB77

                move.l  #$ddcb77,d7
                bra     no_instr
_DDCB78

                move.l  #$ddcb78,d7
                bra     no_instr
_DDCB79

                move.l  #$ddcb79,d7
                bra     no_instr
_DDCB7A

                move.l  #$ddcb7a,d7
                bra     no_instr
_DDCB7B

                move.l  #$ddcb7b,d7
                bra     no_instr
_DDCB7C

                move.l  #$ddcb7c,d7
                bra     no_instr
_DDCB7D

                move.l  #$ddcb7d,d7
                bra     no_instr
_DDCB7E ;BIT 7,(IX+S)
                btst.b  #7,(a0)
                move.w  sr,d7
                and.b   #%00000100,d7
                and.b   #%10001011,d0
                or.b    d7,d0
                add.w   #20,d5
                bcc     kernel
                bra     interrupt
_DDCB7F

                move.l  #$ddcb7f,d7
                bra     no_instr

_DDCB80

                move.l  #$ddcb80,d7
                bra     no_instr
_DDCB81

                move.l  #$ddcb81,d7
                bra     no_instr
_DDCB82

                move.l  #$ddcb82,d7
                bra     no_instr
_DDCB83

                move.l  #$ddcb83,d7
                bra     no_instr
_DDCB84

                move.l  #$ddcb84,d7
                bra     no_instr
_DDCB85

                move.l  #$ddcb85,d7
                bra     no_instr
_DDCB86 ;RES 0,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCB86wp
                bclr.b  #0,(a0)
_DDCB86wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB87

                move.l  #$ddcb87,d7
                bra     no_instr
_DDCB88

                move.l  #$ddcb88,d7
                bra     no_instr
_DDCB89

                move.l  #$ddcb89,d7
                bra     no_instr
_DDCB8A

                move.l  #$ddcb8a,d7
                bra     no_instr
_DDCB8B

                move.l  #$ddcb8b,d7
                bra     no_instr
_DDCB8C

                move.l  #$ddcb8c,d7
                bra     no_instr
_DDCB8D

                move.l  #$ddcb8d,d7
                bra     no_instr
_DDCB8E ;RES 1,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCB8Ewp
                bclr.b  #1,(a0)
_DDCB8Ewp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB8F

                move.l  #$ddcb8f,d7
                bra     no_instr

_DDCB90

                move.l  #$ddcb90,d7
                bra     no_instr
_DDCB91

                move.l  #$ddcb91,d7
                bra     no_instr
_DDCB92

                move.l  #$ddcb92,d7
                bra     no_instr
_DDCB93

                move.l  #$ddcb93,d7
                bra     no_instr
_DDCB94

                move.l  #$ddcb94,d7
                bra     no_instr
_DDCB95

                move.l  #$ddcb95,d7
                bra     no_instr
_DDCB96 ;RES 2,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCB96wp
                bclr.b  #2,(a0)
_DDCB96wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB97

                move.l  #$ddcb97,d7
                bra     no_instr
_DDCB98

                move.l  #$ddcb98,d7
                bra     no_instr
_DDCB99

                move.l  #$ddcb99,d7
                bra     no_instr
_DDCB9A

                move.l  #$ddcb9a,d7
                bra     no_instr
_DDCB9B

                move.l  #$ddcb9b,d7
                bra     no_instr
_DDCB9C

                move.l  #$ddcb9c,d7
                bra     no_instr
_DDCB9D

                move.l  #$ddcb9d,d7
                bra     no_instr
_DDCB9E ;RES 3,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCB9Ewp
                bclr.b  #3,(a0)
_DDCB9Ewp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCB9F

                move.l  #$ddcb9f,d7
                bra     no_instr

_DDCBA0

                move.l  #$ddcba0,d7
                bra     no_instr
_DDCBA1

                move.l  #$ddcba1,d7
                bra     no_instr
_DDCBA2

                move.l  #$ddcba2,d7
                bra     no_instr
_DDCBA3

                move.l  #$ddcba3,d7
                bra     no_instr
_DDCBA4

                move.l  #$ddcba4,d7
                bra     no_instr
_DDCBA5
                move.l  #$ddcba0,d7
                bra     no_instr
_DDCBA6 ;RES 4,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBA6wp
                bclr.b  #4,(a0)
_DDCBA6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBA7

                move.l  #$ddcba7,d7
                bra     no_instr
_DDCBA8

                move.l  #$ddcba8,d7
                bra     no_instr
_DDCBA9

                move.l  #$ddcba9,d7
                bra     no_instr
_DDCBAA

                move.l  #$ddcbaa,d7
                bra     no_instr
_DDCBAB

                move.l  #$ddcbab,d7
                bra     no_instr
_DDCBAC

                move.l  #$ddcbac,d7
                bra     no_instr
_DDCBAD

                move.l  #$ddcbad,d7
                bra     no_instr
_DDCBAE ;RES 5,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBAEwp
                bclr.b  #5,(a0)
_DDCBAEwp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBAF

                move.l  #$ddcbaf,d7
                bra     no_instr

_DDCBB0

                move.l  #$ddcbb0,d7
                bra     no_instr
_DDCBB1

                move.l  #$ddcbb1,d7
                bra     no_instr
_DDCBB2

                move.l  #$ddcbb2,d7
                bra     no_instr
_DDCBB3

                move.l  #$ddcbb3,d7
                bra     no_instr
_DDCBB4

                move.l  #$ddcbb4,d7
                bra     no_instr
_DDCBB5

                move.l  #$ddcbb5,d7
                bra     no_instr
_DDCBB6 ;RES 6,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBB6wp
                bclr.b  #6,(a0)
_DDCBB6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBB7

                move.l  #$ddcbb7,d7
                bra     no_instr
_DDCBB8

                move.l  #$ddcbb8,d7
                bra     no_instr
_DDCBB9

                move.l  #$ddcbb9,d7
                bra     no_instr
_DDCBBA

                move.l  #$ddcbba,d7
                bra     no_instr
_DDCBBB

                move.l  #$ddcbbb,d7
                bra     no_instr
_DDCBBC

                move.l  #$ddcbbc,d7
                bra     no_instr
_DDCBBD

                move.l  #$ddcbbd,d7
                bra     no_instr
_DDCBBE ;RES 7,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBBEwp
                bclr.b  #7,(a0)
_DDCBBEwp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBBF

                move.l  #$ddcbbf,d7
                bra     no_instr

_DDCBC0

                move.l  #$ddcbc0,d7
                bra     no_instr
_DDCBC1

                move.l  #$ddcbc1,d7
                bra     no_instr
_DDCBC2

                move.l  #$ddcbc2,d7
                bra     no_instr
_DDCBC3

                move.l  #$ddcbc3,d7
                bra     no_instr
_DDCBC4

                move.l  #$ddcbc4,d7
                bra     no_instr
_DDCBC5

                move.l  #$ddcbc5,d7
                bra     no_instr
_DDCBC6 ;SET 0,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBC6wp
                bset.b  #0,(a0)
_DDCBC6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBC7

                move.l  #$ddcbc7,d7
                bra     no_instr
_DDCBC8

                move.l  #$ddcbc8,d7
                bra     no_instr
_DDCBC9

                move.l  #$ddcbc9,d7
                bra     no_instr
_DDCBCA

                move.l  #$ddcbca,d7
                bra     no_instr
_DDCBCB

                move.l  #$ddcbcb,d7
                bra     no_instr
_DDCBCC

                move.l  #$ddcbcc,d7
                bra     no_instr
_DDCBCD

                move.l  #$ddcbcd,d7
                bra     no_instr
_DDCBCE ;SET 1,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBCEwp
                bset.b  #1,(a0)
_DDCBCEwp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBCF

                move.l  #$ddcbcf,d7
                bra     no_instr

_DDCBD0

                move.l  #$ddcbd0,d7
                bra     no_instr
_DDCBD1

                move.l  #$ddcbd1,d7
                bra     no_instr
_DDCBD2

                move.l  #$ddcbd2,d7
                bra     no_instr
_DDCBD3

                move.l  #$ddcbd3,d7
                bra     no_instr
_DDCBD4

                move.l  #$ddcbd4,d7
                bra     no_instr
_DDCBD5

                move.l  #$ddcbd5,d7
                bra     no_instr
_DDCBD6 ;SET 2,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBD6wp
                bset.b  #2,(a0)
_DDCBD6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBD7

                move.l  #$ddcbd7,d7
                bra     no_instr
_DDCBD8

                move.l  #$ddcbd8,d7
                bra     no_instr
_DDCBD9

                move.l  #$ddcbd9,d7
                bra     no_instr
_DDCBDA

                move.l  #$ddcbda,d7
                bra     no_instr
_DDCBDB

                move.l  #$ddcbdb,d7
                bra     no_instr
_DDCBDC

                move.l  #$ddcbdc,d7
                bra     no_instr
_DDCBDD

                move.l  #$ddcbdd,d7
                bra     no_instr
_DDCBDE ;SET 3,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBDEwp
                bset.b  #3,(a0)
_DDCBDEwp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBDF

                move.l  #$ddcbdf,d7
                bra     no_instr

_DDCBE0

                move.l  #$ddcbe0,d7
                bra     no_instr
_DDCBE1

                move.l  #$ddcbe1,d7
                bra     no_instr
_DDCBE2

                move.l  #$ddcbe2,d7
                bra     no_instr
_DDCBE3

                move.l  #$ddcbe3,d7
                bra     no_instr
_DDCBE4

                move.l  #$ddcbe4,d7
                bra     no_instr
_DDCBE5

                move.l  #$ddcbe5,d7
                bra     no_instr
_DDCBE6 ;SET 4,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBE6wp
                bset.b  #4,(a0)
_DDCBE6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBE7

                move.l  #$ddcbe7,d7
                bra     no_instr
_DDCBE8

                move.l  #$ddcbe8,d7
                bra     no_instr
_DDCBE9

                move.l  #$ddcbe9,d7
                bra     no_instr
_DDCBEA

                move.l  #$ddcbea,d7
                bra     no_instr
_DDCBEB

                move.l  #$ddcbeb,d7
                bra     no_instr
_DDCBEC

                move.l  #$ddcbec,d7
                bra     no_instr
_DDCBED

                move.l  #$ddcbed,d7
                bra     no_instr
_DDCBEE ;SET 5,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBEEwp
                bset.b  #5,(a0)
_DDCBEEwp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBEF

                move.l  #$ddcbef,d7
                bra     no_instr

_DDCBF0

                move.l  #$ddcbf0,d7
                bra     no_instr
_DDCBF1

                move.l  #$ddcbf1,d7
                bra     no_instr
_DDCBF2

                move.l  #$ddcbf2,d7
                bra     no_instr
_DDCBF3

                move.l  #$ddcbf3,d7
                bra     no_instr
_DDCBF4

                move.l  #$ddcbf4,d7
                bra     no_instr
_DDCBF5

                move.l  #$ddcbf5,d7
                bra     no_instr
_DDCBF6 ;SET 6,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBF6wp
                bset.b  #6,(a0)
_DDCBF6wp       add.w   #23,d5
                bcc     kernel
                bra     interrupt
_DDCBF7

;                move.l  #$ddcbf7,d7
;                bra     no_instr
_DDCBF8

;                move.l  #$ddcbf8,d7
;                bra     no_instr
_DDCBF9

;                move.l  #$ddcbf9,d7
;                bra     no_instr
_DDCBFA

;                move.l  #$ddcbfa,d7
;                bra     no_instr
_DDCBFB

;                move.l  #$ddcbfb,d7
;                bra     no_instr
_DDCBFC

;                move.l  #$ddcbfc,d7
;                bra     no_instr
_DDCBFD

                move.l  #$ddcbfd,d7
                bra     no_instr
_DDCBFE ;SET 7,(IX+S)
                move.w  a0,d7
;                cmp.w   #$4000,d7
;                bcs     _DDCBFEwp
                bset.b  #7,(a0)
_DDCBFEwp       add.w   #23,d5
                bcc.l     kernel
                bra.l     interrupt
_DDCBFF
                move.l  #$ddcbff,d7
                bra     no_instr

