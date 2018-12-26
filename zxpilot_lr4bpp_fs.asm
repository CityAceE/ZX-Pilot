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

scr_upd_lr4bpp_fs
                bsr     flash

                move.l  a6,d3

                move.l  palitra(a5),a4

                move.l  zx_scr_tab(a5),a0
                adda.w  scroll_y_const(a5),a0

                move.l  zx_atr_tab(a5),a1
                move.w  scroll_y_const(a5),d0
                lsr.w   #3,d0
                add.w   d0,a1

                lea     zx_scr_summ(a5),a2
                add.w   d0,a2
                move.l  palm_screen(a5),a6

                move.l  #20-1,d0
                tst.b   keyboard_sw(a5)
                beq     next_line_gr_c
                move.l  #15-1,d0
next_line_gr_c
                moveq.l #0,d5
                moveq.l #0,d7
                move.l  #3,d6
;� a0 ������ ����� �����
                move.l  a4,d4

scr_change_gr_c   move.l  (a0)+,a4
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
                dbra    d6,scr_change_gr_c
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
                bne     znakoryad_gr_c
                adda.l  #640,a6
                bra     the_end_gr_c
;___________
;������ ������������ ���
;� a0 ������� ����� ������ ������
;� �1 ������� ����� ������ ���������
;� �2 ������� ����������� ����
;� �4 ZX-Palette
;� �6 palm_screen

znakoryad_gr_c
                subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1   ;��������� ����� �����
                suba    #4,a1
                suba    #32,a0

                move.l  (a0),a2        ;����� ������ ����� ����������
                adda.w  scroll_x_const(a5),a2
                adda.w  #32,a0
                move.l  (a1)+,a3       ;��������������� �� ������ ���������
                adda.w  scroll_x_const(a5),a3

                move.l  a0,d2   ;��������� ����� �������

;======== ��������� ����������
                moveq   #20-1,d6
                moveq   #$1e,d7

line_update_gr_c
                moveq   #0,d5
                move.b  (a3)+,d5      ; ������ ��������� �������
                and.b   flash_mask(a5),d5
                lsl.w   #5,d5
                lea     (a4,d5.w),a0  ; ������� � ���������� 32�� ������
; ���������� ������ ����� ����������� ������ � 8 ����
                move.b  (a2),d5
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                adda.w  #78,a6
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
                suba.w  #558,a6
                suba.w  #1791,a2
                dbra    d6,line_update_gr_c
                adda.w  #560,a6
;=======
                move.l  d2,a0   ;��������� ����� �������
                move.l  d1,a2   ;��������� ����� �����
the_end_gr_c
                dbra    d0,next_line_gr_c

                move.l  d3,a6

                rts