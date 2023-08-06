proc ChangeLang uses esi edi ebx, hWnd

locals
    buffer db 256 dup (?)
    counter dd 0
endl


	mov ebx, [Lang]; получить язык
; настроим сразу радио-кнопки языка, сперва сбросив обе, а потом установив нужную
	stdcall SendDlgItemMessage, [hWnd], ID_LANG_ENG, BM_SETCHECK, BST_UNCHECKED, 0
	stdcall SendDlgItemMessage, [hWnd], ID_LANG_RUS, BM_SETCHECK, BST_UNCHECKED, 0
	lea eax, [ebx + ID_LANG_ENG]
	stdcall SendDlgItemMessage, [hWnd], eax, BM_SETCHECK, BST_CHECKED, 0
; Грузим файл с главными строками
	stdcall LoadFile, [ebx*4+case_Common]
	xchg esi, eax
	push ebx
; Установка заголовков
	mov edi, 2016; счётчик заголовков
	xor ebx, ebx; счётчик строк файла
@@:
	stdcall linein,esi,ebx
	xchg eax, ebx
	stdcall SendDlgItemMessage, [hWnd], edi, WM_SETTEXT, ebx, ecx
	inc edi
	cmp edi, 2034
	jle @b
	stdcall MFree, esi
	pop ebx; возвратить язык
; загрузка файла зданий
	mov edi, [Town]
	cinvoke wsprintf, addr buffer, dword [edi*4+case_Towns], dword [ebx*4+case_Lang]
	stdcall LoadFile, addr buffer
	xchg esi, eax
; запоминаем позицию
	stdcall SendDlgItemMessage, [hWnd], 300, LB_GETCURSEL, 0, 0;
	push eax
; очистить список зданий
	stdcall SendDlgItemMessage, [hWnd], 300, LB_RESETCONTENT, 0, 0
; настроить названия зданий
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
; восстанавливаем позицию:
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 300, LB_SETCURSEL, eax, 0;
; настройка комбобоксов существ:
	invoke GetDlgItem,[hWnd],76
	invoke IsWindowEnabled, eax
     .if eax; комбобоксы всключены
; получаем и сохраняем позиции
	stdcall SendDlgItemMessage, [hWnd], 76, CB_GETCURSEL, 0, 0;
	push eax
	stdcall SendDlgItemMessage, [hWnd], 77, CB_GETCURSEL, 0, 0
	push eax
; уничтожаем предыдущие списки
	stdcall SendDlgItemMessage, [hWnd], 76, CB_RESETCONTENT, 0, 0;
	stdcall SendDlgItemMessage, [hWnd], 77, CB_RESETCONTENT, 0, 0;
; настраиваем новый язык:
	mov ebx, [Lang]
	stdcall LoadFile, dword [ebx*4+case_Monsters] ; load file into memory
	xchg esi, eax; файл
; cписок существ для основных жителей
	mov [counter], -1; счётчик строк
	xor ebx, ebx; счётчик позиций
	stdcall linein,esi,ebx; пропуск первой строки
	xchg eax, ebx; пропуск первой строки, ибо основное существо обязательно
.goto_monsters_names:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWnd], 76, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWnd], 76, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 998
	jle .goto_monsters_names
; cписок существ для альтенатив
	mov ebx, [Lang]
	stdcall LoadFile, dword [ebx*4+case_Monsters] ; load file into memory
	xchg esi, eax; файл
	mov [counter], -1; счётчик строк
	xor ebx, ebx; счётчик позиций
.goto_monsters_names2:
	stdcall linein,esi,ebx
	xchg eax, ebx
	push ecx
	stdcall SendDlgItemMessage, [hWnd], 77, CB_ADDSTRING, 0, ecx
	stdcall SendDlgItemMessage, [hWnd], 77, WM_SETTEXT, ebx;, ecx
	inc [counter]
	cmp [counter], 999
	jle .goto_monsters_names2
	stdcall MFree, esi; освободить буфер с файлом
; восстанавливаем позиции
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 77, CB_SETCURSEL, eax, 0;
	pop eax
	stdcall SendDlgItemMessage, [hWnd], 76, CB_SETCURSEL, eax, 0
     .endif
	ret
endp