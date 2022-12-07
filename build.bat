.\toolchain\pilrc -I .\assets\ .\assets\ZXPilot.rcp .\assets
.\toolchain\pila .\sources\ZXPilot.asm
del ZXPilot.prc /q
ren .prc ZXPilot.prc
pause 0