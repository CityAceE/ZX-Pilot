;==================================================
;Подпрограмма обновления изменений на экране
;в режиме HE330 4bpp (16 градаций серого)

;D0 - OK количество строк на экране
;D2 - OK количество линий в знакоместе
;D3 - OK цвет чернил
;D4 - OK временное хранение A4
;D5 - OK текущий байт экрана Спектурма
;D6 - OK подсчет суммы и кол-во знаков в строке
;D7 - OK подсчет суммы и цвет бумаги

;A0 - ОК адреса начал строк
;A1 - OK адреса строки атрибутов
;A2 - OK адреса контрольных сумм
;A3 - OK адрес атрибутов
;A4 - ОК сумма и ZX-palette
;A5 - ОК Palm_screen
                
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
                move.l  a4,d4   ;В a0 адреса начал строк
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
                move.l  (a1)+,a4        ;В а1 адреса строки атрибутов
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
;Рисуем знакоместный ряд
;В a0 таблица адрес начала строки
;В а1 таблица адрес строки атрибутов
;В а2 таблица контрольных сумм
;В а4 ZX-Palette                
;В а6 palm_screen

znakoryad_gr_he subq.l  #4,a2
                move.l  d7,(a2)+
                move.l  a2,d1   ;Сохранили адрес суммы
                suba    #4,a1
                suba    #32,a0
                move.l  (a0),a2        ;Адрес первой линии знаколинии 
                add.w   shift(a5),a2
                adda.w  #32,a0
                move.l  (a1)+,a3       ;Соответствующая ей строка атрибутов
                add.w   shift(a5),a3
                move.l  a0,d2   ;Запомнили адрес таблицы
                move.l  palitra(a5),a4  ;Обновляем знаколинию
                moveq   #30-1,d6
                moveq   #$1e,d7
line_upd_gr_he  moveq  #0,d5
                move.b (a3)+,d5      ; возьмём очередной атрибут

                and.b   flash_mask(a5),d5
                lsl.w  #5,d5
                lea    (a4,d5.w),a0  ; перейдём к конкретным 32ум байтам

                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                adda.w  #118,a6
                adda.w  #256,a2
                move.b  (a2),d5 ; обновление одного байта спековского экрана в 8 байт
                lsr.w   #3,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)+   ; обновим первые четыре бита на 256ом экране
                move.b  (a2),d5
                lsl.w   #1,d5
                and.w   d7,d5
                move.w  (a0,d5.w),(a6)    ; обновим другие четыре бита на 256ом экране
                suba.w  #838,a6
                suba.w  #1791,a2
                dbra    d6,line_upd_gr_he
                adda.w  #840,a6
                move.l  d2,a0   ;Вспомнили адрес таблицы
                move.l  d1,a2   ;Вспомнили адрес суммы
the_end_gr_he   dbra    d0,next_line_gr_he
                move.l  d3,a6

                rts