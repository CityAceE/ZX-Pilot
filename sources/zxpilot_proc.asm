;Разные процедуры и подпрограммы:
;HiRes_on
;flash
;hex2ascii
;palette_4bpp
;palette_8bpp

;=============================================

HiRes_off
                ;А это вообще CLIE?
                systrap FtrGet(#$536f4e79.l, #1.w, &sonyHiResRefNum(a5).l)
                tst.l   d0              ;если не ноль, то это
                bne     no_hires        ;не Cони!
                ;А доступен ли HiRes?
                moveq   #1,d0
                movea.l sonyHiResRefNum(a5),a0
                and.l   8(a0),d0
                beq     no_hires        ;Режим HiRes не доступен на этой Соне

                ;Ищем библиотеку HiRes
                systrap SysLibFind(&sonySysLibNameHR(a5).l, &sonyHiResRefNum(a5).l)
                tst.w   d0
                beq     HiRes_off_1       ;HiRes доступен
                cmpi.w  #$050a,d0       ;error == sysErrLibNotFound)
                beq     no_hires        ;Такой библиотеки нет!

HiRes_off_1
                move.l  #160,temp(a5)
                systrap HRWinScreenMode (sonyHiResRefNum(a5).w, #winScreenModeSet.b, &temp(a5).l, &temp(a5).l, #0.l, #0.l)
;                systrap HRWinScreenMode(sonyHiResRefNum(a5).w,#winScreenModeSetToDefaults.b, #0.l, #0.l, #0.l, #0.l)
                systrap HRClose(sonyHiResRefNum(a5).w)
                move.b  #0,HiRes(a5)
                rts
;----------------------------------------------
;Проверка и установка HiRes
;(было HiRes_detect)
                
HiRes_on        
                ;А это вообще CLIE?
                systrap FtrGet(#$536f4e79.l, #1.w, &sonyHiResRefNum(a5).l)
                tst.l   d0              ;если не ноль, то это
                bne     no_hires        ;не Cони!
                ;А доступен ли HiRes?
                moveq   #1,d0
                movea.l sonyHiResRefNum(a5),a0
                and.l   8(a0),d0
                beq     no_hires        ;Режим HiRes не доступен на этой Соне

                ;Ищем библиотеку HiRes
                systrap SysLibFind(&sonySysLibNameHR(a5).l, &sonyHiResRefNum(a5).l)
                tst.w   d0
                beq     hires_ava       ;HiRes доступен
                cmpi.w  #$050a,d0       ;error == sysErrLibNotFound)
                beq     no_hires        ;Такой библиотеки нет!
                ;Загружаем библиотеку HiRes, если она не загружена
                systrap SysLibLoad(#$6c696272.l, #$536c4872.l, &sonyHiResRefNum(a5).l)
                tst.w   d0
                bne     no_hires
                ;-------------------
                ;CLIE HiRes доступен
hires_ava       
                systrap HROpen(sonyHiResRefNum(a5).w)
                move.l  #320,temp(a5)
                systrap HRWinScreenMode (sonyHiResRefNum(a5).w, #winScreenModeSet.b, &temp(a5).l, &temp(a5).l, #0.l, #0.l)

;                systrap  HRClose(sonyHiResRefNum(a5).w)
hires_ava1
                move.b  #1,HiRes(a5)
                rts

no_hires        

;--------------------------------------------
;Определение выского разрешения для Palm OS 5
                systrap FtrGet(#$70737973.l,#24.w,&temp(a5))
                tst.w   d0
                bne     no_hires1

                moveq   #4,d0
                cmp.l   temp(a5),d0
                bhi     no_hires1

                ;WinScreenGetAttribute(winScreenDensity, &attr)
                ;systrap WinScreenGetAttribute(#winScreenDensity.b, &temp(a5))
                
                moveq   #14,d2  ;Подпорка получена дизассемблированием
                systrap WinScreenGetAttribute(#5.b, &temp(a5))
                cmp.l   #144.b,temp(a5) ;kDensityDouble = 144
                beq     hires_ava1
no_hires1
;--------------------------------------------

                move.b  #0,HiRes(a5)    ;CLIE HiRes не доступен
                rts

;=========================================
;Мигалка
flash           subq.b  #1,flash_count(a5)
                bne     no_flash
                move.b  #16,flash_count(a5)
                eor.b   #%10000000,flash_mask(a5)
                lea     zx_scr_summ(a5),a0
                move.l  zx_atr(a5),a1
                move.l  #24-1,d2
no_flash3       moveq.l #8-1,d1
no_flash2       move.l  (a1)+,d0
                and.l   #$80808080,d0
                beq     no_flash1
                move.l  #-1,(a0)
no_flash1       dbra    d1,no_flash2
                addq.l  #4,a0
                dbra    d2,no_flash3
no_flash        rts

;==============================================
;Подпрограмма перевода HEX-числа в ASCII стринг
;Input d1.l - hex number
;Input a4.l - string pointer

hex2ascii       move.l  #7,d2
next_nibble     move.l  #0,d0
                asl.l   #1,d1
                roxl.l  #1,d0
                asl.l   #1,d1
                roxl.l  #1,d0
                asl.l   #1,d1
                roxl.l  #1,d0
                asl.l   #1,d1
                roxl.l  #1,d0
                cmp.b   #$a,d0
                bcs     adder
                add.b   #7,d0
adder           add.b   #$30,d0
                move.b  d0,(a4)+
                dbra    d2,next_nibble
                rts


;====================================================
;Подпрограммы построения таблиц цвета для разных цветовых режимов
;Разворачиваем палитру для 4bpp

palette_4bpp    move.l  palitra(a5),a3
                lea     ZX_palette_bw(a5),a4
                moveq.l #0,d3
                moveq.l #0,d5
                moveq.l #0,d7
                moveq.l #0,d1
next_attrib_gr  move.b  d1,d7
                btst    #7,d1
                beq     swaper2
                and.b   #%11000000,d7
                move.b  d1,d3
                lsr.b   #3,d3
                and.b   #%111,d3
                or.b    d3,d7
                move.b  d1,d3
                lsl.b   #3,d3
                and.b   #%111000,d3
                or.b    d3,d7
swaper2         move.b  d7,d3
                move.b  d3,d5
                lsr.b   #3,d7
                and.b   #%1000,d7
                and.b   #%0111,d3
                or      d7,d3
                and.l   #%1111,d3
                move.b  (a4,d3),d3      ;в d3 имеем цвет чернил
                lsr.b   #3,d5
                and.l   #%1111,d5
                move.b  (a4,d5),d7      ;в d7 имеем цвет бумаги
                moveq.l #0,d2
pal_nibble_gr   move.b  d2,d0
                lsl.b   #5,d0
                bcs     iapgr1
                move.b  d7,d6
                bra     paigr1
iapgr1          move.b  d3,d6
paigr1          lsl.b   #4,d6
                lsl.b   #1,d0
                bcs     iapgr2
                or.b    d7,d6
                bra     paigr2
iapgr2          or.b    d3,d6
paigr2          move.b  d6,(a3)+
                lsl.b   #1,d0
                bcs     iapgr3
                move.b  d7,d6
                bra     paigr3
iapgr3          move.b  d3,d6
paigr3          lsl.b   #4,d6
                lsl.b   #1,d0
                bcs     iapgr4
                or.b    d7,d6
                bra     paigr4
iapgr4          or.b    d3,d6
paigr4          move.b  d6,(a3)+
                addq.b  #1,d2
                cmp.b   #16,d2
                bne     pal_nibble_gr
                addq.b  #1,d1
                bcc     next_attrib_gr
                rts

;Разворачиваем палитру для 8bpp
;color_enable    
                
palette_8bpp    move.l  palitra(a5),a3
                lea     ZX_palette(a5),a4
                moveq.l #0,d3
                moveq.l #0,d5
                moveq.l #0,d7
                moveq.l #0,d1
next_attrib     move.b  d1,d7
                btst    #7,d1
                beq     swaper1
                and.b   #%11000000,d7
                move.b  d1,d3
                lsr.b   #3,d3
                and.b   #%111,d3
                or.b    d3,d7
                move.b  d1,d3
                lsl.b   #3,d3
                and.b   #%111000,d3
                or.b    d3,d7
swaper1         move.b  d7,d3
                move.b  d3,d5

                lsr.b   #3,d7
                and.b   #%1000,d7
                and.b   #%0111,d3
                or      d7,d3
                and.l   #%1111,d3
                move.b  (a4,d3),d3      ;в d3 имеем цвет чернил
                lsr.b   #3,d5
                and.l   #%1111,d5
                move.b  (a4,d5),d7      ;в d7 имеем цвет бумаги
                moveq.l #0,d2
pal_nibble      move.b  d2,d0
                lsl.b   #5,d0
                bcs     iap1
                move.b  d7,(a3)+
                bra     pai1
iap1            move.b  d3,(a3)+
pai1            lsl.b   #1,d0
                bcs     iap2
                move.b  d7,(a3)+
                bra     pai2
iap2            move.b  d3,(a3)+
pai2            lsl.b   #1,d0
                bcs     iap3
                move.b  d7,(a3)+
                bra     pai3
iap3            move.b  d3,(a3)+
pai3            lsl.b   #1,d0
                bcs     iap4
                move.b  d7,(a3)+
                bra     pai4
iap4            move.b  d3,(a3)+
pai4            addq.b  #1,d2
                cmp.b   #16,d2
                bne     pal_nibble
                addq.b  #1,d1
                bcc     next_attrib
                rts

;====================================
;Установка требуемого ражима экрана
;на выходе d0=0 - переключение произошло успешно
;на выходе d1=$ff - переключения не произошло

mode_he4bpp
                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off
                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #240,temp1(a5)
                bne     mode_off
                bsr     palette_4bpp                
                move.b  #he4bpp,scr_mode(a5)
                bra     mode_on

mode_he1bpp
                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off
                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #240,temp1(a5)
                bne     mode_off
                move.b  #he1bpp,scr_mode(a5)
                bra     mode_on

mode_hr8bpp
                bsr     HiRes_on
                move.l  #8,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off

                cmp.b   #1,HiRes(a5)
                beq     mode_hr8bpp_1

                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #320,temp1(a5)
                bne     mode_off
mode_hr8bpp_1
                bsr     palette_8bpp                
                move.b  #hr8bpp,scr_mode(a5)
                bra     mode_on

mode_hr4bpp
                cmp.b   #1,arm(a5)
                beq     mode_off

                bsr     HiRes_on
                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off

                cmp.b   #1,HiRes(a5)
                beq     mode_hr4bpp_1

                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)

                cmp.l   #320,temp1(a5)
                bne     mode_off
mode_hr4bpp_1
                bsr     palette_4bpp                
                move.b  #hr4bpp,scr_mode(a5)
                bra     mode_on

mode_hr1bpp
                cmp.b   #1,arm(a5)
                beq     mode_off

                bsr     HiRes_on
                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off

                cmp.b   #1,HiRes(a5)
                beq     mode_hr1bpp_1

                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #320,temp1(a5)
                bne     mode_off

mode_hr1bpp_1
;                bsr     palette_4bpp                
                move.b  #hr1bpp,scr_mode(a5)
                bra     mode_on

mode_lr8bpp
                bsr     HiRes_off
                cmp.b   #1,HiRes(a5)
                beq     mode_off

                move.l  #8,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off
                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #160,temp1(a5)
                bne     mode_off
                bsr     palette_8bpp                
                move.b  #lr8bpp,scr_mode(a5)
                bra     mode_on

mode_lr4bpp
                cmp.b   #1,arm(a5)
                beq     mode_off

                bsr     HiRes_off
                cmp.b   #1,HiRes(a5)
                beq     mode_off

                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off

                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #160,temp1(a5)
                bne     mode_off
                bsr     palette_4bpp                
                move.b  #lr4bpp,scr_mode(a5)
                bra     mode_on

mode_lr2bpp
                cmp.b   #1,arm(a5)
                beq     mode_off

                bsr     HiRes_off
                cmp.b   #1,HiRes(a5)
                beq     mode_off

                move.l  #2,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off
                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #160,temp1(a5)
                bne     mode_off
;                bsr     palette_4bpp                
                move.b  #lr2bpp,scr_mode(a5)
                bra     mode_on

mode_lr1bpp
                cmp.b   #1,arm(a5)
                beq     mode_off

                bsr     HiRes_off
                cmp.b   #1,HiRes(a5)
                beq     mode_off

                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                cmp.w   #0,d0                
                bne     mode_off
                systrap WinScreenMode(#winScreenModeGet.b,&temp1(a5).l,&temp2(a5).l,&temp(a5).l,#0.l)
                cmp.l   #160,temp1(a5)
                bne     mode_off
;                bsr     palette_4bpp                
                move.b  #lr1bpp,scr_mode(a5)
                bra     mode_on

;------------------------------------------
;Требуемый режим включен
mode_on
                moveq.l #0,d0
                rts
;------------------------------------------
;Режим не поддерживается на этом устройстве
mode_off
                moveq.l #-1,d0
                rts
;------------------------------------------

