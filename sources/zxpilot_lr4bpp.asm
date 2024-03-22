;==================================================
;Подпрограмма обновления изменений на экране
;вместе с бордюром в режиме LoRes 4bpp (16 градаций серого) - scale

;D0 - OK количество строк на экране
;D2 - OK количество линий в знакоместе
;D3 - OK цвет чернил
;D4 - OK временное хранение A4
;D5 - OK текущий байт экрана Спектрума
;D6 - OK подсчет суммы и кол-во знаков в строке
;D7 - OK подсчет суммы и цвет бумаги

;A0 - ОК адреса начал строк
;A1 - OK адреса строки атрибутов
;A2 - OK адреса контрольных сумм
;A3 - OK адрес атрибутов
;A4 - ОК сумма и ZX-palette
;A5 - ОК Palm_screen

                data

global          attributes.64
pixel_color1    dc.b    0
pixel_color2    dc.b    0
pixel_color3    dc.b    0
pixel_color4    dc.b    0
first_line      dc.l    0
second_line     dc.l    0

                code

scr_upd_lr4bpp  
                bsr     flash
                moveq   #0,d7
                move.b  border_color(a5),d7
                cmp.b   border_color1(a5),d7
                beq     no_brdr_chng_lr
                move.b  d7,border_color1(a5)
                lea     ZX_palette_bw(a5),a4
                move.b  (a4,d7),d6
                move.b  d6,d7
                lsl.w   #4,d7
                or.b    d6,d7
                lsl.w   #4,d7
                or.b    d6,d7
                lsl.w   #4,d7
                or.b    d6,d7
                lsl.l   #4,d7
                or.b    d6,d7
                lsl.l   #4,d7
                or.b    d6,d7
                lsl.l   #4,d7
                or.b    d6,d7
                lsl.l   #4,d7
                or.b    d6,d7
                move.l  palm_screen(a5),a1
                move.l  #240+2-1,d6
border1_lr      move.l  d7,(a1)+
                dbra    d6,border1_lr
                move.l  #96-1,d5
border2_lr      adda.w  #64,a1
                move.l  #4-1,d6
border3_lr      move.l  d7,(a1)+
                dbra    d6,border3_lr
                dbra    d5,border2_lr
                move.l  #240-2-1,d6                
border4_lr      move.l  d7,(a1)+
                dbra    d6,border4_lr
no_brdr_chng_lr move.l  a6,-(a7)
                move.l  zx_scr_tab(a5),a0
                move.l  zx_atr_tab(a5),a1
                lea     zx_scr_summ(a5),a2
                lea     ZX_palette_bw(a5),a4
                move.l  palm_screen1(a5),a6
                move.l  #23,d0
nxt_ln_col_lr   move.l  d0,-(a7)
                moveq.l #0,d7
                move.l  #7,d6
                move.l  a4,d4           ;В a0 адреса начал строк
scr_chng_col_lr move.l  (a0)+,a4
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                dbra    d6,scr_chng_col_lr
                move.l  (a1)+,a4        ;В а1 адреса строки атрибутов
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                move.l  d4,a4
                move.l  (a2)+,d6        ;В а2 адреса контрольных сумм
                cmp.l   d7,d6
                bne     znakoryad_lr
                adda.l  #320,a6
                bra     the_end_lr
;___________
;Рисуем знакоместный ряд
;В a0 таблица адрес начала строки
;В а1 таблица адрес строки атрибутов
;В а2 таблица контрольных сумм
;В а4 ZX-Palette                
;В а6 palm_screen

znakoryad_lr    subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1
                suba    #4,a1
                suba    #32,a0
                lea     attributes(a5),a2
                move.l  (a1)+,a3        ;Соответствующая ей строка атрибутов

                move.l  #32-1,d0                


ink_and_pap_lr  move.b  (a3)+,d7

                move.b  d7,d3
                move.b  d7,d5
                move.b  d7,d2

                lsr.b   #3,d7
                and.b   #%1000,d7
                and.b   #%0111,d3
                or      d7,d3           
                and.l   #%1111,d3
                move.b  (a4,d3),d3      ;в d3 имеем цвет чернил      
                lsr.b   #3,d5
                and.l   #%1111,d5
                move.b  (a4,d5),d7      ;в d7 имеем цвет бумаги

                and.b   #$80,d2
                beq     ink_n_pap_lr1_1
                cmp.b   #$ff,flash_mask(a5)
                beq     ink_n_pap_lr1_1
                move.b  d7,(a2)+
                move.b  d3,(a2)+
                bra     ink_n_pap_lr1_2
ink_n_pap_lr1_1 move.b  d3,(a2)+
                move.b  d7,(a2)+
ink_n_pap_lr1_2

                dbra    d0,ink_and_pap_lr

                move.l  d1,a2
                move.l  #4-1,d2
line_update_lr  lea     attributes(a5),a3
                move.l  (a0)+,a2        ;Адрес строки в экране
                move.l  a2,first_line(a5)
                move.l  (a0)+,a2
                move.l  a2,second_line(a5)
                move.l  #32-1,d6

byte_update_lr  move.b  (a3)+,d3


                move.b  (a3)+,d7


                move.l  first_line(a5),a2
                move.b  (a2)+,d5
                move.l  a2,first_line(a5)
                add.b   d5,d5
                bcs     c_1_lr
                move.b  d7,pixel_color1(a5)
                bra     b_1_lr
c_1_lr          move.b  d3,pixel_color1(a5)
b_1_lr          add.b   d5,d5
                bcs     c_2_lr
                add.b   d7,pixel_color1(a5)
                bra     b_2_lr
c_2_lr          add.b   d3,pixel_color1(a5)
b_2_lr          add.b   d5,d5
                bcs     c_3_lr
                move.b  d7,pixel_color2(a5)
                bra     b_3_lr
c_3_lr          move.b  d3,pixel_color2(a5)
b_3_lr          add.b   d5,d5
                bcs     c_4_lr
                add.b   d7,pixel_color2(a5)
                bra     b_4_lr
c_4_lr          add.b   d3,pixel_color2(a5)
b_4_lr          add.b   d5,d5
                bcs     c_5_lr
                move.b  d7,pixel_color3(a5)
                bra     b_5_lr
c_5_lr          move.b  d3,pixel_color3(a5)
b_5_lr          add.b   d5,d5
                bcs     c_6_lr
                add.b   d7,pixel_color3(a5)
                bra     b_6_lr
c_6_lr          add.b   d3,pixel_color3(a5)
b_6_lr          add.b   d5,d5
                bcs     c_7_lr
                move.b  d7,pixel_color4(a5)
                bra     b_7_lr
c_7_lr          move.b  d3,pixel_color4(a5)
b_7_lr          add.b   d5,d5
                bcs     c_8_lr
                add.b   d7,pixel_color4(a5)
                bra     b_8_lr
c_8_lr          add.b   d3,pixel_color4(a5)
b_8_lr          move.l  second_line(a5),a2      ;Берем байт из следующей строки
                move.b  (a2)+,d5
                move.l  a2,second_line(a5)
                add.b   d5,d5
                bcs     c_12_lr
                add.b   d7,pixel_color1(a5)
                bra     b_12_lr
c_12_lr         add.b   d3,pixel_color1(a5)
b_12_lr         add.b   d5,d5
                bcs     c_22_lr
                add.b   d7,pixel_color1(a5)
                bra     b_22_lr
c_22_lr         add.b   d3,pixel_color1(a5)
b_22_lr         add.b   d5,d5
                bcs     c_32_lr
                add.b   d7,pixel_color2(a5)
                bra     b_32_lr
c_32_lr         add.b   d3,pixel_color2(a5)
b_32_lr         add.b   d5,d5
                bcs     c_42_lr
                add.b   d7,pixel_color2(a5)
                bra     b_42_lr
c_42_lr         add.b   d3,pixel_color2(a5)
b_42_lr         add.b   d5,d5
                bcs     c_52_lr
                add.b   d7,pixel_color3(a5)
                bra     b_52_lr
c_52_lr         add.b   d3,pixel_color3(a5)
b_52_lr         add.b   d5,d5
                bcs     c_62_lr
                add.b   d7,pixel_color3(a5)
                bra     b_62_lr
c_62_lr         add.b   d3,pixel_color3(a5)
b_62_lr         add.b   d5,d5
                bcs     c_72_lr
                add.b   d7,pixel_color4(a5)
                bra     b_72_lr
c_72_lr         add.b   d3,pixel_color4(a5)
b_72_lr         add.b   d5,d5
                bcs     c_82_lr
                add.b   d7,pixel_color4(a5)
                bra     b_82_lr
c_82_lr         add.b   d3,pixel_color4(a5)

b_82_lr         move.b  pixel_color1(a5),d7
                lsl.b   #2,d7
                and.b   #$f0,d7
                move.b  pixel_color2(a5),d3
                lsr.b   #2,d3
                and.b   #$0f,d3
                or.b    d3,d7
                move.b  d7,(a6)+
                move.b  pixel_color3(a5),d7
                lsl.b   #2,d7
                and.b   #$f0,d7
                move.b  pixel_color4(a5),d3
                lsr.b   #2,d3
                and.b   #$0f,d3
                or.b    d3,d7
                move.b  d7,(a6)+

                dbra    d6,byte_update_lr
                adda    #16,a6
                dbra    d2,line_update_lr
                move.l  d1,a2
the_end_lr      move.l  (a7)+,d0
                dbra    d0,nxt_ln_col_lr
                move.l  (a7)+,a6
                rts
