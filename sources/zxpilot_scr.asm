;-----------------------------------------------;
;В этом файле идёт очистка экрана, а также поиск;
;и вывод на экран экранной клавиатуры для       ;
;разных режимов экрана                          ;
;-----------------------------------------------;

;Mode0 - резерв

lr1bpp          equ     1     ;Mode1 - 160x160 1bpp монохром (не используется)
lr2bpp          equ     2     ;Mode2 - 160x160 2bpp 4 градации серого
lr4bpp          equ     3     ;Mode3 - 160х160 4bpp 16 градаций серого
lr8bpp          equ     4     ;Mode4 - 160х160 8bpp 256 цветов

hr1bpp          equ     5     ;Mode5 - 320х320 1bpp монохром
hr2bpp          equ     6     ;Mode6 - 320x320 2bpp 4 градации серого (не используется)
hr4bpp          equ     7     ;Mode7 - 320х320 4bpp 16 градаций серого
hr8bpp          equ     8     ;Mode8 - 320х320 8bpp 256 цветов

he1bpp          equ     9     ;Mode9 - 240х320 1bpp монохром
he2bpp          equ     10    ;ModeA - 240x320 2bpp 4 градации серого (не используется)
he4bpp          equ     11    ;ModeB - 240x320 4bpp 16 градаций серого

lr1bpp_fs       equ     12    ;ModeC LoRes1bpp_fs
lr2bpp_fs       equ     13    ;ModeD LoRes2bpp_fs
lr4bpp_fs       equ     14    ;ModeE LoRes4bpp_fs
lr8bpp_fs       equ     15    ;ModeF LoRes8bpp_fs
         

chng_mode
;                trap    #8
                
                move.b  scr_mode(a5),d7

                cmp.b   #lr1bpp_fs,d7
                bne     chng_mode_2_1
                move.b  #lr2bpp,d7
                bra     chng_mode_3
chng_mode_2_1
                cmp.b   #lr4bpp_fs,d7
                bne     chng_mode_2_2
                move.b  #lr4bpp,d7
                bra     chng_mode_3
chng_mode_2_2
                cmp.b   #lr8bpp_fs,d7
                bne     chng_mode_2
                move.b  #lr8bpp,d7
                bra     chng_mode_3
chng_mode_2     
                sub.b   #1,d7
chng_mode_3
                bcc     chng_mode_1
                
chng_mode_max
                move.b  #$b,d7          ;Максимально возможный режим
chng_mode_1

                cmp.b   #lr1bpp,d7
                beq     chng_mode_max

                move.b  d7,-(a7)
                bsr     chng_mode_sr
                move.b  (a7)+,d7
                cmp.b   #0,d0
                bne     chng_mode_2
                rts
chng_mode_sr
                lea.l   chng_tab(a5),a2
                lea.l   scr_hr8bpp(pc),a3
                moveq   #0,d0
                move.b  d7,d0
                add.w   d0,d0
                move.w  (a2,d0.w),d0
                jmp     (a3,d0.w)

        data

chng_tab
                dc.w    scr_null-scr_hr8bpp     ;Mode0
        
                dc.w    scr_lr1bpp-scr_hr8bpp   ;Mode1
                dc.w    scr_lr2bpp-scr_hr8bpp   ;Mode2
                dc.w    scr_lr4bpp-scr_hr8bpp   ;Mode3
                dc.w    scr_lr8bpp-scr_hr8bpp   ;Mode4

                dc.w    scr_hr1bpp-scr_hr8bpp   ;Mode5
                dc.w    scr_null-scr_hr8bpp     ;Mode6
                dc.w    scr_hr4bpp-scr_hr8bpp   ;Mode7
                dc.w    scr_hr8bpp-scr_hr8bpp   ;Mode8

                dc.w    scr_he1bpp-scr_hr8bpp   ;Mode9
                dc.w    scr_null-scr_hr8bpp     ;ModeA
                dc.w    scr_he4bpp-scr_hr8bpp   ;ModeB

;                dc.w    scr_lr1bpp_fs-scr_hr8bpp     ;ModeC
;                dc.w    scr_null-scr_hr8bpp     ;ModeD
;                dc.w    scr_null-scr_hr8bpp     ;ModeE
;                dc.w    scr_null-scr_hr8bpp     ;ModeF
        code



scr_update

                lea.l   scr_tab(a5),a2
                lea.l   scr_upd(pc),a3
                moveq   #0,d7
                move.b  scr_mode(a5),d7
                add.w   d7,d7
                move.w  (a2,d7.w),d7    ;14
                jmp     (a3,d7.w)
                
        data
scr_tab         dc.w    scr_upd-scr_upd                 ;Mode0 reserved

                dc.w    scr_upd_lr1bpp-scr_upd          ;Mode1 LoRes1bpp
                dc.w    scr_upd_lr2bpp-scr_upd          ;Mode2 LoRes2bpp
                dc.w    scr_upd_lr4bpp-scr_upd          ;Mode3 LoRes4bpp
                dc.w    scr_upd_lr8bpp-scr_upd          ;Mode4 LoRes8bpp

                dc.w    scr_upd_hr1bpp-scr_upd          ;Mode5 HiRes8bpp
                dc.w    scr_upd_hr2bpp-scr_upd          ;Mode6 HiRes8bpp
                dc.w    scr_upd_hr4bpp-scr_upd          ;Mode7 HiRes8bpp
                dc.w    scr_upd_hr8bpp-scr_upd          ;Mode8 HiRes8bpp

                dc.w    scr_upd_he1bpp-scr_upd          ;Mode9 HE3308bpp
                dc.w    scr_upd_he2bpp-scr_upd          ;ModeA HE3008bpp
                dc.w    scr_upd_he4bpp-scr_upd          ;ModeB HE3308bpp

                dc.w    scr_upd_lr1bpp_fs-scr_upd       ;ModeC LoRes1bpp_fs
                dc.w    scr_upd_lr2bpp_fs-scr_upd       ;ModeD LoRes2bpp_fs
                dc.w    scr_upd_lr4bpp_fs-scr_upd       ;ModeD LoRes4bpp_fs
                dc.w    scr_upd_lr8bpp_fs-scr_upd       ;ModeE LoRes8bpp_fs
        code


;==========================================
;HiRes режим для 8-ми бит - 256 цветов
;Режим - 8

scr_hr8bpp
;                cmp.b   #hr8bpp,scr_mode(a5)
;                beq     no_mode

                bsr     mode_hr8bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #8,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                move.b  #$ff,border_color1(a5)
                systrap WinScreenLock(#winLockDontCare.b)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda    #7712,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #19200-1,d1
cls1_1          move.l  d0,(a1)+
                dbra    d1,cls1_1
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #2,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp1

                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                move.l  keyboard_screen(a5),a4

                move.l  #3200-1,d6
                bsr     bmp_8bpp_out

                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)

No_such_bmp1    lea     zx_scr_summ(a5),a1
                move.l  #23,d0
summ_clear      clr.l   (a1)+
                dbra    d0,summ_clear
                bsr     palette_8bpp
                systrap WinScreenUnlock()

                move.b  #hr8bpp,scr_mode(a5)        ;HiRes 8bpp
                moveq.l  #0,d0
no_mode         rts

;==========================================
;HiRes режим для 4-х бит - 16 градаций серого
;Режим - 7

scr_hr4bpp      
                bsr     mode_hr4bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.b  #$ff,border_color1(a5)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda    #3856,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #9600-1,d1
cls3_1          move.l  d0,(a1)+
                dbra    d1,cls3_1
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #2,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp2
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                move.l  keyboard_screen(a5),a4

                move.l  #3200-1,d6
                bsr     bmp_4bpp_out
                
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)

No_such_bmp2    lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear1     clr.l   (a1)+
                dbra    d0,summ_clear1
                bsr     palette_4bpp
                systrap WinScreenUnlock()

                move.b  #hr4bpp,scr_mode(a5)        ;HiRes 4bpp
                moveq.l #0,d0
                rts

;==========================================
;HiRes режим для 1-го бита - чёрный и белый
;Режим - 5

scr_hr1bpp      
                bsr     mode_hr1bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda    #964,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #2400-1,d1
cls2_1          move.l  d0,(a1)+
                dbra    d1,cls2_1
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #2,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp3
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                move.l  keyboard_screen(a5),a4

                move.l  #800-1,d6
                bsr     bmp_1bpp_out
                
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
No_such_bmp3    
                systrap WinScreenUnlock()

                move.b  #hr1bpp,scr_mode(a5)        ;HiRes 1bpp
                moveq.l  #0,d0
                rts

;==========================================
;LoRes режим для 8-ми бит - 256 цветов
;Режим - 4

scr_lr8bpp      
                bsr     mode_lr8bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #8,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.b  #$ff,border_color1(a5)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda.l  #1936,a0
                move.l  a0,palm_screen1(a5)
                        
                move.l  #-1,d0
                move.l  #4800-1,d1
cls4_1_lr       move.l  d0,(a1)+
                dbra    d1,cls4_1_lr

                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #1,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp4_lr
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                systrap WinDrawBitmap(a0.l,#0.w,#120.w)
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)

No_such_bmp4_lr lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear4_lr  clr.l   (a1)+
                dbra    d0,summ_clear4_lr
                move.b  #lr8bpp,scr_max(a5)
                systrap WinScreenUnlock()

                move.b  #lr8bpp,scr_mode(a5)        ;LoRes 8bpp
                moveq.l  #0,d0
                rts

;=============================================
;LoRes режим для 4-х бит - 16 градаций серого
;Режим - 3

scr_lr4bpp      
                bsr     mode_lr4bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.b  #$ff,border_color1(a5)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda    #968,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #2400-1,d1
cls3_1_lr       move.l  d0,(a1)+
                dbra    d1,cls3_1_lr
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #1,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp2_lr
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                systrap WinDrawBitmap(a0.l,#0.w,#120.w)
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)

No_such_bmp2_lr lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
summ_clear1_lr  clr.l   (a1)+
                dbra    d0,summ_clear1_lr
                move.b  #lr4bpp,scr_max(a5)
                systrap WinScreenUnlock()

                move.b  #lr4bpp,scr_mode(a5)        ;LoRes 4bpp
                moveq.l  #0,d0
                rts

;=============================================
;LoRes режим для 2-х бит - 4 градации серого
;Режим - 2

scr_lr2bpp      
                bsr     mode_lr2bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #2,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
                adda    #484,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #1200-1,d1
cls2_1_lr       move.l  d0,(a1)+
                dbra    d1,cls2_1_lr
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #1,d6
                systrap DmGetResource(d0.l,d6.w)

                cmp.l   #0,a0
                beq     No_such_bmp3_lr
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                systrap WinDrawBitmap(a0.l,#0.w,#120.w)
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
No_such_bmp3_lr move.l  #0,crc_scr(a5)
                systrap WinScreenUnlock()

                move.b  #lr2bpp,scr_mode(a5)        ;LoRes 2bpp
                moveq.l  #0,d0
                rts

;=============================================
;LoRes режим для 1 бит - монохром
;Режим - 2

scr_lr1bpp
                bsr     mode_lr1bpp

                cmp.b   #0,d0
                bne     no_mode

                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.l  a0,palm_screen(a5)

                move.l  a0,a1
;                adda    #242,a0
                move.l  a0,palm_screen1(a5)

                move.l  #-1,d0
                move.l  #600-1,d1
cls2_1_lr1bpp   move.l  d0,(a1)+
                dbra    d1,cls2_1_lr1bpp
                move.l  a1,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #1,d6
                systrap DmGetResource(d0.l,d6.w)

                cmp.l   #0,a0
                beq     No_such_bmp9_lr
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                systrap WinDrawBitmap(a0.l,#0.w,#120.w)
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
No_such_bmp9_lr move.l  #0,crc_scr(a5)
                systrap WinScreenUnlock()

                move.b  #lr1bpp_fs,scr_mode(a5)        ;LoRes 1bpp
                moveq.l  #0,d0
                rts


;==========================================
;HE330 режим для 4-х бит - 16 градаций серого
;Режим - 7

scr_he4bpp      
                bsr     mode_he4bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #4,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.b  #$ff,border_color1(a5)
                move.l  a0,palm_screen(a5)
                move.l  a0,palm_screen1(a5) ;Для HE330 palm_screen = palmscreen1

                move.l  palm_screen(a5),a1
                move.l  #-1,d0
                move.l  #5760-1,d1
scr_4bpp_he1    move.l  d0,(a0)+
                dbra    d1,scr_4bpp_he1
                move.l  a0,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #3,d6
                systrap DmGetResource(d0.l,d6.w)

                cmp.l   #0,a0
                beq     scr_4bpp_he2
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError

                move.l  keyboard_screen(a5),a4
                move.l  #1800-1,d6 ;Надо уточнить
                bsr     bmp_4bpp_out
                
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
scr_4bpp_he2    lea     zx_scr_summ(a5),a1
                move.l  #24-1,d0
scr_4bpp_he3    clr.l   (a1)+
                dbra    d0,scr_4bpp_he3
                bsr     palette_4bpp
                systrap WinScreenUnlock()

                move.b  #he4bpp,scr_mode(a5)        ;HE330 4bpp
                moveq.l  #0,d0
                rts

;==========================================
;HE330 режим для 1-го бита - чёрный и белый
;Режим - 9

scr_he1bpp      
                bsr     mode_he1bpp
                cmp.b   #0,d0
                bne     no_mode

                move.l  #1,temp(a5)
                systrap WinScreenMode(#winScreenModeSet.b,#0.l,#0.l,&temp(a5).l,#0.l)
                systrap WinScreenLock(#winLockDontCare.b)
                move.l  a0,palm_screen(a5)
                move.l  a0,palm_screen1(a5) ;Для HE330 palm_screen = palm_screen1

                move.l  #-1,d0
                move.l  #1440-1,d1
cls2_1_he       move.l  d0,(a0)+
                dbra    d1,cls2_1_he
                move.l  a0,keyboard_screen(a5)

                move.l  #'Tbmp',d0
                move.w  #3,d6
                systrap DmGetResource(d0.l,d6.w)
                cmp.l   #0,a0
                beq     No_such_bmp3_he
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq     DError
                move.l  keyboard_screen(a5),a4

;                systrap WinDrawBitmap(a0.l,#0.w,#192.w)

                move.l  #360-1,d6       ;было 800
                bsr     bmp_1bpp_out
                
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
No_such_bmp3_he 
                systrap WinScreenUnlock()

                move.b  #he1bpp,scr_mode(a5)        ;HE330 1bpp
                moveq.l  #0,d0
                rts

scr_null
                moveq.l  #-1,d0
                rts
;-----------------------------------------
;Самостоятельный вывод 1 битной BMP для 8 битного режима HiRes экрана
;В регистре a0 - адрес начала BMP
;В регистре a4 - адрес  куда выводить картинку
;В регистре d6 - длина данных 3200-1 для 320х320

bmp_8bpp_out    adda.l  #16,a0
bmp_8bpp_9      move.b  (a0)+,d7
                moveq.l #0,d0
                lsl.b   #1,d7
                bcc     bmp_8bpp_1
                move.w  #$ff00,d0
bmp_8bpp_1      lsl.b   #1,d7
                bcc     bmp_8bpp_2
                move.b  #$ff,d0
bmp_8bpp_2      swap    d0
                lsl.b   #1,d7
                bcc     bmp_8bpp_3
                move.w  #$ff00,d0
bmp_8bpp_3      lsl.b   #1,d7
                bcc     bmp_8bpp_4
                move.b  #$ff,d0
bmp_8bpp_4      move.l  d0,(a4)+
                moveq.l #0,d0
                lsl.b   #1,d7
                bcc     bmp_8bpp_5
                move.w  #$ff00,d0
bmp_8bpp_5      lsl.b   #1,d7
                bcc     bmp_8bpp_6
                move.b  #$ff,d0
bmp_8bpp_6      swap    d0
                lsl.b   #1,d7
                bcc     bmp_8bpp_7
                move.w  #$ff00,d0
bmp_8bpp_7      lsl.b   #1,d7
                bcc     bmp_8bpp_8
                move.b  #$ff,d0
bmp_8bpp_8      move.l  d0,(a4)+
                dbra    d6,bmp_8bpp_9
                rts
;-----------------------------------------
;Самостоятельный вывод 1 битной BMP для 4 битного режима HiRes экрана
;В регистре a0 - адрес начала BMP
;В регистре a4 - адрес  куда выводить картинку
;В регистре d6 - длина данных 3200-1 для 320х320

bmp_4bpp_out    adda.l  #16,a0
bmp_4bpp_9      move.b  (a0)+,d7
                moveq.l #0,d0
                lsl.b   #1,d7
                bcc     bmp_4bpp_1
                move.w  #$f000,d0
bmp_4bpp_1      lsl.b   #1,d7
                bcc     bmp_4bpp_2
                or.w    #$0f00,d0
bmp_4bpp_2      lsl.b   #1,d7
                bcc     bmp_4bpp_3
                or.b    #$f0,d0
bmp_4bpp_3      lsl.b   #1,d7
                bcc     bmp_4bpp_4
                or.b    #$0f,d0
bmp_4bpp_4      swap    d0
                lsl.b   #1,d7
                bcc     bmp_4bpp_5
                move.w  #$f000,d0
bmp_4bpp_5      lsl.b   #1,d7
                bcc     bmp_4bpp_6
                or.w    #$0f00,d0
bmp_4bpp_6      lsl.b   #1,d7
                bcc     bmp_4bpp_7
                or.b    #$f0,d0
bmp_4bpp_7      lsl.b   #1,d7
                bcc     bmp_4bpp_8
                or.b    #$0f,d0
bmp_4bpp_8      move.l  d0,(a4)+
                dbra    d6,bmp_4bpp_9
                rts
;-----------------------------------------
;Самостоятельный вывод 1 битной BMP для 1 битного режима HiRes экрана
;В регистре a0 - адрес начала BMP
;В регистре a4 - адрес  куда выводить картинку
;В регистре d6 - длина данных 800-1 для 320х320
;В регистре d6 - длина данных 360-1 для 240х320

bmp_1bpp_out    adda.l  #16,a0
bmp_1bpp_1      move.l  (a0)+,(a4)+
                dbra    d6,bmp_1bpp_1
                rts
;-----------------------------------------