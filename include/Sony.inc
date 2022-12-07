sonySysFtrCreator                       equ     'SoNy'


hrWidth                 equ     320
hrHeight                equ     320
stdWidth                equ     160
stdHeight               equ     160


sonySysFtrNumSysInfoP                   equ     1
sonySysFtrNumStringInfoP                equ     2
sonySysFtrNumJogAstMaskP                equ     3
sonySysFtrNumJogAstMOCardNoP            equ     4
sonySysFtrNumJogAstMODbIDP              equ     5


;File: SonyHighResLib.h

sysTrapHROpen				equ	$A801
sysTrapHRClose				equ	$A802

sysTrapHRGetAPIVersion                  equ     $A805
sysTrapHRWinClipRectangle               equ     $A806
sysTrapHRWinCopyRectangle               equ     $A807
sysTrapHRWinCreateBitmapWindow          equ     $A808
sysTrapHRWinCreateOffscreenWindow       equ     $A809
sysTrapHRWinCreateWindow                equ     $A80A
sysTrapHRWinDisplayToWindowPt           equ     $A80B
sysTrapHRWinDrawBitmap                  equ     $A80C
sysTrapHRWinDrawChar                    equ     $A80D
sysTrapHRWinDrawChars                   equ     $A80E
sysTrapHRWinDrawGrayLine                equ     $A80F
sysTrapHRWinDrawGrayRectangleFrame      equ     $A810
sysTrapHRWinDrawInvertedChars           equ     $A811
sysTrapHRWinDrawLine                    equ     $A812
sysTrapHRWinDrawPixel                   equ     $A813
sysTrapHRWinDrawRectangle               equ     $A814
sysTrapHRWinDrawRectangleFrame          equ     $A815
sysTrapHRWinDrawTruncChars              equ     $A816
sysTrapHRWinEraseChars                  equ     $A817
sysTrapHRWinEraseLine                   equ     $A818
sysTrapHRWinErasePixel                  equ     $A819
sysTrapHRWinEraseRectangle              equ     $A81A
sysTrapHRWinEraseRectangleFrame         equ     $A81B
sysTrapHRWinFillLine                    equ     $A81C
sysTrapHRWinFillRectangle               equ     $A81D
sysTrapHRWinGetClip                     equ     $A81E
sysTrapHRWinGetDisplayExtent            equ     $A81F
sysTrapHRWinGetFramesRectangle          equ     $A820
sysTrapHRWinGetPixel                    equ     $A821
sysTrapHRWinGetWindowBounds             equ     $A822
sysTrapHRWinGetWindowExtent             equ     $A823
sysTrapHRWinGetWindowFrameRect          equ     $A824
sysTrapHRWinInvertChars                 equ     $A825
sysTrapHRWinInvertLine                  equ     $A826
sysTrapHRWinInvertPixel                 equ     $A827
sysTrapHRWinInvertRectangle             equ     $A828
sysTrapHRWinInvertRectangleFrame        equ     $A829
sysTrapHRWinPaintBitmap                 equ     $A82A
sysTrapHRWinPaintChar                   equ     $A82B
sysTrapHRWinPaintChars                  equ     $A82C
sysTrapHRWinPaintLine                   equ     $A82D
sysTrapHRWinPaintLines                  equ     $A82E
sysTrapHRWinPaintPixel                  equ     $A82F
sysTrapHRWinPaintPixels                 equ     $A830
sysTrapHRWinPaintRectangle              equ     $A831
sysTrapHRWinPaintRectangleFrame         equ     $A832
sysTrapHRWinRestoreBits                 equ     $A833
sysTrapHRWinSaveBits                    equ     $A834
sysTrapHRWinScreenMode                  equ     $A835
sysTrapHRWinScrollRectangle             equ     $A836
sysTrapHRWinSetClip                     equ     $A837
sysTrapHRWinSetWindowBounds             equ     $A838
sysTrapHRWinWindowToDisplayPt           equ     $A839
sysTrapHRBmpBitsSize                    equ     $A83A
sysTrapHRBmpSize                        equ     $A83B
sysTrapHRBmpCreate                      equ     $A83C
sysTrapHRFntGetFont                     equ     $A83D
sysTrapHRFntSetFont                     equ     $A83E
sysTrapHRFontSelect                     equ     $A83F
sysTrapHRSystem                         equ     $A840
sysTrapHRWinGetPixelRGB                 equ     $A841
sysTrapHRGetInfo                        equ     $A842
