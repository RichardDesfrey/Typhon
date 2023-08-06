proc LoadFile; адрес строки с именем файла
		push	ebp
		mov	ebp,esp
		push	esi
		push	edi
		push	00000000h
		push	00000080h
		push	00000003h
		push	00000000h
		push	00000001h
		push	0C0000000h
		push  dword  [ebp+08h]
		call	[CreateFile]
		mov	edi,eax
		push	00000000h
		push	edi
		call	[GetFileSize]
		mov	[ebp+08h],eax
		push eax
		call	MAlloc
		mov	esi,eax
		push	00000000h
		lea	ecx,[ebp+08h]
		push	ecx
		push  dword  [ebp+08h]
		push	eax
		push	edi
		call	[ReadFile]
		push	edi
		call	[CloseHandle]
		mov	eax,esi
		pop	edi
		pop	esi
		pop	ebp
		retn	0004h
endp

proc SaveFile; размер файла; адрес буфера данных; адрес строки с именем файла
		push	ebp
		mov	ebp,esp
		push	edi
		push	00000000h
		push	00000080h
		push	TRUNCATE_EXISTING
		push	00000000h
		push	00000001h
		push	0C0000000h
		push   dword	[ebp+08h]
		call	[CreateFile]
		mov	edi,eax
		push	00000000h
		lea	ecx,[ebp+10h]
		push	ecx
		push   dword	[ebp+10h]
		push   dword	[ebp+0Ch]
		push	eax
		call	[WriteFile]
		push	edi
		call	[CloseHandle]
		pop	edi
		pop	ebp
		retn	000Ch
endp

proc MAlloc
		push	esi
		mov	esi,[esp+8]
		push	00000004h
		push	00001000h
		push	esi
		push	00000000h
		call	[VirtualAlloc]
		push	00000004h
		push	00001000h
		push	esi
		push	eax
		call	[VirtualAlloc]
		pop	esi
		retn 4
endp

proc MFree
		push	00008000h
		push	00000000h
		push  dword  [esp+12]
		call	[VirtualFree]
		retn 4
endp

proc linein
	mov edx,[ESP+4]
	ADD EDX,[ESP+8]
	push edx
	XOR EAX,EAX
	or ECX,-1
L404268:	
	inc ecx
	mov ax,word [ECX+EDX]
	CMP AL,9
	JE L404268
	CMP Ax,0A0Dh
	Jnz L404268
	MOV BYTE [ECX+EDX],0
	TEST EAX,EAX
	JE L404288
	LEA EAX,[ECX+2]
	ADD EAX,[ESP+12]
L404288:
	pop ecx
	RETN 8
endp

proc lineout string;, buffer
	mov ecx, [string]; адрес строки
	mov edx, esi; адрес буфера
     @@:
	mov al, [ecx]; символ
      .if al <> 0Dh; игнорируем отступы Win
	mov [edx], al
	inc edx
      .endif
	inc ecx
	test al, al
	jnz @b
	mov word [edx-1], 0A0Dh
	sub edx, esi
	inc edx
	add esi, edx
	mov eax, edx
	ret
endp

lfcnt:
    xor eax, eax ; set counter to zero
    mov ecx, [esp+4]
    dec ecx
    jmp @f
  pre:
    inc eax		 ; add 1 to return value if LF found
  @@:
    inc ecx
    cmp byte [ecx], 0	; test for zero terminator
    je @f
    cmp word [ecx], 0A0Dh ; test line feed
    je pre
    jmp @b
  @@:
    retn 4


proc SaveStringsToFile, hWin, case, ID

locals
     buffer db 1000 dup (?)
     Temp dd ?
     limit dd ?
     rpos dd ?
     Counter dd ?
endl
	  push esi
	  xorps xmm0, xmm0
	  movups xword [Temp], xmm0
	  mov eax, [case]
	  mov ebx, [Lang]
	  stdcall LoadFile, dword [ebx*4+eax]
	  xchg ebx, eax
	  stdcall lfcnt, ebx
	  mov [limit], eax
@@:
	  stdcall linein, ebx, [rpos]
	  mov [rpos], eax
	  stdcall ConvertWinToHeroes, ecx, addr buffer
	.if edi = [Temp]
	  invoke GetDlgItemText, [hWin], [ID], addr buffer, 1000
	.endif
	  stdcall lineout, addr buffer
	  add [Counter], eax
	  inc [Temp]
	  mov eax, [Temp]
	  cmp eax, [limit]
	  jl @b
	  stdcall MFree, ebx
	  mov ebx, [Lang]
	  pop esi
	  mov eax, [case]
	  stdcall SaveFile, dword [ebx*4+eax], esi, [Counter]
	  ret
endp

; ImportTable
proc SendDlgItemMessage
	  jmp dword [SendDlgItemMessageA]
endp