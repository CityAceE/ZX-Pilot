;==================================================
;������������ ���������� ��������� �� ������
;� ������ HE330 4bpp (16 �������� ������)

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
                
scr_upd_he4bpp  
                bsr     flash
                move.l  a6,d3
                lea     ZX_palette(a5),a4
                move.l  zx_scr_tab(a5),a0
                move.l  zx_atr_tab(a5),a1
                lea     zx_scr_summ(a5),a2
                move.l  palm_screen(a5),a6
                move.l  #23,d0
next_line_gr_he moveq.l #0,d5
                moveq.l #0,d7
                moveq.l #3,d6
                move.l  a4,d4   ;� a0 ������ ����� �����
scr_chng_gr_he  move.l  (a0)+,a4
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
                dbra    d6,scr_chng_gr_he
                move.l  (a1)+,a4        ;� �1 ������ ������ ���������
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
                move.l  (a2)+,d6
                cmp.l   d7,d6
                bne     znakoryad_gr_he
                adda.l  #960,a6
                bra     the_end_gr_he
;___________
;������ ������������ ���
;� a0 ������� ����� ������ ������
;� �1 ������� ����� ������ ���������
;� �2 ������� ����������� ����
;� �4 ZX-Palette                
;� �6 palm_screen

znakoryad_gr_he subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1   ;��������� ����� �����
                suba    #4,a1
                suba    #32,a0
                move.l  (a0),a2        ;����� ������ ����� ���������� 
                add.w   shift(a5),a2
                adda.w  #32,a0
                move.l  (a1)+,a3       ;��������������� �� ������ ���������
                add.w   shift(a5),a3
                move.l  a0,d2   ;��������� ����� �������
                move.l  palitra(a5),a4  ;��������� ����������
                moveq   #30-1,d6
                moveq   #$1e,d7
line_upd_gr_he  moveq  #0,d5
                move.b (a3)+,d5      ; ������ ��������� �������

                and.b   flash_mask(a5),d5
                lsl.w  #5,d5
                lea    (a4,d5.w),a0  ; ������� � ���������� 32�� ������

                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; ���������� ������ ����� ����������� ������ � 8 ����
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; ������� ������ ������ ���� �� 256�� ������
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; ������� ������ ������ ���� �� 256�� ������
                suba.w  #838,a6
                suba.w  #1791,a2
                dbra    d6,line_upd_gr_he
                adda.w  #840,a6
                move.l  d2,a0   ;��������� ����� �������
                move.l  d1,a2   ;��������� ����� �����
the_end_gr_he   dbra    d0,next_line_gr_he
                move.l  d3,a6

                rts