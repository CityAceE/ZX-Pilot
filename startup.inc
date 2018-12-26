; Startup.inc
; by Darrin Massena (darrin@massena.com)
; 17 Jul 96

        code

proc __Startup__()
local pappi.l
local prevGlobals.l
local globalsPtr.l
beginproc
        systrap SysAppStartup(&pappi(a6), &prevGlobals(a6), &globalsPtr(a6))
        tst.w   d0
        beq.s   _SU1

        systrap SndPlaySystemSound(#sndError.b)
        moveq   #-1,d0
        bra.s   _SUExit

_SU1:
        movea.l pappi(a6),a0
        call    PilotMain(SysAppInfoType.cmd(a0).w, SysAppInfoType.cmdPBP(a0).l, SysAppInfoType.launchFlags(a0).w)

        systrap SysAppExit(pappi(a6).l, prevGlobals(a6).l, globalsPtr(a6).l)
        moveq   #0,d0

_SUExit:
endproc

        data

        ds.l    1                            ;loader stores SysAppInfoPtr here

        code
