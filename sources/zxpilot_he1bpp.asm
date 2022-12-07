;==================================================
;Подпрограмма обновления изменений на экране
;в режиме HE330 1bpp (монохром)

scr_upd_he1bpp  move.l  zx_scr_tab(a5),a0
                move.l  palm_screen(a5),a3
                move.l  #192-1,d1
                cmp.w   #2,shift(a5)
                beq     next_line2_he
                cmp.w   #0,shift(a5)
                beq     next_line0_he
next_line_he    move.l  (a0)+,a4
                addq.l  #1,a4
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)
                move.w  (a7)+,d0
                move.b  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                move.b  (a4)+,-(a7)     ;12
                move.w  (a7)+,d0        ;8
                move.b  (a4)+,d0        ;8
                not.w   d0              ;4
                move.w  d0,(a3)+        ;8    40
                dbra    d1,next_line_he
                rts

next_line2_he   move.l  (a0)+,a4
                addq.w  #2,a4
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
                move.w  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                dbra    d1,next_line2_he
                rts

next_line0_he   move.l  (a0)+,a4
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
                move.w  (a4)+,d0
                not.w   d0
                move.w  d0,(a3)+
                dbra    d1,next_line0_he
                rts
