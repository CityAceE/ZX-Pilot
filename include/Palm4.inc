       list 0          ;disable listing

;----------------------------------------------
; palm4.inc
;
;   Include file for Pila
;       File version 1.0
;       May 2002
;       Rodolphe Pineau
;
;   Processed from Palm OS 4.0 C header files
;
;----------------------------------------------

        include "CoreTraps.inc"

        include "ErrorBase.inc"

        include "MemoryMgr.inc"

        include "Window.inc"

; System\SystemMgr.rh


sysFileCSystem          equ     'psys'
sysFileCGraffiti        equ     'graf'
sysFileCSystemPatch     equ     'ptch'

sysFileCCalculator      equ     'calc'
sysFileCSecurity        equ     'secr'
sysFileCPreferences     equ     'pref'
sysFileCAddress         equ     'addr'
sysFileCToDo            equ     'todo'
sysFileCDatebook        equ     'date'
sysFileCMemo            equ     'memo'
sysFileCSync            equ     'sync'
sysFileCMemory          equ     'memr'
sysFileCMail            equ     'mail'
sysFileCExpense         equ     'exps'
sysFileCLauncher        equ     'lnch'

sysFileCGraffitiDemo    equ     'gdem'
sysFileCMailDemo        equ     'mdem'

sysFileCFirstApp                equ     sysFileCPreferences
sysFileCDefaultApp              equ     sysFileCPreferences
sysFileCDefaultButton1App       equ     sysFileCDatebook
sysFileCDefaultButton2App       equ     sysFileCAddress
sysFileCDefaultButton3App       equ     sysFileCToDo
sysFileCDefaultButton4App       equ     sysFileCMemo
sysFileCDefaultCalcButtonApp    equ     sysFileCCalculator
sysFileCDefaultCradleApp        equ     sysFileCSync
sysFileCDefaultModemApp         equ     sysFileCSync
sysFileCNullApp                 equ     '0000'

sysFileCDigitizer       equ     'digi'
sysFileCGeneral         equ     'gnrl'
sysFileCFormats         equ     'frmt'
sysFileCShortCuts       equ     'shct'
sysFileCButtons         equ     'bttn'
sysFileCOwner           equ     'ownr'
sysFileCModemPanel      equ     'modm'
sysFileCDialPanel       equ     'dial'
sysFileCNetworkPanel    equ     'netw'
sysFileCPADHtal         equ     'hpad'
sysFileCTCPHtal         equ     'htcp'
sysFileCMineHunt        equ     'mine'
sysFileCPuzzle15        equ     'puzl'
sysFileCOpenLibInfo     equ     'olbi'

sysFileTLibrary         equ     'libr'

sysFileCNet             equ     'netl'
sysFileCIrLib           equ     'irda'

sysFileCSerialHwrMgr    equ     'shwm'
sysFileCSerialWrapper   equ     'swrp'
sysFileCIrSerialWrapper equ     'iwrp'

sysFileTUartPlugIn      equ     'sdrv'
sysFileCUart328         equ     'u328'
sysFileCUart650         equ     'u650'

sysFileTSystem          equ     'rsrc'
sysFileTSystemPatch     equ     'ptch'
sysFileTKernel          equ     'krnl'
sysFileTUIAppShell      equ     'uish'
sysFileTExtension       equ     'extn'
sysFileTApplication     equ     'appl'
sysFileTPanel           equ     'panl'
sysFileTSavedPreferences        equ     'sprf'
sysFileTPreferences     equ     'pref'
sysFileTMidi            equ     'smfr'

sysFileTGraffitiMacros  equ     'macr'

sysFileTHtalLib         equ     'htal'

sysFileTExgLib          equ     'exgl'

sysFileTFileStream      equ     'strm'

sysFileTTemp            equ     'temp'

sysResTBootCode         equ     'boot'
sysResIDBootReset       equ     10000
sysResIDBootInitCode    equ     10001
sysResIDBootSysCodeStart        equ     10100
sysResIDBootSysCodeMin  equ     10102
sysResIDBootUICodeStart equ     10200
sysResIDBootUICodeMin   equ     10203

sysResTAppPrefs         equ     'pref'

sysResTAppCode          equ     'code'
sysResTAppGData         equ     'data'

sysResTExtensionCode    equ     'extn'

sysResTFeatures         equ     'feat'
sysResIDFeatures        equ     10000

sysResTCountries        equ     'cnty'
sysResIDCountries       equ     10000

sysResTLibrary                  equ     'libr'
sysResIDLibrarySerMgr328        equ     10000
sysResIDLibrarySerMgr681        equ     10001
sysResIDLibraryRMPPlugIn        equ     10002

sysResTGrfTemplate      equ     'tmpl'
sysResIDGrfTemplate     equ     10000
sysResTGrfDictionary    equ     'dict'
sysResIDGrfDictionary   equ     10000
sysResIDGrfDefaultMacros        equ     10000

sysResTDefaultDB        equ     'dflt'
sysResIDDefaultDB       equ     1

sysResTErrStrings       equ     'tST'
sysResIDErrStrings      equ     10000

sysResTSysPref                  equ     sysFileCSystem
sysResIDSysPrefMain             equ     0
sysResIDSysPrefPassword         equ     1
sysResIDSysPrefFindStr          equ     2
sysResIDSysPrefCalibration      equ     3
sysResIDDlkUserInfo             equ     4
sysResIDDlkLocalPC              equ     5
sysResIDDlkCondFilterTab        equ     6
sysResIDModemMgrPref            equ     7
sysResIDDlkLocalPCAddr          equ     8
sysResIDDlkLocalPCMask          equ     9

sysResTInBox    equ     'ibox'
sysResTOutBox   equ     'obox'





sysTrapsysLibTrapBase                  equ     $A800
sysTrapsysLibTrapName                  equ     $A800
sysTrapsysLibTrapOpen                  equ     $A801
sysTrapsysLibTrapClose                 equ     $A802
sysTrapsysLibTrapSleep                 equ     $A803
sysTrapsysLibTrapWake                  equ     $A804
sysLibTrapCustom                equ     $A805


sysDbgBreakpointTrapNum         equ     0
sysDbgTrapNum                   equ     8
sysDispatchTrapNum              equ     15


; AppBuildRules.h

SHELL_COMMAND_DB        equ     0
SHELL_COMMAND_UI        equ     0
SHELL_COMMAND_APP       equ     0
SHELL_COMMAND_EMULATOR  equ     1


; BuildRules.h

EMULATION_NONE          equ     0
EMULATION_WINDOWS       equ     1
EMULATION_DOS           equ     2
EMULATION_MAC           equ     3

MEMORY_LOCAL            equ     0
MEMORY_REMOTE           equ     1

ENVIRONMENT_CW          equ     0
ENVIRONMENT_MPW         equ     1

ERROR_CHECK_NONE        equ     0
ERROR_CHECK_PARTIAL     equ     1
ERROR_CHECK_FULL        equ     2

CPU_68K                 equ     0
CPU_x86                 equ     1

HW_TARGET_NONE          equ     0
HW_TARGET_302           equ     1
HW_TARGET_328EMU        equ     2
HW_TARGET_328           equ     3
HW_TARGET_TD1           equ     4

MEMORY_FORCE_LOCK_OFF   equ     0
MEMORY_FORCE_LOCK_ON    equ     1

DEBUG_LEVEL_NONE        equ     1
DEBUG_LEVEL_PARTIAL     equ     2
DEBUG_LEVEL_FULL        equ     3

CONSOLE_SERIAL_LIB_68328        equ     1
CONSOLE_SERIAL_LIB_68681        equ     2

COUNTRY_UNITED_STATES   equ     0
COUNTRY_FRANCE          equ     1
COUNTRY_GERMANY         equ     2
COUNTRY_ITALY           equ     3
COUNTRY_SPAIN           equ     4

LANGUAGE_ENGLISH        equ     0
LANGUAGE_FRENCH         equ     1
LANGUAGE_GERMAN         equ     2
LANGUAGE_ITALIAN        equ     3
LANGUAGE_SPANISH        equ     4
LANGUAGE_WORKPAD        equ     5

USER_MODE_NORMAL        equ     0
USER_MODE_DEMO          equ     1

INTERNAL_COMMANDS_EXCLUDE       equ     0
INTERNAL_COMMANDS_INCLUDE       equ     1

MEMORY_VERSION_1        equ     1
MEMORY_VERSION_2        equ     2

GRAPHICS_VERSION_1      equ     1
GRAPHICS_VERSION_2      equ     2

INCLUDE_DES_OFF         equ     0
INCLUDE_DES_ON          equ     1

EMULATION_LEVEL         equ     0
USE_TRAPS               equ     1

MEMORY_TYPE             equ     MEMORY_LOCAL
ENVIRONMENT             equ     ENVIRONMENT_CW
ERROR_CHECK_LEVEL       equ     ERROR_CHECK_FULL
CPU_TYPE                equ     CPU_68K
HW_TARGET               equ     HW_TARGET_NONE
MEMORY_FORCE_LOCK       equ     MEMORY_FORCE_LOCK_ON
COUNTRY                 equ     COUNTRY_UNITED_STATES
LANGUAGE                equ     LANGUAGE_ENGLISH
USER_MODE               equ     USER_MODE_NORMAL
INTERNAL_COMMANDS       equ     INTERNAL_COMMANDS_EXCLUDE
MEMORY_VERSION          equ     MEMORY_VERSION_2
GRAPHICS_VERSION        equ     GRAPHICS_VERSION_2
;INCLUDE_DES            equ     INCUDE_DES_OFF


; Common.h

NULL    equ     0
true    equ     1
false   equ     0


; System\SystemMgr.h

sysAppLaunchCmdNormalLaunch     equ     0
sysAppLaunchCmdFind             equ     1
sysAppLaunchCmdGoTo             equ     2
sysAppLaunchCmdSyncNotify       equ     3
sysAppLaunchCmdTimeChange       equ     4
sysAppLaunchCmdSystemReset      equ     5
sysAppLaunchCmdAlarmTriggered   equ     6
sysAppLaunchCmdDisplayAlarm     equ     7
sysAppLaunchCmdCountryChange    equ     8
sysAppLaunchCmdSyncRequestLocal equ     9
sysAppLaunchCmdSyncRequest      equ     sysAppLaunchCmdSyncRequestLocal
sysAppLaunchCmdSaveData         equ     10
sysAppLaunchCmdInitDatabase     equ     11
sysAppLaunchCmdSyncCallApplicationV10   equ     12
sysAppLaunchCmdPanelCalledFromApp       equ     13
sysAppLaunchCmdReturnFromPanel  equ     14
sysAppLaunchCmdLookup           equ     15
sysAppLaunchCmdSystemLock       equ     16
sysAppLaunchCmdSyncRequestRemote        equ     17
sysAppLaunchCmdHandleSyncCallApp        equ     18
sysAppLaunchCmdAddRecord        equ     19

sysSvcLaunchCmdSetServiceID     equ     20
sysSvcLaunchCmdGetServiceID     equ     21
sysSvcLaunchCmdGetServiceList   equ     22
sysSvcLaunchCmdGetServiceInfo   equ     23


sysAppLaunchCmdFailedAppNotify  equ     24
sysAppLaunchCmdEventHook        equ     25
sysAppLaunchCmdExgReceiveData   equ     26
sysAppLaunchCmdExgAskUser       equ     27

sysDialLaunchCmdDial            equ     30
sysDialLaunchCmdHangUp          equ     31
sysDialLaunchCmdLast            equ     39

sysSvcLaunchCmdGetQuickEditLabel        equ     40
sysSvcLaunchCmdLast             equ     49

sysAppLaunchCmdCustomBase       equ     $8000

sysAppLaunchFlagNewThread       equ     $01
sysAppLaunchFlagNewStack        equ     $02
sysAppLaunchFlagNewGlobals      equ     $04
sysAppLaunchFlagUIApp   equ     $08
sysAppLaunchFlagSubCall equ     $10
sysAppLaunchFlagDataRelocated   equ     $80

sysAppLaunchFlagPrivateSet      equ     sysAppLaunchFlagSubCall | sysAppLaunchFlagDataRelocated

struct SysAppLaunchCmdSaveDataType
        uiComing.b
endstruct

struct SysAppLaunchCmdSystemResetType
        hardReset.b
        createDefaultDB.b
endstruct

struct SysAppLaunchCmdInitDatabaseType
        dbP.l
        creator.l
        type.l
        version.w
endstruct

struct SysAppLaunchCmdSyncCallApplicationTypeV10
        action.w
        paramSize.w
        paramP.l
        remoteSocket.b
        tid.b
        handled.b
        bPad.b
endstruct

struct SysAppLaunchCmdHandleSyncCallAppType
        pbSize.w
        action.w
        paramP.l
        dwParamSize.l
        dlRefP.l
        handled.b
        pad.b
        replyErr.w
        dwReserved1.l
        dwReserved2.l
endstruct

struct SysAppLaunchCmdFailedAppNotifyType
        creator.l
        type.l
        result.w
endstruct

struct SysLibTblEntryType
        dispatchTblP.l
        globalsP.l
        dbID.l
        codeRscH.l
endstruct

sysDbgCommLibraryRefNum equ     0

sysInvalidRefNum        equ     $FFFF

memErrorClass   equ     $0100
dmErrorClass    equ     $0200
serErrorClass   equ     $0300
slkErrorClass   equ     $0400
sysErrorClass   equ     $0500
fplErrorClass   equ     $0600
flpErrorClass   equ     $0680
evtErrorClass   equ     $0700
sndErrorClass   equ     $0800
almErrorClass   equ     $0900
timErrorClass   equ     $0A00
penErrorClass   equ     $0B00
ftrErrorClass   equ     $0C00
cmpErrorClass   equ     $0D00
dlkErrorClass   equ     $0E00
padErrorClass   equ     $0F00
grfErrorClass   equ     $1000
mdmErrorClass   equ     $1100
netErrorClass   equ     $1200
htalErrorClass  equ     $1300
inetErrorClass  equ     $1400
exgErrorClass   equ     $1500
fileErrorClass  equ     $1600
rfutErrorClass  equ     $1700

appErrorClass   equ     $8000

sysErrTimeout           equ     sysErrorClass | 1
sysErrParamErr          equ     sysErrorClass | 2
sysErrNoFreeResource    equ     sysErrorClass | 3
sysErrNoFreeRAM         equ     sysErrorClass | 4
sysErrNotAllowed        equ     sysErrorClass | 5
sysErrSemInUse          equ     sysErrorClass | 6
sysErrInvalidID         equ     sysErrorClass | 7
sysErrOutOfOwnerIDs     equ     sysErrorClass | 8
sysErrNoFreeLibSlots    equ     sysErrorClass | 9
sysErrLibNotFound       equ     sysErrorClass | 10
sysErrDelayWakened      equ     sysErrorClass | 11
sysErrRomIncompatible   equ     sysErrorClass | 12

sysFtrCreator   equ     sysFileCSystem
sysFtrNumROMVersion     equ     1
;sysFtrNumProductID     equ     2       ; Obsolete in 3.1+
sysFtrNumBacklight      equ     3
sysFtrNumEncryption     equ     4
sysFtrNumEncryptionMaskDES      equ     $00000001
sysFtrNumCountry        equ     5
sysFtrNumLanguage       equ     6
sysFtrNumDisplayDepth   equ     7

sysFtrNumHwrMiscFlags           equ     8
sysFtrNumHwrMiscFlagsExt        equ     9
sysFtrNumIntlMgr                equ     10
sysFtrNumEncoding               equ     11
sysFtrDefaultFont               equ     12
sysFtrDefaultBoldFont           equ     13
sysFtrNumGremlinsSupportGlobals equ     14
sysFtrNumVendor                 equ     15
sysFtrNumCharEncodingFlags      equ     16
sysFtrNumNotifyMgrVersion       equ     17
sysFtrNumOEMROMVersion          equ     18
sysFtrNumErrorCheckLevel        equ     19
sysFtrNumOEMCompanyID           equ     20
sysFtrNumOEMDeviceID            equ     21
sysFtrNumOEMHALID               equ     22
sysFtrNumDefaultCompression     equ     23
sysFtrNumWinVersion             equ     24
sysFtrNumAccessorTrapPresent    equ     25


sysFtrNumProcessorID    equ     2       ; 0xMMMMRRRR, where MMMM is the processor model and RRRR is the revision.
sysFtrNumProcessorMask  equ     $FFFF0000       ; Mask to obtain processor model
sysFtrNumProcessor328   equ     $00010000       ; Motorola 68328  (Dragonball)
sysFtrNumProcessorEZ    equ     $00020000       ; Motorola 68EZ328  (Dragonball


sysROMTokenSnum equ     'snum'




sysROMStageDevelopment  equ     0
sysROMStageAlpha        equ     1
sysROMStageBeta         equ     2
sysROMStageRelease      equ     3

; SysBatteryKind
sysBatteryKindAlkaline  equ     0
sysBatteryKindNiCad     equ     1
sysBatteryKindLithium   equ     2


struct SysDBListItemType
        name.32
        creator.l
        type.l
        version.w
        dbID.l
        cardNo.w
        iconP.l
endstruct

struct SysMailboxMsgType
        data.12
endstruct

sysEvGroupSignalConstant        equ     0
sysEvGroupSignalPulse   equ     1
sysEvGroupWaitOR        equ     0
sysEvGroupWaitAND       equ     1

sysFileDescStdIn        equ     0


; System\SysUtils.h

sysRandomMax    equ     $7FFF


; System\SystemPrv.h

sysCardSignature        equ     $FEEDBEEF
sysStoreSignature       equ     $FEEDFACE

sysLowMemSize   equ     $1480
sysInitStack    equ     sysLowMemSize+$1000

sysRAMOnlyCardHeaderOffset      equ     $0000000
sysCardHeaderSize       equ     $0100

sysROMStoreRelOffset    equ     sysCardHeaderSize
sysStoreHeaderSize      equ     $0100

sysMaxHeapsPerCard      equ     128

;sysDefaultLibraries    equ     DEFAULT_LIB_ENTRIES

sysDefaultSerPort       equ     1
sysDefaultSerBaud       equ     57600

struct SysAppPrefs
        priority.w
        stackSize.l
        minHeapSpace.l
endstruct

struct SysAppInfoType
        cmd.w
        cmdPBP.l
        launchFlags.w
        taskID.l
        codeH.l
        dbP.l
        stackP.l
        globalsChunkP.l
        memOwnerID.w
        dmAccessP.l
        dmLastErr.w
        errExceptionP.l
        a5Ptr.l
        stackEndP.l
        globalEndP.l
        rootP.l
        extraP.l
endstruct

struct SysTCBUserInfoType
        tmpAppInfoP.l
        rootAppInfoP.l
        initialA5.l
endstruct

struct SysNVParamsType
        rtcHours.l
        rtcHourMinSecCopy.l
endstruct

sysFileDescNet  equ     sysFileDescStdIn+1

sysResetFlagHardReset   equ     $01
sysResetFlagCreateDefaultDBs    equ     $02
sysResetFlagNoExtensions        equ     $04

sysPrefFlagTaxiDisable  equ     $0001
sysPrefFlagEnableEasterEggs     equ     $0002
sysPrefFlagTaxiDisIdle  equ     $8000

sysPrefFlagTaxiDisIdleTime      equ     $4000

sysMiscFlagInFatalAlert equ     $0001
sysMiscFlagAlwaysSwitchApp      equ     $0002

sysMiscFlagProfile      equ     $0004
sysMiscFlagGrfDisable   equ     $0008
sysMiscFlagInDemoAlert  equ     $0010
sysMiscFlagBacklightDisable     equ     $0020
sysMiscFlagUIInitialized        equ     $0040
sysMiscFlagExgEvent     equ     $0080

dbgEnteredFlagPseudoNMI equ     $80


; Hardware\M68KHwr.h

m68kTrapInstr           equ     $4E40
m68kTrapVectorMask      equ     $000F

struct M68KExcTableType
        initStack.l
        initPC.l
        busErr.w
        addressErr.w
        illegalInstr.l
        divideByZero.l
        chk.l
        trap.l
        privilege.l
        trace.l
        aTrap.l
        fTrap.l
        reserved12.l
        coproc.l
        formatErr.w
        unitializedInt.l
        reserved.32
        spuriousInt.l
        autoVec1.l
        autoVec2.l
        autoVec3.l
        autoVec4.l
        autoVec5.l
        autoVec6.l
        autoVec7.l
        trapN.64
        unassigned.64
endstruct

struct M68KRegsType
        d.32
        a.28
        usp.l
        ssp.l
        pc.l
        sr.w
endstruct

m68kSrTraceMask         equ     $08000
m68kSrTraceBit          equ     15

m68kSrSupervisorMask    equ     $02000

m68kSrInterruptMask     equ     $00700

m68kSrExtendMask        equ     $00010
m68kSrNegativeMask      equ     $00008
m68kSrZeroMask          equ     $00004
m68kSrOverflowMask      equ     $00002
m68kSrCarryMask         equ     $00001


; System\SoundMgr.h

sndMaxAmp       equ     64
sndDefaultAmp   equ     sndMaxAmp
sndMidiNameLength       equ     32

; SndCmdIDType
sndCmdFreqDurationAmp   equ     1
sndCmdNoteOn    equ     2
sndCmdFrqOn     equ     3
sndCmdQuiet     equ     4

struct SndCommandType
        cmd.w
        param1.l
        param2.w
        param3.w
endstruct

; SndSysBeepType
sndInfo equ     1
sndWarning      equ     2
sndError        equ     3
sndStartUp      equ     4
sndAlarm        equ     5
sndConfirmation equ     6
sndClick        equ     7

sndMidiRecSignature     equ     'PMrc'

struct SndMidiRecHdrType
        signature.l
        bDataOffset.b
        reserved.b
endstruct

struct SndMidiRecType
        hdr.SndMidiRecHdrType
        name.b
endstruct

struct SndMidiListItemType
        name.32
        uniqueRecID.l
        dbID.l
        cardNo.w
endstruct

; SndSmfCmdEnum
sndSmfCmdPlay   equ     1
sndSmfCmdDuration       equ     2

struct SndCallbackInfoType
        funcP.l
        dwUserData.l
endstruct

struct SndSmfCallbacksType
        completion.l
        blocking.l
        reserved.l
endstruct

sndSmfPlayAllMilliSec   equ     $FFFFFFFF

struct SndSmfOptionsType
        dwStartMilliSec.l
        dwEndMilliSec.l
        amplitude.w
        interruptible.b
        pad.b
        reserved.l
endstruct

struct SndSmfChanRangeType
        bFirstChan.b
        bLastChan.b
endstruct

sndErrBadParam          equ     sndErrorClass | 1
sndErrBadChannel        equ     sndErrorClass | 2
sndErrMemory            equ     sndErrorClass | 3
sndErrOpen              equ     sndErrorClass | 4
sndErrQFull             equ     sndErrorClass | 5
sndErrQEmpty            equ     sndErrorClass | 6
sndErrFormat            equ     sndErrorClass | 7
sndErrBadStream         equ     sndErrorClass | 8
sndErrInterrupted       equ     sndErrorClass | 9


; System\SoundPrv.h

sndSamplingRate equ     8000

sndBeepDurationMSec     equ     70
sndConfirmationDurationMSec     equ     70
sndClickDurationMSec    equ     9

sndInfoFreq     equ     500
sndWarningFreq  equ     500
sndErrorFreq    equ     500
sndConfirmationFreq     equ     500
sndStartUpFreq  equ     1000
sndClickFreq    equ     200

struct SndGlobalsType
        smID.l
        sysAmp.b
        alarmAmp.b
        defAmp.b
        pad.b
        wMidiFrqTabP.l
endstruct


; System\Preferences.h

noPreferenceFound       equ     -1

preferenceDataVersion   equ     4

defaultAutoOffDuration  equ     2

; SoundLevelTypeV20
slOn    equ     0
slOff   equ     1

defaultSysSoundLevel    equ     slOn
defaultGameSoundLevel   equ     slOn
defaultAlarmSoundLevel  equ     slOn

defaultSysSoundVolume   equ     sndMaxAmp
defaultGameSoundVolume  equ     sndMaxAmp
defaultAlarmSoundVolume equ     sndMaxAmp

; CountryType;
cAustralia      equ     0
cAustria        equ     1
cBelgium        equ     2
cBrazil equ     3
cCanada equ     4
cDenmark        equ     5
cFinland        equ     6
cFrance equ     7
cGermany        equ     8
cHongKong       equ     9
cIceland        equ     10
cIreland        equ     11
cItaly  equ     12
cJapan  equ     13
cLuxembourg     equ     14
cMexico equ     15
cNetherlands    equ     16
cNewZealand     equ     17
cNorway equ     18
cSpain  equ     19
cSweden equ     20
cSwitzerland    equ     21
cUnitedKingdom  equ     22
cUnitedStates   equ     23

countryFirst    equ     cAustralia
countryLast     equ     cUnitedStates
countryCount    equ     countryLast - countryFirst + 1

;???typedef enum
;???    tfColon,
;???    tfColonAMPM,
;???    tfColon24h,
;???    tfDot,
;???    tfDotAMPM,
;???    tfDot24h,
;???    tfHoursAMPM,
;???    tfHours24h,
;???    tfComma24h
;???    } TimeFormatType;

;???typedef enum {
;???    dsNone,
;???    dsUSA,
;???    dsAustralia,
;???    dsWesternEuropean,
;???    dsMiddleEuropean,
;???    dsEasternEuropean,
;???    dsGreatBritain,
;???    dsRumania,
;???    dsTurkey,
;???    dsAustraliaShifted
;???    } DaylightSavingsTypes;

;???typedef enum {
;???    dfMDYWithSlashes,
;???    dfDMYWithSlashes,
;???    dfDMYWithDots,
;???    dfDMYWithDashes,
;???    dfYMDWithSlashes,
;???    dfYMDWithDots,
;???    dfYMDWithDashes,
;???    dfMDYLongWithComma,
;???    dfDMYLong,
;???    dfDMYLongWithDot,
;???    dfDMYLongNoDay,
;???    dfDMYLongWithComma,
;???    dfYMDLongWithDot,
;???    dfYMDLongWithSpace,
;???    dfMYMed,
;???    dfMYMedNoPost
;???    } DateFormatType;

;???typedef enum {
;???    nfCommaPeriod,
;???    nfPeriodComma,
;???    nfSpaceComma,
;???    nfApostrophePeriod,
;???    nfApostropheComma
;???    } NumberFormatType;

countryNameLength       equ     20
currencyNameLength      equ     20
currencySymbolLength    equ     6

;struct
;       CountryType country;                                    // Country the structure represents
;       countryName[countryNameLength].b
;       DateFormatType dateFormat;                      // Format to display date in
;       longDateFormat.l
;       weekStartDay.b
;       TimeFormatType timeFormat;                      // Format to display time in
;       NumberFormatType numberFormat;  // Format to display numbers in
;       currencyName[currencyNameLength].b
;       currencySymbol[currencySymbolLength].b
;       uniqueCurrencySymbol[currencySymbolLength].b
;       currencyDecimalPlaces.b
;       DaylightSavingsTypes    daylightSavings;        // Type of daylight savings correction
;       minutesWestOfGMT.l
;endstruct CountryPreferencesTypeCountryPreferencesType

;???typedef enum {
;???    alOff,
;???    alEventsOnly,
;???    alEventsAndRandom,
;???    alEventsAndMoreRandom
;???    } AnimationLevelType;

;???typedef enum
;???    prefVersion,
;???    prefCountry,
;???    prefDateFormat,
;???    prefLongDateFormat,
;???    prefWeekStartDay,
;???    prefTimeFormat,
;???    prefNumberFormat,
;???    prefAutoOffDuration,
;???    prefSysSoundLevelV20,
;???    prefGameSoundLevelV20,
;???    prefAlarmSoundLevelV20,
;???    prefHidePrivateRecords,
;???    prefDeviceLocked,
;???    prefLocalSyncRequiresPassword,
;???    prefRemoteSyncRequiresPassword,
;???    prefSysBatteryKind,
;???    prefAllowEasterEggs,
;???    prefMinutesWestOfGMT,
;???    prefDaylightSavings,
;???    prefRonamaticChar,
;???    prefHard1CharAppCreator,
;???    prefHard2CharAppCreator,
;???    prefHard3CharAppCreator,
;???    prefHard4CharAppCreator,
;???    prefCalcCharAppCreator,
;???    prefHardCradleCharAppCreator,
;???    prefLauncherAppCreator,
;???    prefSysPrefFlags,
;???    prefHardCradle2CharAppCreator,
;???    prefAnimationLevel,
;???    prefSysSoundVolume,
;???    prefGameSoundVolume,
;???    prefAlarmSoundVolume,
;???    prefBeamReceive,
;???    prefCalibrateDigitizerAtReset,
;???    prefSystemKeyboardID,
;???    prefDefSerialPlugIn
;???    } SystemPreferencesChoice;

;struct {
;       version.w
;       International.w
;       CountryType country;                                    // Country the device is in
;       DateFormatType dateFormat;                      // Format to display date in
;       longDateFormat.l
;       weekStartDay.b
;       TimeFormatType timeFormat;                      // Format to display time in
;       NumberFormatType numberFormat;  // Format to display numbers in
;
;       // system preferences
;       autoOffDuration.b
;       SoundLevelTypeV20 sysSoundLevel;                //      High, Med, Low, Off - error beeps
;       SoundLevelTypeV20 alarmSoundLevel;      //      High, Med, Low, Off - alarm only
;       hideSecretRecords.b
;       deviceLocked.b
;       sysPrefFlags.w
;       SysBatteryKind  sysBatteryKind; // The type of batteries installed. This
;endstruct SystemPreferencesTypeV10SystemPreferencesTypeV10

struct SystemPreferencesTypeV10
    version.w
    country.b
    dateFormat.b
    longDateFormat.b
    weekStartDay.b
    timeFormat.b
    numberFormat.b
    autoOffDuration.b
    sysSoundLevel.b
    alarmSoundLevel.b
    hideSecretRecords.b
    deviceLocked.b
    bPad.b
    sysPrefFlags.w
    sysBatteryKind.b
    bPad2.b
endstruct

struct SystemPreferencesType
        version.w
        International.w
        country.b
        dateFormat.b
        longDateFormat.l
        weekStartDay.b
        timeFormat.b
        numberFormat.b
        autoOffDuration.b
        sysSoundLevelV20.b
        gameSoundLevelV20.b
        alarmSoundLevelV20.b
        hideSecretRecords.b
        deviceLocked.b
        localSyncRequiresPassword.b
        remoteSyncRequiresPassword.b
        pad.b
        sysPrefFlags.w
        sysBatteryKind.b
        pad2.b
        minutesWestOfGMT.l
        daylightSavings.b
        pad3.b
        romanaticChar.w
        hard1CharAppCreator.l
        hard2CharAppCreator.l
        hard3CharAppCreator.l
        hard4CharAppCreator.l
        calcCharAppCreator.l
        hardCradleCharAppCreator.l
        launcherCharAppCreator.l
        hardCradle2CharAppCreator.l
        animationLevel.b
        pad4.b
        sysSoundVolume.w
        gameSoundVolume.w
        alarmSoundVolume.w
        beamReceive.b
        calibrateDigitizerAtReset.b
        systemKeyboardID.w
        defSerialPlugIn.l
endstruct


; Hardware\M68328Hwr.h

struct HwrDBallType
        scr.b
        filler1.255
        csAGroupBase.w
        csBGroupBase.w
        csCGroupBase.w
        csDGroupBase.w
        csAGroupMask.w
        csBGroupMask.w
        csCGroupMask.w
        csDGroupMask.w
        csASelect0.l
        csASelect1.l
        csASelect2.l
        csASelect3.l
        csBSelect0.l
        csBSelect1.l
        csBSelect2.l
        csBSelect3.l
        csCSelect0.l
        csCSelect1.l
        csCSelect2.l
        csCSelect3.l
        csDSelect0.l
        csDSelect1.l
        csDSelect2.l
        csDSelect3.l
        csDebug.w
        filler2.174
        pllControl.w
        pllFreqSel.w
        pllTest.w
        filler44.b
        pwrControl.b
        filler3.248
        intVector.w
        filler4.b
        intControl.w
        intMaskHi.w
        intMaskLo.w
        intWakeupEnHi.w
        intWakeupEnLo.w
        intStatusHi.w
        intStatusLo.w
        intPendingHi.w
        intPendingLo.w
        filler4a.236
        portADir.b
        portAData.b
        filler5.b
        portASelect.b
        filler6.4
        portBDir.b
        portBData.b
        filler7.b
        portBSelect.b
        filler8.4
        portCDir.b
        portCData.b
        filler9.b
        portCSelect.b
        filler10.4
        portDDir.b
        portDData.b
        portDPullupEn.b
        filler11.b
        portDPolarity.b
        portDIntReqEn.w
        filler12.b
        portDIntEdge.w
        portEDir.b
        portEData.b
        portEPullupEn.b
        portESelect.b
        filler14.4
        portFDir.b
        portFData.b
        portFPullupEn.b
        portFSelect.b
        filler16.4
        portGDir.b
        portGData.b
        portGPullupEn.b
        portGSelect.b
        filler18.4
        portJDir.b
        portJData.b
        filler19.b
        portJSelect.b
        filler19a.4
        portKDir.b
        portKData.b
        portKPullupEn.b
        portKSelect.b
        filler21.4
        portMDir.b
        portMData.b
        portMPullupEn.b
        portMSelect.b
        filler22.4
        filler23.176
        pwmControl.w
        pwmPeriod.w
        pwmWidth.w
        pwmCounter.w
        filler24.248
        tmr1Control.w
        tmr1Prescaler.w
        tmr1Compare.w
        tmr1Capture.w
        tmr1Counter.w
        tmr1Status.w
        tmr2Control.w
        tmr2Prescaler.w
        tmr2Compare.w
        tmr2Capture.w
        tmr2Counter.w
        tmr2Status.w
        wdControl.w
        wdReference.w
        wdCounter.w
        filler25.226
        spiSlave.w
        filler26.254
        spiMasterData.w
        spiMasterControl.w
        filler27.252
        uControl.w
        uBaud.w
        uReceive.w
        uTransmit.w
        uMisc.w
        filler28.246
        lcdStartAddr.l
        filler29.b
        lcdPageWidth.b
        filler30.2
        lcdScreenWidth.w
        lcdScreenHeight.w
        filler31.12
        lcdCursorXPos.w
        lcdCursorYPos.w
        lcdCursorWidthHeight.w
        filler32.b
        lcdBlinkControl.b
        lcdPanelControl.w
        lcdPolarity.b
        filler33.b
        lcdACDRate.b
        filler34.b
        lcdPixelClock.b
        filler35.b
        lcdClockControl.b
        filler36.b
        lcdLastBufferAddr.b
        filler37.b
        lcdOctetTermCount.b
        filler38.b
        lcdPanningOffset.b
        filler39.3
        lcdFrameRate.b
        lcdGrayPalette.w
        lcdReserved.b
        filler40.203
        rtcHourMinSec.l
        rtcAlarm.l
        rtcReserved.l
        rtcControl.w
        rtcIntStatus.w
        rtcIntEnable.w
        stopWatch.w
endstruct

hwr328LcdCursorXPosCtlMask      equ     $C000
hwr328LcdCursorXPosCtlTrans     equ     $0000
hwr328LcdCursorXPosCtlBlack     equ     $4000
hwr328LcdCursorXPosCtlReverse   equ     $8000

hwr328LcdBlinkControlEnable     equ     $80

hwr328LcdPanelControlBusMask    equ     $06
hwr328LcdPanelControlBus1Bit    equ     $00
hwr328LcdPanelControlBus2Bit    equ     $02
hwr328LcdPanelControlBus4Bit    equ     $04
hwr328LcdPanelControlGrayScale  equ     $01

hwr328LcdPolarityShiftClock     equ     $08
hwr328LcdPolarityFLM            equ     $04
hwr328LcdPolarityLP             equ     $02
hwr328LcdPolarityPixel          equ     $01

hwr328LcdClockControlEnable     equ     $80
hwr328LcdClockControl16WordBursts       equ     $40
hwr328LcdClockControlBurstRateMask      equ     $30

hwr328LcdClockControlBurstRate1         equ     $00
hwr328LcdClockControlBurstRate2         equ     $04
hwr328LcdClockControlBurstRate3         equ     $08
hwr328LcdClockControlBurstRate4         equ     $0C
hwr328LcdClockControlBurstRate5         equ     $10
hwr328LcdClockControlBurstRate6         equ     $14
hwr328LcdClockControlBurstRate7         equ     $18
hwr328LcdClockControlBurstRate8         equ     $1C
hwr328LcdClockControlBurstRate9         equ     $20
hwr328LcdClockControlBurstRate10        equ     $24
hwr328LcdClockControlBurstRate11        equ     $28
hwr328LcdClockControlBurstRate12        equ     $2C
hwr328LcdClockControlBurstRate13        equ     $30
hwr328LcdClockControlBurstRate14        equ     $34
hwr328LcdClockControlBurstRate15        equ     $38
hwr328LcdClockControlBurstRate16        equ     $3C

hwr328LcdClockControl8BitBus            equ     $02
hwr328LcdClockControlPixelClkSrc        equ     $01

hwr328IntHiNMI          equ     $0080
hwr328IntHiTimer1       equ     $0040
hwr328IntHiSPIS         equ     $0020
hwr328IntHiPen          equ     $0010
hwr328IntHiIRQ6         equ     $0008
hwr328IntHiIRQ3         equ     $0004
hwr328IntHiIRQ2         equ     $0002
hwr328IntHiIRQ1         equ     $0001

hwr328IntHiIRQ6Clr      equ     $0001
hwr328IntHiIRQ3Clr      equ     $0002
hwr328IntHiIRQ2Clr      equ     $0004
hwr328IntHiIRQ1Clr      equ     $0008

hwr328IntLoInt7         equ     $8000
hwr328IntLoInt6         equ     $4000
hwr328IntLoInt5         equ     $2000
hwr328IntLoInt4         equ     $1000
hwr328IntLoInt3         equ     $0800
hwr328IntLoInt2         equ     $0400
hwr328IntLoInt1         equ     $0200
hwr328IntLoInt0         equ     $0100
hwr328IntLoAllKeys      equ     $FF00
hwr328IntLoInt0Bit      equ     8
hwr328IntLoPWM          equ     $0080
hwr328IntLoPWMBit       equ     7
hwr328IntLoKbd          equ     $0040
hwr328IntLoLCDC         equ     $0020
hwr328IntLoRTC          equ     $0010
hwr328IntLoRTCBit       equ     4
hwr328IntLoWDT          equ     $0008
hwr328IntLoUART         equ     $0004
hwr328IntLoUARTBit      equ     2
hwr328IntLoTimer2       equ     $0002
hwr328IntLoTimer2Bit    equ     1
hwr328IntLoSPIM         equ     $0001

hwr328IntCtlEdge1       equ     $0800
hwr328IntCtlEdge2       equ     $0400
hwr328IntCtlEdge3       equ     $0200
hwr328IntCtlEdge6       equ     $0100
hwr328IntCtlPol1        equ     $8000
hwr328IntCtlPol2        equ     $4000
hwr328IntCtlPol3        equ     $2000
hwr328IntCtlPol6        equ     $1000

hwr328TmrControlUnused                  equ     $FE00
hwr328TmrControlFreeRun                 equ     $0100
hwr328TmrControlCaptureEdgeMask         equ     $00C0
hwr328TmrControlCaptureEdgeNone         equ     $0000
hwr328TmrControlCaptureEdgeRising       equ     $0040
hwr328TmrControlCaptureEdgeFalling      equ     $0080
hwr328TmrControlCaptureEdgeBoth         equ     $00C0
hwr328TmrControlOutputModeToggle        equ     $0020
hwr328TmrControlEnInterrupt             equ     $0010
hwr328TmrControlClkSrcMask              equ     $000E
hwr328TmrControlClkSrcStop              equ     $0000
hwr328TmrControlClkSrcSys               equ     $0002
hwr328TmrControlClkSrcSysBy16           equ     $0004
hwr328TmrControlClkSrcTIN               equ     $0006
hwr328TmrControlClkSrc32KHz             equ     $0008
hwr328TmrControlEnable                  equ     $0001

hwr328TmrStatusCapture          equ     $0002
hwr328TmrStatusCaptureBit       equ     1
hwr328TmrStatusCompare          equ     $0001
hwr328TmrStatusCompareBit       equ     0

hwr328UControlUARTEnable        equ     $8000
hwr328UControlRxEnable          equ     $4000
hwr328UControlTxEnable          equ     $2000
hwr328UControlRxClock1x         equ     $1000
hwr328UControlParityEn          equ     $0800
hwr328UControlParityOdd         equ     $0400
hwr328UControlStopBits2         equ     $0200
hwr328UControlDataBits8         equ     $0100
hwr328UControlGPIODeltaEn       equ     $0080
hwr328UControlCTSDeltaEn        equ     $0040
hwr328UControlRxFullEn          equ     $0020
hwr328UControlRxHalfEn          equ     $0010
hwr328UControlRxRdyEn           equ     $0008
hwr328UControlTxEmptyEn         equ     $0004
hwr328UControlTxHalfEn          equ     $0002
hwr328UControlTxAvailEn         equ     $0001

hwr328UControlEnableAll         equ     hwr328UControlUARTEnable | hwr328UControlRxEnable | hwr328UControlTxEnable

hwr328UBaudGPIODelta            equ     $8000
hwr328UBaudGPIOData             equ     $4000
hwr328UBaudGPIODirOut           equ     $2000
hwr328UBaudGPIOSrcBaudGen       equ     $1000
hwr328UBaudBaudSrcGPIO          equ     $0800
hwr328UBaudDivider              equ     $0700
hwr328UBaudPrescaler            equ     $003F

hwr328UBaudDivideBitOffset      equ     8

hwr328UReceiveFIFOFull          equ     $8000
hwr328UReceiveFIFOHalf          equ     $4000
hwr328UReceiveDataRdy           equ     $2000
hwr328UReceiveDataRdyBit        equ     13
hwr328UReceiveOverrunErr        equ     $0800
hwr328UReceiveOverrunErrBit     equ     11
hwr328UReceiveFrameErr          equ     $0400
hwr328UReceiveFrameErrBit       equ     10
hwr328UReceiveBreakErr          equ     $0200
hwr328UReceiveBreakErrBit       equ     9
hwr328UReceiveParityErr         equ     $0100
hwr328UReceiveParityErrBit      equ     8
hwr328UReceiveData              equ     $00FF

hwr328UReceiveErrsMask          equ     hwr328UReceiveOverrunErr | hwr328UReceiveFrameErr | hwr328UReceiveBreakErr | hwr328UReceiveParityErr

hwr328UTransmitFIFOEmpty        equ     $8000
hwr328UTransmitFIFOHalf         equ     $4000
hwr328UTransmitTxAvail          equ     $2000
hwr328UTransmitSendBreak        equ     $1000
hwr328UTransmitIgnoreCTS        equ     $0800
hwr328UTransmitCTSStatus        equ     $0200
hwr328UTransmitCTSDelta         equ     $0100
hwr328UTransmitData             equ     $00FF

hwr328UMiscClkSrcGPIO           equ     $4000
hwr328UMiscForceParityErr       equ     $2000
hwr328UMiscLoopback             equ     $1000
hwr328UMiscReservedMask         equ     $8F00
hwr328UMiscRTSThruFIFO          equ     $0080
hwr328UMiscRTSOut               equ     $0040
hwr328UMiscIRDAEn               equ     $0020
hwr328UMiscLoopIRDA             equ     $0010
hwr328UMiscUnused               equ     $000F

hwr328PWMControlEnable          equ     $0010
hwr328PWMControlEnableBit       equ     4
hwr328PWMControlEnableIRQ       equ     $4000
hwr328PWMControlLoad            equ     $0100
hwr328PWMIRQStatus              equ     $8000

hwr328PWMControlDivMask         equ     $0007
hwr328PWMControlDivBy2          equ     $0
hwr328PWMControlDivBy4          equ     $1
hwr328PWMControlDivBy8          equ     $2
hwr328PWMControlDivBy16         equ     $3
hwr328PWMControlDivBy32         equ     $4
hwr328PWMControlDivBy64         equ     $5
hwr328PWMControlDivBy128        equ     $6
hwr328PWMControlDivBy256        equ     $7

hwr328PLLControlDisable         equ     $0008
hwr328PLLControlClkEn           equ     $0010

hwr328PLLControlSysVCODiv2      equ     $0000
hwr328PLLControlSysVCODiv4      equ     $0100
hwr328PLLControlSysVCODiv8      equ     $0200
hwr328PLLControlSysVCODiv16     equ     $0300
hwr328PLLControlSysVCODiv1      equ     $0400

hwr328PLLControlPixVCODiv2      equ     $0000
hwr328PLLControlPixVCODiv4      equ     $080
hwr328PLLControlPixVCODiv8      equ     $1000
hwr328PLLControlPixVCODiv16     equ     $1800
hwr328PLLControlPixVCODiv1      equ     $2000

hwr328RTCControlRTCEnable       equ     $80
hwr328RTCControlRefSelMask      equ     $20
hwr328RTCControlRefSel38400     equ     $20
hwr328RTCControlRefSel32768     equ     $00

hwr328RTCIntEnableSec           equ     $10
hwr328RTCIntEnable24Hr          equ     $08
hwr328RTCIntEnableAlarm         equ     $04
hwr328RTCIntEnableMinute        equ     $02
hwr328RTCIntEnableStopWatch     equ     $01

hwr328RTCIntStatusSec           equ     $10
hwr328RTCIntStatus24Hr          equ     $08
hwr328RTCIntStatusAlarm         equ     $04
hwr328RTCIntStatusMinute        equ     $02
hwr328RTCIntStatusStopWatch     equ     $01

hwr328RTCAlarmSecondsMask       equ     $0000003f
hwr328RTCAlarmSecondsOffset     equ     0
hwr328RTCAlarmMinutesMask       equ     $003f0000
hwr328RTCAlarmMinutesOffset     equ     16
hwr328RTCAlarmHoursMask         equ     $1f000000
hwr328RTCAlarmHoursOffset       equ     24


hwr328RTCHourMinSecSecondsMask          equ     $0000003f
hwr328RTCHourMinSecSecondsOffset        equ     0
hwr328RTCHourMinSecMinutesMask          equ     $003f0000
hwr328RTCHourMinSecMinutesOffset        equ     16
hwr328RTCHourMinSecHoursMask            equ     $1f000000
hwr328RTCHourMinSecHoursOffset          equ     24

hwr328SPIMControlRateMask       equ     $E000
hwr328SPIMControlRateDiv4       equ     $0000
hwr328SPIMControlRateDiv8       equ     $2000
hwr328SPIMControlRateDiv16      equ     $4000
hwr328SPIMControlRateDiv32      equ     $6000
hwr328SPIMControlRateDiv64      equ     $8000
hwr328SPIMControlRateDiv128     equ     $A000
hwr328SPIMControlRateDiv256     equ     $C000
hwr328SPIMControlRateDiv512     equ     $E000
hwr328SPIMControlEnable         equ     $0200
hwr328SPIMControlExchange       equ     $0100
hwr328SPIMControlIntStatus      equ     $0080
hwr328SPIMControlIntEnable      equ     $0040
hwr328SPIMControlOppPhase       equ     $0020
hwr328SPIMControlInvPolarity    equ     $0010
hwr328SPIMControlBitsMask       equ     $000F

hwr328PortCMOClk        equ     $01
hwr328PortCUDS          equ     $02
hwr328PortCLDS          equ     $04
hwr328PortCNMI          equ     $10
hwr328PortCDTack        equ     $20
hwr328PortCPcmciaWE     equ     $40

hwr328PortGUartTxD      equ     $01
hwr328PortGUartRxD      equ     $02
hwr328PortGPwmOut       equ     $04
hwr328PortGTOut2        equ     $08
hwr328PortGTIn2         equ     $10
hwr328PortGTOut1        equ     $20
hwr328PortGTIn1         equ     $40
hwr328PortGRtcOut       equ     $80

hwr328PortKSpimTxD      equ     $01
hwr328PortKSpimRxD      equ     $02
hwr328PortKSpimClkO     equ     $04
hwr328PortKSpisEn       equ     $08
hwr328PortKSpisRxD      equ     $10
hwr328PortKSpisClkI     equ     $20
hwr328PortKPcmciaCE2    equ     $40
hwr328PortKPcmciaCE1    equ     $80

hwr328PortMCTS          equ     $01
hwr328PortMRTS          equ     $02
hwr328PortMIRQ6         equ     $04
hwr328PortMIRQ3         equ     $08
hwr328PortMIRQ2         equ     $10
hwr328PortMIRQ1         equ     $20
hwr328PortMPenIRQ       equ     $40
hwr328PortMUnused7      equ     $80


; Hardware\M68681Hwr.h

struct read
        mra.b
        u0.b
        sra.b
        u2.b
        doNotAccess1.b
        u4.b
        rba.b
        u6.b
        ipcr.b
        u8.b
        isr.b
        uA.b
        cur.b
        uC.b
        clr.b
        uE.b
        mrb.b
        u10.b
        srb.b
        u12.b
        doNotAccess2.b
        u14.b
        rbb.b
        u16.b
        ivr.w
        u18.b
        ipr.b
        u1A.b
        startCtr.b
        u1C.b
        stopCtr.b
        u1E.b
endstruct

struct write
        mra.b
        u0.b
        csra.b
        u2.b
        cra.b
        u4.b
        tba.b
        u6.b
        acr.b
        u8.b
        imr.w
        uA.b
        ctur.b
        uC.b
        ctlr.b
        uE.b
        mrb.b
        u10.b
        csrb.b
        u12.b
        crb.b
        u14.b
        tbb.b
        u16.b
        ivr.w
        u18.b
        opcr.b
        u1A.b
        opSet.b
        u1C.b
        opReset.b
        u1E.b
endstruct

hwrDuartSRRegRB         equ     $80
hwrDuartSRRegFE         equ     $40
hwrDuartSRRegPE         equ     $20
hwrDuartSRRegOE         equ     $10
hwrDuartSRRegTxEMP      equ     $08
hwrDuartSRRegTxRDY      equ     $04
hwrDuartSRRegFFULL      equ     $02
hwrDuartSRRegRxRDY      equ     $01


; Hardware\HardwareTD1.h

hwrTD1PortDNoExtPower   equ     $80
hwrTD1PortENoBacklight  equ     $80
hwrTD1PortFPanelYPOff   equ     $01
hwrTD1PortFPanelYMOn    equ     $02
hwrTD1PortFPanelXPOff   equ     $04
hwrTD1PortFPanelXMOn    equ     $08
hwrTD1PortFLCDEnableOn  equ     $10
hwrTD1PortFLCDVccOff    equ     $20
hwrTD1PortFLCDVeeOn     equ     $40
hwrTD1PortFADCSOff      equ     $80
hwrTD1PortFPanelMask    equ     $0F
hwrTD1PortFPanelCfgOff  equ     hwrTD1PortFPanelYPOff | hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgPenIRQ       equ     hwrTD1PortFPanelXMOn | hwrTD1PortFPanelYPOff | hwrTD1PortFPanelXPOff
hwrTD1PortFPanelCfgYMeas        equ     hwrTD1PortFPanelXMOn | hwrTD1PortFPanelYPOff
hwrTD1PortFPanelCfgXMeas        equ     hwrTD1PortFPanelXPOff | hwrTD1PortFPanelYMOn
hwrTD1PortGSerialOn     equ     $08
hwrTD1PortGBattOff      equ     $10
hwrTD1PortGRefreshOut   equ     $20
hwrTD1PortGSelfRefOff   equ     $40
hwrTD1PortGSelfRefOffBit        equ     6
hwrTD1PortGBacklightOn  equ     $80
hwrTD1PortJIrOn         equ     $10
hwrTD1PortJLedOn        equ     $20
hwrTD1PortMVccFail      equ     $04
hwrTD1PortMCardIRQ      equ     $08
hwrTD1PortMUnused4      equ     $10
hwrTD1PortMDockButton   equ     $20
hwrTD1PortMPenIO        equ     $40
hwrTD1PortMDockIn       equ     $80
hwrTD1SPIMBaseControl   equ     hwr328SPIMControlRateDiv16 | hwr328SPIMControlIntEnable | hwr328SPIMControlInvPolarity | hwr328SPIMControlOppPhase | 16-1

hwrTD1PLLControl        equ     hwr328PLLControlClkEn | hwr328PLLControlSysVCODiv1 | hwr328PLLControlPixVCODiv1
hwrTD1FreqSelQ          equ     $01
hwrTD1FreqSelP          equ     $23
hwrTD1Frequency         equ     32768*((hwrTD1FreqSelP+1)*14+hwrTD1FreqSelQ+1)/1


; Hardware\Hardware.h

hwrWakeUpGeneral        equ     $0001
hwrWakeUpPWM            equ     $0002
hwrWakeUpFromKey        equ     $0004
hwrWakeUpReturnToSleep  equ     $0008

hwrMiscFlagHasBacklight equ     $0001
hwrMiscFlagHasMbdIrDA   equ     $0002
hwrMiscFlagHasCardIrDA  equ     $0004
hwrMiscFlagHasBurrBrown equ     $0008
hwrMiscFlagHasJerryHW   equ     $0010

hwrMiscFlagID1  equ     $1000
hwrMiscFlagID2  equ     $2000
hwrMiscFlagID3  equ     $4000
hwrMiscFlagID4  equ     $8000
hwrMiscFlagIDMask       equ     $F000

hwrDockInSyncButton     equ     $0001
hwrDockInGeneric1       equ     $0002

hwrDockOutGeneric0      equ     $0001

hwrNumCardSlots         equ     1

hwrDisplayWidth         equ     160
hwrDisplayHeight        equ     160

hwrDisplayBootDepth     equ     1
hwrDisplayMaxDepth      equ     2
hwrDisplayAllDepths     equ     $0003

hwrDisplayPeriod        equ     12

hwrStepsPerVolt         equ     78
hwrVoltStepsOffset      equ     0

hwrSystemTop            equ     (hwrDisplayHeight+4)
hwrSystemHeight         equ     56

hwrGraffitiTop          equ     hwrSystemTop
hwrGraffitiLeft         equ     27
hwrGraffitiWidth        equ     106
hwrGraffitiHeight       equ     hwrSystemHeight
hwrGraffitiSplit        equ     hwrGraffitiLeft+62

hwrLaunchBtnLeft        equ     0
hwrLaunchBtnTop         equ     hwrSystemTop
hwrLaunchBtnWidth       equ     27
hwrLaunchBtnHeight      equ     hwrSystemHeight/2

hwrMenuBtnWidth         equ     27
hwrMenuBtnHeight        equ     hwrSystemHeight/2
hwrMenuBtnLeft          equ     0
hwrMenuBtnTop           equ     hwrSystemTop+hwrMenuBtnHeight

hwrCalcBtnLeft          equ     133
hwrCalcBtnTop           equ     hwrSystemTop
hwrCalcBtnWidth         equ     27
hwrCalcBtnHeight        equ     hwrSystemHeight/2

hwrFindBtnLeft          equ     133
hwrFindBtnTop           equ     hwrSystemTop+hwrCalcBtnHeight
hwrFindBtnWidth         equ     27
hwrFindBtnHeight        equ     hwrSystemHeight/2

hwrKeyboardAlphaBtnLeft equ     27
hwrKeyboardAlphaBtnTop  equ     (hwrSystemTop+hwrSystemHeight-hwrSystemHeight/4)
hwrKeyboardAlphaBtnWidth        equ     18
hwrKeyboardAlphaBtnHeight       equ     (hwrSystemHeight/4)

hwrKeyboardNumericBtnWidth      equ     18
hwrKeyboardNumericBtnHeight     equ     hwrKeyboardAlphaBtnHeight
hwrKeyboardNumericBtnLeft       equ     hwrFindBtnLeft-hwrKeyboardNumericBtnWidth
hwrKeyboardNumericBtnTop        equ     hwrKeyboardAlphaBtnTop

hwrLCDGetCurrentDepth   equ     0

struct HwrROMTokenRec
        token.l
        len.w
        data.b
endstruct

hwrROMTokenSnum equ     'snum'
hwrROMTokenIrda equ     'irda'
hwrROMTokenFlex equ     'flex'
hwrROMTokenBoot1        equ     'cd01'
hwrROMTokenBoot2        equ     'cd02'
hwrROMTokenBoot3        equ     'cd03'


; Hardware\HardwarePrv.h

hwr68328Base    equ     $FFFFF000

hwrCardBase0    equ     $10000000
hwrCardSize     equ     $10000000
hwrFlashBase    equ     $10C00000
hwrFlashSize    equ     $00100000
hwrCardOffsetMask       equ     $0FFFFFFF

hwrROMWidth     equ     2

hwrDuartBase    equ     $10E00000
hwrDuartClock   equ     3686400
hwrDuartACRReg  equ     $60


; System\AlarmMgr.h

almErrMemory    equ     almErrorClass | 1
almErrFull      equ     almErrorClass | 2

struct SysAlarmTriggeredParamType
        ref.l
        alarmSeconds.l
        purgeAlarm.b
        pad.b
endstruct

struct SysDisplayAlarmParamType
        ref.l
        alarmSeconds.l
        soundAlarm.b
        pad.b
endstruct


; System\AlarmPrv.h

almMinTableLength       equ     2
almMaxTableLength       equ     20

struct AlmEntryType
        ref.l
        alarmSeconds.l
        dbID.l
        cardNo.w
        quiet.w
        triggered.w
        notified.w
endstruct

struct AlmTableType
        numEntries.w
        list.20
endstruct

struct AlmGlobalsType
        tableH.l
        lastSoundSeconds.l
        displaying.w
        triggered.w
        disableCount.b
        pad.b
endstruct


; System\AppLaunchCmd.h

; AddressLookupFields;
addrLookupName  equ     0
addrLookupFirstName     equ     1
addrLookupCompany       equ     2
addrLookupAddress       equ     3
addrLookupCity  equ     4
addrLookupState equ     5
addrLookupZipCode       equ     6
addrLookupCountry       equ     7
addrLookupTitle equ     8
addrLookupCustom1       equ     9
addrLookupCustom2       equ     10
addrLookupCustom3       equ     11
addrLookupCustom4       equ     12
addrLookupNote  equ     13
addrLookupWork  equ     14
addrLookupHome  equ     15
addrLookupFax   equ     16
addrLookupOther equ     17
addrLookupEmail equ     18
addrLookupMain  equ     19
addrLookupPager equ     20
addrLookupMobile        equ     21
addrLookupSortField     equ     22
addrLookupListPhone     equ     23
addrLookupNoField       equ     $ff

addrLookupStringLength  equ     12

struct AddrLookupParamsType
        title.l
        pasteButtonText.l
        lookupString.12
        field1.b
        field2.b
        field2Optional.b
        userShouldInteract.b
        formatStringP.l
        resultStringH.l
        uniqueID.l
endstruct

;prefAppLaunchCmdSetActivePanel equ     sysAppaunchCmdCustomBase + 1

struct PrefActivePanelParamsType
        activePanel.l
endstruct


; MailMsgPriorityType
mailPriorityHigh        equ     0
mailPriorityNormal      equ     1
mailPriorityLow equ     2

struct MailAddRecordParamsType
        secret.b
        signature.b
        confirmRead.b
        confirmDelivery.b
        priority.b
        pad.b
        subject.l
        from.l
        to.l
        cc.l
        bcc.l
        replyTo.l
        body.l
endstruct


; System\CMClient.h

cmErrParam      equ     cmpErrorClass | 1
cmErrTimeOut    equ     cmpErrorClass | 2
cmErrComm       equ     cmpErrorClass | 3
cmErrCommVersion        equ     cmpErrorClass | 4
cmErrMemory     equ     cmpErrorClass | 5
cmErrCommBusy   equ     cmpErrorClass | 6
cmErrUserCan    equ     cmpErrorClass | 7

cmWakeupTransactionID   equ     $FF

struct CmParamType
        localSocket.w
        remoteSocket.w
        maxBaud.l
        viaModem.b
        abortProc.l
        userRef.l
endstruct

struct CmSessionType
        param.CmParamType
        serRefNum.w
endstruct


; System\CMCommon.h

; CmpType
cmpWakeup       equ     1
cmpInit         equ     2
cmpAbort        equ     3
cmpExtended     equ     4

struct CmpBodyType
        type.b
        flags.b
        verMajor.b
        verMinor.b
        wReserved.w
        commVersion.l
        baudRate.l
endstruct

cmpInitFlagChangeBaudRate       equ     $80
cmpInitFlagRcvTOut1Min  equ     $40
cmpInitFlagRcvTOut2Min  equ     $20

cmpAbortFlagVersionError        equ     $80

cmpWakeupTransactionID  equ     $FF

cmpInitialBaudRate      equ     9600

cmpMaxInitiateSec       equ     20

struct CmpCommandHeaderType
        hdrType.b
        cmd.b
        errorCode.w
        argCount.b
        reserved1.b
        reserved2.l
endstruct

;???typedef union CmpGenericCommandType {
;???    Byte                                            hdrType;        ;       ;
;???    ;CmpBodyType                            body10;
;???    ;CmpCommandHeaderType   exHdr;
;???    ;} CmpGenericCommandType;
;???    ;
;???type def CmpGenericCommandType*             CmpGenericCommandPtr;

cmpRespBit      equ     $80

cmpCmdIDMask    equ     $7f

cmpFirstArgID   equ     $20

; CmpRespErrEnum
cmpRespErrNone  equ     0
cmpRespErrSystem        equ     1
cmpRespErrUnknownCmd    equ     2
cmpRespErrMemory        equ     3
cmpRespErrParam equ     4
cmpRespErrLast  equ     5

; CmpCmdEnum
cmpCmdReserved  equ     $0F
cmpCmdXCommPrefs        equ     $10
cmpCmdHShakeComplete    equ     $11
cmpCmdLast      equ     $12

struct CmpCommPrefsType
        maxPktDataSize.l
        maxDataBlkSize.l
        maxBaudRate.l
        hwHShakeAbove.l
        flags.l
        version.l
        reserved2.l
        reserved3.l
endstruct

cmpCommPrefsFlagSupportPktCRC16 equ     $80000000
cmpCommPrefsFlagUsePktCRC16     equ     $00008000

cmpCommPrefsFlagSupportShortOffsets     equ     $40000000
cmpCommPrefsFlagUseShortOffsets         equ     $00004000
cmpCommPrefsFlagSupportLongOffsets      equ     $20000000
cmpCommPrefsFlagUseLongOffsets          equ     $00002000

cmpXCommPrefsReqArgID   equ     cmpFirstArgID

struct CmpXCommPrefsReqType
        prefs.CmpCommPrefsType
endstruct

cmpXCommPrefsPrefsRespArgID     equ     cmpFirstArgID
;???    cmpXCommPrefsIPAddrRespArgID    equ     cmpFirstArgID + 1

struct CmpXCommPrefsPrefsRespType
        prefs.CmpCommPrefsType
endstruct

struct CmpXCommPrefsIPAddrRespType
        ipAddr.b
endstruct

cmpHShakeCompleteReqArgID       equ     cmpFirstArgID

struct CmpHShakeCompleteReqType
        final.CmpCommPrefsType
endstruct CmpHShakeCompleteReqTypeCmpHShakeCompleteReqType


; System\CTP.h

; CTPCmdEnum
ctpCmdReqURL    equ     0
ctpCmdReqMail   equ     1
ctpCmdEcho      equ     2
ctpCmdMsgGen    equ     3
ctpCmdDiscard   equ     4

; ctpConvEnum
ctpConvCML      equ     0
ctpConvCML8Bit  equ     1
ctpConvCMLLZSS  equ     2
ctpConvNone     equ     3

; CTPReqExtEnum
ctpExtIncHTTPResponse   equ     1
ctpExtNetID     equ     128
ctpExtUserID    equ     129
ctpExtUserPW    equ     130
ctpExtUserName  equ     131
ctpExtServer    equ     132
ctpExtConvertTo equ     133

; CTPRspExtURLEnum
ctpExtContentType       equ     128
ctpExtContentEncoding   equ     129
ctpExtUncompressSize    equ     130

; CTPNetIDEnum
ctpNetIDMobitex equ     0
ctpNetIDUnknown equ     $FFFF

; CTPSchemeEnum
ctpSchemeHTTP   equ     0
ctpSchemeHTTPS  equ     1
ctpSchemeFTP    equ     2
ctpSchemeEmpty  equ     7

; CTPErrEnum
ctpErrNone      equ     0
ctpErrMalformedRequest  equ     1
ctpErrUnknownCmd        equ     2
ctpErrProxy     equ     3
ctpErrServer    equ     4
ctpErrTruncated equ     $8000


; System\DataMgr.h

dmRecAttrCategoryMask   equ     $0F
dmRecNumCategories      equ     16
dmCategoryLength        equ     16

dmAllCategories equ     $ff
dmUnfiledCategory       equ     0

dmMaxRecordIndex        equ     $ffff

dmRecAttrDelete equ     $80
dmRecAttrDirty  equ     $40
dmRecAttrBusy   equ     $20
dmRecAttrSecret equ     $10

dmAllRecAttrs   equ     dmRecAttrDelete|dmRecAttrDirty|dmRecAttrBusy|dmRecAttrSecret

dmSysOnlyRecAttrs       equ     dmRecAttrBusy

dmDBNameLength  equ     32

dmHdrAttrResDB  equ     $0001
dmHdrAttrReadOnly       equ     $0002
dmHdrAttrAppInfoDirty   equ     $0004
dmHdrAttrBackup equ     $0008
dmHdrAttrOKToInstallNewer       equ     $0010
dmHdrAttrResetAfterInstall      equ     $0020
dmHdrAttrCopyPrevention equ     $0040
dmHdrAttrStream equ     $0080
dmHdrAttrOpen   equ     $8000

dmAllHdrAttrs   equ     dmHdrAttrResDB | dmHdrAttrReadOnly | dmHdrAttrAppInfoDirty | dmHdrAttrBackup | dmHdrAttrOKToInstallNewer | dmHdrAttrResetAfterInstall | dmHdrAttrCopyPrevention | dmHdrAttrStream | dmHdrAttrOpen)

dmSysOnlyHdrAttrs       equ     dmHdrAttrResDB | dmHdrAttrOpen)

dmRecordIDReservedRange equ     1

dmDefaultRecordsID      equ     0

dmUnusedRecordID        equ     0

dmModeReadOnly  equ     $0001
dmModeWrite     equ     $0002
dmModeReadWrite equ     $0003
dmModeLeaveOpen equ     $0004
dmModeExclusive equ     $0008
dmModeShowSecret        equ     $0010

struct DmSearchStateType
        info.32
endstruct

struct SortRecordInfoType
        attributes.b
        uniqueID.3
endstruct

dmErrMemError                   equ     dmErrorClass | 1
dmErrIndexOutOfRange            equ     dmErrorClass | 2
dmErrInvalidParam               equ     dmErrorClass | 3
dmErrReadOnly                   equ     dmErrorClass | 4
dmErrDatabaseOpen               equ     dmErrorClass | 5
dmErrCantOpen                   equ     dmErrorClass | 6
dmErrCantFind                   equ     dmErrorClass | 7
dmErrRecordInWrongCard          equ     dmErrorClass | 8
dmErrCorruptDatabase            equ     dmErrorClass | 9
dmErrRecordDeleted              equ     dmErrorClass | 10
dmErrRecordArchived             equ     dmErrorClass | 11
dmErrNotRecordDB                equ     dmErrorClass | 12
dmErrNotResourceDB              equ     dmErrorClass | 13
dmErrROMBased                   equ     dmErrorClass | 14
dmErrRecordBusy                 equ     dmErrorClass | 15
dmErrResourceNotFound           equ     dmErrorClass | 16
dmErrNoOpenDatabase             equ     dmErrorClass | 17
dmErrInvalidCategory            equ     dmErrorClass | 18
dmErrNotValidRecord             equ     dmErrorClass | 19
dmErrWriteOutOfBounds           equ     dmErrorClass | 20
dmErrSeekFailed                 equ     dmErrorClass | 21
dmErrAlreadyOpenForWrites       equ     dmErrorClass | 22
dmErrOpenedByAnotherTask        equ     dmErrorClass | 23
dmErrUniqueIDNotFound           equ     dmErrorClass | 24
dmErrAlreadyExists              equ     dmErrorClass | 25
dmErrInvalidDatabaseName        equ     dmErrorClass | 26
dmErrDatabaseProtected          equ     dmErrorClass | 27

dmSeekForward   equ     1
dmSeekBackward  equ     -1


; System\DataPrv.h

struct RecordEntryType
        localChunkID.l
        attributes.b
        uniqueID.3
endstruct

struct RsrcEntryType
        type.l
        id.w
        localChunkID.l
endstruct

dmRsrcAttrUnused        equ     $0000

struct RecordListType
        nextRecordListID.l
        numRecords.w
        firstEntry.w
endstruct

struct DatabaseHdrType
        name.32
        attributes.w
        version.w
        creationDate.l
        modificationDate.l
        lastBackupDate.l
        modificationNumber.l
        appInfoID.l
        sortInfoID.l
        type.l
        creator.l
        uniqueIDSeed.l
        recordList.RecordListType
endstruct

struct DatabaseDirType
        nextDatabaseListID.l
        numDatabases.w
        databaseID.l
endstruct

struct DmOpenInfoType
        next.l
        openCount.w
        ownerTaskID.l
        exclusive.w
        writeAccess.w
        resDB.w
        hdrID.l
        hdrH.l
        hdrP.l
        cardNo.w
        numRecords.w
        hdrMasterP.l
        handleTableP.l
endstruct

struct DmAccessType
        next.l
        mode.w
        openP.l
        savedModNum.l
endstruct

struct DmPrvSearchStateType
        index.w
        relIndex.w
        cardNo.b
        storeNo.b
        storeEntries.w
        storeStartIndex.w
        dirID.l
endstruct

struct DmProtectEntryType
        protectCount.b
        cardNo.b
        dbID.l
endstruct

dmDynOwnerID    equ     $00
dmMgrOwnerID    equ     $01
dmRecOwnerID    equ     $02
dmOrphanOwnerID equ     $03


; System\DateTime.h

struct DateTimeType
        second.w
        minute.w
        hour.w
        day.w
        month.w
        year.w
        weekDay.w
endstruct

struct TimeType
        hours.b
        minutes.b
endstruct

noTime  equ     -1

struct DateType
        year.w
        month.w
        day.w
endstruct

timeStringLength        equ     9
dateStringLength        equ     9
longDateStrLength       equ     15

firstYear       equ     1904
numberOfYears   equ     128
lastYear        equ     firstYear + numberOfYears - 1

minutesInSeconds        equ     60
hoursInMinutes  equ     60
hoursInSeconds  equ     hoursInMinutes * minutesInSeconds
hoursPerDay     equ     24

daysInSeconds   equ     $15180

daysInWeek      equ     7
daysInYear      equ     365
daysInLeapYear  equ     366
daysInFourYears equ     daysInLeapYear + 3 * daysInYear

monthsInYear    equ     12

maxDays equ     numberOfYears / 4 * daysInFourYears - 1
maxSeconds      equ     maxDays * daysInSeconds
maxTime equ     $0

sunday  equ     0
monday  equ     1
tuesday equ     2
wednesday       equ     3
thursday        equ     4
friday  equ     5
saturday        equ     6

january equ     1
february        equ     2
march   equ     3
april   equ     4
may     equ     5
june    equ     6
july    equ     7
august  equ     8
september       equ     9
october equ     10
november        equ     11
december        equ     12

; DayOfWeekType
dom1stSun       equ     0
dom1stMon       equ     1
dom1stTue       equ     2
dom1stWen       equ     3
dom1stThu       equ     4
dom1stFri       equ     5
dom1stSat       equ     6
dom2ndSun       equ     7
dom2ndMon       equ     8
dom2ndTue       equ     9
dom2ndWen       equ     10
dom2ndThu       equ     11
dom2ndFri       equ     12
dom2ndSat       equ     13
dom3rdSun       equ     14
dom3rdMon       equ     15
dom3rdTue       equ     16
dom3rdWen       equ     17
dom3rdThu       equ     18
dom3rdFri       equ     19
dom3rdSat       equ     20
dom4thSun       equ     21
dom4thMon       equ     22
dom4thTue       equ     23
dom4thWen       equ     24
dom4thThu       equ     25
dom4thFri       equ     26
dom4thSat       equ     27
domLastSun      equ     28
domLastMon      equ     29
domLastTue      equ     30
domLastWen      equ     31
domLastThu      equ     32
domLastFri      equ     33
domLastSat      equ     34


; System\DebugMgr.h

dbgCtlNotHandled        equ     false
dbgCtlHandled           equ     true
dbgCtlAllHandlersID     equ     0
dbgCtlHandlerNameLen    equ     31
dbgCtlHandlerVerLen     equ     15
dbgCtlFirstCustomOp     equ     $8000

struct DbgCtlHandlerInfoType
        handlerFuncP.l
        version.l
        enabled.b
        pad.b
        name.32
        ver.16
        dwReserved.l
endstruct

struct DbgCtlEnumInfoType
        enumFuncP.l
        callbackDataP.l
endstruct

dbgCtlOpEnumHandlers    equ     1
dbgCtlOpGetHandlerInfo  equ     2
dbgCtlOpEnableHandler   equ     3
dbgCtlOpDisableHandler  equ     4
dbgCtlOpGetEnabledStatus        equ     5
dbgCtlOpGetVersion      equ     6
dbgCtlOpLAST    equ     7


; System\ExgMgr.h

exgMemError             equ     exgErrorClass | 1
exgErrStackInit         equ     exgErrorClass | 2
exgErrUserCancel        equ     exgErrorClass | 3
exgErrNoReceiver        equ     exgErrorClass | 4
exgErrNoKnownTarget     equ     exgErrorClass | 5
exgErrTargetMissing     equ     exgErrorClass | 6
exgErrNotAllowed        equ     exgErrorClass | 7
exgErrBadData           equ     exgErrorClass | 8
exgErrAppError          equ     exgErrorClass | 9
exgErrUnknown           equ     exgErrorClass | 10
exgErrDeviceFull        equ     exgErrorClass | 11
exgErrDisconnected      equ     exgErrorClass | 12
exgErrNotFound          equ     exgErrorClass | 13
exgErrBadParam          equ     exgErrorClass | 14
exgErrNotSupported      equ     exgErrorClass | 15
exgErrDeviceBusy        equ     exgErrorClass | 16
exgErrBadLibrary        equ     exgErrorClass | 17

struct ExgGoToType
        dbCardNo.w
        dbID.l
        recordNum.w
        uniqueID.l
        matchCustom.l
endstruct

struct ExgSocketType
        libraryRef.w
        socketRef.l
        target.l
        count.l
        length.l
        time.l
        appData.l
        goToCreator.l
        goToParams.ExgGoToType
        flags.w
        description.l
        type.l
        name.l
endstruct
;       localMode:1.w
;       packetMode:1.w
;       reserved:14.w

struct ExgAskParamType
        socketP.l
        result.w        ;exgAskResultType
endstruct

exgSeparatorChar        equ     '\t'

exgRegLibraryID         equ     $fffc
exgRegExtensionID       equ     $fffd
exgRegTypeID            equ     $fffe

exgDataPrefVersion      equ     0
exgMaxTitleLen          equ     20

exgLibCtlGetTitle       equ     1
exgLibCtlSpecificOp     equ     $8000


; System\ErrorMgr.h

struct ErrExceptionType
        nextP.l
        state.52
        err.l
endstruct


; System\ExgLib.h

exgIntDataChr   equ     $01ff

; ExgLibTrapNumberEnum
exgLibTrapHandleEvent   equ     sysLibTrapCustom
exgLibTrapConnect       equ     sysLibTrapCustom+1
exgLibTrapAccept        equ     sysLibTrapCustom+2
exgLibTrapDisconnect    equ     sysLibTrapCustom+3
exgLibTrapPut           equ     sysLibTrapCustom+4
exgLibTrapGet           equ     sysLibTrapCustom+5
exgLibTrapSend          equ     sysLibTrapCustom+6
exgLibTrapReceive       equ     sysLibTrapCustom+7
exgLibTrapControl       equ     sysLibTrapCustom+8
exgLibReserved1         equ     sysLibTrapCustom+9
exgLibTrapLast          equ     sysLibTrapCustom+10


; System\FeatureMgr.h

ftrErrInvalidParam      equ     ftrErrorClass | 1
ftrErrNoSuchFeature     equ     ftrErrorClass | 2
ftrErrAlreadyExists     equ     ftrErrorClass | 3
ftrErrROMBased          equ     ftrErrorClass | 4
ftrErrInternalErr       equ     ftrErrorClass | 5


; System\FeaturePrv.h

struct FtrFeatureType
        num.w
        value.l
endstruct

struct FtrCreatorType
        creator.l
        numEntries.w
        feature.FtrFeatureType
endstruct

struct FtrTableType
        numEntries.w
        creator.FtrCreatorType
endstruct

struct FtrGlobalsType
        romTableH.l
        ramTableH.l
endstruct

struct FtrCacheType
        romTableH.l
        ramTableH.l
        romTableP.l
        ramTableP.l
endstruct


; System\FileStream.h

fileErrMemError                 equ     fileErrorClass | 1
fileErrInvalidParam             equ     fileErrorClass | 2
fileErrCorruptFile              equ     fileErrorClass | 3
fileErrNotFound                 equ     fileErrorClass | 4
fileErrTypeCreatorMismatch      equ     fileErrorClass | 5
fileErrReplaceError             equ     fileErrorClass | 6
fileErrCreateError              equ     fileErrorClass | 7
fileErrOpenError                equ     fileErrorClass | 8
fileErrInUse                    equ     fileErrorClass | 9
fileErrReadOnly                 equ     fileErrorClass | 10
fileErrInvalidDescriptor        equ     fileErrorClass | 11
fileErrCloseError               equ     fileErrorClass | 12
fileErrOutOfBounds              equ     fileErrorClass | 13
fileErrPermissionDenied         equ     fileErrorClass | 14
fileErrIOError                  equ     fileErrorClass | 15
fileErrEOF                      equ     fileErrorClass | 16
fileErrNotStream                equ     fileErrorClass | 17

fileNullHandle  equ     0

fileModeReadOnly        equ     $80000000
fileModeReadWrite       equ     $40000000
fileModeUpdate          equ     $20000000
fileModeAppend          equ     $10000000

fileModeLeaveOpen       equ     $08000000
fileModeExclusive       equ     $04000000
fileModeAnyTypeCreator  equ     $02000000

fileModeTemporary       equ     $01000000

fileModeDontOverwrite   equ     $00800000

fileModeAllFlags        equ     fileModeReadOnly | fileModeReadWrite | fileModeUpdate | fileModeAppend | fileModeLeaveOpen | fileModeExclusive | fileModeAnyTypeCreator | fileModeTemporary | fileModeDontOverwrite

; FileOriginEnum
fileOriginBeginning     equ     1
fileOriginCurrent       equ     2
fileOriginEnd   equ     3

; FileOpEnum
fileOpNone      equ     0
fileOpDestructiveReadMode       equ     1
fileOpGetEOFStatus      equ     2
fileOpGetLastError      equ     3
fileOpClearError        equ     4
fileOpGetIOErrorStatus  equ     5
fileOpGetCreatedStatus  equ     6
fileOpGetOpenDbRef      equ     7
fileOpFlush     equ     8
fileOpLAST      equ     9


; System\FileStreamPrv.h

fileDescriptorSignature equ     'STRM'
fileStateOpenComplete   equ     ($8000)
fileStateWriteAccess    equ     ($4000)
fileStateDestructiveRead        equ     ($2000)
fileStateAppend         equ     ($1000)
fileStateCreated        equ     ($0800)
fileStateCompressed     equ     ($0400)
fileStateIOError        equ     ($0001)
fileStateEOF            equ     ($0002)


fileAllStates   equ     fileStateOpenComplete | fileStateWriteAccess | fileStateDestructiveRead | fileStateAppend | fileStateCreated | fileStateCompressed | fileStateIOError | fileStateEOF

struct FileCachedInfoType
        blockH.l
        blockIndex.l
        forWrite.b
        bReserved.b
endstruct

struct FileDescriptorType
        sig.l
        openMode.l
        state.w
        dbR.l
        lastError.w
        fileSize.l
        numBlocks.l
        curOffset.l
        cached.FileCachedInfoType
        dwReserved1.l
        dwReserved2.l
endstruct

fileBlockDataSize       equ     1024 * 4

fileDataBlockSignature  equ     'DBLK'
fileDataBlockCategory   equ     dmUnfiledCategory

struct FileBlockHeaderType
        sig.l
        dataSize.l
endstruct

struct FileDataBlockType
        hdr.FileBlockHeaderType
        data.4096
endstruct


; System\FloatMgr.h

fMaxLong        equ     ($7FFFFFFF)
fMinLong        equ     ($80000000)

struct FloatTypeFloatType
        man.l
        exp.w
        sign.b
        pad.b
endstruct

kExpInf equ     16000

fplErrOutOfRange        equ     fplErrorClass | 1


; System\Globals.h

sysUIRsvGlobalsSize equ $000000a0

struct FixedGlobalsType
        memCardSlots.b
        dbgWasEntered.b
        memCardInfoP.l
        memSemaphoreID.l
        memDebugMode.w
        dmOpenList.l
        dbgInDebugger.b
        dbgTracing.b
        dbgGlobalsP.l
        dbgSerGlobalsP.l
        sysAppInfoP.l
        sysKernelDataP.l
        sysDispatchTableP.l
        sysOwnerIDsInUse.l
        sysAMXAppInfoP.l
        sysClockFreq.l
        sysHardKeyCreators.l
        sysBatteryCheckTimer.w
        sysBatteryMinThreshold.b
        hwrBatteryLevel.b
        sysNextBatteryAlertTimer.w
        sysBatteryWarnThreshold.b
        sysDispatchTableRev.b
        sysDispatchTableSize.w
        sysLibTableP.l
        sysLibTableEntries.w
        sysConsoleStackChunkP.l
        sysUIShellAppInfoP.l
        sysTimerID.l
        sysAutoOffEvtTicks.l
        sysAutoOffSeconds.w
        sysRandomSeed.l
        slkGlobalsP.l
        serGlobalsP.l
        scrGlobalsP.l
        fplGlobalsP.l
        penGlobalsP.l
        sysEvtMgrGlobalsP.l
        sndGlobalsP.l
        timGlobalsP.l
        almGlobalsP.l
        ftrGlobalsP.l
        grfGlobalsP.l
        keyGlobalsP.l
        uiGlobals.160
        uiExtensionsP.l
        unusedPtr.l
        nextUIAppDBID.l
        nextUIAppCmd.w
        nextUIAppCmdPBP.l
        nextUIAppCardNo.b
        hwrDataWELevel.b
        hwrWakeUp.w
        hwrCPUDutyCycle.b
        hwrPenDown.b
        hwrCurTicks.l
        hwrTotalRAMSize.l
        hwrDozeSubTicks.l
        sndOffTicks.l
        sysResetFlags.b
        sysBatteryKind.b
        memMinDynHeapFree.l
        sysPrefFlags.w
        sysGlobalsP.l
        sysMiscFlags.w
        sysLibNet.w
        netPktFreeQ.l
        sysEvGroupID.l
        irq3GlobalsP.l
        sysLastBatteryWarning.l
        sysLowMemChecksum.l
        hwrHardwareRev.w
        Handle.l
        dmProtectListH.l
        hwrMiscFlags.w
        sysProfileRefcon.l
        sysProfileProcP.l
        flpSoftFPSCR.l
        irLibGlobalsP.l
        exgActiveLib.w
        uiBusyCount.w
        irq1GlobalsP.l
        irq2GlobalsP.l
        irq6GlobalsP.l
endstruct

struct LowMemHdrType
        vectors.M68KExcTableType
        globals.FixedGlobalsType
endstruct

PilotGlobalsP   equ     0


; System\Graffiti.h

grfNoShortCut   equ     $ffff

struct GrfMatchType
        glyphID.b
        unCertainty.b
endstruct

grfMaxMatches   equ     4

struct GrfMatchInfoType
        numMatches.w
        match.8
endstruct

grfNameLength   equ     8
grfVirtualSequence      equ     $01
grfShiftSequence        equ     $02
grfSpecialSequence      equ     $03
grfExpansionSequence    equ     '@'
expandDateChar  equ     'D'
expandTimeChar  equ     'T'
expandStampChar equ     'S'

shortcutBinaryDataFlag  equ     $01

grfTempShiftPunctuation equ     1
grfTempShiftExtended    equ     2
grfTempShiftUpper       equ     3
grfTempShiftLower       equ     4

grfErrBadParam          equ     grfErrorClass | 1
grfErrPointBufferFull   equ     grfErrorClass | 2
grfErrNoGlyphTable      equ     grfErrorClass | 3
grfErrNoDictionary      equ     grfErrorClass | 4
grfErrNoMapping equ     grfErrorClass | 5
grfErrMacroNotFound     equ     grfErrorClass | 6
grfErrDepthTooDeep      equ     grfErrorClass | 7
grfErrMacroPtrTooSmall  equ     grfErrorClass | 8
grfErrNoMacros          equ     grfErrorClass | 9
grfErrMacroIncomplete   equ     grfErrorClass | 129
grfErrBranchNotFound    equ     grfErrorClass | 130


; System\GraffitiPrv.h

grfSpecialToggleSplitMode       equ     $01
grfSpecialNoAutoOff             equ     $02
grfSpecialShowUserInfo          equ     $03
grfSpecialDeleteUserInfo        equ     $04
grfSpecialSystemBuildDate       equ     $05
grfSpecialBatteryKind           equ     $06

grfMaxKeys      equ     100

grfMacrosResT   equ     'macr'
grfMacrosResID  equ     10000
grfMacrosMinSize        equ     10

grfMacrosDBVersion      equ     0

grfWarningOffset        equ     128

grfMaxMacroName equ     32

;struct GrfGlobalsType
;       p3Data.TP3Data
;       state.TP3DictState
;       uncertain.w
;       glyphFlags.w
;       shiftState.w
;       macroNameLen.w
;       macroName.grfMaxMacroName
;       lastChar.b
;       pad.b
;       globalsSize.l
;       splitMode.w
;       restoreCaps.w
;       inMacro.w
;       wasAutoShifted.w
;       upShiftGlyphID.b
;       pad2.b
;       Handle.l
;       globalsH.l
;       Handle.l
;       templateH.l
;       Handle.l
;       dictH.l
;       Handle.l
;       macrosH.l
;       macrosDbP.l
;endstruct


; System\GraffitiReference.h

; ReferenceType
referenceAlpha  equ     0
referencePunc1  equ     1
referencePunc2  equ     2
referencePunc3  equ     3
referenceExtended       equ     4
referenceAccent equ     5
referenceDefault        equ     $ff

referenceFirst  equ     referenceAlpha
referenceLast   equ     referenceAccent


; System\ImcUtils.h

EOF     equ     $ffff

parameterDelimeterChr   equ     ';'
valueDelimeterChr       equ     ':'
groupDelimeterChr       equ     '.'
paramaterNameDelimiterChr       equ     '='
endOfLineChr            equ     $0D

imcFilenameLength       equ     32
imcUnlimitedChars       equ     $FFFE


; System\irlib.h

;irLibName      equ     "IrDA Library"

;irFtrCreator   equ     sysFileCIrLib
irFtrNumVersion equ     0

irOpenOptBackground     equ     $80000000
irOpenOptSpeed115200    equ     $0000003F
irOpenOptSpeed57600     equ     $0000001F
irOpenOptSpeed9600      equ     $00000003

;irGetScanningMode      equ     exgibCtlSpecificOp
;irSetScanningMode      equ     exgibCtlSpecificOp
;irGetStatistics        equ     exgibCtlSpecificOp
;irSetSerialMode        equ     exgibCtlSpecificOp
;irSetBaudMask  equ     exgibCtlSpecificOp
;irSetSupported equ     exgibCtlSpecificOp

struct IrStatsType
        recLineErrors.w
        crcErrors.w
endstruct

;???    } IrLibTrapNumberEnum;
;???    irLibTrapBind = exgLibTrapLast
;???    irLibTrapUnBind,
;???    irLibTrapDiscoverReq,
;???    irLibTrapConnectIrLap,
;???    irLibTrapDisconnectIrLap,
;???    irLibTrapConnectReq,
;???    irLibTrapConnectRsp,
;???    irLibTrapDataReq,
;???    irLibTrapLocalBusy,
;???    irLibTrapMaxTxSize,
;???    irLibTrapMaxRxSize,
;???    irLibTrapSetDeviceInfo,
;???    irLibTrapIsNoProgress,
;???    irLibTrapIsRemoteBusy,
;???    irLibTrapIsMediaBusy,
;???    irLibTrapIsIrLapConnected,
;???    irLibTrapTestReq,
;???    irLibTrapIAS_Add,
;???    irLibTrapIAS_Query,
;???    irLibTrapIAS_SetDeviceName,
;???    irLibTrapIAS_Next,
;???    irLibTrapIrOpen,
;???    irLibTrapHandleEvent,
;???    irLibTrapWaitForEvent,
;???    irLibTrapLast

IR_MAX_CON_PACKET       equ     60
IR_MAX_TTP_CON_PACKET   equ     52
IR_MAX_TEST_PACKET      equ     376
IR_MAX_DEVICE_INFO      equ     23

IR_DEVICE_LIST_SIZE     equ     6

IR_MAX_XID_LEN  equ     23

IR_MAX_LSAP     equ     $6f

IR_HINT_PNP     equ     $01
IR_HINT_PDA     equ     $02
IR_HINT_COMPUTER        equ     $04
IR_HINT_PRINTER equ     $08
IR_HINT_MODEM   equ     $10
IR_HINT_FAX     equ     $20
IR_HINT_LAN     equ     $40
IR_HINT_EXT     equ     $80

IR_HINT_TELEPHONY       equ     $01
IR_HINT_FILE    equ     $02
IR_HINT_IRCOMM  equ     $04
IR_HINT_MESSAGE equ     $08
IR_HINT_HTTP    equ     $10
IR_HINT_OBEX    equ     $20

;???typedef Byte IrStatus;

;???typedef Byte IrCharSet;

IR_CHAR_ASCII   equ     0
IR_CHAR_ISO_8859_1      equ     1
IR_CHAR_ISO_8859_2      equ     2
IR_CHAR_ISO_8859_3      equ     3
IR_CHAR_ISO_8859_4      equ     4
IR_CHAR_ISO_8859_5      equ     5
IR_CHAR_ISO_8859_6      equ     6
IR_CHAR_ISO_8859_7      equ     7
IR_CHAR_ISO_8859_8      equ     8
IR_CHAR_ISO_8859_9      equ     9
IR_CHAR_UNICODE equ     $ff

;???typedef Byte IrEvent;

LEVENT_LM_CON_IND       equ     0
LEVENT_LM_DISCON_IND    equ     1
LEVENT_DATA_IND equ     2
LEVENT_PACKET_HANDLED   equ     3
LEVENT_LAP_CON_IND      equ     4
LEVENT_LAP_DISCON_IND   equ     5
LEVENT_DISCOVERY_CNF    equ     6
LEVENT_LAP_CON_CNF      equ     7
LEVENT_LM_CON_CNF       equ     8
LEVENT_STATUS_IND       equ     9
LEVENT_TEST_IND equ     10
LEVENT_TEST_CNF equ     11

LCON_FLAGS_TTP  equ     $02

IR_MAX_QUERY_LEN        equ     61

IR_MAX_IAS_NAME equ     60
IR_MAX_ATTRIBUTES       equ     255

IR_MAX_IAS_ATTR_SIZE    equ     56

IAS_ATTRIB_MISSING      equ     0
IAS_ATTRIB_INTEGER      equ     1
IAS_ATTRIB_OCTET_STRING equ     2
IAS_ATTRIB_USER_STRING  equ     3
IAS_ATTRIB_UNDEFINED    equ     $ff

IAS_GET_VALUE_BY_CLASS  equ     4

;struct IrPacket
;       node.ListEntry
;       buff.l
;       len.w
;       origin.l
;       headerLen.b
;       pad.b
;       header.14
;endstruct

;???typedef  union {
;???    Byte  u8[4];
;???    Word  u16[2];
;???    DWord u32;
;???} IrDeviceAddr;

struct IrDeviceInfo
        hDevice.l
        len.b
        xid.23
endstruct

;pstruct IrDeviceList
;       nItems.b
;       pad.b
; IrDeviceInfo  dev[IR_DEVICE_LIST_SIZE]; /* Fixed size in IrDA Lite */
;endstruct IrDeviceList

struct IrCallBackParms
        event.b
        pad.b
        rxBuff.l
        rxLen.w
        packet.l
        deviceList.l;  /* Pointer to discovery device list */
        status.w
endstruct

;struct _hconnect
;       lLsap.b
;       rLsap.b
;       flags.b
;       pad.b
;       callBack.l
;       packet.IrPacket
;       packets.ListEntry
;       sendCredit.w
;       availCredit.b
;       dataOff.b
;endstruct


struct _IrIasAttribute
        name.l
        len.b
        pad.b
        value.l
        valLen.b
endstruct

struct _IrIasObject
        name.l
        len.b
        nAttribs.b
        attribs.l
endstruct IrIasObjectIrIasObject

struct _IrIasQuery
        queryLen.b
        pad.b
        queryBuf.l
        resultBufSize.w
        resultLen.w
        listLen.w
        offset.w
        retCode.b
        overFlow.b
        result.l
endstruct


; System\KeyMgr.h

keyBitPower     equ     $01
keyBitPageUp    equ     $02
keyBitPageDown  equ     $04
keyBitHard1     equ     $08
keyBitHard2     equ     $10
keyBitHard3     equ     $20
keyBitHard4     equ     $40
keyBitCradle    equ     $80

keyBitsAll      equ     $FFFFFFFF

slowestKeyDelayRate     equ     $ff
slowestKeyPeriodRate    equ     $ff


; System\KeyPrv.h

;keyMinUpTicks  equ     sysTicksPerSecond/20

;keyMinBacklightTicks   equ     sysTicksPerSecond
keyBitMask      equ     $007F

struct KeyGlobalsType
        lastKeyTicks.l
        keyState.b
        keyStateMask.b
        keyUpCount.b
        initDelay.b
        period.b
        turnOnTicks.l
        doubleTapTicks.l
        doubleTapDelay.w
        doubleTapState.b
        Belongs.l
        queueAhead.b
endstruct


; System\Launcher.h

struct LauncherType
        form.l
        numItems.w
        columns.w
        rows.w
        topItem.w
        selection.b
        appInfoH.l
        timeFormat.w
        timeString.9
        pad.b
        savedForm.l
endstruct



; LocalIDKind
memIDPtr        equ     0
memIDHandle     equ     1

memNewChunkFlagPreLock  equ     $0100
memNewChunkFlagNonMovable       equ     $0200
memNewChunkFlagAtStart  equ     $0400
memNewChunkFlagAtEnd    equ     $0800

memDebugModeCheckOnChange       equ     $0001
memDebugModeCheckOnAll  equ     $0002
memDebugModeScrambleOnChange    equ     $0004
memDebugModeScrambleOnAll       equ     $0008
memDebugModeFillFree    equ     $0010
memDebugModeAllHeaps    equ     $0020
memDebugModeRecordMinDynHeapFree        equ     $0040


; System\MidiPrv.h

midiSmfHeaderChunkType  equ     'MThd'
midiSmfTrackChunkType   equ     'MTrk'

midiSmfFmt0     equ     0
midiSmfFmt1     equ     1
midiSmfFmt2     equ     2
midiSmfFmtUnknown       equ     $FFFF

midiSmfMaxValidFmt      equ     midiSmfFmt2

midiSmfNegSMPTEFmt24            equ     -24
midiSmfNegSMPTEFmt25            equ     -25
midiSmfNegSMPTEFmt30Drop        equ     -29
midiSmfNegSMPTEFmt30NonDrop     equ     -30

midiMsgStatusNone       equ     0
midiMaxChanMsgStatus    equ     $EF
midiMsgBaseNoteOff      equ     $080
midiMsgBaseNoteOn       equ     $090
midiMsgBasePolyPress    equ     $0A0
midiMsgBaseCtlChange    equ     $0B0
midiMsgBaseProgChange   equ     $0C0
midiMsgBaseChanPress    equ     $0D0
midiMsgBasePitchBend    equ     $0E0

midiSmfEvtStatusMeta    equ     $FF
midiSmfEvtStatusSysExF0 equ     $F0
midiSmfEvtStatusSysExF7 equ     $F7

midiSmfMetaEvtTypeEOT   equ     $2F
midiSmfMetaEvtTypeTempo equ     $51

midiStatusBit           equ     $80
midiChanNumMask         equ     $0F
midiChanMsgMask         equ     $F0
midiSmfSMPTEDivBit      equ     $8000
midiSmfSMPTEDivTicksMask        equ     $00FF

midiMinChan     equ     0
midiMaxChan     equ     15

midiMinKey      equ     0
midiMaxKey      equ     127

midiMinVel      equ     0
midiMaxVel      equ     127

midiSmfMinHdrChunkDataSize      equ     6
midiSmfMinTrkChunkDataSize      equ     4

midiDefTempo    equ     500000
midiDefVel      equ     64

midiSmfHdrFmtBytes      equ     2
midiSmfHdrTrkBytes      equ     2
midiSmfHdrDivBytes      equ     2
midiSmfChunkTypeBytes   equ     4
midiSmfChunkLengthBytes equ     4
midiSmfTempoBytes       equ     3

struct MidiSmfHdrInfoType
        wFmt.w
        wNumTracks.w
        wDivRaw.w
        bUsingSMPTE.b
        pad.b
        wTicksPerQN.w
        dwTicksPerSec.l
endstruct

struct MidiStateType
        hdr.MidiSmfHdrInfoType
        streamP.l
        chunkEndP.l
        dwChunkType.l
        dwChunkSize.l
        bMsgStatus.b
        pad.b
        dwTempo.l
        bFirstChan.b
        bLastChan.b
endstruct

;???typedef enum MidiSmfEvtClassEnum {
;???    eMidiSmfEvtClassUnknown = 0,
;???    eMidiSmfEvtClassChannel,
;???    eMidiSmfEvtClassSysEx,
;???    eMidiSmfEvtClassMeta
;???    } MidiSmfEvtClassEnum;

;???typedef enum MidiSmfEvtEnum {
;???    eMidiSmfEvtUnknown              = 0,
;???    eMidiSmfEvtNoteOff              = 0x080,
;???    eMidiSmfEvtNoteOn                       = 0x090,
;???    eMidiSmfEvtPolyPress            = 0x0A0,
;???    eMidiSmfEvtCtlChange            = 0x0B0,
;???    eMidiSmfEvtProgChange   = 0x0C0,
;???    eMidiSmfEvtChanPress            = 0x0D0,
;???    eMidiSmfEvtPitchBend            = 0x0E0,
;???    eMidiSmfEvtSysEx1                       = 0x0F0,
;???    eMidiSmfEvtSysEx2                       = 0x0F7,
;???    eMidiSmfMetaEvtEOT              = 0xFF2F,
;???    eMidiSmfMetaEvtTempo            = 0xFF51,
;???    eMidiSmfMetaEvtOther            = 0xFF80
;???    } MidiSmfEvtEnum;

struct MidiEventType
        id.w            ;MidiSmfEvtEnum
        evtClass.w      ;MidiSmfEvtClassEnum
        dwDeltaTicks.l
        bChan.b
        evtData.l
endstruct

struct setTempo
        dwTempo.l
endstruct

struct note
        bKey.b
        bVel.b
endstruct


; System\ModemMgr.h

mdmMaxStringSize        equ     40

mdmCmdBufSize   equ     81
mdmRespBufSize  equ     81
mdmCmdSize      equ     8

mdmDefCmdTimeOut        equ     500000

mdmDefDTWaitSec equ     4
mdmDefDCDWaitSec        equ     70
mdmDefSpeakerVolume     equ     1

;???enum {
;???    mdmVolumeOff = 0,
;???    mdmVolumeLow = 1,
;???    mdmVolumeMed = 2,
;???    mdmVolumeHigh = 3
;???    };

;???typedef enum {
;???    mdmStageInvalid = 0,
;???    mdmStageReserved = 1,
;???    mdmStageFindingModem,
;???    mdmStageInitializing,
;???    mdmStageDialing,
;???    mdmStageWaitingForCarrier,
;???    mdmStageHangingUp
;???    } MdmStageEnum;

struct MdmInfoType
        serRefNum.w
        initialBaud.l
        cmdTimeOut.l
        dtWaitSec.w
        dcdWaitSec.w
        volume.w
        pulse.b
        hwHShake.b
        autoBaud.b
        pad.b
        canProcP.l
        userRef.l
        cmdBuf.81
        respBuf.81
        connectBaud.l
        curStage.b
        pad2.b
endstruct MdmInfoTypeMdmInfoType

mdmErrNoTone    equ     mdmErrorClass | 1
mdmErrNoDCD     equ     mdmErrorClass | 2
mdmErrBusy      equ     mdmErrorClass | 3
mdmErrUserCan   equ     mdmErrorClass | 4
mdmErrCmdError  equ     mdmErrorClass | 5
mdmErrNoModem   equ     mdmErrorClass | 6
mdmErrMemory    equ     mdmErrorClass | 7
mdmErrPrefs     equ     mdmErrorClass | 8
mdmErrDial      equ     mdmErrorClass | 9


; System\ModemPrv.h

mdmDefaultResponseWait  equ     300000

;???typedef enum  {
;???    mdmCmdCSI,
;???    mdmCmdEOC,
;???    mdmCmdQuiet,
;???    mdmCmdDialTone,
;???    mdmCmdDialPulse,
;???    mdmCmdEchoOff,
;???    mdmCmdVerbose,
;???    mdmCmdDTWait,
;???    mdmCmdDCDWait,
;???    mdmCmdBasicXCmd,
;???    mdmCmdAdvXCmd,
;???    mdmCmdSpkrOnTillConnect,
;???    mdmCmdSpkrOff,
;???    mdmCmdVolume,
;???    mdmCmdHUP,
;???    mdmCmdFirmDTRDCD,
;???    mdmCmdEscape,
;???    mdmCmdReset,
;???    mdmCmdFactory,
;???    mdmCmdRetToCmdMode
;???    } MdmCmdEnum;

;???typedef enum MdmRespIDType {
;???    mdmRespUnknown = 0,
;???    mdmRespOK,
;???    mdmRespConnect,
;???    mdmRespNoCarrier,
;???    mdmRespError,
;???    mdmRespNoDialTone,
;???    mdmRespBusy,
;???    mdmRespRing,
;???
;???    mdmRespReserved = -1
;???    } MdmRespIDType;

;???enum {
;???    mdmHandshakeStd         = 0,
;???    mdmHandshakeOff         = 1,
;???    mdmHandshakeOn                  = 2
;???    };

mdmPrefVersionNum       equ     2

;struct MdmPrefType
;       version.w
;       baud.l
;       volume.b
;       pulse.b
;       hShk.b
;       autoBaud.b
;       resetString[(mdmCmdSize*2)+1].b
;       initString[mdmCmdBufSize].b
;endstruct MdmPrefTypeMdmPrefType

mdmDefaultDialMode      equ     false

mdmDefaultBaud          equ     19200
;mdmDefaultVolume       equ     mdmVolumeow
mdmDefaultPulse         equ     false
;mdmDefaultHShk         equ     mdmHandshakeStd
mdmDefaultAutoBaud      equ     false
;mdmDefaultResetString  equ     ""
;mdmDefaultInitString   equ     "&F&B1X4"


; System\NewFloatMgr.h

flpVersion      equ     $02008000

flpToNearest    equ     0
flpTowardZero   equ     1
flpUpward       equ     3
flpDownward     equ     2
flpModeMask     equ     $00000030
flpModeShift    equ     4

flpInvalid      equ     $00008000
flpOverflow     equ     $00004000
flpUnderflow    equ     $00002000
flpDivByZero    equ     $00001000
flpInexact      equ     $00000800

flpEqual        equ     0
flpLess         equ     1
flpGreater      equ     2
flpUnordered    equ     3

struct _sfpe_64_bits
        high.l
        low.l
endstruct

struct FlpDoubleBits
        sign.l
        exp.l
        manH.l
        manL.l
endstruct

;???typedef union {
;???        double                              d;
;???        FlpDouble                   fd;
;???        DWord                               ul[2];
;???        FlpDoubleBits       fdb;
;???} FlpCompDouble;

;???typedef union {
;???        float                               f;
;???        FlpFloat                    ff;
;???        DWord                               ul;
;???} FlpCompFloat;

flpErrOutOfRange        equ     flpErrorClass | 1

m68kMoveQd2Instr        equ     $7400

;???typedef enum {
;???    sysFloatBase10Info = 0,
;???    sysFloatFToA,
;???    sysFloatAToF,
;???    sysFloatCorrectedAdd,
;???    sysFloatCorrectedSub,
;???    sysFloatVersion,
;???    flpMaxFloatSelector = sysFloatVersion
;???} sysFloatSelector;

;???typedef enum {
;???    sysFloatEm_fp_round = 0,
;???    sysFloatEm_fp_get_fpscr,
;???    sysFloatEm_fp_set_fpscr,
;???    sysFloatEm_f_utof,
;???    sysFloatEm_f_itof,
;???    sysFloatEm_f_ulltof,
;???    sysFloatEm_f_lltof,
;???    sysFloatEm_d_utod,
;???    sysFloatEm_d_itod,
;???    sysFloatEm_d_ulltod,
;???    sysFloatEm_d_lltod,
;???    sysFloatEm_f_ftod,
;???    sysFloatEm_d_dtof,
;???    sysFloatEm_f_ftoq,
;???    sysFloatEm_f_qtof,
;???    sysFloatEm_d_dtoq,
;???    sysFloatEm_d_qtod,
;???    sysFloatEm_f_ftou,
;???    sysFloatEm_f_ftoi,
;???    sysFloatEm_f_ftoull,
;???    sysFloatEm_f_ftoll,
;???    sysFloatEm_d_dtou,
;???    sysFloatEm_d_dtoi,
;???    sysFloatEm_d_dtoull,
;???    sysFloatEm_d_dtoll,
;???    sysFloatEm_f_cmp,
;???    sysFloatEm_f_cmpe,
;???    sysFloatEm_f_feq,
;???    sysFloatEm_f_fne,
;???    sysFloatEm_f_flt,
;???    sysFloatEm_f_fle,
;???    sysFloatEm_f_fgt,
;???    sysFloatEm_f_fge,
;???    sysFloatEm_f_fun,
;???    sysFloatEm_f_for,
;???    sysFloatEm_d_cmp,
;???    sysFloatEm_d_cmpe,
;???    sysFloatEm_d_feq,
;???    sysFloatEm_d_fne,
;???    sysFloatEm_d_flt,
;???    sysFloatEm_d_fle,
;???    sysFloatEm_d_fgt,
;???    sysFloatEm_d_fge,
;???    sysFloatEm_d_fun,
;???    sysFloatEm_d_for,
;???    sysFloatEm_f_neg,
;???    sysFloatEm_f_add,
;???    sysFloatEm_f_mul,
;???    sysFloatEm_f_sub,
;???    sysFloatEm_f_div,
;???    sysFloatEm_d_neg,
;???    sysFloatEm_d_add,
;???    sysFloatEm_d_mul,
;???    sysFloatEm_d_sub,
;???    sysFloatEm_d_div
;???} sysFloatEmSelector;


; System\Password.h

pwdLength       equ     32
pwdEncryptionKeyLength  equ     64


; System\PenMgr.h

penErrBadParam  equ     penErrorClass | 1


; System\PenPrv.h

penCalibrateTop equ     10
penCalibrateLeft        equ     10
penCalibrateBottom      equ     hwrDisplayHeight-10
penCalibrateRight       equ     hwrDisplayWidth-10

penInitDelay    equ     $180

penBBDelay      equ     105
penInitMaxDDZ   equ     12
penInitMaxSlop  equ     2
penInitMaxRetries       equ     3
penInitMaxEndBlip       equ     5

penNumSamples   equ     5

penHotSample    equ     2

penMinUpSamples equ     3
penMinDownSamples       equ     1

penDownButInvalid       equ     $7FFF

struct PenGlobalsType
        calibrated.b
        filler.b
        xOffset.w
        yOffset.w
        xScale.w
        yScale.w
        sample.20
        delay.w
        maxDDZ.w
        maxRetries.w
        maxSlop.w
        maxEndBlip.w
        penDownCount.w
        penDownCountInit.w
endstruct


; System\PilotStdio.h

SEEK_SET        equ     fileOriginBeginning
SEEK_CUR        equ     fileOriginCurrent
SEEK_END        equ     fileOriginEnd


; System\SysConfigPrv.h

mem32K  equ     $008000
mem64K  equ     $010000
mem96K  equ     $018000
mem128K equ     $020000
mem256K equ     $040000
mem512K equ     $080000
mem1MB  equ     $100000
mem2MB  equ     $200000


; System\SysEvtMgr.h

evtErrParamErr          equ     evtErrorClass | 1
evtErrQueueFull         equ     evtErrorClass | 2
evtErrQueueEmpty        equ     evtErrorClass | 3


; UI\Rect.h

struct AbsRectType
        left.w
        top.w
        right.w
        bottom.w
endstruct

struct PointType
        x.w
        y.w
endstruct

struct RectangleType
        topLeft.PointType
        extent.PointType
endstruct


; System\SysEvtPrv.h

struct PenQueueType
        start.w
        end.w
        size.w
        strokeCount.w
        returnedPenDown.b
        pad.b
        addLast.PointType
        addStrokeStart.w
        strokesRemoved.w
        strokesAdded.w
        rmvStrokeStage.w
        rmvLast.PointType
        rmvStartPt.PointType
        data.b
endstruct

struct KeyQueueType
        start.w
        end.w
        size.w
        data.b
endstruct

struct PenBtnInfoType
        boundsR.RectangleType
        asciiCode.w
        keyCode.w
        modifiers.w
endstruct

evtKeyStringEscape      equ     $01

evtDefaultPenQSize      equ     $100
evtDefaultKeyQSize      equ     $40

grmGremlinsOn   equ     $01
grmEventTraceOn equ     $02
grmGremlinsIdle equ     $04

struct SysEvtMgrGlobalsType
        sendNullEvent.b
        enableGraffiti.b
        enableSoftKeys.b
        removeTopStroke.b
        penQP.l
        penQStrokesRemoved.w
        keyQP.l
        writingR.RectangleType
        appAreaBottom.w
        penX.w
        penY.w
        penDown.b
        displayingBatteryAlert.b
        lastPenX.w
        lastPenY.w
        lastPenDown.b
        needRemoteScrUpdate.b
        gremlinsFlags.b
        idle.b
endstruct


; Core/System/Window.h
winScreenModeGetDefaults        equ     0
winScreenModeGet                equ     1
winScreenModeSetToDefaults      equ     2
winScreenModeSet                equ     3
winScreenModeGetSupportedDepths equ     4
winScreenModeGetSupportsColor   equ     5

; UI\WindowNew.h

up      equ     0
down    equ     1
left    equ     3
right   equ     4

; windowFormats
screenFormat    equ     0
genericFormat   equ     1

; ScrOperation
scrCopy equ     0
scrAND  equ     1
scrANDNOT       equ     2
scrXOR  equ     3
scrOR   equ     4
scrCopyNOT      equ     5

; patterns
blackPattern    equ     0
whitePattern    equ     1
grayPattern     equ     2
customPattern   equ     3

grayHLinePattern        equ     $AA

; underlineModes
noUnderline     equ     0
grayUnderline   equ     1
solidUnderline  equ     2

BitmapFlagsType_compressed      equ     $0001
BitmapFlagsType_hasColorTable   equ     $0002

struct BitmapType
        width.w
        height.w
        rowBytes.w
        flags.w
        pixelSize.b
        version.b
        nextDepthOffset.l
        reserved.4
        Bits.b
endstruct

struct RGBColorType
        unused.b
        red.b
        green.b
        blue.b
endstruct

struct ColorTableType
        numEntries.w
        entry.RGBColorType
endstruct

struct GraphicStateType
        grafMode.b
        patternMode.b
        pattern.w
        customPtn.8
        fontId.b
        padding1.b
        font.l
        underlineMode.w
        foreColor.RGBColorType
        backColor.RGBColorType
endstruct

;typedef union {
;       struct {
;               Word cornerDiam   : 8;            // corner diameter, max 38
;               Word reserved_3   : 3;
;               Word threeD                     : 1;                    ;       // Draw 3D button    ;
;               Word s;hadowWidth  : 2;            // Width of shadow
;               Word w;idth        : 2;            // Width frame
;       } bits;;
;       Word wo;rd;                                                             ;// IMPORTANT: INITIALIZE word to zero before setting bits!
;;noFrame       equ     0
;impleFrame     equ     1
;ectangleFrame  equ     1
;imple3DFrame   equ     $0012
;oundFrame      equ     $0401
;oldRoundFrame  equ     $0702
;opupFrame      equ     $0205
;ialogFrame     equ     $0302
;enuFrame       equ     popupFrame
;;WindowFlagsType_format_shift     equ 0
;indowFlagsType_format_count     equ 1
;indowFlagsType_format_mask      equ $00000001
;indowFlagsType_offscreen_shift  equ 1
;indowFlagsType_offscreen_count  equ 1
;indowFlagsType_offscreen_mask   equ $00000002
;indowFlagsType_modal_shift      equ 2
;indowFlagsType_modal_count      equ 1
;indowFlagsType_modal_mask       equ $00000004
;indowFlagsType_focusable_shift  equ 3
;indowFlagsType_focusable_count  equ 1
;indowFlagsType_focusable_mask   equ $00000008
;indowFlagsType_enabled_shift    equ 4
;indowFlagsType_enabled_count    equ 1
;indowFlagsType_enabled_mask     equ $00000010
;indowFlagsType_visible_shift    equ 5
;indowFlagsType_visible_count    equ 1
;indowFlagsType_visible_mask     equ $00000020
;indowFlagsType_dialog_shift     equ 6
;indowFlagsType_dialog_count     equ 1
;indowFlagsType_dialog_mask      equ $00000040
;indowFlagsType_compressed_shift equ 7
;indowFlagsType_compressed_count equ 1
;indowFlagsType_compressed_mask  equ $00000080
;indowFlagsType_reserved_shift   equ 8
;indowFlagsType_reserved_count   equ 8
;indowFlagsType_reserved_mask    equ $0000ff00
;;struct GDeviceType
;baseAddr.l
;width.w
;height.w
;rowBytes.w
;pixelSize.b
;version.b
;flages.w
;       forDriver:1.w
;       dynamic:1.w
;       compressed:1.w
;       flags:13.w
;       cTableP.l
;endstruct

struct WindowType
        displayWidthV20.w
        displayHeightV20.w
        displayAddrV20.l
        windowFlags.w
        windowBounds.RectangleType
        clippingBounds.AbsRectType
        gDeviceP.l
        frameType.w
        gstate.l
        nextWindow.l
endstruct


; UI\Control.h

ControlAttrType_usable_shift     equ 0
ControlAttrType_usable_count     equ 1
ControlAttrType_usable_mask      equ $00000001
ControlAttrType_enabled_shift    equ 1
ControlAttrType_enabled_count    equ 1
ControlAttrType_enabled_mask     equ $00000002
ControlAttrType_visible_shift    equ 2
ControlAttrType_visible_count    equ 1
ControlAttrType_visible_mask     equ $00000004
ControlAttrType_on_shift         equ 3
ControlAttrType_on_count         equ 1
ControlAttrType_on_mask          equ $00000008
ControlAttrType_leftAnchor_shift equ 4
ControlAttrType_leftAnchor_count equ 1
ControlAttrType_leftAnchor_mask  equ $00000010
ControlAttrType_frame_shift      equ 5
ControlAttrType_frame_count      equ 3
ControlAttrType_frame_mask       equ $000000e0

;controlStyles
buttonCtl       equ     0
pushButtonCtl   equ     1
checkboxCtl     equ     2
popupTriggerCtl equ     3
selectorTriggerCtl      equ     4
repeatingButtonCtl      equ     5

; buttonFrames
noButtonFrame   equ     0
standardButtonFrame     equ     1
boldButtonFrame equ     2
rectangleButtonFrame    equ     3

struct ControlType
        id.w
        bounds.RectangleType
        text.l
        attr.w          ;ControlAttrType
        style.w         ;ControlStyleType
        font.b          ;FontID
        group.b
endstruct


; UI\Category.h

struct AppInfoType
        renamedCategories.w
        categoryLabels.256
        categoryUniqIDs.16
        lastUniqID.b
endstruct


; UI\CharAttr.h

_XA     equ     $200
_XS     equ     $100
_BB     equ     $80
_CN     equ     $40
_DI     equ     $20
_LO     equ     $10
_PU     equ     $08
_SP     equ     $04
_UP     equ     $02
_XD     equ     $01


; UI\Chars.h

downArrowChr    equ     $1F
upArrowChr      equ     $1E
leftArrowChr    equ     $1C
rightArrowChr   equ     $1D

pageUpChr       equ     $0B
pageDownChr     equ     $0C

lowBatteryChr   equ     $0101
enterDebuggerChr        equ     $0102
nextFieldChr    equ     $0103
startConsoleChr equ     $0104
menuChr equ     $0105
commandChr      equ     $0106
confirmChr      equ     $0107
launchChr       equ     $0108
keyboardChr     equ     $0109
findChr equ     $010A
calcChr equ     $010B
prevFieldChr    equ     $010C
alarmChr        equ     $010D
ronamaticChr    equ     $010E
graffitiReferenceChr    equ     $010F
keyboardAlphaChr        equ     $0110
keyboardNumericChr      equ     $0111
lockChr equ     $0112
backlightChr    equ     $0113
autoOffChr      equ     $0114
exgTestChr      equ     $0115
sendDataChr     equ     $0116
irReceiveChr    equ     $0117

hardKeyMin      equ     $0200
hardKeyMax      equ     $02FF
hard1Chr        equ     $0204
hard2Chr        equ     $0205
hard3Chr        equ     $0206
hard4Chr        equ     $0207
hardPowerChr    equ     $0208
hardCradleChr   equ     $0209
hardCradle2Chr  equ     $020A

nullChr equ     $00
backspaceChr    equ     $08
tabChr  equ     $09
linefeedChr     equ     $0A
crChr   equ     $0D
colonChr        equ     ':'
periodChr       equ     '.'
commaChr        equ     ','
quoteChr        equ     '"'

returnChr       equ     $0D
escapeChr       equ     $1B
spaceChr        equ     $20
lastAsciiChr    equ     $FF

numericSpaceChr equ     $80

cutChr  equ     $12D
copyChr equ     $12E
pasteChr        equ     $12F

lowSingleCommaQuoteChr  equ     $82
scriptFChr      equ     $83
lowDblCommaQuoteChr     equ     $84
horizEllipsisChr        equ     $85
daggerChr       equ     $86
dblDaggerChr    equ     $87
circumflexChr   equ     $88
perMilleChr     equ     $89
upSHacekChr     equ     $8A
leftSingleGuillemetChr  equ     $8B
upOEChr equ     $8C

clubChr equ     $8E
heartChr        equ     $8F
spadeChr        equ     $90
singleOpenCommaQuoteChr equ     $91
singleCloseCommaQuoteChr        equ     $92
dblOpenCommaQuoteChr    equ     $93
dblCloseCommaQuoteChr   equ     $94
bulletChr       equ     $95
enDashChr       equ     $96
emDashChr       equ     $97
spacingTildeChr equ     $98
trademarkChr    equ     $99
lowSHacekChr    equ     $9A
rightSingleGuillemetChr equ     $9B
lowOEChr        equ     $9C
commandStrokeChr        equ     $9D
shortcutStrokeChr       equ     $9E
upYDiaeresisChr equ     $9F
nonBreakSpaceChr        equ     $A0
invertedExclamationChr  equ     $A1
centChr equ     $A2
poundChr        equ     $A3
currencyChr     equ     $A4
yenChr  equ     $A5
brokenVertBarChr        equ     $A6
sectionChr      equ     $A7
spacingDiaeresisChr     equ     $A8
copyrightChr    equ     $A9
feminineOrdinalChr      equ     $AA
leftGuillemetChr        equ     $AB
notChr  equ     $AC
softHyphenChr   equ     $AD
registeredChr   equ     $AE
spacingMacronChr        equ     $AF
degreeChr       equ     $B0
plusMinusChr    equ     $B1
superscript2Chr equ     $B2
superscript3Chr equ     $B3
spacingAcuteChr equ     $B4
microChr        equ     $B5
paragraphChr    equ     $B6
middleDotChr    equ     $B7
spacingCedillaChr       equ     $B8
superscript1Chr equ     $B9
masculineOrdinalChr     equ     $BA
rightGuillemetChr       equ     $BB
fractOneQuarterChr      equ     $BC
fractOneHalfChr equ     $BD
fractThreeQuartersChr   equ     $BE
invertedQuestionChr     equ     $BF
upAGraveChr     equ     $C0
upAAcuteChr     equ     $C1
upACircumflexChr        equ     $C2
upATildeChr     equ     $C3
upADiaeresisChr equ     $C4
upARingChr      equ     $C5
upAEChr equ     $C6
upCCedillaChr   equ     $C7
upEGraveChr     equ     $C8
upEAcuteChr     equ     $C9
upECircumflexChr        equ     $CA
upEDiaeresisChr equ     $CB
upIGraveChr     equ     $CC
upIAcuteChr     equ     $CD
upICircumflexChr        equ     $CE
upIDiaeresisChr equ     $CF
upEthChr        equ     $D0
upNTildeChr     equ     $D1
upOGraveChr     equ     $D2
upOAcuteChr     equ     $D3
upOCircumflexChr        equ     $D4
upOTildeChr     equ     $D5
upODiaeresisChr equ     $D6
multiplyChr     equ     $D7
upOSlashChr     equ     $D8
upUGraveChr     equ     $D9
upUAcuteChr     equ     $DA
upUCircumflexChr        equ     $DB
upUDiaeresisChr equ     $DC
upYAcuteChr     equ     $DD
upThorn equ     $DE
lowSharpSChr    equ     $DF
lowAGraveChr    equ     $E0
lowAAcuteChr    equ     $E1
lowACircumflexChr       equ     $E2
lowATildeChr    equ     $E3
lowADiaeresisChr        equ     $E4
lowARingChr     equ     $E5
lowAEChr        equ     $E6
lowCCedillaChr  equ     $E7
lowEGraveChr    equ     $E8
lowEAcuteChr    equ     $E9
lowECircumflexChr       equ     $EA
lowEDiaeresisChr        equ     $EB
lowIGraveChr    equ     $EC
lowIAcuteChr    equ     $ED
lowICircumflexChr       equ     $EE
lowIDiaeresisChr        equ     $EF
lowEthChr       equ     $F0
lowNTildeChr    equ     $F1
lowOGraveChr    equ     $F2
lowOAcuteChr    equ     $F3
lowOCircumflexChr       equ     $F4
lowOTildeChr    equ     $F5
lowODiaeresisChr        equ     $F6
divideChr       equ     $F7
lowOSlashChr    equ     $F8
lowUGraveChr    equ     $F9
lowUAcuteChr    equ     $FA
lowUCircumflexChr       equ     $FB
lowUDiaeresisChr        equ     $FC
lowYAcuteChr    equ     $FD
lowThorn        equ     $FE
lowYDiaeresisChr        equ     $FF

; symbolChars
symbolLeftArrow equ     3
symbolRightArrow        equ     4
symbolUpArrow   equ     5
symbolDownArrow equ     6
symbolSmallDownArrow    equ     7
symbolSmallUpArrow      equ     8
symbolMemo      equ     9
symbolHelp      equ     10
symbolNote      equ     11
symbolNoteSelected      equ     12
symbolCapsLock  equ     13
symbolNumLock   equ     14
symbolShiftUpper        equ     15
symbolShiftPunc equ     16
symbolShiftExt  equ     17
symbolShiftNone equ     18
symbolNoTime    equ     19
symbolAlarm     equ     20
symbolRepeat    equ     21
symbolCheckMark equ     22

;symbol7Chars
symbol7ScrollUp equ     1
symbol7ScrollDown       equ     2
symbol7ScrollUpDisabled equ     3
symbol7ScrollDownDisabled       equ     4

; symbol11Chars
symbolCheckboxOff       equ     0
symbolCheckboxOn        equ     1
symbol11LeftArrow       equ     2
symbol11RightArrow      equ     3


; System\Keyboard.h

kbdReturnKey    equ     linefeedChr
kbdTabKey       equ     tabChr
kbdBackspaceKey equ     backspaceChr
kbdShiftKey     equ     2
kbdCapsKey      equ     1
kbdNoKey        equ     $ff

; KeyboardType
kbdAlpha        equ     0
kbdNumbersAndPunc       equ     1
kbdAccent       equ     2
kbdDefault      equ     $ff


; UI\ClipBoard.h

numClipboardForamts     equ     3
cbdMaxTextLength        equ     1000

; clipboardFormats
clipboardText   equ     0
clipboardInk    equ     1
clipboardBitmap equ     2

struct ClipboardItem
        item.l
        length.w
endstruct


; UI\Day.h

; SelectDayType
selectDayByDay  equ     0
selectDayByWeek equ     1
selectDayByMonth        equ     2

struct DaySelectorType
        bounds.RectangleType
        visible.w
        visibleMonth.w
        visibleYear.w
        selected.DateTimeType
        selectDayBy.b   ;SelectDayType
        pad.b
endstruct


; UI\Event.H

; events
nilEvent        equ     0
penDownEvent    equ     1
penUpEvent      equ     2
penMoveEvent    equ     3
keyDownEvent    equ     4
winEnterEvent   equ     5
winExitEvent    equ     6
ctlEnterEvent   equ     7
ctlExitEvent    equ     8
ctlSelectEvent  equ     9
ctlRepeatEvent  equ     10
lstEnterEvent   equ     11
lstSelectEvent  equ     12
lstExitEvent    equ     13
popSelectEvent  equ     14
fldEnterEvent   equ     15
fldHeightChangedEvent   equ     16
fldChangedEvent equ     17
tblEnterEvent   equ     18
tblSelectEvent  equ     19
daySelectEvent  equ     20
menuEvent       equ     21
appStopEvent    equ     22
frmLoadEvent    equ     23
frmOpenEvent    equ     24
frmGotoEvent    equ     25
frmUpdateEvent  equ     26
frmSaveEvent    equ     27
frmCloseEvent   equ     28
;tblExitEvent   equ     29      ; PalmOS 1.0
frmTitleEnterEvent      equ     29
frmTitleSelectEvent     equ     30
tblExitEvent    equ     31
sclEnterEvent   equ     32
sclExitEvent    equ     33
sclRepeatEvent  equ     34
firstUserEvent  equ     32767

shiftKeyMask    equ     $0001
capsLockMask    equ     $0002
numLockMask     equ     $0004
commandKeyMask  equ     $0008
optionKeyMask   equ     $0010
controlKeyMask  equ     $0020
autoRepeatKeyMask       equ     $0040
doubleTapKeyMask        equ     $0080
poweredOnKeyMask        equ     $0100
appEvtHookKeyMask       equ     $0200
libEvtHookKeyMask       equ     $0400

evtWaitForever  equ     -1

struct EventType
        eType.w
        penDown.w
        screenX.w
        screenY.w
        data.16
endstruct

; union data

struct generic
        data1.w
        data2.w
        data3.w
        data4.w
        data5.w
        data6.w
        data7.w
        data8.w
endstruct

struct penUp
        start.PointType
        end.PointType
endstruct

struct keyDown
        chr.w
        keyCode.w
        modifiers.w
endstruct

struct winEnter
        enterWindow.l
        exitWindow.l
endstruct

struct winExit
        enterWindow.l
        exitWindow.l
endstruct

struct ctlEnter
        controlID.w
        pControl.l
endstruct

struct ctlSelect
        controlID.w
        pControl.l
        on.b
        bPad.b
endstruct

struct ctlRepeat
        controlID.w
        pControl.l
        time.l
endstruct

struct fldEnter
        fieldID.w
        pField.l
endstruct

struct fldHeightChanged
        fieldID.w
        pField.l
        newHeight.w
        currentPos.w
endstruct

struct fldChanged
        fieldID.w
        pField.l
endstruct

struct fldExit
        fieldID.w
        pField.l
endstruct

struct lstEnter
        listID.w
        pList.l
        selection.w
endstruct

struct lstExit
        listID.w
        pList.l
endstruct

struct lstSelect
        listID.w
        pList.l
        selection.w
endstruct

struct tblEnter
        tableID.w
        pTable.l
        row.w
        column.w
endstruct

struct tblExit
        tableID.w
        pTable.l
        row.w
        column.w
endstruct

struct tblSelect
        tableID.w
        pTable.l
        row.w
        column.w
endstruct

struct frmLoad
        formID.w
endstruct

struct frmOpen
        formID.w
endstruct

struct frmGoto
        formID.w
        recordNum.w
        matchPos.w
        matchLen.w
        matchFieldNum.w
        matchCustom.l
endstruct

struct frmClose
        formID.w
endstruct

struct frmUpdate
        formID.w
        updateCode.w
endstruct

struct frmTitleEnter
        formID.w
endstruct

struct frmTitleSelect
        formID.w
endstruct

struct daySelect
        pSelector.l
        selection.w
        useThisDate.b
        bPad.b
endstruct

struct menu
        itemID.w
endstruct

struct popSelect
        controlID.w
        controlP.l
        listID.w
        listP.l
        selection.w
        priorSelection.w
endstruct

struct sclEnter
        scrollBarID.w
        pScrollBar.l
endstruct

struct sclExit
        scrollBarID.w
        pScrollBar.l
        value.w
        newValue.w
endstruct

struct sclRepeat
        scrollBarID.w
        pScrollBar.l
        value.w
        newValue.w
        time.l
endstruct

struct EventStoreType
        event.w
        id.l
endstruct EventStoreType


; System\INetMgr.h

inetCreator     equ     'inet'
inetLibFtrCreator       equ     inetCreator
inetFtrNumVersion       equ     0
inetLibType     equ     'libr'

inetOpenFlagOKWireless  equ     $00000001
inetOpenFlagOKWireline  equ     $00000002
inetOpenFlagPreferWireless      equ     $00000004

inetErrTooManyClients           equ     inetErrorClass | 1
inetErrHandleInvalid            equ     inetErrorClass | 2
inetErrParamsInvalid            equ     inetErrorClass | 3
inetErrURLVersionInvalid        equ     inetErrorClass | 4
inetErrURLBufTooSmall           equ     inetErrorClass | 5
inetErrURLInvalid               equ     inetErrorClass | 6
inetErrTooManySockets           equ     inetErrorClass | 7
inetErrNoRequestCreated equ     inetErrorClass | 8
inetErrNotConnected             equ     inetErrorClass | 9
inetErrInvalidRequest           equ     inetErrorClass | 10
inetErrNeedTime         equ     inetErrorClass | 11
inetErrHostnameInvalid          equ     inetErrorClass | 12
inetErrInvalidPort              equ     inetErrorClass | 13
inetErrInvalidHostAddr          equ     inetErrorClass | 14
inetErrNilBuffer                equ     inetErrorClass | 15
inetErrConnectTimeout           equ     inetErrorClass | 16
inetErrResolveTimeout           equ     inetErrorClass | 17
inetErrSendReqTimeout           equ     inetErrorClass | 18
inetErrReadTimeout              equ     inetErrorClass | 19
inetErrBufTooSmall              equ     inetErrorClass | 20
inetErrSchemeNotSupported       equ     inetErrorClass | 21
inetErrInvalidResponse          equ     inetErrorClass | 22

; INetSchemeEnum
inetSchemeUnknown       equ     -1
inetSchemeDefault       equ     0
inetSchemeHTTP  equ     1
inetSchemeHTTPS equ     2
inetSchemeFTP   equ     3
inetSchemeGopher        equ     4
inetSchemeFile  equ     5
inetSchemeNews  equ     6
inetSchemeMailTo        equ     7
inetSchemeMail  equ     8
inetSchemeFirst equ     inetSchemeHTTP
inetSchemeLast  equ     inetSchemeMail

struct INetURLType
        version.w
        schemeP.l
        schemeLen.w
        schemeEnum.w
        hostnameP.l
        hostnameLen.w
        port.w
        usernameP.l
        usernameLen.w
        passwordP.l
        passwordLen.w
        pathP.l
        pathLen.w
        extraInfoP.l
        extraInfoLen.w
endstruct

; INetProxyEnum
inetProxyNone   equ     0
inetProxyJerry  equ     1

; INetSettingEnum;
inetSettingProxyType    equ     0
inetSettingJerryProxyName       equ     1
inetSettingJerryProxyPort       equ     2
inetSettingJerryProxyAddrGrMAN  equ     3
inetSettingJerryProxyAddrMAN    equ     4
inetSettingWirelessNetwork      equ     5
inetSettingSockContext  equ     6
inetSettingLast equ     7

; INetStatusEnum;
inetStatusNew                   equ     0
inetStatusResolvingName         equ     1
inetStatusNameResolved          equ     2
inetStatusConnecting            equ     3
inetStatusConnected             equ     4
inetStatusSendingRequest        equ     5
inetStatusWaitingForResponse    equ     6
inetStatusReceivingResponse     equ     7
inetStatusResponseReceived      equ     8
inetStatusClosingConnection     equ     9

; INetHTTPAttrEnum;
inetHTTPAttrCommErr             equ     0
inetHTTPAttrEntityURL           equ     1
inetHTTPAttrReqAuthorization    equ     2
inetHTTPAttrReqFrom             equ     3
inetHTTPAttrReqIfModifiedSince  equ     4
inetHTTPAttrReqReferer          equ     5
inetHTTPAttrRspAll              equ     6
inetHTTPAttrRspVersion          equ     7
inetHTTPAttrStatusCode          equ     8
inetHTTPAttrReason              equ     9
inetHTTPAttrDate                equ     10
inetHTTPAttrNoCache             equ     11
inetHTTPAttrPragma              equ     12
inetHTTPAttrServer              equ     13
inetHTTPAttrWWWAuthentication   equ     14
inetHTTPAttrContentAllow        equ     15
inetHTTPAttrContentEncoding     equ     16
inetHTTPAttrContentLength       equ     17
inetHTTPAttrContentPtr          equ     18
inetHTTPAttrContentType         equ     19
inetHTTPAttrContentExpires      equ     20
inetHTTPAttrContentLastModified equ     21
inetHTTPAttrContentLocation     equ     22

inetSockReadyEvent              equ     firstUserEvent
inetSockStatusChangeEvent       equ     firstUserEvent+1
inetLastEvent                   equ     firstUserEvent+1

struct INetEventType
        eType.b
        penDown.b
        screenX.w
        screenY.w
        union.16
endstruct

struct generic
        data1.w
        data2.w
        data3.w
        data4.w
        data5.w
        data6.w
        data7.w
        data8.w
endstruct

struct inetSockReady
        sockH.l
        context.l
        inputReady.b
        outputReady.b
endstruct

struct inetSockStatusChange
        sockH.l
        context.l
        status.w
        sockErr.w
endstruct

; INetLibTrapNumberEnum;
inetLibTrapSettingGet   equ     sysLibTrapCustom
inetLibTrapSettingSet   equ     sysLibTrapCustom+1
inetLibTrapGetEvent     equ     sysLibTrapCustom+2
inetLibTrapURLOpen      equ     sysLibTrapCustom+3
inetLibTrapSockRead     equ     sysLibTrapCustom+4
inetLibTrapSockWrite    equ     sysLibTrapCustom+5
inetLibTrapSockOpen     equ     sysLibTrapCustom+6
inetLibTrapSockClose    equ     sysLibTrapCustom+7
inetLibTrapSockStatus   equ     sysLibTrapCustom+8
inetLibTrapSockSettingGet       equ     sysLibTrapCustom+9
inetLibTrapSockSettingSet       equ     sysLibTrapCustom+10
inetLibTrapSockConnect  equ     sysLibTrapCustom+11
inetLibTrapURLCrack     equ     sysLibTrapCustom+12
inetLibTrapSockHTTPReqCreate    equ     sysLibTrapCustom+13
inetLibTrapSockHTTPAttrSet      equ     sysLibTrapCustom+14
inetLibTrapSockHTTPReqSend      equ     sysLibTrapCustom+15
inetLibTrapSockHTTPAttrGet      equ     sysLibTrapCustom+16
inetLibTrapSockMailReqCreate    equ     sysLibTrapCustom+17
inetLibTrapSockMailAttrSet      equ     sysLibTrapCustom+18
inetLibTrapSockMailReqAdd       equ     sysLibTrapCustom+19
inetLibTrapSockMailReqSend      equ     sysLibTrapCustom+20
inetLibTrapSockMailAttrGet      equ     sysLibTrapCustom+21
inetLibTrapSockMailQueryProgress        equ     sysLibTrapCustom+22
inetLibTrapLast equ     sysLibTrapCustom+23


; System\INetMgrMail.h

; inetMailAttrEnum
inetMailAttrCommErr     equ     0
inetMailAttrReqEncrypted        equ     1

struct INetMailUIDType
        hi.w
        lo.l
endstruct

; INetMailCmdEnum;
inetMailCmdNew          equ     0
inetMailCmdSend         equ     1
inetMailCmdGetMore      equ     2
inetMailCmdServer       equ     3

inetMailMaxUsername     equ     32
inetMailMaxPassword     equ     32

struct INetMailNewType
        id.INetMailUIDType
        previewSize.l
        headerFieldsP.l
        availMemory.l
        truncationSize.l
        networkID.l
        username.32
        password.32
endstruct

struct INetMailSendType
        priority.w
        confirmRead.b
        confirmDelivery.b
        attachmentCount.w
        attachmentsP.l
        msgSize.l
        msgP.l
endstruct

struct INetMailGetMoreType
        id.INetMailUIDType
        bodyEndOffset.l
        headerFieldsP.l
endstruct

struct INetMailServerType
        serverCmd.l
        serverParamsLen.l
        serverParamsP.l
endstruct

inetMailContentJerry    equ     0

struct INetMailHeaderType
        proxyErr.w
        serverErr.w
        rspSize.l
        serverErr.w
        contentType.w
        newMsgs.w
        updMsgs.w
        moreMailAvail.b
        pad.b
endstruct

; INetMailRspEnum;
inetMailRspEnd                  equ     0
inetMailRspNewMsg               equ     1
inetMailRspMsgAttachment        equ     2
inetMailRspUpdMsg               equ     3
inetMailRspAck                  equ     4

struct INetMailRspType
        kind.w
        dataSize.l
        union.32
endstruct

struct generic
        generic.32
endstruct

struct newMsg
        id.INetMailUIDType
        addrType.w
        bodyEndOffset.l
        priority.w
        serverMsgSize.l
        serverNoteID.w
        attachmentCount.w
        timeStamp.l
endstruct

struct attachment
        type.l
endstruct

struct updMsg
        id.INetMailUIDType
        bodyEndOffset.l
        serverNoteID.w
        attachmentCount.w
endstruct

struct ack
        cmd.w
        serverErr.l
        id.INetMailUIDType
        dataType.l
endstruct


; UI\Font.h

struct FontCharInfoType
        offset.b
        width.b
endstruct

struct FontType
        fontType.w
        firstChar.w
        lastChar.w
        maxWidth.w
        kernMax.w
        nDescent.w
        fRectWidth.w
        fRectHeight.w
        owTLoc.w
        ascent.w
        descent.w
        leading.w
        rowWords.w
endstruct

; fontID
stdFont equ     0
boldFont        equ     1
largeFont       equ     2
symbolFont      equ     3
symbol11Font    equ     4
symbol7Font     equ     5
ledFont equ     6
largeBoldFont   equ     7
fntAppFontCustomBase    equ     $80

checkboxFont    equ     symbol11Font


; UI\Find.h

maxFinds        equ     9
maxFindStrLen   equ     16

struct FindMatchType
        appCardNo.w
        appDbID.l
        foundInCaller.w
        dbCardNo.w
        dbID.l
        recordNum.w
        matchPos.w
        matchFieldNum.w
        matchCustom.l
endstruct

struct FindParamsType
        dbAccesMode.w
        recordNum.w
        more.b
        strAsTyped.17
        strToFind.17
        pad.b
        numMatches.w
        lineNumber.w
        continuation.b
        searchedCaller.b
        callerAppDbID.l
        callerAppCardNo.w
        appDbID.l
        appCardNo.w
        newSearch.w
        searchState.DmSearchStateType
        match0.FindMatchType
        match1.FindMatchType
        match2.FindMatchType
        match3.FindMatchType
        match4.FindMatchType
        match5.FindMatchType
        match6.FindMatchType
        match7.FindMatchType
        match8.FindMatchType
endstruct

struct GoToParamsType
        searchStrLen.w
        dbCardNo.w
        dbID.l
        recordNum.w
        matchPos.w
        matchFieldNum.w
        matchCustom.l
endstruct


; UI\Field.h

maxFieldTextLen equ     $7fff
maxFieldLines   equ     11

; justifications
leftAlign       equ     0
centerAlign     equ     1
rightAlign      equ     2

undoBufferSize  equ     100

; UndoMode
undoNone        equ     0
undoTyping      equ     1
undoBackspace   equ     2
undoDelete      equ     3
undoPaste       equ     4
undoCut         equ     5

struct FieldUndoType
        mode.w
        start.w
        end.w
        bufferLen.w
        buffer.l
endstruct

FieldAttrType_usable_shift        equ 0
FieldAttrType_usable_count        equ 1
FieldAttrType_usable_mask         equ $00000001
FieldAttrType_visible_shift       equ 1
FieldAttrType_visible_count       equ 1
FieldAttrType_visible_mask        equ $00000002
FieldAttrType_editable_shift      equ 2
FieldAttrType_editable_count      equ 1
FieldAttrType_editable_mask       equ $00000004
FieldAttrType_singleLine_shift    equ 3
FieldAttrType_singleLine_count    equ 1
FieldAttrType_singleLine_mask     equ $00000008
FieldAttrType_hasFocus_shift      equ 4
FieldAttrType_hasFocus_count      equ 1
FieldAttrType_hasFocus_mask       equ $00000010
FieldAttrType_dynamicSize_shift   equ 5
FieldAttrType_dynamicSize_count   equ 1
FieldAttrType_dynamicSize_mask    equ $00000020
FieldAttrType_insPtVisible_shift  equ 6
FieldAttrType_insPtVisible_count  equ 1
FieldAttrType_insPtVisible_mask   equ $00000040
FieldAttrType_dirty_shift         equ 7
FieldAttrType_dirty_count         equ 1
FieldAttrType_dirty_mask          equ $00000080
FieldAttrType_underlined_shift    equ 8
FieldAttrType_underlined_count    equ 2
FieldAttrType_underlined_mask     equ $00000300
FieldAttrType_justification_shift equ 10
FieldAttrType_justification_count equ 2
FieldAttrType_justification_mask  equ $00000c00
FieldAttrType_autoShift_shift     equ 12
FieldAttrType_autoShift_count     equ 1
FieldAttrType_autoShift_mask      equ $00001000
FieldAttrType_hasScrollBar_shift  equ 13
FieldAttrType_hasScrollBar_count  equ 1
FieldAttrType_hasScrollBar_mask   equ $00002000
FieldAttrType_numeric_shift       equ 14
FieldAttrType_numeric_count       equ 1
FieldAttrType_numeric_mask        equ $00004000

struct LineInfoType
        start.b
        length.b
endstruct

struct FieldType
        id.w
        rect.RectangleType
        attr.w
        text.l
        textHandle.l
        lines.l
        textLen.w
        textBlockSize.w
        maxChars.w
        selFirstPos.w
        selLastPos.w
        insPtXPos.w
        insPtYPos.w
        fontID.b
        pad.b
endstruct


; UI\Form.h

noFocus equ     $ffff
frmRedrawUpdateCode     equ     $8000

; alertTypes
informationAlert        equ     0
confirmationAlert       equ     1
warningAlert            equ     2
errorAlert              equ 3

struct AlertTemplateType
        alertType.w
        helpRscID.w
        numButtons.w
        defaultButton.w
endstruct

; formObjects
frmFieldObj     equ     0
frmControlObj   equ     1
frmListObj      equ     2
frmTableObj     equ     3
frmBitmapObj    equ     4
frmLineObj      equ     5
frmFrameObj     equ     6
frmRectangleObj equ     7
frmLabelObj     equ     8
frmTitleObj     equ     9
frmPopupObj     equ     10
frmGraffitiStateObj     equ     11
frmGadgetObj    equ     12
frmScrollBarObj equ     13

FormObjAttrType_usable_shift    equ     0
FormObjAttrType_usable_count    equ     1
FormObjAttrType_usable_mask     equ     $00000001

struct FormBitmapType
        attr.w
        pos.PointType
        rscID.w
endstruct

struct FormLineType
        attr.w
        point1.PointType
        point2.PointType
endstruct

struct FormFrameType
        id.w
        attr.w
        rect.RectangleType
        frameType.w
endstruct

struct FormRectangleType
        attr.w
        rect.RectangleType
endstruct

struct FormLabelType
        id.w
        pos.PointType
        attr.b
        pad.b
        fontID.w
        text.l
endstruct

struct FormTitleType
        rect.RectangleType
        text.l
endstruct

struct FormPopupType
        controlID.w
        listID.w
endstruct

struct FrmGraffitiStateType
        pos.PointType
endstruct

struct FormGadgetType
        id.w
        attr.w
        rect.RectangleType
        data.l
endstruct

struct FormObjListType
        objectType.w
        object.l
endstruct

FormAttrType_usable_shift       equ     0
FormAttrType_usable_count       equ     1
FormAttrType_usable_mask        equ     $00000001
FormAttrType_visible_shift      equ     1
FormAttrType_visible_count      equ     1
FormAttrType_visible_mask       equ     $00000002
FormAttrType_dirty_shift        equ     2
FormAttrType_dirty_count        equ     1
FormAttrType_dirty_mask         equ     $00000004
FormAttrType_saveBehind_shift   equ     3
FormAttrType_saveBehind_count   equ     1
FormAttrType_saveBehind_mask    equ     $00000008
FormAttrType_graffitiShift_shift        equ     4
FormAttrType_graffitiShift_count        equ     1
FormAttrType_graffitiShift_mask equ     $00000010

struct FormType
        window.WindowType
        formId.w
        attr.w
        bitsBehindForm.l
        handler.l
        focus.w
        defaultButton.w
        helpRscId.w
        menuRscId.w
        numObjects.w
        objects.l
endstruct

struct FormActiveStateType
        data.22
endstruct


; UI\GraffitiShift.h

glfCapsLock     equ     $01
glfNumLock      equ     $02


; GsiShiftState
gsiShiftNone    equ     0
gsiNumLock      equ     1
gsiCapsLock     equ     2
gsiShiftPunctuation     equ     3
gsiShiftExtended        equ     4
gsiShiftUpper   equ     5
gsiShiftLower   equ     6


; UI\List.h

noListSelection equ     $ffff

ListAttrType_usable_shift       equ     0
ListAttrType_usable_count       equ     1
ListAttrType_usable_mask        equ     $00000001
ListAttrType_enabled_shift      equ     1
ListAttrType_enabled_count      equ     1
ListAttrType_enabled_mask       equ     $00000002
ListAttrType_visible_shift      equ     2
ListAttrType_visible_count      equ     1
ListAttrType_visible_mask       equ     $00000004
ListAttrType_poppedUp_shift     equ     3
ListAttrType_poppedUp_count     equ     1
ListAttrType_poppedUp_mask      equ     $00000008
ListAttrType_reserved_shift     equ     4
ListAttrType_reserved_count     equ     4
ListAttrType_reserved_mask      equ     $000000f0

struct ListType
        id.w
        bounds.RectangleType
        attr.b
        pad.b
        itemsText.l
        numItems.w
        currentItem.w
        topItem.w
        font.b
        pad2.b
        popupWin.l
        drawItemsCallback.l
endstruct


; UI\Menu.h

noMenuSelection equ     -1
noMenuItemSelection     equ     -1
separatorItemSelection  equ     -2

MenuSeparatorChar       equ     '-'

struct MenuItemType
        id.w
        command.b
        itemStr.b
endstruct

struct MenuPullDownType
        menuWin.l
        bounds.RectangleType
        bitsBehind.l
        titleBounds.RectangleType
        title.l
        numItems.w
        items.l
endstruct

MenuBarAttrType_visible_shift        equ 0
MenuBarAttrType_visible_count        equ 1
MenuBarAttrType_visible_mask         equ $00000001
MenuBarAttrType_commandPending_shift equ 1
MenuBarAttrType_commandPending_count equ 1
MenuBarAttrType_commandPending_mask  equ $00000002
MenuBarAttrType_insPtEnabled_shift   equ 2
MenuBarAttrType_insPtEnabled_count   equ 1
MenuBarAttrType_insPtEnabled_mask    equ $00000004
MenuBarAttrType_sizeof               equ 2

struct MenuBarType
        barWin.l
        bitsBehind.l
        savedActiveWin.l
        bitsBehindStatus.l
        attr.w
        curMenu.w
        curItem.w
        commandTick.l
        numMenus.w
        menus.l
endstruct


; UI\Progress.h

progressMaxMessage      equ     128
progressMaxTitle        equ     20

struct PrgCallbackData
        stage.w
        textP.l
        textLen.w
        message.l
        error.w
        bitmapId.w
        flags.w
        timeout.l
        barMaxValue.l
        barCurValue.l
        barMessage.l
        barFlags.w
endstruct
;       canceled:1.w
;       showDetails:1.w
;       textChanged:1.w
;       timedOut:1.w

struct ProgressType
        frmP.l
        timeout.l
        flags.w
        error.w
        stage.w
        lastBitmapID.w
        ctlLabel.8
        serviceNameP.l
        lastBarMaxValue.l
        lastBarCurValue.l
        oldDrawWinH.l
        oldActiveWinH.l
        oldFrmP.l
        oldInsPtState.w
        oldInsPtPos.PointType
        textCallback.l
        title.22
endstruct
;       needUpdate:1.w
;       cancel:1.w
;       waitingForOK:1.w
;       showDetails:1.w
;       messageChanged:1.w


; UI\ScrDriver.h
;
;scrMaxLineBytes        equ     32
;
; ScrDisplayModeOperation
scrDisplayModeGetDefaults       equ     0
scrDisplayModeGet               equ     1
scrDisplayModeSetToDefaults     equ     2
scrDisplayModeSet               equ     3
scrDisplayModeGetSupportedDepths        equ     4
scrDisplayModeGetSupportsColor  equ     5
;
;struct ScrBltInfoType
;       op.ScrOperation
;       height.w
;       dstBaseP.l
;       dstRowBytes.l
;       srcBaseP.l
;       srcRowBytes.l
;       leftMask.w
;       rightMask.w
;       midWords.w
;       dstRowDelta.w
;       dstP.l
;       srcRowDelta.w
;       srcP.l
;       patternP.w
;       solidPat.w
;       simple.b
;       pattern.CustomPatternType
;endstruct
;
;struct ScrGlobalsType
;       width.w
;       height.w
;       rowBytes.b
;       baseAddr.l
;       grayPat.CustomPatternType
;       doDrawNotify.b
;       updateR.AbsRectType
;       lastUpdate.l
;endstruct


; UI\ScrDriverNew.h

scrMaxLineBytes equ     40
scrMaxDepth     equ     2

; ScrDisplayModeOperation
scrDisplayModeGetDefaults               equ     0
scrDisplayModeGet                       equ     1
scrDisplayModeSetToDefaults             equ     2
scrDisplayModeSet                       equ     3
scrDisplayModeGetSupportedDepths        equ     4
scrDisplayModeGetSupportsColor          equ     5

struct ScrBltInfoType
        op.w
        height.w
        dstBaseP.l
        dstRowBytes.l
        dstDepth.w
        dstShift.w
        dstPixelsInWordZ.w
        forePixels.w
        backPixels.w
        oneBitTableP.l
        srcBaseP.l
        srcRowBytes.l
        srcDepth.w
        srcShift.w
        srcPixelsInWordZ.w
        convSrcP.l
        dynConvSrcP.w   ; :1
        patternP.l
        simple.w
        dstP.l
        dstRowDelta.l
        leftMask.w
        rightMask.w
        midWords.w
        srcP.l
        srcRowDelta.l
        forward.w       ; :1
        srcBytesInLine.w
endstruct

;struct ScrGlobalsType
;       gDevice.GDeviceType
;       grayPat.8       ;CustomPatternType
;       doDrawNotify.w
;       updateR.AbsRectType
;       lastUpdate.l
;       expSrcSize.w
;       expSrcP.l
;endstruct


; UI\ScrollBar.h

; ScrollBarRegionType
sclUpArrow      equ     0
sclDownArrow    equ     1
sclUpPage       equ     2
sclDownPage     equ     3
sclCar          equ     4

ScrollBarAttrType_usable        equ     $0001
ScrollBarAttrType_visible       equ     $0002
ScrollBarAttrType_hilighted     equ     $0004
ScrollBarAttrType_shown         equ     $0008
ScrollBarAttrType_activeRegion  equ     $000F

struct ScrollBarType
        bounds.RectangleType
        id.w
        attr.w
        value.w
        minValue.w
        maxValue.w
        pageSize.w
        penPosInCar.w
        savePos.w
endstruct


; UI\SelDay.h

daySelectorMinYear      equ     firstYear
daySelectorMaxYear      equ     lastYear


; UI\SelTime.h

NumericSpaceChar        equ     $80

struct HMSTime
        hours.b
        minutes.b
        seconds.b
        pad.b
endstruct


; UI\Table.h

tableDefaultColumnSpacing       equ     1
tableNoteIndicatorWidth         equ     7
tableNoteIndicatorHeight        equ     11
tableMaxTextItemSize            equ     255

; tableItemStyles
checkboxTableItem       equ     0
customTableItem         equ     1
dateTableItem           equ     2
labelTableItem          equ     3
numericTableItem        equ     4
popupTriggerTableItem   equ     5
textTableItem           equ     6
textWithNoteTableItem   equ     7
timeTableItem           equ     8
narrowTextTableItem     equ     9

struct TableItemType
        itemType.b
        fontID.b
        intValue.w
        ptr.l
endstruct

struct TableColumnAttrType
        width.w
        unused.w
        editIndicator.w
        usable.w
        spacing.w
        drawCallback.l
        loadDataCallback.l
        saveDataCallback.l
endstruct

struct TableRowAttrType
        id.w
        height.w
        data.l
        reserved1.w
        usable.w
        reserved2.w
        invalid.w
        staticHeight.w
        selectable.w
        reserved3.w
endstruct

TableAttrType_visible_shift  equ 0
TableAttrType_visible_count  equ 1
TableAttrType_visible_mask   equ $00000001
TableAttrType_editable_shift equ 1
TableAttrType_editable_count equ 1
TableAttrType_editable_mask  equ $00000002
TableAttrType_editing_shift  equ 2
TableAttrType_editing_count  equ 1
TableAttrType_editing_mask   equ $00000004
TableAttrType_selected_shift equ 3
TableAttrType_selected_count equ 1
TableAttrType_selected_mask  equ $00000008
TableAttrType_hasScrollBar_shift equ 4
TableAttrType_hasScrollBar_count equ 1
TableAttrType_hasScrollBar_mask  equ $00000010

struct TableType
        id.w
        bounds.RectangleType
        attr.b
        pad.b
        numColumns.w
        numRows.w
        currentRow.w
        currentColumn.w
        topRow.w
        columnAttrs.l
        rowAttrs.l
        items.l
        currentField.FieldType
endstruct


; UI\UICommon.h

strRsc  equ     'tSTR'
ainRsc  equ     'tAIN'
iconType        equ     'tAIB'
bitmapRsc       equ     'Tbmp'
alertRscType    equ     'Talt'
kbdRscType      equ     'tkbd'
MenuRscType     equ     'MBAR'
fontRscType     equ     'NFNT'
verRsc  equ     'tver'
appInfoStringsRsc       equ     'tAIS'

appVersionID    equ     1
appVersionAlternateID   equ     1000
ainID   equ     1000

defaultAppIconBitmap    equ     10000
defaultAppSmallIconBitmap       equ     10001

systemVersionID equ     10000

palmLogoBitmap  equ     10000
keyboardBackspaceBitmap equ     10001
keyboardTabBitmap       equ     10002
keyboardReturnBitmap    equ     10003
InformationAlertBitmap  equ     10004
ConfirmationAlertBitmap equ     10005
WarningAlertBitmap      equ     10006
ErrorAlertBitmap        EQU     10007
keyboardShiftBitmap     equ     10008
keyboardCapBitmap       equ     10009

daysOfWeekStrID equ     10000
dayFullNamesStrID       equ     10001
monthNamesStrID equ     10002
monthFullNamesStrID     equ     10003
categoryAllStrID        equ     10004
categoryEditStrID       equ     10005
menuCommandStrID        equ     10006
launcherBatteryStrID    equ     10007
systemNameStrID equ     10008
phoneLookupTitleStrID   equ     10009
phoneLookupAddStrID     equ     10010
phoneLookupFormatStrID  equ     10011

oemProductNameStrID     equ     10012

proStrID        equ     10013
demoStrID       equ     10014

sysSendStatusBeamingStrID       equ     10015
sysSendStatusReceivingStrID     equ     10016

SelectACategoryAlert    equ     10000
; This alert broke 1.0 applications and is now disabled until later.
; It is redefined below (10015).
;#define RemoveCategoryAlert                            10001
;#define RemoveCategoryRecordsButton            0
;#define RemoveCategoryNameButton                       1
;#define RemoveCategoryCancelButton             2
LowBatteryAlert equ     10002
VeryLowBatteryAlert     equ     10003
UndoAlert       equ     10004
UndoCancelButton        equ     1

MergeCategoryAlert      equ     10005
MergeCategoryYes        equ     0
MergeCategoryNo equ     1

privateRecordInfoAlert  equ     10006

ClipboardLimitAlert     equ     10007

CategoryExistsAlert     equ     10012

DeviceFullAlert equ     10013

categoryAllUsedAlert    equ     10014

RemoveCategoryAlert     equ     10015
RemoveCategoryYes       equ     0
RemoveCategoryNo        equ     1

DemoUnitAlert   equ     10016

NoDataToBeamAlert       equ     10017

sysEditMenuID   equ     10000
sysEditMenuUndoCmd      equ     10000
sysEditMenuCutCmd       equ     10001
sysEditMenuCopyCmd      equ     10002
sysEditMenuPasteCmd     equ     10003
sysEditMenuSelectAllCmd equ     10004
sysEditMenuSeparator    equ     10005
sysEditMenuKeyboardCmd  equ     10006
sysEditMenuGraffitiCmd  equ     10007

sysKeyboardMenuID       equ     10100
sysKeyboardEditUndoCmd  equ     100
sysKeyboardEditCutCmd   equ     101
sysKeyboardEditCopyCmd  equ     102
sysKeyboardEditPasteCmd equ     103
sysKeyboardEditSelectAllCmd     equ     104

noteMenuID      equ     10200
noteUndoCmd     equ     10000
noteCutCmd      equ     10001
noteCopyCmd     equ     10002
notePasteCmd    equ     10003
noteSelectAllCmd        equ     10004
noteSeparator   equ     10005
noteKeyboardCmd equ     10006
noteGraffitiCmd equ     10007
noteFontCmd     equ     10200
noteTopOfPageCmd        equ     10201
noteBottomOfPageCmd     equ     10202
notePhoneLookupCmd      equ     10203

SystemKeyboardID        equ     10000

CategoriesEditForm      equ     10000
CategoriesEditList      equ     10002
CategoriesEditOKButton  equ     10003
CategoriesEditNewButton equ     10004
CategoriesEditRenameButton      equ     10005
CategoriesEditDeleteButton      equ     10006

DateSelectorForm        equ     10100
DateSelectorYearLabel   equ     10102
DateSelectorPriorYearButton     equ     10103
DateSelectorNextYearButton      equ     10104
DateSelectorTodayButton equ     10118
DateSelectorCancelButton        equ     10119
DateSelectorDayGadget   equ     10120
DateSelectorThisWeekButton      equ     10121
DateSelectorThisMonthButton     equ     10122

TimeSelectorForm        equ     10200
TimeSelectorStartTimeButton     equ     10204
TimeSelectorEndTimeButton       equ     10205
TimeSelectorHourList    equ     10206
TimeSelectorMinuteList  equ     10207
TimeSelectorOKButton    equ     10208
TimeSelectorCancelButton        equ     10209
TimeSelectorNoTimeButton        equ     10210

KeyboardForm    equ     10300
KeyboardGadget  equ     10310

HelpForm        equ     10400
HelpField       equ     10402
HelpDoneButton  equ     10403
HelpUpButton    equ     10404
HelpDownButton  equ     10405

FindDialog      equ     10500
FindStrField    equ     10503
FindOKButton    equ     10504

FindResultsDialog       equ     10600
FindResultsMsgLabel     equ     10602
FindResultsTable        equ     10603
FindResultsGoToButton   equ     10604
FindResultsCancelButton equ     10605
FindResultsMoreButton   equ     10606
FindResultsStopButton   equ     10607

FindResultsSearchingStr equ     10607
FindResultsMatchesStr   equ     10608
FindResultsNoMatchesStr equ     10609
FindResultsContinueStr  equ     10610

NoteView        equ     10900
NoteField       equ     10901
NoteDoneButton  equ     10902
NoteSmallFontButton     equ     10903
NoteLargeFontButton     equ     10904
NoteDeleteButton        equ     10905
NoteUpButton    equ     10906
NoteDownButton  equ     10907
NoteScrollBar   equ     10908
NoteFontGroup   equ     1
noteViewMaxLength       equ     4096

aboutDialog     equ     11000
aboutNameLabel  equ     11001
aboutVersionLabel       equ     11002
aboutErrorStr   EQU     11003

categoryNewNameDialog   equ     11100
categoryNewNameField    equ     11103
categoryNewNameOKButton equ     11104

graffitiReferenceDialog equ     11200
graffitiReferenceDoneButton     equ     11202
graffitiReferenceUpButton       equ     11203
graffitiReferenceDownButton     equ     11204
graffitiReferenceFirstBitmap    equ     11205

netSerStringList        equ     11300

netSerProgressFrm       equ     11300
netSerProgressLabelStage        equ     11302
netSerProgressBtnCancel equ     11303
netSerPictPhone equ     11300
netSerPictHandshake     equ     11301
netSerPictBook  equ     11302

netSerPromptFrm equ     11400
netSerPromptAsk equ     11402
netSerPromptField       equ     11403
netSerPromptBtnOK       equ     11404
netSerPromptBtnCancel   equ     11405

launcherDialog  equ     11500
launcherGadget  equ     11501

prgStringList   equ     11600
prgProgressFrm  equ     11600
prgProgressLabelStage   equ     11602
prgProgressBtnCancel    equ     11603
prgPictPhone    equ     11620
prgPictHandshake        equ     11621
prgPictBook     equ     11622
prgPictError    EQU     11623

prgBeamSend1    equ     11640
prgBeamSend2    equ     11641
prgBeamRec1     equ     11642
prgBeamRec2     equ     11643
prgBeamPrepare1 equ     11644
prgBeamPrepare2 equ     11645
prgBeamIdle     equ     11646

exgPrgStringList        equ     11650
exgStrIndexOK   equ     1
exgStrIndexCancelling   equ     2
exgStrIndexError        EQU     3
exgStrIndexInitializing equ     4
exgStrIndexStarting     equ     5
exgStrIndexSearching    equ     6
exgStrIndexConnected    equ     7
exgStrIndexSending      equ     8
exgStrIndexReceiving    equ     9
exgStrIndexDisconnecting        equ     10
exgStrIndexWaitingSender        equ     11
exgStrIndexPreparing    equ     12
exgStrIndexAccepting    equ     13
exgStrIndexInterrupted  EQU     14

ExchangeForm    equ     11700
ExchangeOKButton        equ     11701
ExchangeCancelButton    equ     11702
ExchangeIconBitMap      equ     11704
ExchangeMessageField    equ     11703
ExchangeQuestionString  equ     11710
ExchangeUnnamedString   equ     11711
ExchangeIrBeamString    equ     11712
ExchangeLowBatteryAlert equ     11720
ExchangeReceiveDisabledAlert    equ     11730
ExchangeIrUnsupportedAlert      equ     11740
ExchangeNoLibraryAlert  equ     11750

FontSelectorForm        equ     11900
FontSelector1Button     equ     11903
FontSelector2Button     equ     11904
FontSelector3Button     equ     11905
FontSelectorOKButton    equ     11906
FontSelectorCancelButton        equ     11907
FontSelectorFontGroup   equ     1

CustomAlertDialog       equ     12000
CustomAlertBitmap       equ     12002
CustomAlertField        equ     12003
CustomAlertFirstButton  equ     12004


; UI\UIGlobals.h

UIDefNumSysFonts        equ     8
UIDefNumAppFonts        equ     4

eventQueueSize  equ     10

struct UIGlobalsType
        activeWindow.l
        displayWindow.l
        drawWindow.l
        firstWindow.l
        exitWindowID.l
        enterWindowID.l
        exitedWindowID.l
        gState.GraphicStateType
        eventQ.l
        eventQIndex.w
        eventQLength.w
        lastScreenX.w
        lastScreenY.w
        lastPenDown.b
        Pad.b
        needNullTickCount.l
        uiCurrentFontPtr.l
        FontPtr.l
        uiSysFontTablePtr.l
        uiAppFontTablePtr.l
        uiNumSysFonts.w
        uiNumAppFonts.w
        uiUnused1.l
        uiUnused2.l
        uiCurrentFontID.b
        pad2.b
        currentForm.l
        insPtIsEnabled.b
        insPtOn.b
        insPtLoc.PointType
        insPtHeight.w
        insPtLastTick.l
        insPtBitsBehind.l
        clipboard.18
        uiCurrentMenu.l
        uiCurrentMenuRscID.w
        undoGlobals.FieldUndoType
        gsiState.b
        gsiIsEnabled.b
        gsiLocation.PointType
        uiDecimalSeparator.b
endstruct


       list 1          ;renable listing
