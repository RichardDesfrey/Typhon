proc ChangeLang uses esi edi ebx, hWnd

locals
    buffer db 256 dup (?)
    counter dd 0
endl


	mov ebx, [Lang]; �������� ����
; �������� ����� �����-������ �����, ������ ������� ���, � ����� ��������� ������
	stdcall SendDlgItemMessage, [hWnd], ID_LANG_ENG, BM_SETCHECK, BST_UNCHECKED, 0
	stdcall SendDlgItemMessage, [hWnd], ID_LANG_RUS, BM_SETCHECK, BST_UNCHECKED, 0
	lea eax, [ebx + ID_LANG_ENG]
	stdcall SendDlgItemMessage, [hWnd], eax, BM_SETCHECK, BST_CHECKED, 0
; ������ ���� � �������� ��������
	stdcall LoadFile, [ebx*4+case_Common]
	xchg esi, eax
	push ebx
; ��������� ����������
	mov edi, 2016; ������� ����������
	xor ebx, ebx; ������� ����� �����
@@:
	stdcall linein,esi,ebx
	xchg eax, ebx
	stdcall SendDlgItemMessage, [hWnd], edi, WM_SETTEXT, ebx, ecx
	inc edi
	cmp edi, 2034
	jle @b
	stdcall MFree, esi
	pop ebx; ���������� ����
; �������� ����� ������
	mov edi, [Town]
	cinvoke wsprintf, addr buffer, dword [edi*4+case_Towns], dword [ebx*4+case_Lang]
	stdcall LoadFile, addr buffer
	xchg esi, eax
; ���������� �������
	stdcall SendDlgItemMessage, [hWnd], 300, LB_GETCURSEL, 0, 0;
	push eax
; �������� ������ ������
	stdcall SendDlgItemMessage, [hWnd], 300, LB_RESETCONTENT, 0, 0
; ��������� �������� ������
	xor ebx, ebx
	mov edi, 32
    @@:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWnd], 300, LB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWnd], edi, WM_SETTEXT, ebx;, ecx
	inc edi
	cmp edi, 76
	jl @b
	stdcall MFree, esi
; ��������������� �������:
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 300, LB_SETCURSEL, eax, 0;
; ��������� ����������� �������:
	invoke GetDlgItem,[hWnd],76
	invoke IsWindowEnabled, eax
     .if eax; ���������� ���������
; �������� � ��������� �������
	stdcall SendDlgItemMessage, [hWnd], 76, CB_GETCURSEL, 0, 0;
	push eax
	stdcall SendDlgItemMessage, [hWnd], 77, CB_GETCURSEL, 0, 0
	push eax
; ���������� ���������� ������
	stdcall SendDlgItemMessage, [hWnd], 76, CB_RESETCONTENT, 0, 0;
	stdcall SendDlgItemMessage, [hWnd], 77, CB_RESETCONTENT, 0, 0;
; ����������� ����� ����:
	mov ebx, [Lang]
	stdcall LoadFile, dword [ebx*4+case_Monsters] ; load file into memory
	xchg esi, eax; ����
; c����� ������� ��� �������� �������
	mov [counter], -1; ������� �����
	xor ebx, ebx; ������� �������
	stdcall linein,esi,ebx; ������� ������ ������
	xchg eax, ebx; ������� ������ ������, ��� �������� �������� �����������
.goto_monsters_names:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWnd], 76, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWnd], 76, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 998
	jle .goto_monsters_names
; c����� ������� ��� ����������
	mov ebx, [Lang]
	stdcall LoadFile, dword [ebx*4+case_Monsters] ; load file into memory
	xchg esi, eax; ����
	mov [counter], -1; ������� �����
	xor ebx, ebx; ������� �������
.goto_monsters_names2:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWnd], 77, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWnd], 77, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 999
	jle .goto_monsters_names2
	stdcall MFree, esi; ���������� ����� � ������
; ��������������� �������
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 77, CB_SETCURSEL, eax, 0;
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 76, CB_SETCURSEL, eax, 0
     .endif
	ret
endp