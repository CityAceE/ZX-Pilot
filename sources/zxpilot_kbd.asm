;-------------------------;
;Опрос экранной клавиатуры;
;Установка значений порта ;
;Реакция экранных клавиш  ;
;-------------------------;

;keys2bpp_lr - mode2
;keys4bpp_lr - mode3
;keys8bpp_lr - mode4
;keys1bpp_hr - mode5
;keys4bpp_hr - mode7
;keys8bpp_hr - mode8
;keys1bpp_he - mode9
;keys4bpp_he - modeB


kbd_scan

                move.b  scr_mode(a5),d0

                cmp.b   #lr2bpp,d0
                beq     keys_lr2bpp

                cmp.b   #lr1bpp_fs,d0
                beq     keys_lr2bpp

                cmp.b   #lr4bpp,d0
                beq     keys_lr4bpp

                cmp.b   #lr4bpp_fs,d0
                beq     keys_lr4bpp

                cmp.b   #lr8bpp,d0
                beq     keys_lr8bpp

                cmp.b   #lr8bpp_fs,d0
                beq     keys_lr8bpp

                cmp.b   #hr1bpp,d0
                beq     keys_hr1bpp

                cmp.b   #hr4bpp,d0
                beq     keys_hr4bpp

                cmp.b   #hr8bpp,d0
                beq     keys_hr8bpp

                cmp.b   #he1bpp,d0
                beq     keys_he1bpp

                cmp.b   #he4bpp,d0
                beq     keys_he4bpp
                
                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode5 - 320х320 1bpp монохром

keys_hr1bpp     moveq.l #0,d7
                lea     keys_matrix(a5),a0
                move.l  #$40404040,(a0)+
                move.l  #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click                

                move.w  #$ffff,last_key(a5)
                bra     key_inverse

click           moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                beq     no_click

                bne     click1

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click

                move.w  #$ffff,last_key(a5)
                bra     key_inverse                
click1          lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_1bpp(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click

                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0

                move.l  #20-1,d0
key_true        move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #40,a0
                dbra    d0,key_true

key_inverser    move.w  d7,last_key(a5)
key_inverse     move.l  keyboard_screen(a5),a0
                adda.l  d7,a0

                move.l  #20-1,d0
key_inv         move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #40,a0
                dbra    d0,key_inv

                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode7 - 320х320 4bpp 16 градаций серого

keys_hr4bpp     moveq.l #0,d7
                lea     keys_matrix(a5),a0
                and.l   #$40404040,(a0)+
                and.l   #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_b

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click                

                move.w  #$ffff,last_key(a5)
                bra     key_inverse_b

click_b         moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
;                beq     no_click
                bne     click1_b

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click

                move.w  #$ffff,last_key(a5)
                bra     key_inverse_b
click1_b        lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click

                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_4bpp(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click

                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_b
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0

                move.l  #20-1,d0
key_true_b      move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #160-12,a0
                dbra    d0,key_true_b

key_inverser_b  move.w  d7,last_key(a5)
key_inverse_b   move.l  keyboard_screen(a5),a0
                adda.l  d7,a0

                move.l  #20-1,d0
key_inv_b       move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #160-12,a0
                dbra    d0,key_inv_b
                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode8 - 320х320 8bpp 256 цветов

keys_hr8bpp     moveq.l #0,d7
                lea     keys_matrix(a5),a0
                move.l  #$40404040,(a0)+
                move.l  #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_c

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click                

                move.w  #$ffff,last_key(a5)
                bra     key_inverse_c

click_c         moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                bne     click1_c

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_c

click1_c        lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click

                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_8bpp(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click

                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_c
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0

                move.l  #20-1,d0
key_true_c      move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #320-28,a0
                dbra    d0,key_true_c

key_inverser_c  move.w  d7,last_key(a5)
key_inverse_c   move.l  keyboard_screen(a5),a0
                adda.l  d7,a0

                move.l  #20-1,d0
key_inv_c       move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #320-28,a0
                dbra    d0,key_inv_c
no_click        rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode2 - 160x160 2bpp 4 градации серого

keys_lr2bpp
                cmp.b   #lr2bpp,scr_mode(a5)
                beq     keys_lr2bpp_1

                tst.b   keyboard_sw(a5)
                beq     keys_lr4bpp2

keys_lr2bpp_1
                moveq.l #0,d7
                lea     keys_matrix(a5),a0

                move.l  #$40404040,(a0)+
                move.l  #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_lr
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)

                cmp.b   #lr1bpp_fs,scr_mode(a5)
                beq     key_inv_lr_1bpp

                bra     key_inverse_lr

click_lr        moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6
                cmp.b   #$ff,d6
                bne     click_no2_lr

                lea     scroll_y(a5),a1
                tst.b   keyboard_sw(a5)
                bne     chupa1_lr
                lea     scroll_y_full(a5),a1
chupa1_lr       move.w  pScreenY(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),scroll_y_const(a5)
                lea     scroll_x(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),scroll_x_const(a5)

                lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear55_lr move.l  #-1,(a1)+
                dbra    d0,summ_clear55_lr

;                cmp.b  #lr1bpp,scr_mode(a5)
;                bne     chupa1_lr_22

                cmp.b   #lr1bpp_fs,scr_mode(a5)        ;LoRes 1bpp
                beq     chupa1_lr_22
                bsr     scr_lr1bpp
chupa1_lr_22

;                move.b  #lr1bpp_fs,scr_mode(a5)
                
                bra     no_click_lr

click_no2_lr    

                cmp.b   #lr1bpp_fs,scr_mode(a5)
                beq     keys_lr1bpp1

                cmp.b   #$00,d6
                bne     click1_lr
click_no1_lr    move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_lr
click1_lr       lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_lr
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_2bpp_lr(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7

                cmp.w   last_key(a5),d7
                beq     no_click_lr
                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_lr
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0
                move.l  #10-1,d0
key_true_lr     move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #40,a0
                dbra    d0,key_true_lr
key_inverser_lr move.w  d7,last_key(a5)
key_inverse_lr  move.l  keyboard_screen(a5),a0
                adda.l  d7,a0
                move.l  #10-1,d0
key_inv_lr      move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #40,a0
                dbra    d0,key_inv_lr
                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode - 160х160 1bpp монохром

keys_lr1bpp1
;                trap    #8

                cmp.b   #$00,d6
                bne     click1_lr_1bpp

                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)
                bra     key_inv_lr_1bpp

click1_lr_1bpp  lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_lr
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_1bpp_lr(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7

                cmp.w   last_key(a5),d7
                beq     no_click_lr
                cmp.w   #$ffff,last_key(a5)
                beq     key_inr_lr_1bpp
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0

                move.l  #10-1,d0

key_tr_lr_1bpp  move.w  (a0),d6
                not.w   d6
                move.w  d6,(a0)
                adda.l  #20,a0
                dbra    d0,key_tr_lr_1bpp

key_inr_lr_1bpp move.w  d7,last_key(a5)

key_inv_lr_1bpp move.l  keyboard_screen(a5),a0
                adda.l  d7,a0

                move.l  #10-1,d0

key_in_lr_1bpp  move.w  (a0),d7
                not.w   d7
                move.w  d7,(a0)

                adda.l  #20,a0
                dbra    d0,key_in_lr_1bpp

                rts


;==================================
;Реакция на нажатие клавиш в режиме 
;Mode3 - 160х160 4bpp 16 градаций серого

keys_lr4bpp
                cmp.b   #lr4bpp,scr_mode(a5)
                beq     keys4bpp1_lr

                tst.b   keyboard_sw(a5)
                beq     keys_lr4bpp2

keys4bpp1_lr    moveq.l #0,d7
                lea     keys_matrix(a5),a0
                and.l   #$40404040,(a0)+
                and.l   #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_b_lr
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_b_lr
click_b_lr      moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                bne     click5_b_lr

                lea     scroll_y(a5),a1
                tst.b   keyboard_sw(a5)
                bne     chupa_lr
                lea     scroll_y_full(a5),a1
chupa_lr        move.w  pScreenY(a5),d6

                add.w   d6,d6
                move.w  (a1,d6),scroll_y_const(a5)
                lea     scroll_x(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),scroll_x_const(a5)

;                cmp.b   #4,scr_mode(a5) ;???????????????
;                cmp.b   #lr4bpp_fs,scr_mode(a5) ;???????????????
;                beq     click6_b_lr
;                move.b  scr_mode(a5),scr_mode_before(a5)

                move.b  #lr4bpp_fs,scr_mode(a5)

;                bsr     scr_mode_max_lr
;                move.b  scr_max(a5),scr_mode(a5)

click6_b_lr     lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear5_lr  move.l  #-1,(a1)+
                dbra    d0,summ_clear5_lr

;                cmp.b   #4,scr_mode(a5) ;????????????????
                cmp.b   #lr4bpp,scr_mode(a5)
                bne     no_click_lr
                bra     click51_b_lr

click5_b_lr     tst.b   d6
                bne     click1_b_lr

click51_b_lr    move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_b_lr

click1_b_lr     lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_lr
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_4bpp_lr(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click_lr
                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_b_lr
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0
                move.l  #10-1,d0
key_true_b_lr   move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #80-4,a0
                dbra    d0,key_true_b_lr
key_inverser_b_lr 
                move.w  d7,last_key(a5)
key_inverse_b_lr
                move.l  keyboard_screen(a5),a0
                adda.l  d7,a0
                move.l  #10-1,d0
key_inv_b_lr    move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #80-4,a0
                dbra    d0,key_inv_b_lr
                rts

keys_lr4bpp2    cmp.b   #0,pPenDown(a5)
                beq     no_click

                lea     scroll_y_full(a5),a1
                move.w  pScreenY(a5),d6
                cmp.w   #160,d6
                bcc     no_click

                add.w   d6,d6
                move.w  (a1,d6),scroll_y_const(a5)
                lea     scroll_x(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),scroll_x_const(a5)

                lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clr_lr4bpp move.l  #-1,(a1)+
                dbra    d0,summ_clr_lr4bpp
                bra     no_click


;==================================
;Реакция на нажатие клавиш в режиме 
;Mode4 - 160х160 8bpp 256 цветов

keys_lr8bpp
                cmp.b   #lr8bpp,scr_mode(a5)
                beq     keys8bpp1_lr

                tst.b   keyboard_sw(a5)
                beq     keys_lr4bpp2

;                tst.b   keyboard_sw(a5) ;отладка
;                bne     keys8bpp1_lr    ;отладка
;                beq     click5_c_lr

;keys8bpp2_lr    cmp.b   #0,pPenDown(a5)
;                beq     no_click_lr

;                lea     scroll_y_full(a5),a1
;                move.w  pScreenY(a5),d6
 
;               cmp.w   #160,d6
;                bcc     no_click_lr

;                add.w   d6,d6
;                move.w  (a1,d6),scroll_y_const(a5)
;                lea     scroll_x(a5),a1
;                move.w  pScreenX(a5),d6
;                add.w   d6,d6
;                move.w  (a1,d6),scroll_x_const(a5)

;                lea     zx_scr_summ(a5),a1
;                move.l  #24-1,d0
;summ_clear8bpp_lr 
;                move.l  #-1,(a1)+
;                dbra    d0,summ_clear8bpp_lr
;                bra     no_click_lr

           ;------------------------------------     

keys8bpp1_lr    moveq.l #0,d7
                lea     keys_matrix(a5),a0
                move.l  #$40404040,(a0)+
                move.l  #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_c_lr
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_c_lr

click_c_lr      moveq.l #0,d6
                lea     key_line(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                bne     click5_c_lr

                lea     scroll_y(a5),a1
                tst.b   keyboard_sw(a5)
                bne     chupa_c_lr
                lea     scroll_y_full(a5),a1
chupa_c_lr       move.w  pScreenY(a5),d6

                add.w   d6,d6
                move.w  (a1,d6),scroll_y_const(a5)
                lea     scroll_x(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),scroll_x_const(a5)

                move.b  #lr8bpp_fs,scr_mode(a5)


                lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clearA_lr  move.l  #-1,(a1)+
                dbra    d0,summ_clearA_lr

                cmp.b   #lr8bpp,scr_mode(a5)
                bne     no_click_lr
;                bra     click51_c_lr

click5_c_lr     tst.b   d6
                bne     click1_c_lr



click51_c_lr
              ;  bne     click1_c_lr
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_lr

                move.w  #$ffff,last_key(a5)
                bra     key_inverse_c_lr

click1_c_lr     lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_lr

                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_8bpp_lr(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click_lr

                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_c_lr
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0

                move.l  #10-1,d0
key_true_c_lr   move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #160-16+4,a0
                dbra    d0,key_true_c_lr
key_inverser_c_lr
                move.w  d7,last_key(a5)
key_inverse_c_lr
                move.l  keyboard_screen(a5),a0
                adda.l  d7,a0
                move.l  #10-1,d0
key_inv_c_lr    move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #160-16+4,a0
                dbra    d0,key_inv_c_lr
no_click_lr
                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;Mode9 - 240х320 1bpp монохром

keys_he1bpp     moveq.l #0,d7

                lea     keys_matrix(a5),a0

                move.l  #$40404040,(a0)+
                move.l  #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_he
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_he                
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_he
click_he        moveq.l #0,d6

                lea     key_line_he(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                bne     click11_bw_he

                lea     scroll_x_he(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),shift(a5)
                bra     click1_bw_he

click11_bw_he   tst.b   d6               
                bne     click1_he

click1_bw_he    move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_he
                move.w  #$ffff,last_key(a5)
                bra     key_inverse_he
click1_he       lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_he
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_1bpp_he(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7

click2_he       cmp.w   last_key(a5),d7
                beq     no_click_he
                cmp.w   #$ffff,last_key(a5)
                beq     key_inverser_he
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0
                move.l  #12-1,d0
key_true_he     move.b  (a0),d6
                not.b   d6
                move.b  d6,(a0)+
                move.b  (a0),d6
                not.b   d6
                move.b  d6,(a0)+
                move.b  (a0),d6
                not.b   d6
                move.b  d6,(a0)
                adda.l  #28,a0
                dbra    d0,key_true_he
key_inverser_he move.w  d7,last_key(a5)
key_inverse_he  move.l  keyboard_screen(a5),a0
                adda.l  d7,a0
                move.l  #12-1,d0
key_inv_he      move.b  (a0),d7
                not.b   d7
                move.b  d7,(a0)+
                move.b  (a0),d7
                not.b   d7
                move.b  d7,(a0)+
                move.b  (a0),d7
                not.b   d7
                move.b  d7,(a0)
                adda.l  #28,a0
                dbra    d0,key_inv_he
                rts

;==================================
;Реакция на нажатие клавиш в режиме 
;ModeB - 240х320 4bpp 16 градаций серого

keys_he4bpp     moveq.l #0,d7
                lea     keys_matrix(a5),a0
                and.l   #$40404040,(a0)+
                and.l   #$40404040,(a0)
                cmp.b   #0,pPenDown(a5)
                bne     click_b_he
                move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_he
                move.w  #$ffff,last_key(a5)
                bra     key_invrs_b_he
click_b_he      moveq.l #0,d6
                lea     key_line_he(a5),a1
                move.w  pScreenY(a5),d6
                move.b  (a1,d6),d6

                cmp.b   #$ff,d6
                bne     click5_b_he

                lea     scroll_x_he(a5),a1
                move.w  pScreenX(a5),d6
                add.w   d6,d6
                move.w  (a1,d6),shift(a5)

                lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear5_he  move.l  #-1,(a1)+
                dbra    d0,summ_clear5_he
                bra     click51_b_he

click5_b_he     tst.b   d6
                bne     click1_b_he

click51_b_he    move.w  last_key(a5),d7
                cmp.w   #$ffff,d7
                beq     no_click_he
                move.w  #$ffff,last_key(a5)
                bra     key_invrs_b_he

click1_b_he     lea     key_data(a5),a0
                add.w   d6,a0
                move.w  pScreenX(a5),d6
                lea     key_column(a5),a1
                move.b  (a1,d6),d6
                beq     no_click_he
                add.w   d6,a0
                move.l  (a0),d7
                lea     keys_matrix(a5),a0
                moveq.l #0,d6
                move.b  d7,d6
                swap    d7
                move.b  d7,(a0,d6)
                lea     keys_bloks(a5),a0
                and.l   #%11111,d7
                move.b  (a0,d7),d7
                lea     key_xy_4bpp_he(a5),a0
                adda.l  d6,a0
                adda.l  d6,a0
                move.w  (a0,d7),d7
                cmp.w   last_key(a5),d7
                beq     no_click_he
                cmp.w   #$ffff,last_key(a5)
                beq     key_invrsr_b_he
                move.l  keyboard_screen(a5),a0
                adda.w  last_key(a5),a0
                move.l  #12-1,d0
key_true_b_he   move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)+
                move.l  (a0),d6
                not.l   d6
                move.l  d6,(a0)
                adda.l  #120-8,a0
                dbra    d0,key_true_b_he
key_invrsr_b_he move.w  d7,last_key(a5)
key_invrs_b_he  move.l  keyboard_screen(a5),a0
                adda.l  d7,a0
                move.l  #12-1,d0
key_inv_b_he    move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)+
                move.l  (a0),d7
                not.l   d7
                move.l  d7,(a0)
                adda.l  #120-8,a0
                dbra    d0,key_inv_b_he
no_click_he
                rts

        data

;================================================
;Переменные

keys_matrix     dcb.b   4,0
keys_matrix2    dcb.b   4,0

key_line       ; dcb.b   120,0   ;$ff for LoRes
                dcb.b   120,$ff
                dcb.b   10,2
                dcb.b   10,44
                dcb.b   10,86
                dcb.b   10,128
                dcb.b   64,0    ;224 всего
      
key_line_he     dcb.b   128,$ff  ;$ff
                dcb.b   8,2
                dcb.b   8,44
                dcb.b   8,86
                dcb.b   8,128
                dcb.b   160,0    ;320 всего

key_column      dcb.b   16,2
                dcb.b   16,6
                dcb.b   16,10
                dcb.b   16,14
                dcb.b   16,18
                dcb.b   16,22
                dcb.b   16,26
                dcb.b   16,30
                dcb.b   16,34
                dcb.b   16,38   ;160 всего


key_data        dc.w    0,0
                dc.w    $41,4 ;1
                dc.w    $42,4 ;2
                dc.w    $44,4 ;3
                dc.w    $48,4 ;4
                dc.w    $50,4 ;5
                dc.w    $50,3 ;6
                dc.w    $48,3 ;7
                dc.w    $44,3 ;8
                dc.w    $42,3 ;9
                dc.w    $41,3 ;0
                dc.w    0
                dc.w    $41,5 ;Q
                dc.w    $42,5 ;W
                dc.w    $44,5 ;E
                dc.w    $48,5 ;R
                dc.w    $50,5 ;T
                dc.w    $50,2 ;Y
                dc.w    $48,2 ;U
                dc.w    $44,2 ;I
                dc.w    $42,2 ;O
                dc.w    $41,2 ;P
                dc.w    0
                dc.w    $41,6 ;A
                dc.w    $42,6 ;S
                dc.w    $44,6 ;D
                dc.w    $48,6 ;F
                dc.w    $50,6 ;G
                dc.w    $50,1 ;H
                dc.w    $48,1 ;J
                dc.w    $44,1 ;K
                dc.w    $42,1 ;L
                dc.w    $41,1 ;Enter
                dc.w    0
                dc.w    $41,7 ;Caps Shift
                dc.w    $42,7 ;Z
                dc.w    $44,7 ;X
                dc.w    $48,7 ;C
                dc.w    $50,7 ;V
                dc.w    $50,0 ;B
                dc.w    $48,0 ;N
                dc.w    $44,0 ;M
                dc.w    $42,0 ;Symbol Shift
                dc.w    $41,0 ;Space

keys_bloks      dc.b    0       ;0
                dc.b    0       ;1
                dc.b    16      ;2
                dc.b    0       ;3
                dc.b    32      ;4
                dc.b    0,0,0   ;5-7
                dc.b    48      ;8
                dcb.b   7,0     ;9-15
                dc.b    64,0    ;16

;======================================
;1bpp 320х320
key_xy_1bpp     dc.w    2436    ;Space
                dc.w    1636    ;Enter
                dc.w    836     ;P
                dc.w    36      ;0      
                dc.w    0       ;1       
                dc.w    800     ;Q     
                dc.w    1600    ;A     
                dc.w    2400    ;Caps Shift

                dc.w    2432    ;Symbol Shift
                dc.w    1632    ;L     
                dc.w    832     ;O     
                dc.w    32      ;9    
                dc.w    4       ;2    
                dc.w    804     ;W     
                dc.w    1604    ;S     
                dc.w    2404    ;Z    

                dc.w    2428    ;M
                dc.w    1628    ;K     
                dc.w    828     ;I     
                dc.w    28      ;8   
                dc.w    8       ;3    
                dc.w    808     ;E     
                dc.w    1608    ;D     
                dc.w    2408    ;X    

                dc.w    2424    ;N
                dc.w    1624    ;J     
                dc.w    824     ;U     
                dc.w    24      ;7   
                dc.w    12      ;4    
                dc.w    812     ;R     
                dc.w    1612    ;F     
                dc.w    2412    ;C    

                dc.w    2420    ;B
                dc.w    1620    ;H     
                dc.w    820     ;Y     
                dc.w    20      ;6   
                dc.w    16      ;5   
                dc.w    816     ;T     
                dc.w    1616    ;G     
                dc.w    2416    ;V    

;======================================
;4bpp 320х320
key_xy_4bpp     dc.w    9744    ;Space
                dc.w    6544    ;Enter
                dc.w    3344    ;P
                dc.w    144     ;0      
                dc.w    0       ;1       
                dc.w    3200    ;Q     
                dc.w    6400    ;A     
                dc.w    9600    ;Caps Shift

                dc.w    9728    ;Symbol Shift
                dc.w    6528    ;L     
                dc.w    3328    ;O     
                dc.w    128     ;9    
                dc.w    16      ;2    
                dc.w    3216    ;W     
                dc.w    6416    ;S     
                dc.w    9616    ;Z    

                dc.w    9712    ;M
                dc.w    6512    ;K     
                dc.w    3312    ;I     
                dc.w    112     ;8   
                dc.w    32      ;3    
                dc.w    3232    ;E     
                dc.w    6432    ;D     
                dc.w    9632    ;X    

                dc.w    9696    ;N
                dc.w    6496    ;J     
                dc.w    3296    ;U     
                dc.w    96      ;7   
                dc.w    48      ;4    
                dc.w    3248    ;R     
                dc.w    6448    ;F     
                dc.w    9648    ;C    

                dc.w    9680    ;B
                dc.w    6480    ;H     
                dc.w    3280    ;Y     
                dc.w    80      ;6   
                dc.w    64      ;5   
                dc.w    3264    ;T     
                dc.w    6464    ;G     
                dc.w    9664    ;V    

;======================================
;8bpp 320х320
key_xy_8bpp     dc.w    19488   ;Space
                dc.w    13088   ;Enter
                dc.w    6688    ;P
                dc.w    288     ;0      
                dc.w    0       ;1       
                dc.w    6400    ;Q     
                dc.w    12800   ;A     
                dc.w    19200   ;Caps Shift

                dc.w    19456   ;Symbol Shift
                dc.w    13056   ;L     
                dc.w    6656    ;O     
                dc.w    256     ;9    
                dc.w    32      ;2    
                dc.w    6432    ;W     
                dc.w    12832   ;S     
                dc.w    19232   ;Z    

                dc.w    19424   ;M
                dc.w    13024   ;K     
                dc.w    6624    ;I     
                dc.w    224     ;8   
                dc.w    64      ;3    
                dc.w    6464    ;E     
                dc.w    12864   ;D     
                dc.w    19264   ;X    

                dc.w    19392   ;N
                dc.w    12992   ;J     
                dc.w    6592    ;U     
                dc.w    192     ;7   
                dc.w    96      ;4    
                dc.w    6496    ;R     
                dc.w    12896   ;F     
                dc.w    19296   ;C    

                dc.w    19360   ;B
                dc.w    12960   ;H     
                dc.w    6560    ;Y     
                dc.w    160     ;6   
                dc.w    128     ;5   
                dc.w    6528    ;T     
                dc.w    12928   ;G     
                dc.w    19328   ;V    

;======================================
;1bpp 160х160
key_xy_1bpp_lr  dc.w    618     ;1236    ;Space
                dc.w    418     ;836     ;Enter
                dc.w    218     ;436     ;P
                dc.w    18      ;36      ;0      
                dc.w    0       ;0       ;1       
                dc.w    200     ;400     ;Q     
                dc.w    400     ;800     ;A     
                dc.w    600     ;1200    ;Caps Shift

                dc.w    616     ;1232    ;Symbos Shift
                dc.w    416     ;832     ;L     
                dc.w    216     ;432     ;O     
                dc.w    16      ;32      ;9    
                dc.w    2       ;4       ;2    
                dc.w    202     ;404     ;W     
                dc.w    402     ;804     ;S     
                dc.w    602     ;1204    ;Z    

                dc.w    614     ;1228    ;M
                dc.w    414     ;828     ;K     
                dc.w    214     ;428     ;I     
                dc.w    14      ;28      ;8   
                dc.w    4       ;8       ;3    
                dc.w    204     ;408     ;E     
                dc.w    404     ;808     ;D     
                dc.w    604     ;1208    ;X    

                dc.w    612     ;1224    ;N
                dc.w    412     ;824     ;J     
                dc.w    212     ;424     ;U     
                dc.w    12      ;24      ;7   
                dc.w    6       ;12      ;4    
                dc.w    206     ;412     ;R     
                dc.w    406     ;812     ;F     
                dc.w    606     ;1212    ;C    

                dc.w    610     ;1220    ;B
                dc.w    410     ;820     ;H     
                dc.w    210     ;420     ;Y     
                dc.w    10      ;20      ;6   
                dc.w    8       ;16      ;5   
                dc.w    208     ;416     ;T     
                dc.w    408     ;816     ;G     
                dc.w    608     ;1216    ;V    

;======================================
;2bpp 160х160
key_xy_2bpp_lr  dc.w    1236    ;Space
                dc.w    836     ;Enter
                dc.w    436     ;P
                dc.w    36      ;0      
                dc.w    0       ;1       
                dc.w    400     ;Q     
                dc.w    800     ;A     
                dc.w    1200    ;Caps Shift

                dc.w    1232    ;Symbos Shift
                dc.w    832     ;L     
                dc.w    432     ;O     
                dc.w    32      ;9    
                dc.w    4       ;2    
                dc.w    404     ;W     
                dc.w    804     ;S     
                dc.w    1204    ;Z    

                dc.w    1228    ;M
                dc.w    828     ;K     
                dc.w    428     ;I     
                dc.w    28      ;8   
                dc.w    8       ;3    
                dc.w    408     ;E     
                dc.w    808     ;D     
                dc.w    1208    ;X    

                dc.w    1224    ;N
                dc.w    824     ;J     
                dc.w    424     ;U     
                dc.w    24      ;7   
                dc.w    12      ;4    
                dc.w    412     ;R     
                dc.w    812     ;F     
                dc.w    1212    ;C    

                dc.w    1220    ;B
                dc.w    820     ;H     
                dc.w    420     ;Y     
                dc.w    20      ;6   
                dc.w    16      ;5   
                dc.w    416     ;T     
                dc.w    816     ;G     
                dc.w    1216    ;V    

;======================================
;4bpp 160х160
key_xy_4bpp_lr  dc.w    2472    ;Space
                dc.w    1672    ;Enter
                dc.w    872     ;P
                dc.w    72      ;0      
                dc.w    0       ;1       
                dc.w    800     ;Q     
                dc.w    1600    ;A     
                dc.w    2400    ;Caps Shift

                dc.w    2464    ;Symbol Shift
                dc.w    1664    ;L     
                dc.w    864     ;O     
                dc.w    64      ;9    
                dc.w    8       ;2    
                dc.w    808     ;W     
                dc.w    1608    ;S     
                dc.w    2408    ;Z    

                dc.w    2456    ;M
                dc.w    1656    ;K     
                dc.w    856     ;I     
                dc.w    56      ;8   
                dc.w    16      ;3    
                dc.w    816     ;E     
                dc.w    1616    ;D     
                dc.w    2416    ;X    

                dc.w    2448    ;N
                dc.w    1648    ;J     
                dc.w    848     ;U     
                dc.w    48      ;7   
                dc.w    24      ;4    
                dc.w    824     ;R     
                dc.w    1624    ;F     
                dc.w    2424    ;C    

                dc.w    2440    ;B
                dc.w    1640    ;H     
                dc.w    840     ;Y     
                dc.w    40      ;6   
                dc.w    32      ;5   
                dc.w    832     ;T     
                dc.w    1632    ;G     
                dc.w    2432    ;V    

;======================================
;8bpp 160х160
key_xy_8bpp_lr  dc.w    4944    ;Space
                dc.w    3344    ;Enter
                dc.w    1744    ;P
                dc.w    144     ;0      
                dc.w    0       ;1       
                dc.w    1600    ;Q     
                dc.w    3200    ;A     
                dc.w    4800    ;Caps Shift

                dc.w    4928    ;Symbol Shift
                dc.w    3328    ;L     
                dc.w    1728    ;O     
                dc.w    128     ;9    
                dc.w    16      ;2    
                dc.w    1616    ;W     
                dc.w    3216    ;S     
                dc.w    4816    ;Z    

                dc.w    4912    ;M
                dc.w    3312    ;K     
                dc.w    1712    ;I     
                dc.w    112     ;8   
                dc.w    32      ;3    
                dc.w    1632    ;E     
                dc.w    3232    ;D     
                dc.w    4832    ;X    

                dc.w    4896    ;N
                dc.w    3296    ;J     
                dc.w    1696    ;U     
                dc.w    96      ;7   
                dc.w    48      ;4    
                dc.w    1648    ;R     
                dc.w    3248    ;F     
                dc.w    4848    ;C    

                dc.w    4880    ;B
                dc.w    3280    ;H     
                dc.w    1680    ;Y     
                dc.w    80      ;6   
                dc.w    64      ;5   
                dc.w    1664    ;T     
                dc.w    3264    ;G     
                dc.w    4864    ;V    

;======================================
;1bpp 240х320
key_xy_1bpp_he  dc.w    1107    ;SP
                dc.w    747     ;EN
                dc.w    387     ;P
                dc.w    27      ;0      
                dc.w    0       ;1       
                dc.w    360     ;Q     
                dc.w    720     ;A     
                dc.w    1080    ;CS     

                dc.w    1104    ;SS
                dc.w    744     ;L     
                dc.w    384     ;O     
                dc.w    24      ;9    
                dc.w    3       ;2    
                dc.w    363     ;W     
                dc.w    723     ;S     
                dc.w    1083    ;Z    

                dc.w    1101    ;M
                dc.w    741     ;K     
                dc.w    381     ;I     
                dc.w    21      ;8   
                dc.w    6       ;3    
                dc.w    366     ;E     
                dc.w    726     ;D     
                dc.w    1086    ;X    

                dc.w    1098    ;N
                dc.w    738     ;J     
                dc.w    378     ;U     
                dc.w    18      ;7   
                dc.w    9       ;4    
                dc.w    369     ;R     
                dc.w    729     ;F     
                dc.w    1089    ;C    

                dc.w    1095    ;B
                dc.w    735     ;H     
                dc.w    375     ;Y     
                dc.w    15      ;6   
                dc.w    12      ;5   
                dc.w    372     ;T     
                dc.w    732     ;G     
                dc.w    1092    ;V    

;======================================
;4bpp 240х320
key_xy_4bpp_he  dc.w    4428    ;SP
                dc.w    2988    ;EN
                dc.w    1548    ;P
                dc.w    108     ;0      
                dc.w    0       ;1       
                dc.w    1440    ;Q     
                dc.w    2880    ;A     
                dc.w    4320    ;CS     

                dc.w    4416    ;SS
                dc.w    2976    ;L     
                dc.w    1536    ;O     
                dc.w    96      ;9    
                dc.w    12      ;2    
                dc.w    1452    ;W     
                dc.w    2892    ;S     
                dc.w    4332    ;Z    

                dc.w    4404    ;M
                dc.w    2964    ;K     
                dc.w    1524    ;I     
                dc.w    84      ;8   
                dc.w    24      ;3    
                dc.w    1464    ;E     
                dc.w    2904    ;D     
                dc.w    4344    ;X    

                dc.w    4392    ;N
                dc.w    2952    ;J     
                dc.w    1512    ;U     
                dc.w    72      ;7   
                dc.w    36      ;4    
                dc.w    1476    ;R     
                dc.w    2916    ;F     
                dc.w    4356    ;C    

                dc.w    4380    ;B
                dc.w    2940    ;H     
                dc.w    1500    ;Y     
                dc.w    60      ;6   
                dc.w    48      ;5   
                dc.w    1488    ;T     
                dc.w    2928    ;G     
                dc.w    4368    ;V    

        code
