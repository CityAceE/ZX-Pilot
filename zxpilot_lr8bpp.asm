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

;Те же переменные в файле zxpilot_lr4bpp.asm
;                data
;global          attributes.64
;pixel_color1    dc.b    0
;pixel_color2    dc.b    0
;pixel_color3    dc.b    0
;pixel_color4    dc.b    0
;first_line      dc.l    0
;second_line     dc.l    0
;                code

scr_upd_lr8bpp  
                bsr     flash

                moveq   #0,d7
                move.b  border_color(a5),d7
                cmp.b   border_color1(a5),d7
                beq     no_b_chng_lr2
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
                move.l  #480+4-1,d6
border1_lr2     move.l  d7,(a1)+
                dbra    d6,border1_lr2
                move.l  #95-1,d5
border2_lr2     adda.w  #128,a1
                move.l  #8-1,d6
border3_lr2     move.l  d7,(a1)+
                dbra    d6,border3_lr2
                dbra    d5,border2_lr2
                adda.w  #128,a1
                move.l  #4+480-1,d6
border4_lr2     move.l  d7,(a1)+
                dbra    d6,border4_lr2

no_b_chng_lr2   move.l  a6,-(a7)
                move.l  zx_scr_tab(a5),a0
                move.l  zx_atr_tab(a5),a1
                lea     zx_scr_summ(a5),a2
                lea     ZX_palette_lr(a5),a4
                move.l  palm_screen1(a5),a6

                move.l  #23,d0
nxt_ln_col_lr2  move.l  d0,-(a7)
                moveq.l #0,d7
                move.l  #7,d6

                move.l  a4,d4           ;В a0 адреса начал строк
scr_chng_cl_lr2 move.l  (a0)+,a4
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                add.l   (a4)+,d7
                dbra    d6,scr_chng_cl_lr2

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
                move.l  (a2)+,d6        ;В а2 адреса контольных сумм
                cmp.l   d7,d6
                bne     znakoryad_lr2
                adda.l  #640,a6
                bra     the_end_lr2
;___________
;Рисуем знакоместный ряд
;В a0 таблица адрес начала строки
;В а1 таблица адрес строки атрибутов
;В а2 таблица контрольных сумм
;В а4 ZX-Palette                
;В а6 palm_screen

znakoryad_lr2   subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1
                suba    #4,a1
                suba    #32,a0
                lea     attributes(a5),a2
                move.l  (a1)+,a3        ;Соответствующая ей строка атрибутов

                move.l  #32-1,d0                
ink_and_pap_lr2 move.b  (a3)+,d7
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
                beq     ink_n_pap_lr2_1
                cmp.b   #$ff,flash_mask(a5)
                beq     ink_n_pap_lr2_1
                move.b  d7,(a2)+
                move.b  d3,(a2)+
                bra     ink_n_pap_lr2_2
ink_n_pap_lr2_1 move.b  d3,(a2)+
                move.b  d7,(a2)+
ink_n_pap_lr2_2
                dbra    d0,ink_and_pap_lr2

                move.l  d1,a2

                move.l  #4-1,d2
line_update_lr2 lea     attributes(a5),a3
                move.l  (a0)+,a2        ;Адрес строки в экране
                move.l  a2,first_line(a5)
                move.l  (a0)+,a2
                move.l  a2,second_line(a5)

                move.l  #32-1,d6
byte_update_lr2 move.b  (a3)+,d3
                move.b  (a3)+,d7

                move.b  d3,bright(a5)
                and.b   #%1111111,d3
                and.b   #%1111111,d7

                move.l  first_line(a5),a2
                move.b  (a2)+,d5
                move.l  a2,first_line(a5)

;Кладём в ячейку pixel_color1 цвет первой точки экрана Спектрума

                add.b   d5,d5
                bcs     c_1_lr2
                move.b  d7,pixel_color1(a5)
                bra     b_1_lr2
c_1_lr2         move.b  d3,pixel_color1(a5)


;Прибавляем к первой точке цвет второй точки

b_1_lr2         add.b   d5,d5
                bcs     c_2_lr2
                add.b   d7,pixel_color1(a5)
                bra     b_2_lr2
c_2_lr2         add.b   d3,pixel_color1(a5)

;Кладём в ячейку pixel_color2 цвет третьей точки экрана Спектрума

b_2_lr2         add.b   d5,d5
                bcs     c_3_lr2
                move.b  d7,pixel_color2(a5)
                bra     b_3_lr2
c_3_lr2         move.b  d3,pixel_color2(a5)

;Прибавляем к третьей точке цвет четвёртой точки

b_3_lr2         add.b   d5,d5
                bcs     c_4_lr2
                add.b   d7,pixel_color2(a5)
                bra     b_4_lr2
c_4_lr2         add.b   d3,pixel_color2(a5)

b_4_lr2         add.b   d5,d5
                bcs     c_5_lr2
                move.b  d7,pixel_color3(a5)
                bra     b_5_lr2
c_5_lr2         move.b  d3,pixel_color3(a5)

b_5_lr2         add.b   d5,d5
                bcs     c_6_lr2
                add.b   d7,pixel_color3(a5)
                bra     b_6_lr2
c_6_lr2         add.b   d3,pixel_color3(a5)

b_6_lr2         add.b   d5,d5
                bcs     c_7_lr2
                move.b  d7,pixel_color4(a5)
                bra     b_7_lr2
c_7_lr2         move.b  d3,pixel_color4(a5)

b_7_lr2         add.b   d5,d5
                bcs     c_8_lr2
                add.b   d7,pixel_color4(a5)
                bra     b_8_lr2
c_8_lr2         add.b   d3,pixel_color4(a5)

b_8_lr2         move.l  second_line(a5),a2      ;Берем байт из следующией строки
                move.b  (a2)+,d5
                move.l  a2,second_line(a5)

                add.b   d5,d5
                bcs     c_12_lr2
                add.b   d7,pixel_color1(a5)
                bra     b_12_lr2
c_12_lr2        add.b   d3,pixel_color1(a5)

b_12_lr2        add.b   d5,d5
                bcs     c_22_lr2
                add.b   d7,pixel_color1(a5)
                bra     b_22_lr2
c_22_lr2        add.b   d3,pixel_color1(a5)

b_22_lr2        add.b   d5,d5
                bcs     c_32_lr2
                add.b   d7,pixel_color2(a5)
                bra     b_32_lr2
c_32_lr2        add.b   d3,pixel_color2(a5)

b_32_lr2        add.b   d5,d5
                bcs     c_42_lr2
                add.b   d7,pixel_color2(a5)
                bra     b_42_lr2
c_42_lr2        add.b   d3,pixel_color2(a5)

b_42_lr2        add.b   d5,d5
                bcs     c_52_lr2
                add.b   d7,pixel_color3(a5)
                bra     b_52_lr2
c_52_lr2        add.b   d3,pixel_color3(a5)

b_52_lr2        add.b   d5,d5
                bcs     c_62_lr2
                add.b   d7,pixel_color3(a5)
                bra     b_62_lr2
c_62_lr2        add.b   d3,pixel_color3(a5)

b_62_lr2        add.b   d5,d5
                bcs     c_72_lr2
                add.b   d7,pixel_color4(a5)
                bra     b_72_lr2
c_72_lr2        add.b   d3,pixel_color4(a5)

b_72_lr2        add.b   d5,d5
                bcs     c_82_lr2
                add.b   d7,pixel_color4(a5)
                bra     b_82_lr2
c_82_lr2        add.b   d3,pixel_color4(a5)


;В ячейках pixel_color1-4 цвета стоящих рядом 4-х точек

b_82_lr2        

                move.l  a2,d7
                btst.b  #7,bright(a5)
                beq     b_82_lr2_1

                lea     ZX_palette_sc_b(a5),a2
                bra     b_82_lr2_2
b_82_lr2_1
                lea     ZX_palette_sc(a5),a2
b_82_lr2_2
                move.b  pixel_color1(a5),d3
                move.b  (a2,d3),(a6)+
                move.b  pixel_color2(a5),d3
                move.b  (a2,d3),(a6)+
                move.b  pixel_color3(a5),d3
                move.b  (a2,d3),(a6)+
                move.b  pixel_color4(a5),d3
                move.b  (a2,d3),(a6)+

                move.l  d7,a2

                dbra    d6,byte_update_lr2
                adda    #32,a6
                dbra    d2,line_update_lr2
                move.l  d1,a2
the_end_lr2     move.l  (a7)+,d0
                dbra    d0,nxt_ln_col_lr2
                move.l  (a7)+,a6
                rts

        data

ZX_palette_lr
                dc.b    0       ;0   Чёрный
                dc.b    1       ;1   Синий
                dc.b    5       ;2   Красный
                dc.b    6       ;3   Фиолетовый
                dc.b    25      ;4   Зелёный
                dc.b    26      ;5   Голубой
                dc.b    30      ;6   Жёлтый
                dc.b    31      ;7   Белый

                dc.b    0+128       ;8   Яркий чёрный
                dc.b    1+128       ;9   Яркий синий
                dc.b    5+128       ;10  Яркий красный
                dc.b    6+128       ;11  Яркий фиолетовый
                dc.b    25+128      ;12  Яркий зелёный
                dc.b    26+128      ;13  Яркий голубой
                dc.b    30+128      ;14  Яркий жёлтый
                dc.b    31+128      ;15  Яркий белый

ZX_palette_sc                   ;Палитра для выключенной яркости
                dc.b    255
                dc.b    209
                dc.b    203
                dc.b    107
                dc.b    101
                dc.b    197
                dc.b    191
                dc.b    255
                dc.b    89
                dc.b    83
                dc.b    179
                dc.b    255
                dc.b    167
                dc.b    255
                dc.b    65
                dc.b    161
                dc.b    155
                dc.b    255
                dc.b    53
                dc.b    47
                dc.b    143
                dc.b    137
                dc.b    131
                dc.b    35
                dc.b    29
                dc.b    214
                dc.b    208
                dc.b    255
                dc.b    106
                dc.b    100
                dc.b    196
                dc.b    190
                dc.b    255
                dc.b    88
                dc.b    82
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    160
                dc.b    154
                dc.b    255
                dc.b    52
                dc.b    46
                dc.b    142
                dc.b    136
                dc.b    255
                dc.b    34
                dc.b    28
                dc.b    213
                dc.b    255
                dc.b    201
                dc.b    255
                dc.b    99
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    177
                dc.b    255
                dc.b    165
                dc.b    255
                dc.b    63
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    141
                dc.b    255
                dc.b    129
                dc.b    255
                dc.b    27
                dc.b    212
                dc.b    206
                dc.b    255
                dc.b    104
                dc.b    98
                dc.b    194
                dc.b    188
                dc.b    255
                dc.b    86
                dc.b    80
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    158
                dc.b    152
                dc.b    255
                dc.b    50
                dc.b    44
                dc.b    140
                dc.b    134
                dc.b    255
                dc.b    32
                dc.b    26
                dc.b    211
                dc.b    205
                dc.b    199
                dc.b    103
                dc.b    97
                dc.b    193
                dc.b    187
                dc.b    255
                dc.b    85
                dc.b    79
                dc.b    175
                dc.b    255
                dc.b    163
                dc.b    255
                dc.b    61
                dc.b    157
                dc.b    151
                dc.b    255
                dc.b    49
                dc.b    43
                dc.b    139
                dc.b    133
                dc.b    127
                dc.b    31
                dc.b    25
                dc.b    255
ZX_palette_sc_b                 ;Палитра для включенной яркости
                dc.b    255
                dc.b    203
                dc.b    107
                dc.b    101
                dc.b    95
                dc.b    179
                dc.b    167
                dc.b    255
                dc.b    65
                dc.b    59
                dc.b    161
                dc.b    255
                dc.b    53
                dc.b    255
                dc.b    41
                dc.b    143
                dc.b    131
                dc.b    255
                dc.b    29
                dc.b    23
                dc.b    125
                dc.b    113
                dc.b    17
                dc.b    11
                dc.b    5
                dc.b    213
                dc.b    201
                dc.b    255
                dc.b    99
                dc.b    93
                dc.b    177
                dc.b    165
                dc.b    255
                dc.b    63
                dc.b    57
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    141
                dc.b    129
                dc.b    255
                dc.b    27
                dc.b    21
                dc.b    123
                dc.b    111
                dc.b    255
                dc.b    9
                dc.b    3
                dc.b    212
                dc.b    255
                dc.b    104
                dc.b    255
                dc.b    92
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    158
                dc.b    255
                dc.b    50
                dc.b    255
                dc.b    38
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    122
                dc.b    255
                dc.b    14
                dc.b    255
                dc.b    2
                dc.b    211
                dc.b    199
                dc.b    255
                dc.b    97
                dc.b    91
                dc.b    175
                dc.b    163
                dc.b    255
                dc.b    61
                dc.b    55
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    255
                dc.b    139
                dc.b    127
                dc.b    255
                dc.b    25
                dc.b    19
                dc.b    121
                dc.b    109
                dc.b    255
                dc.b    7
                dc.b    1
                dc.b    210
                dc.b    198
                dc.b    102
                dc.b    96
                dc.b    90
                dc.b    174
                dc.b    162
                dc.b    255
                dc.b    60
                dc.b    54
                dc.b    156
                dc.b    255
                dc.b    48
                dc.b    255
                dc.b    36
                dc.b    138
                dc.b    126
                dc.b    255
                dc.b    24
                dc.b    18
                dc.b    120
                dc.b    108
                dc.b    12
                dc.b    6
                dc.b    0
                dc.b    255

bright          dc.b    0       ;Яркость (bright) для текущего оттрибута
                dc.b    0 

        code