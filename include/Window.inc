kWinVersion			equ	3

winUp		equ	0
winDown		equ	1
winLeft		equ	2
winRight	equ	3


screenFormat	equ	0
genericFormat	equ	1


winLockCopy		equ	0
winLockErase	equ	1
winLockDontCare	equ	2


winScreenModeGetDefaults			equ	0
winScreenModeGet					equ	1
winScreenModeSetToDefaults			equ	2
winScreenModeSet					equ	3
winScreenModeGetSupportedDepths		equ	4
winScreenModeGetSupportsColor		equ	5

winPaletteGet			equ	0
winPaletteSet			equ	1
winPaletteSetToDefault			equ	2
winPaletteInit			equ	3 ;for internal use only
blackPattern	equ	0
whitePattern	equ	1
grayPattern		equ	2
customPattern	equ	3
noPattern			equ	blackPattern
grayHLinePattern			equ	$AA
grayHLinePatternOdd			equ	$55
WinMaxSupportedDepth			equ	8
WinNumSupportedColors			equ	4
WinUseTableIndexes			equ	-1
DrawStateStackSize			equ	5 ;enough for a control in a field in a window
noFrame			equ	0
simpleFrame			equ	1
rectangleFrame			equ	1
simple3DFrame			equ	$0012 ;3d,frame=2
roundFrame			equ	$0401 ;corner=7,frame=1
boldRoundFrame			equ	$0702 ;corner=7,frame=2
popupFrame			equ	$0205 ;corner=2,frame=1,shadow=1
dialogFrame			equ	$0302 ;corner=3,frame=2
menuFrame			equ	popupFrame
winDefaultDepthFlag			equ	$FF
winErrPalette			equ	(winErrorClass|1)
