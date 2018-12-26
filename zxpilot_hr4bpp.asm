;==================================================
;������������ ���������� ��������� �� ������
;������ � �������� � ������ HiRes 4bpp (16 �������� ������)

scr_upd_hr4bpp  
                bsr     flash
                moveq   #0,d7
                move.b  border_color(a5),d7
                cmp.b   border_color1(a5),d7
                beq     no_border_change_bw
                move.b  d7,border_color1(a5)
                lea     ZX_palette_bw(a5),a4

                move.b  (a4,d7),d6
                move.b  d6,d7
                lsl.b   #4,d7
                or.b    d6,d7
                move.b  d7,d6
                move.b  d7,-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.w  d7,d6
                swap    d7
                move.w  d6,d7
                move.l  palm_screen(a5),a1
                move.l  #960+4-1,d6
border1_bw      move.l  d7,(a1)+
                dbra    d6,border1_bw
                move.l  #192-1,d5
border2_bw      adda.w  #128,a1
                move.l  #8-1,d6
border3_bw      move.l  d7,(a1)+
                dbra    d6,border3_bw
                dbra    d5,border2_bw
                move.l  #956-1,d6
border4_bw      move.l  d7,(a1)+
                dbra    d6,border4_bw
no_border_change_bw

;D0 - OK ���������� ����� �� ������
;D2 - OK ���������� ����� � ����������
;D3 - OK ���� ������
;D4 - OK ��������� �������� A4
;D5 - OK ������� ���� ������ ���������
;D6 - OK ������� ����� � ���-�� ������ � ������
;D7 - OK ������� ����� � ���� ������

;A0 - �� ������ ����� �����
;A1 - OK ������ ������ ���������
;A2 - OK ������ ���������� ����
;A3 - OK ����� ���������
;A4 - �� ����� � ZX-palette
;A5 - �� Palm_screen


                move.l  a6,d3

                move.l  palitra(a5),a4
                move.l  zx_scr_tab(a5),a0
                move.l  zx_atr_tab(a5),a1
                lea     zx_scr_summ(a5),a2
                move.l  palm_screen1(a5),a6

                move.l  #23,d0
next_line_gr
                moveq.l #0,d5
                moveq.l #0,d7
                moveq.l #3,d6

;� a0 ������ ����� �����

                move.l  a4,d4

scr_change_gr   move.l  (a0)+,a4
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4),d7
                move.l  (a0)+,a4
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4)+,d5
                add.l   (a4),d5
                dbra    d6,scr_change_gr
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
                bne     znakoryad_gr
                adda.l  #1280,a6
                bra     the_end_gr
;___________
;������ ������������ ���
;� a0 ������� ����� ������ ������
;� �1 ������� ����� ������ ���������
;� �2 ������� ����������� ����
;� �4 ZX-Palette
;� �6 palm_screen

znakoryad_gr
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
                moveq   #$1e,d7

;                trap    #8

line_update_gr
                moveq  #0,d5
                move.b (a3)+,d5      ; ������ ��������� �������

                and.b   flash_mask(a5),d5

                lsl.w  #5,d5
                lea    (a4,d5.w),a0  ; ������� � ���������� 32�� ������
; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #158,a6
                adda.w  #256,a2

; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                suba.w  #1118,a6
;                suba.w  #2236,a6
                suba.w  #1791,a2
                dbra    d6,line_update_gr

                adda.w  #1152,a6
;                adda.w  #2304,a6
;=======

                move.l  d2,a0   ;��������� ����� �������
                move.l  d1,a2   ;��������� ����� �����
the_end_gr
                dbra    d0,next_line_gr

                move.l  d3,a6

;=====================
                rts
