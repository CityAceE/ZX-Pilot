;==================================================
;Подпрограмма обновления изменений на экране
;в режиме HiRes 1bpp (монохром)

scr_upd_hr1bpp  move.l  zx_scr_tab(a5),a0
                move.l  palm_screen1(a5),a3
                move.l  #191,d1
next_line_hr    move.l  (a0)+,a4
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
                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+
                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+
                move.l  (a4)+,d0
                not.l   d0
                move.l  d0,(a3)+
                adda    #8,a3
                dbra    d1,next_line_hr
                rts
