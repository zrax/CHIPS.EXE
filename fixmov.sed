# There are two ways to assemble MOV ax,bx:
#
# 8BC3              mov ax,bx
# 89D8              mov ax,bx
#
# NASM chooses the latter, but CHIPS.EXE uses the former.
# We want to build a byte-for-byte identical binary,
# so before passing the file to NASM
# we replace MOV ax,bx with DB 0x8B,0xC3
# - in effect assembling the instruction manually.

s/mov ax,ax/db 0x8B,0xC0/
s/mov ax,bx/db 0x8B,0xC3/
s/mov ax,ax/db 0x8B,0xC0/
s/mov ax,cx/db 0x8B,0xC1/
s/mov ax,dx/db 0x8B,0xC2/
s/mov ax,bx/db 0x8B,0xC3/
s/mov ax,sp/db 0x8B,0xC4/
s/mov ax,bp/db 0x8B,0xC5/
s/mov ax,si/db 0x8B,0xC6/
s/mov ax,di/db 0x8B,0xC7/

s/mov cx,ax/db 0x8B,0xC8/
s/mov cx,cx/db 0x8B,0xC9/
s/mov cx,dx/db 0x8B,0xCA/
s/mov cx,bx/db 0x8B,0xCB/
s/mov cx,sp/db 0x8B,0xCC/
s/mov cx,bp/db 0x8B,0xCD/
s/mov cx,si/db 0x8B,0xCE/
s/mov cx,di/db 0x8B,0xCF/

s/mov dx,ax/db 0x8B,0xD0/
s/mov dx,cx/db 0x8B,0xD1/
s/mov dx,dx/db 0x8B,0xD2/
s/mov dx,bx/db 0x8B,0xD3/
s/mov dx,sp/db 0x8B,0xD4/
s/mov dx,bp/db 0x8B,0xD5/
s/mov dx,si/db 0x8B,0xD6/
s/mov dx,di/db 0x8B,0xD7/

s/mov bx,ax/db 0x8B,0xD8/
s/mov bx,cx/db 0x8B,0xD9/
s/mov bx,dx/db 0x8B,0xDA/
s/mov bx,bx/db 0x8B,0xDB/
s/mov bx,sp/db 0x8B,0xDC/
s/mov bx,bp/db 0x8B,0xDD/
s/mov bx,si/db 0x8B,0xDE/
s/mov bx,di/db 0x8B,0xDF/

s/mov sp,bp/db 0x8B,0xE5/
s/mov bp,sp/db 0x8B,0xEC/

s/mov si,ax/db 0x8B,0xF0/
s/mov si,cx/db 0x8B,0xF1/
s/mov si,dx/db 0x8B,0xF2/
s/mov si,bx/db 0x8B,0xF3/
s/mov si,sp/db 0x8B,0xF4/
s/mov si,bp/db 0x8B,0xF5/
s/mov si,si/db 0x8B,0xF6/
s/mov si,di/db 0x8B,0xF7/

s/mov di,ax/db 0x8B,0xF8/
s/mov di,cx/db 0x8B,0xF9/
s/mov di,dx/db 0x8B,0xFA/
s/mov di,bx/db 0x8B,0xFB/
s/mov di,sp/db 0x8B,0xFC/
s/mov di,bp/db 0x8B,0xFD/
s/mov di,si/db 0x8B,0xFE/
s/mov di,di/db 0x8B,0xFF/

s/xor ax,ax/db 0x33,0xC0/
s/xor cx,cx/db 0x33,0xC9/
s/xor dx,dx/db 0x33,0xD2/
s/xor bx,bx/db 0x33,0xDB/
s/xor sp,sp/db 0x33,0xE4/
s/xor bp,bp/db 0x33,0xED/
s/xor si,si/db 0x33,0xF6/
s/xor di,di/db 0x33,0xFF/

s/xor ax,dx/db 0x33,0xC2/

s/ or ax,ax/ db 0x0B,0xC0/
s/ or cx,cx/ db 0x0B,0xC9/
s/ or dx,dx/ db 0x0B,0xD2/
s/ or bx,bx/ db 0x0B,0xDB/
s/ or sp,sp/ db 0x0B,0xE4/
s/ or bp,bp/ db 0x0B,0xED/
s/ or si,si/ db 0x0B,0xF6/
s/ or di,di/ db 0x0B,0xFF/
