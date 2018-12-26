                Appl    "ZX-Pilot", 'ZXSp'

                include "Sony.inc"
                include "Palm4.inc"
;               list    0
                include "Startup.inc"

        data

sonySysLibNameHR        dc.b    'Sony HR Library',0

sonyHiResRefNum dc.l    0       ;���������� ����������� ��� HiRes
MemHandle       dc.l    0
DmOpenRef       dc.l    0
OurBigPtr       dc.l    0       ;���������� ��� ��������� ������

;------------------------
;���������� ��� LoRes
scr_max         dc.b    0
scr_mode_before dc.b    0
crc_scr         dc.l    0
scroll_y        dcb.w   40,0    ;���� �� ����� ��� �������� 1:1
                dcb.w   40,128
                dcb.w   40,288
scroll_y_full   dcb.w   53,0    ;���� �� ����� ��� �������� 1:1
                dcb.w   54,64
                dcb.w   53,128
scroll_y_const  dc.w    0
scroll_x        dcb.w   53,0    ;���� ����� ��� �������� 1:1
                dcb.w   54,6
                dcb.w   53,12
scroll_x_he     dcb.w   53,0    ;���� ����� ��� �������� 1:1
                dcb.w   54,1
                dcb.w   53,2
scroll_x_const  dc.w    0
;------------------------

shift           dc.w    1       ;����� ������ ��� HandEra330

temp            dc.l    0       ;���������� ������ ����������
temp1           dc.l    0       ;���������� ������ ����������
temp2           dc.l    0       ;���������� ������ ����������

;skin            dc.b    0       ;���� �� ������� � ������ ������. 0 - ����
HiRes           dc.b    0       ;SonyHiRes 1 - ��������, 0 - �� ��������
arm             dc.b    0       ;��� ���������� 1 - arm

zx_atr          dc.l    0       ;����� #5800

sound_flag      dc.b    1       ;�������� ��� ��������� �������� �����
scr_mode        dc.b    0       ;������� ����� ������

keyboard_sw     dc.b    1       ;���� �� ���������� � ������ 1:1 LoRes, 1 - ����
pos4            dc.b    0       ;������ ���. 1 - 4 � ����, 0 - 3 � ����

;-------
joystick        dc.b    0       ;������ �� ������ ������ ��� ������ ������
kempston        dc.b    0,0     ;��������� ��������-���������
port            dc.b    0       ;�������� � �����
;-------

keyboard_screen dc.l    0
last_key        dc.w    0
keys            dc.w    0       ;������� �������
keys_before     dc.w    0       ;���������� ������� �������


flash_mask      dc.b    $ff     ;������� ��������� �������
flash_count     dc.b    16      ;������� ������ �������� �� �������

ZX_palette:
                dc.b    255     ;0   ������
                dc.b    101     ;1   �����
                dc.b    143     ;2   �������
                dc.b    29      ;3   ����������
                dc.b    211     ;4   ������
                dc.b    97      ;5   �������
                dc.b    139     ;6   ������
                dc.b    25      ;7   �����
                dc.b    255     ;8   ����� ������
                dc.b    95      ;9   ����� �����
                dc.b    125     ;10  ����� �������
                dc.b    5       ;11  ����� ����������
                dc.b    210     ;12  ����� ������
                dc.b    90      ;13  ����� �������
                dc.b    120     ;14  ����� ������
                dc.b    0       ;15  ����� �����

ZX_palette_bw:
                dc.b    15              ;0   ׸����
                dc.b    13              ;1   �����
                dc.b    11              ;2   �������
                dc.b    9               ;3   ����������
                dc.b    7               ;4   ������
                dc.b    6               ;5   �������
                dc.b    4               ;6   Ƹ����
                dc.b    2               ;7   �����
                dc.b    15              ;8   ����� ������
                dc.b    12              ;9   ����� �����
                dc.b    10              ;10  ����� �������
                dc.b    8               ;11  ����� ����������
                dc.b    5               ;12  ����� ������
                dc.b    3               ;13  ����� �������
                dc.b    1               ;14  ����� �����
                dc.b    0               ;15  ����� �����

DAA             dc.w    $00
reg_af          dc.w    $55aa
reg_bc          dc.l    $00b100c1
reg_de          dc.l    $00d100e1
reg_hl          dc.l    $00410011
I               dc.w    0               ;������� I
R               dc.w    0
IFF             dc.w    0               ;������� ���������� 1 -���������, 0 -���������
IM              dc.w    0               ;��� ���������� 0, 1, 2
border_color    dc.w    0               ;���� �������
border_color1   dc.w    $ff             ;���������� ���� �������

palm_screen     dc.l    0
palm_screen1    dc.l    0               ;����� � ������ Palm'�, ��� ���������� ZX-�����
zx_screen       dc.l    0
zx_scr_tab      dc.l    0
zx_atr_tab      dc.l    0

z80_memory      dc.l    0
ram_image       dc.l    0

global          zx_scr_summ.96          ;24 ������ �� 4 �����
global          address.10              ;dc.b    0,0,0,0,0,0,0,0,0,0
global          address2.10             ;dc.b    0,0,0,0,0,0,0,0,0,0
global          snap_header.28          ;��������� � �������

name_sna        dc.b    'SNAP.SNA',0,0
email           dc.b    'speccy@softhome.net',0

record_pointer  dc.l    0

pScreenX        dc.w    0               ;���������� X ����
pScreenY        dc.w    0               ;���������� Y ����
pPenDown        dc.w    0               ;���� �� ������� ������?

parity          incbin  "parity.bin"    ;������� ��������������� ����� ��������
push_af         incbin  "push_af.bin"   ;������� ��������������� ���� AF ��� ������
pop_af          incbin  "pop_af.bin"    ;������� ��������������� ���� AF ��� ������
                include "instr_xx_tab.asm"


palitra         dc.l    0    ;����� ����������� ������� ��� 8bpp � 4bpp �������
NOP             dc.l    0               ;����� ������ �������


;befores         dc.l    $1111          ;������ ���������� �� (��� �������)
;crc_scr         dc.l    0              ;����� #4000-5AFF (����������?)
;BMP_error       dc.w    0              ;������ ��� �������� BMP
;ekran.w         dc.w    0              ;���������� ��� �������� ����� (����������?)

        code

;               list 1


proc PilotMain(cmd.w, cmdPBP.l, launchFlags.w)

local           evt.EventType
;local           evt.l
local           err.w

beginproc
                tst.w   cmd(a6)
                bne     AppReturn1

                lea     _00(pc),a3
                move.l  a3,NOP(a5)

                bra     Starter1

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                include "instr_xx.asm"
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Starter1        bra     Starter
AppReturn1      bra     AppReturn


kernel
;******************************
;����� �������� �� ������������� ���������� ������
;                cmp.l   #$23d8,d5      ;���������� ������
;                bcs     debug1
;                trap    #8             ;����� � DEBUGGER
;debug1
;******************************
;����� �������� �� ��������� ������
;                move.l  a1,d7
;                cmp.w   #$ec39,d7      ;�����
;                bne     debug2
;                trap    #8             ;����� � DEBUGGER
;debug2
;******************************
;����� �������� �� �������� ������ ������
;                move.l  a1,d7
;                move.w  #$459C,d7      ;��� ������
;                move.l  d7,a0
;                move.b  (a0),d7
;                cmp.b   #$54,d7        ;��� �������� ������
;                bne     debug3
;                move.l  befores(a5),d7
;                trap    #8             ;����� � DEBUGGER
;debug3          move.l  a1,d7
;                move.l  d7,befores(a5)
;******************************
;����� �������� �� �������� IY
;                move.l  d1,d7
;                swap    d7
;                cmp.w   #$0000,d7      ;��� �������� IY
;                bne     debug4
;                trap    #8             ;����� � DEBUGGER
;debug4
;******************************
;����� �������� �� �������� d3
;                move.l  d3,d7
;                swap    d7
;                and.w   #$ff00,d7
;                cmp.w   #$0400,d7      ;��� �������� d3
;                bne     debug5
;                trap    #8             ;����� � DEBUGGER
;debug5
;******************************
;******************************
;����� �������� �� �������
;                move.b (a1),d7
;                cmp.b  #$dd,d7         ;��� ������ �������
;                bne     debug6
;                trap    #8             ;����� � DEBUGGER
;debug6
;******************************

                moveq   #0,d7           ;4
                move.b  (a1)+,d7        ;8
                add.w   d7,d7           ;4
                move.w  (a2,d7.w),d7    ;14
                jmp     (a3,d7.w)       ;14

;�� ���� ����� ������ ����������
interrupt
                swap    d5
                subq.w  #1,d5
                tst.w   d5
                beq     interrupt1
                swap    d5
                move.w  #$7780,d5
                bra     kernel
interrupt1      move.l   #$27780,d5    ;        #(0-34944),d5
;*********************
;������� 1 �����, �.�. 25 fps ������ 50
;                move.w  ekran(a5),d7
;                addq    #1,d7
;                and.b   #%1,d7
;                move.w  d7,ekran(a5)
;                cmp.b   #1,d7
;                beq     perehod
;**********************

;===========================================
;������ �����
scr_refresh
                movem.l d0-d5/a1-a4,-(a7)
        ;--------------------------------
                bsr     scr_update
        ;--------------------------------
                movem.l (a7)+,d0-d5/a1-a4

;                bra     no_int        ;���������� ��������� ������
                move.b  IFF(a5),d6
                cmp.b   #0,d6
                beq     no_int        ;���������� ���������

                move.b  #0,IFF(a5)

                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)

_IMwp1
                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

                move.w  a1,d7
                move.b  d7,(a4)

_IMwp2
                move.b  IM(a5),d6
                cmp.b   #2,d6
                beq     _IM2

                move.l  a1,d7
                move.w  #56,d7
                move.l  d7,a1
                bra     no_int

_IM2            move.l  a4,d7
                move.w  I(a5),d7
                move.b  #$ff,d7
                move.l  d7,a1
                move.b  (a1)+,d7
                move.b  (a1),-(a7)
                move.w  (a7)+,d6
                move.b  d7,d6
                move.l  a4,d7
                move.w  d6,d7
                move.l  d7,a1

no_int
                movem.l  d0-d5/a1-a4,-(a7)

                move.w  #0,pScreenX(a5)
                move.w  #0,pScreenY(a5)
                move.w  #$ffff,pPenDown(a5)

                systrap KeyCurrentState ()

                move.b  d0,keys(a5)

                systrap EvtGetPen(&pScreenX(a5).l,&pScreenY(a5).l,&pPenDown(a5).l)

                systrap EvtGetEvent(&evt(a6), #0.l)

;======================================
;����� ������ �������� ���������� � ����������� �� ���������� ������

                bsr     kbd_scan

;======================================

                move.w  pScreenY(a5),d6
                cmp.w   #160,d6                 ;��������� �� ����� ������� ��������
                bcs     no_graffity             ;���� ������� ���� ������
                movem.l (a7)+,d0-d5/a1-a4
                bra     save_dialog             ;�����
no_graffity
                movem.l (a7)+,d0-d5/a1-a4

                move.b  keys(a5),d7
                cmp.b   #$01,d7
                beq     save_dialog             ;����� �� ��a����  Power
                cmp.b   #$20,d7                 ;������� ToDo
                bne     mode_return

;--------------------------------------------
;������ ����� �� ������� ToDO

                move.b  keys_before(a5),d7      ;���������� ��������
                move.b  keys(a5),d6
                move.b  d6,keys_before(a5)
                cmp.b   d6,d7
                beq     kernel

;                move.b  #hr8bpp,scr_mode(a5)
                movem.l d0-d5/a1-a4,-(a7)
;                bsr     screen_draw1

                bsr     chng_mode

                movem.l (a7)+,d0-d5/a1-a4

                bra     scr_refresh

;---------------------------------------------

mode_return
                move.b  d7,keys_before(a5)

                move.l  #$40,d6
                btst    #6,d7  ;Memo
                beq     keys1
                or.l    #$100001,d6
keys1
                btst    #3,d7  ;DateBook
                beq     keys2
                or.l    #$020010,d6
keys2
                btst    #4,d7  ;Address
                beq     keys3
                or.l    #$010008,d6
keys3
                btst    #1,d7  ;Up
                beq     keys4
                or.l    #$080002,d6
keys4
                btst    #2,d7  ;Down
                beq     keys5
                or.l    #$040004,d6
keys5
                move.l  d6,joystick(a5)
                bra     kernel

change_mode
                move.b  keys_before(a5),d7
                move.b  keys(a5),d6
                move.b  d6,keys_before(a5)
                cmp.b   d6,d7
                beq     kernel


;==============================================
screen_draw
                movem.l d0-d5/a1-a4,-(a7)


;                move.b  #he4bpp+1,scr_mode(a5)      ;����������� ��������� ����� +1
                bsr     chng_mode_max   ;����������� ��������� �����

;                bsr     scr_lr8bpp      ;��������� ���������� (����������)

scr_draw_01     movem.l (a7)+,d0-d5/a1-a4
                bra     scr_refresh
;==============================================


exit
                systrap MemPtrFree(zx_scr_tab(a5).l)
exit2
                systrap MemChunkFree (OurBigPtr(a5).l)

;               list 0
;==========================================
;����� ���������
;==========================================

AppReturn:
                moveq   #0,d0
endproc
;               list 1

;============================================================
;������� ���� � ������� � ����� � ��� �� ������� �������� Z80
no_instr
                move.l  a1,d3
                systrap KeySetMask (#1.l)
                lea     address(a5),a4
                move.l  d3,d1
                bsr     hex2ascii
                lea     address2(a5),a4
                move.l  d7,d1
                bsr     hex2ascii
                lea     address(a5),a1
                adda.l  #4,a1
                lea     address2(a5),a2
                sub.w   #1,a2
null_cut        add.w   #1,a2
                move.b  (a2),d0
                cmp.b   #$30,d0
                beq     null_cut
                lea     email(a5),a3
                systrap FrmCustomAlert (#1000.w,a1.l,a2.l,a3.l)
                systrap KeySetMask (#-1.l)
                bra     exit

;============================================================
;����� ������� ������
save_dialog
                movem.l d0-d5/a1-a4,-(a7)
                systrap KeySetMask (#1.l)
                systrap FrmAlert (#1001.w)
                move.b  d0,d6
                systrap KeySetMask (#-1.l)
                movem.l (a7)+,d0-d5/a1-a4
                cmp.b   #1,d6
                beq     kernel
                cmp.b   #0,d6
                beq     save_and_exit
                bra     exit

;=========================================

save_and_exit

;��������� �� ����� ����� ������� ��������

                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

                move.w  a1,d7
                lsr.w   #8,d7
                move.b  d7,(a4)

                move.l  a4,d7
                subq.w  #1,d7
                move.l  d7,a4

                move.w  a1,d7
                move.b  d7,(a4)

                lea     snap_header(a5),a0
                move.b  I(a5),(a0)+     ;I

                move.l  reg_hl(a5),d7
                move.b  d7,(a0)+        ;L'
                swap    d7
                move.b  d7,(a0)+        ;H'
                move.l  reg_de(a5),d7
                move.b  d7,(a0)+        ;E'
                swap    d7
                move.b  d7,(a0)+        ;D'
                move.l  reg_bc(a5),d7
                move.b  d7,(a0)+        ;C'
                swap    d7
                move.b  d7,(a0)+        ;B'

                lea     reg_af(a5),a3
                move.b  (a3)+,d6
                move.b  (a3),d7
                lea     push_af(a5),a2
                move.b  (a2,d7),(a0)+   ;F'
                move.b  d6,(a0)+        ;A'

                move.b  d4,(a0)+        ;L
                swap    d4
                move.b  d4,(a0)+        ;H
                move.b  d3,(a0)+        ;E
                swap    d3
                move.b  d3,(a0)+        ;D
                move.b  d2,(a0)+        ;C
                swap    d2
                move.b  d2,(a0)+        ;B

                swap    d1
                move.b  d1,(a0)+        ;LY
                lsr.w   #8,d1
                move.b  d1,(a0)+        ;HY
                swap    d1

                swap    d0
                move.b  d0,(a0)+        ;LX
                lsr.w   #8,d0
                move.b  d0,(a0)+        ;HX
                swap    d0

                move.b  IFF(a5),(a0)+   ;IFF
                move.b  R(a5),(a0)+     ;R

                move.b  (a2,d0),(a0)+   ;F'

                move.b  d1,(a0)+        ;A

                move.l  a4,d7
                move.b  d7,(a0)+        ;
                lsr.w   #8,d7
                move.b  d7,(a0)+        ;SP

                move.b  IM(a5),(a0)+    ;IM
                move.b  border_color(a5),(a0) ;Border color

                lea     name_sna(a5),a0
                systrap DmFindDatabase(#0.w,a0.l)
                tst.l   d0
                ;���� ����, �� ����� ���� ���
                beq     exit
                systrap DmOpenDatabase(#0.w,d0.l,#dmModeReadWrite.w)
                move.l  a0,DmOpenRef(a5)
                systrap DmGetRecord(a0.l,#0.w)
                move.l  a0,MemHandle(a5)
                systrap MemHandleLock(a0.l)
                lea     snap_header(a5),a1
                move.l  a0,record_pointer(a5)
                systrap DmWrite(record_pointer(a5).l,#0.l,&snap_header(a5).l,#27.l)
                systrap DmWrite(record_pointer(a5).l,#27.l,zx_screen(a5).l,#$c000.l)
                sysTrap MemHandleUnlock(MemHandle(a5).l)
                systrap DmReleaseRecord (DmOpenRef(a5).l,#0.w,#1.b)
                systrap DmCloseDatabase(DmOpenRef(a5).l)
                bra     exit


;==========================================
;������ ���������
;==========================================
Starter
                move.w  #$ffff,last_key(a5)     ;������� �������� �������
                move.b  #$ff,border_color1(a5)  ;�������������� ��������� �������
                move.b  #$40,port(a5)

;=====================================
;�������� ���� ����������
                systrap FtrGet(#$70737973.l, #2.w, &temp(a5).l)
                move.l  temp(a5),d0
                and.l   #$fff00000,d0
                beq     not_arm
                move.b  #0,sound_flag(a5)       ;��������� ����, ���� ARM
                move.b  #1,arm(a5)
                bra     not_arm1
not_arm
                move.b  #0,arm(a5)
not_arm1

;================================================
;�������� ������ ������������ �������
                systrap FtrGet(#$70737973.l, #1.w, &temp(a5).l)
                move.l  temp(a5),d0
                and.l   #$ffff0000,d0
                cmp.l   #$04000000,d0   ;���������� � 4-� ������� ���
                bcs     less_4          ;��� ���� 4-�
                move.b  #1,pos4(a5)     ;������������� ���� 4-� ���
less_4

;================================================
;������������ ��������� HiRes �� CLIE
;                bsr     HiRes_on

;=================================================
;��������� ����� �� 129 Kb ��� ������ POS3 � ����
                systrap MemChunkNew (#0.w,#$20010.l,#$1200.w)
                move.l  a0,d0
                cmp.l   #0,d0
                beq     AppReturn ;��� ������!
                move.l  a0,OurBigPtr(a5)
                move.l  a0,z80_memory(a5)

;===================================================
;����������� ������ Z80 � ������ PalmOS �� #xxxx0000
                move.l  z80_memory(a5),a1
                subq.l  #1,a1
poisk           addq.l  #1,a1
                move.w  a1,d0
                tst.w   d0
                bne     poisk

                move.l  a1,z80_memory(a5)
                adda.l  #$4000,a1
                move.l  a1,zx_screen(a5) ;��� ����� ��� �������� ������ ZX-������
                adda.l  #$1800,a1
                move.l  a1,zx_atr(a5)   ;��� ����� ��� �������� ����������

;=====================================================
;������ ������� ����� ����� ���������
                systrap MemPtrNew(#$4360.l)
                cmp.l   #0,a0
                beq     exit2   ;��� ������
                move.l  a0,zx_scr_tab(a5)
                move.l  a0,a3
                move.l  zx_screen(a5),a4
                moveq   #2,d1
mm_33:          move.l  a4,a2
                moveq   #7,d3
mm_31:          moveq   #7,d5
mm_3:           move.l  a4,(a3)+
                adda.l  #32,a4
                move.l  a4,a1
                adda    #$100-32,a4
                dbra    d5,mm_3
                adda    #32,a2
                move.l  a2,a4
                dbra    d3,mm_31
                move.l  a1,a4
                dbra    d1,mm_33
                move.l  a3,zx_atr_tab(a5)
                move.l  zx_scr_tab(a5),a4
                move.l  z80_memory(a5),d0
                add.l   #$5800,d0
                move.l  #23,d1
next_atr_line   move.l  d0,(a3)+
                add.l   #32,d0
                dbra    d1,next_atr_line

                move.l  a3,palitra(a5)

;====================================
;��������� ������� ������
;                bsr     mode_hr8bpp

;====================================
;������ ������� �������
;                bsr     fill_palette
;
;==========================================
;���� ������ � ��� basic48
                move.l  #'ROM',d0
                systrap DmGetResource(d0.l,#1000.w)
                cmp.l   #0,a0
                beq.s   DError
                move.l  a0,a3
                systrap MemHandleLock(a0.l)
                cmp.l   #0,a0
                beq.s   DError
                move.l  #4096-1,d0      ;���������� ��� �� ��� ������� ����� � ����� #0000 Z80
                move.l  z80_memory(a5),a1
rom_transfer    move.l  (a0)+,(a1)+
                dbra    d0,rom_transfer
                systrap MemHandleUnlock(a3.l)
                systrap DmReleaseResource(a3.l)
DError

;==========================================
;���� ���� �� ���������
                lea     name_sna(a5),a0
                systrap DmFindDatabase(#0.w,a0.l)
                tst.l   d0        ;���� ����, �� ����� ���� ���
                bne     ramimage

;===========================================
;���� ��� SNA � ������, �� ������ ������ RESET
RESET           move.l  z80_memory(a5),a1
                lea     instr_xx_tab(a5),a2
                move.l  NOP(a5),a3
                move.l  a1,a4
                adda.l  #$10000,a4
                move.b  #$f3,(a4)+      ;������������ ���
                move.b  #$c7,(a4)+
                move.l  #$c7c7c7c7,(a4)
                move.l  a1,a4
                moveq.l #0,d0
                move.l  d0,d1
                move.l  d0,d2
                move.l  d0,d3
                move.l  d0,d4
                move.l  #$27780,d5      ;#(0-34944),d5
                bra     screen_draw

;======================================
;��������� ���� ������ �� ���������
ramimage
                move.l  d0,-(a7)
                systrap DmOpenDatabase(#0.w,d0.l,#dmModeReadOnly.w)
                move.l  a0,DmOpenRef(a5)
;�������� ����� ����� SNAP � �� ����� ������������� ��� ���: SNA48 ��� SNA128
                move.l  (a7)+,d0
                systrap DmDatabaseSize (#0.w,d0.l,&NULL.l,&NULL.l,&temp(a5).l)
;� temp(a5) ����� ����� ��������
;=======
                systrap DmGetRecord(DmOpenRef(a5).l,#0.w)
                move.l  a0,MemHandle(a5)
                systrap MemHandleLock(a0.l)
                move.l  a0,ram_image(a5)
                sysTrap MemHandleUnlock(MemHandle(a5).l)
                systrap DmReleaseRecord (DmOpenRef(a5).l,#0.w,#1.b)

;��������� ������� � ���
                move.l  ram_image(a5),a0
                adda.l  #27,a0
                move.l  z80_memory(a5),a4
                adda.l  #$4000,a4
                move.l  #$C000-1,d0
sna_transfer    move.b  (a0)+,(a4)+
                dbra    d0,sna_transfer

                move.b  #$f3,(a4)+       ;������������ ���
                move.b  #$c7,(a4)+
                move.l  #$c7c7c7c7,(a4)


;==========================================
;��������� �������������� ��������
                move.l  ram_image(a5),a0
                move.b  (a0)+,I(a5)             ;��������� ������� I
                moveq   #0,d7
                lea     reg_hl(a5),a4           ;��������� HL'
                move.b  (a0)+,d7
                swap    d7
                move.b  (a0)+,d7
                move.w  d7,(a4)+
                swap    d7
                move.w  d7,(a4)
                lea     reg_de(a5),a4           ;��������� DE'
                move.b  (a0)+,d7
                swap    d7
                move.b  (a0)+,d7
                move.w  d7,(a4)+
                swap    d7
                move.w  d7,(a4)
                lea     reg_bc(a5),a4           ;��������� BC'
                move.b  (a0)+,d7
                swap    d7
                move.b  (a0)+,d7
                move.w  d7,(a4)+
                swap    d7
                move.w  d7,(a4)
                lea     reg_af(a5),a4           ;��������� AF'
                move.b  (a0)+,d7
                lea     pop_af(a5),a3
                move.b  (a3,d7),d7
;               or.b    #%110000,d7    ;��� Ghost'N'Goblins
                swap    d7
                move.b  (a0)+,d7
                move.b  d7,(a4)+
                swap    d7
                move.b  d7,(a4)
;==================================
;��������� AF � SP
                moveq.l #0,d0
                moveq.l #0,d1
                adda.l  #12,a0
                move.b  (a0)+,d0
                move.b  (a3,d0),d0
;               or.b    #%110000,d0    ;��� Ghost'N'Goblins
                move.b  (a0)+,d1
                move.l  z80_memory(a5),d7
                move.b  (a0)+,d6
                move.b  (a0)+,d7
                rol.w   #8,d7
                move.b  d6,d7
                move.l  d7,a4

                move.b  (a0)+,IM(a5)    ;��������� ���������� ���/����
                move.b  (a0),border_color(a5)   ;��������� ���� �������

;======================================
;��������� �������� ��������
                move.l  ram_image(a5),a0
                adda.l  #9,a0
                move.b  (a0)+,d4
                swap    d4
                move.b  (a0)+,d4
                swap    d4
                move.b  (a0)+,d3
                swap    d3
                move.b  (a0)+,d3
                swap    d3
                move.b  (a0)+,d2
                swap    d2
                move.b  (a0)+,d2
                swap    d2
                swap    d1
                move.b  (a0)+,d7
                move.b  (a0)+,d1
                rol.w   #8,d1
                move.b  d7,d1
                swap    d1
                swap    d0
                move.b  (a0)+,d7
                move.b  (a0)+,d0
                rol.w   #8,d0
                move.b  d7,d0
                swap    d0
                move.b  (a0)+,d7
                ror.b   #2,d7
                move.b  d7,IFF(a5)
                move.b  (a0),R(a5)

                move.l  z80_memory(a5),a1
                lea     instr_xx_tab(a5),a2
                move.l  NOP(a5),a3
                move.l   #$27780,d5     ;#(0-34944),d5

                move.b  (a4),d6         ;������� �� ����� � ��������� PC
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                move.l  a1,d7
                move.b  (a4),-(a7)
                move.w  (a7)+,d7
                move.b  d6,d7
                move.l  d7,a1
                move.l  a4,d7
                addq.w  #1,d7
                move.l  d7,a4
                bra     screen_draw

                include "zxpilot_scr.asm"

                include "zxpilot_proc.asm"

                include "zxpilot_kbd.asm"

;������������������ include ������ ������!!! ��� �������� ��� ������� scr_tab

                include "zxpilot_mode0.asm"

                include "zxpilot_lr1bpp.asm"
                include "zxpilot_lr2bpp.asm"
                include "zxpilot_lr4bpp.asm"
                include "zxpilot_lr8bpp.asm"

                include "zxpilot_hr1bpp.asm"
                include "zxpilot_hr2bpp.asm"
                include "zxpilot_hr4bpp.asm"
                include "zxpilot_hr8bpp.asm"

                include "zxpilot_he1bpp.asm"
                include "zxpilot_he2bpp.asm"
                include "zxpilot_he4bpp.asm"

                include "zxpilot_lr1bpp_fs.asm"
                include "zxpilot_lr2bpp_fs.asm"
                include "zxpilot_lr4bpp_fs.asm"
                include "zxpilot_lr8bpp_fs.asm"


;---------------------------------------------

;               list 0

                res     'Talt',1000,"Talt03e8.bin"      ;�������� ���
                res     'Talt',1001,"Talt03e9.bin"      ;������ ������

                res     'tAIn',100,"tAIN0064.bin"       ;�������� ���������
                res     'tAIB',1000,"tAIB03e8.bin"      ;������ �������
                res     'tAIB',1001,"tAIB03e9.bin"      ;������ ���������

                res     'Tbmp',1,"Tbmp0001.bin"         ;���������� ��� LoRes
                res     'Tbmp',2,"Tbmp0002.bin"         ;���������� ��� HiRes
                res     'Tbmp',3,"Tbmp0003.bin"         ;���������� ��� HE330

                res     'ROM',1000, "ROM03e8.bin"       ;Basic48

                res     'tver', 1
                dc.b    '0.6b', 0,0

                res     'pref', 1
                dc.w    sysAppLaunchFlagNewStack|sysAppLaunchFlagNewGlobals|sysAppLaunchFlagUIApp|sysAppLaunchFlagSubCall
                dc.l    $1000   ; stack size
                dc.l    $20000  ; heap size

                end
