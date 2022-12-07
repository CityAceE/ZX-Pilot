scr_upd_lr1bpp_fs
                move.l  zx_scr_tab(a5),a0
                adda.w  scroll_y_const(a5),a0

                move.l  (a0),a2        ;Адрес первой линии знаколинии
                adda.w  scroll_x_const(a5),a2

                move.l  palm_screen(a5),a3

                move.l  #160-1,d1
                tst.b   keyboard_sw(a5)
                beq     next_line_lr_fs 
                move.l  #120-1,d1

next_line_lr_fs 
                move.l  (a0)+,a4        ;Адрес первой линии знаколинии

                adda.w  scroll_x_const(a5),a4

                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+

                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+

                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+

                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+

                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+

                adda.l  #12,a4

                dbra    d1,next_line_lr_fs

                rts