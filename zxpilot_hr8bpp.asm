;==================================================
;������������ ���������� ��������� �� ������
;������ � �������� � ������ HiRes 8bpp (256 ������)

scr_upd_hr8bpp  
                bsr     flash

                moveq   #0,d7
                move.b  border_color(a5),d7
                cmp.b   border_color1(a5),d7
                beq     no_brdr_chng
                move.b  d7,border_color1(a5)
                lea     ZX_palette(a5),a4
                move.b  (a4,d7),d6
                move.b  d6,d7
                lsl.w   #8,d7
                move.b  d6,d7
                lsl.l   #8,d7
                move.b  d6,d7
                lsl.l   #8,d7
                move.b  d6,d7
                move.l  palm_screen(a5),a1
                move.l  #1920+8-1,d6
border1         move.l  d7,(a1)+
                dbra    d6,border1
                move.l  #191-1,d5
border2         adda.w  #$100,a1
                move.l  #16-1,d6
border3         move.l  d7,(a1)+
                dbra    d6,border3
                dbra    d5,border2
                adda.w  #$100,a1
                move.l  #1912+16-1,d6
border4         move.l  d7,(a1)+
                dbra    d6,border4
no_brdr_chng


;D0 - OK ���������� ����� �� ������
;D2 - OK ���������� ����� � ����������
;D3 - OK ���� ������
;D4 - OK ��������� �������� A4
;D5 - OK ������� ���� ������ ���������
;D6 - OK ������� ����� � ���-�� ������ � ������
;D7 - OK ������� ����� � ���� ������

;A0 - �� ������ ����� �����
;A1 - OK ������ ������ ���������
;A2 - OK ������ ����������� ����
;A3 - OK ����� ���������
;A4 - �� ����� � ZX-palette
;A6 - �� Palm_screen

;                trap    #8

                move.l  a6,d3

                move.l  palitra(a5),a4
                move.l  zx_scr_tab(a5),a0
                move.l  zx_atr_tab(a5),a1
                lea     zx_scr_summ(a5),a2
                move.l  palm_screen1(a5),a6

                move.l  #23,d0
next_line_col
                moveq.l #0,d5
                moveq.l #0,d7
                moveq.l #3,d6

;� a0 ������ ����� �����

                move.l  a4,d4

scr_change_col  move.l  (a0)+,a4
                add.l   (a4)+,d7 ; � d7 ����� ����� �������� �����/������
                add.l   (a4)+,d7 ; � d5 ����� ����� ������ �����/������
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4),d7
                move.l  (a0)+,a4
                add.l   (a4)+,d5 ; � d7 ����� ����� �������� �����/������
                add.l   (a4)+,d5 ; � d5 ����� ����� ������ �����/������
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4),d5

                dbra    d6,scr_change_col
;� �1 ������ ������ ���������
                move.l  (a1)+,a4
                add.l   (a4)+,d7
                add.l   (a4)+,d5
                add.l   (a4)+,d7
                add.l   (a4)+,d5
                add.l   (a4)+,d7
                add.l   (a4)+,d5
                add.l   (a4)+,d7
                add.l   (a4),d5
                add.l   d5,d5
                add.l   d5,d7

                move.l  d4,a4

;� �2 ������ ����������� ����
;                adda.l  #4,a1

                move.l  (a2)+,d6
                cmp.l   d7,d6
                bne     znakoryad
                adda.l  #2560,a6
                bra     the_end
;___________
;������ ������������ ���
;� a0 ������� ����� ������ ������
;� �1 ������� ����� ������ ���������
;� �2 ������� ����������� ����
;� �4 ZX-Palette
;� �6 palm_screen

znakoryad
                subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1   ;��������� ����� �����
                suba    #4,a1
                suba    #32,a0

                move.l  (a0),a2        ;����� ������ ����� ����������
                adda.w  #32,a0
                move.l  (a1)+,a3       ;��������������� �� ������ ���������

                move.l  a0,d2   ;��������� ����� �������

;======== ��������� ����������
                moveq   #32-1,d6
                moveq   #$3c,d7

;                trap    #8


line_update
                moveq   #0,d5
                move.b  (a3)+,d5      ; ������ ��������� �������

                and.b   flash_mask(a5),d5

                lsl.w   #6,d5
                lea     (a4,d5.w),a0  ; ������� � ���������� 64�� ������
; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #320-4,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #2,d5
                and.w   d7,d5
                move.l  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                suba.w  #2236,a6
                suba.w  #1791,a2
                dbra    d6,line_update

                adda.w  #2304,a6
;=======

                move.l  d2,a0   ;��������� ����� �������
                move.l  d1,a2   ;��������� ����� �����
the_end
                dbra    d0,next_line_col

                move.l  d3,a6

;=====================
                rts
