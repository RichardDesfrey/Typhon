format PE GUI 4.0
entry start

include '../../include/win32ax.inc'

ID_LANG_ENG = 2017
ID_LANG_RUS = 2018
ID_SAVE = 2019
ID_CASTLE = 2021
UDM_SETRANGE32 = 46Fh

section '.text' code readable executable

  start:
	invoke InitCommonControlsEx, icex
	invoke ExitProcess,<invoke DialogBoxParam,NULL,37,NULL,DialogProc,NULL>

proc DialogProc hWin,msg,wparam,lparam

local counter: DWORD
local building: DWORD

	cmp [msg],WM_INITDIALOG
	je .wminitdialog
	cmp [msg],WM_COMMAND
	je .wmcommand
	cmp [msg],WM_CLOSE
	je .wmclose
	xor eax,eax
	jmp .finish
.wminitdialog:
; �������� ������
	invoke SendMessage,[hWin],WM_SETICON,1,<invoke LoadIcon,<invoke GetModuleHandle, NULL>,500>
; �������� ����� ��������
	stdcall LoadFile, TownsSetup.mop
	mov [TownsSetup], eax
; �������� ����� �����
	stdcall LoadFile, Language
	movzx ebx, byte [eax]; �������� ����
	mov [Lang], ebx
	stdcall MFree, eax
	stdcall ChangeLang, [hWin]
; ���������� ��������� ����� �����:
	stdcall SendDlgItemMessage, [hWin], ID_CASTLE, BM_SETCHECK, 1, 0
; ���������� ��������� ������� ������� �����:
	stdcall SendDlgItemMessage, [hWin], 300, LB_SETCURSEL, 0, 0
	jmp .����
.wmcommand:
.if [wparam] = ID_LANG_ENG | [wparam] = ID_LANG_RUS
	stdcall LoadFile, Language
	xchg ebx, eax
	stdcall SendDlgItemMessage, [hWin], ID_LANG_RUS, BM_GETCHECK, 0, 0
	mov [Lang], eax
	mov [ebx], al
	stdcall SaveFile, Language, ebx, 3
	stdcall MFree, ebx
	stdcall ChangeLang, [hWin]
.elseif signed [wparam] >= 2021 & signed [wparam] <= 2029; ����� ������
	mov esi, [wparam]
	sub esi, 2021
	mov [Town], esi
; ���������� ��������� ������� ������� �����:
	stdcall ChangeLang, [hWin]
	stdcall SendDlgItemMessage, [hWin], 300, LB_SETCURSEL, 0, 0
	jmp .����
.elseif [wparam] = 300 or (1 shl 16); ����� ������
.����:
	stdcall SendDlgItemMessage, [hWin], 300, LB_GETCURSEL, 0, 0
	mov [building], eax
; ��������� � ���������� ����������:
    .if signed eax >= 30; ������� ���� �� �����
	invoke GetDlgItem,[hWin],76
	invoke IsWindowEnabled, eax
     .if ~eax
	invoke GetDlgItem,[hWin],76
	invoke EnableWindow, eax, 1; �������� �������
	invoke GetDlgItem,[hWin],77
	invoke EnableWindow, eax, 1; �������� �������
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
	stdcall SendDlgItemMessage, [hWin], 76, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWin], 76, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 998
	jle .goto_monsters_names
	 stdcall MFree, esi; ���������� ����� � ������
; c����� ������� ��� �����������
	mov ebx, [Lang]
	stdcall LoadFile, dword [ebx*4+case_Monsters] ; load file into memory
	xchg esi, eax; ����
	mov [counter], -1; ������� �����
	xor ebx, ebx; ������� �������
.goto_monsters_names2:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWin], 77, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWin], 77, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 999
	jle .goto_monsters_names2
	stdcall MFree, esi; ���������� ����� � ������
     .endif
     ; �������� ������� � ����������
	mov ebx, [Town]
	imul ebx, 56; �������� ����� �� ������ ���������
	mov eax, [building]; �������� ������
	sub eax, 30
	mov esi, [TownsSetup]
	lea esi, [eax*4+esi+3168]
	add esi, ebx
	stdcall SendDlgItemMessage, [hWin], 76, CB_SETCURSEL, dword [esi], 0
	mov eax, [esi+504]
	inc eax
	stdcall SendDlgItemMessage, [hWin], 77, CB_SETCURSEL, eax, 0
    .else
	stdcall SendDlgItemMessage, [hWin], 76, CB_RESETCONTENT, 0, 0
	stdcall SendDlgItemMessage, [hWin], 77, CB_RESETCONTENT, 0, 0
	invoke GetDlgItem,[hWin],76
	invoke EnableWindow, eax, 0; �������� / ��������� �������
	invoke GetDlgItem,[hWin],77
	invoke EnableWindow, eax, 0; �������� / ��������� �������
    .endif

	mov eax, [building]
	mov edi, [TownsSetup]
	imul edx, [Town], 44*8
	lea eax, [eax*8+edx]
	add edi, eax
	xor esi, esi; ������� ������
     @@:
	mov eax, esi
	mov edx, eax
	and eax, 1Fh
	shr edx, 5
	xor ecx, ecx
	bt dword [edi+edx*4], eax
	setc cl
	stdcall SendDlgItemMessage, [hWin], addr esi+32, BM_SETCHECK, ecx, 0
	inc esi
	cmp esi, 43
	jl @b
.elseif [wparam] = ID_SAVE
	stdcall SendDlgItemMessage, [hWin], 300, LB_GETCURSEL, 0, 0
	mov edi, [TownsSetup]
	imul edx, [Town], 44*8
	lea eax, [eax*8+edx]
	add edi, eax; �����
	xor esi, esi; ������� ������
     @@:
	stdcall SendDlgItemMessage, [hWin], addr esi+32, BM_GETCHECK, 0, 0
	mov ebx, esi
	mov edx, ebx
	and ebx, 1Fh
	shr edx, 5
	xor ecx, ecx
     .if eax
	bts dword [edi+edx*4], ebx
     .else
	btr dword [edi+edx*4], ebx
     .endif
	inc esi
	cmp esi, 43
	jl @b
; ��������� ������� � ����������:
; ������� ��������, ������� �� ���������:
	invoke GetDlgItem,[hWin],76
	invoke IsWindowEnabled, eax
     .if eax; �������
	stdcall SendDlgItemMessage, [hWin], 300, LB_GETCURSEL, 0, 0; �������� ������
	mov ebx, [Town]
	imul ebx, 56; �������� ����� �� ������ ���������
	sub eax, 30
	mov esi, [TownsSetup]
	lea esi, [eax*4+esi+3168]
	stdcall SendDlgItemMessage, [hWin], 76, CB_GETCURSEL, 0, 0
	mov [esi+ebx], eax
	stdcall SendDlgItemMessage, [hWin], 77, CB_GETCURSEL, 0, 0
	dec eax
	mov [esi+ebx+504], eax
     .endif
	stdcall SaveFile, TownsSetup.mop, [TownsSetup], 4176; 3168; <- ������ �����
.endif
	jmp .processed
  .wmclose:
	invoke	EndDialog,[hWin],0
  .processed:
	xor eax, eax
	inc eax
  .finish:
	ret
endp

include 'Functions.ASM'
include 'ChangeLang.ASM'

section '.idata' data readable
data import
  library kernel,'kernel32.dll',\
	  user,'user32.dll',\
	  comctl,'comctl32.dll'

  import kernel,\
	 CreateFile,'CreateFileA',\
	 WriteFile,'WriteFile',\
	 GetFileSize,'GetFileSize',\
	 GetModuleHandle,'GetModuleHandleA',\
	 ReadFile,'ReadFile',\
	 CloseHandle,'CloseHandle',\
	 ExitProcess,'ExitProcess',\
	 VirtualAlloc,'VirtualAlloc',\
	 VirtualFree,'VirtualFree'

  import user,\
	 DialogBoxParam,'DialogBoxParamA',\
	 EnableWindow,'EnableWindow',\
	 EndDialog,'EndDialog',\
	 GetDlgItem,'GetDlgItem',\
	 IsWindowEnabled, 'IsWindowEnabled',\
	 SendDlgItemMessageA,'SendDlgItemMessageA',\
	 LoadIcon,'LoadIconA',\
	 SendMessage,'SendMessageA',\
	 wsprintf,'wsprintfA'

  import comctl,\
	 InitCommonControlsEx,'InitCommonControlsEx'
end data

section '.data' data readable writeable

  icex dd 8, 0FFFFh
  TownsSetup.mop db 'TownsSetup.mop',0
  Language db '.\..\MCrEdit\Lang',0
case_Common dd ECommon, RCommon
	  ECommon db 'Eng\Common.txt',0
	  RCommon db 'Rus\Common.txt',0

case_Monsters dd EMonsters, RMonsters
	  EMonsters db '.\..\MCrEdit\Eng\Monsters.txt',0
	  RMonsters db '.\..\MCrEdit\Rus\Monsters.txt',0

case_Lang dd ELang, RLang
	  ELang db 'Eng', 0
	  RLang db 'Rus', 0

case_Towns dd Castle, Rampart, Tower, Inferno, Necropolis, Dungeon, Stronghold, Fortress, Conflux
	 Castle     db '%s\Castle.txt',0
	 Rampart    db '%s\Rampart.txt',0
	 Tower	    db '%s\Tower.txt',0
	 Inferno    db '%s\Inferno.txt',0
	 Necropolis db '%s\Necropolis.txt',0
	 Dungeon    db '%s\Dungeon.txt',0
	 Stronghold db '%s\Stronghold.txt',0
	 Fortress   db '%s\Fortress.txt',0
	 Conflux    db '%s\Conflux.txt',0

; Virtual
  Lang dd ?
  Town dd ?
  TownsSetup dd ?

section '.rsrc' data readable resource from 'rsrc.res'

section '.bss' readable writeable
db 1 dup 0