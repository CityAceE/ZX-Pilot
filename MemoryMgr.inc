; ==================
; System/MemoryMgr.h
; ==================

memNewChunkFlagPreLock			equ	$0100
memNewChunkFlagNonMovable			equ	$0200
memNewChunkFlagAtStart			equ	$0400	; forceallocationatfrontofheap
memNewChunkFlagAtEnd			equ	$0800	;forceallocationatendofheap
memDebugModeCheckOnChange			equ	$0001
memDebugModeCheckOnAll			equ	$0002
memDebugModeScrambleOnChange			equ	$0004
memDebugModeScrambleOnAll			equ	$0008
memDebugModeFillFree			equ	$0010
memDebugModeAllHeaps			equ	$0020
memDebugModeRecordMinDynHeapFree	equ	$0040
memErrChunkLocked			equ	$0101
memErrNotEnoughSpace			equ	$0102
memErrInvalidParam			equ 	$0103 ;invalidparamorrequestedsizeistoobig*/
memErrChunkNotLocked			equ	$0104
memErrCardNotPresent			equ	$0105
memErrNoCardHeader			equ	$0106
memErrInvalidStoreHeader		equ	$0107
memErrRAMOnlyCard			equ	$0108
memErrWriteProtect			equ	$0109
memErrNoRAMOnCard			equ	$010a
memErrNoStore				equ	$010b
memErrROMOnlyCard			equ	$010c
sysTrapMemPtrFree			equ	sysTrapMemChunkFree
