.data
; количество строк для каждого комбобокса-списка (кроме тех, что задаются из отдельных текстовиков)
ComboboxStrings dd 5,\;  ID_RAY
				   3,\;  ID_CLOUD 
				   5,\;  ID_CATAPULT			
				   10,\; ID_MAGIC1				
				   6,\;  ID_MAGIC2					
			       10,\;  ID_MAGIC3				
				   4,\;  ID_MAGIC4			
				   10,\; ID_MAGIC5			
				   9,\; ID_IMMUN				
				   7,\; ID_HATE				
				   9,\; ID_RES_GOLEM
				   3;    ID_REBIRTH					   				   
				   
.code
Change_Lang proc hWnd

LOCAL buffer[1000] :BYTE
LOCAL buffer2[1000] :BYTE
LOCAL rpos :DWORD
LOCAL Counter :DWORD
LOCAL Temp :DWORD
LOCAL Temp2 :DWORD
LOCAL Temp3 :DWORD
LOCAL Monsters[24] :DWORD; 24 списков

	push esi
	push edi
	push ebx
; Запоминаем и очищаем все настройки комбобоксов для перезагрузки строк
	mov ebx, ID_MONSTER_COMBOX	
@@:	
	mov dword ptr ds:[ebx*4-(ID_MONSTER_COMBOX*4)+Monsters], rv(SendDlgItemMessage,hWnd,ebx,CB_GETCURSEL,0,0)
	fn SendDlgItemMessage,hWnd,ebx,CB_RESETCONTENT,0,0;
	inc ebx
	cmp ebx, ID_DEMONOLOGY
	jle @b
; НАСТРОЙКА ЯЗЫКА
	movsx ebx, byte ptr [InputFile(addr Lang)]; получить язык (0 - английский, 1 - русский)
	free eax; освободить память с 1-байтовым файлом
; настроим сразу радио-кнопки языка, сперва сбросив обе, а потом установив нужную
	invoke SendDlgItemMessage, hWnd, ID_LANG_ENG, BM_SETCHECK, BST_UNCHECKED, 0;
	invoke SendDlgItemMessage, hWnd, ID_LANG_RUS, BM_SETCHECK, BST_UNCHECKED, 0;
	lea eax, [ebx + ID_LANG_ENG]
	invoke SendDlgItemMessage, hWnd, eax, BM_SETCHECK, BST_CHECKED, 0;	
; ГЛАВНЫЕ СТРОКИ (заголовки):	
	push ebx; сохранить значение языка в стеке	
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Common]) ; загрузить нужный файл в память
	mov edi, 2000; счётчик заголовков
	xor ebx, ebx; счётчик строк файла
@@:
    mov ebx, linein$(esi,ADDR buffer,ebx)
	invoke SendDlgItemMessage, hWnd, edi, WM_SETTEXT, ebx, ADDR buffer;	
	inc edi
	cmp edi, 2132
	jle @b
	invoke GetDlgItemText, hWnd, 2003, offset MonNumText,120	
	invoke wsprintf, addr buffer, offset MonNumText, Positio
	invoke SendDlgItemMessage, hWnd, 2003, WM_SETTEXT, 0, ADDR buffer;		
; УСТАНОВКА КОМБОБОКСОВ-СПИСКОВ
	mov Counter, ID_RAY; счётчик элементов
Goto_elements:
	xor edi, edi; счётчик строк
	mov Temp, rv(GetDlgItem,hWnd,Counter)
@@:; goto strings	
	mov ebx, linein$(esi,ADDR buffer,ebx)
	fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer
	inc edi
	mov eax, Counter	
	cmp edi, dword ptr ds:[eax*4-(ID_RAY*4)+ComboboxStrings]
	jl @b
	inc Counter
	cmp Counter, ID_REBIRTH+1
	jl Goto_elements
; наложенные заклинания:
	xor edi, edi; счётчик строк
	mov Temp, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_1_lvl)
	mov Temp2, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_2_lvl)
	mov Counter, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_3_lvl)
@@:; goto strings	
	mov ebx, linein$(esi,ADDR buffer,ebx)
	fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer
	fn SendMessage,Temp2,CB_ADDSTRING,0,ADDR buffer
	fn SendMessage,Counter,CB_ADDSTRING,0,ADDR buffer
	inc edi	
	cmp edi, 4
	jl @b	
	free esi; освобождаем память с текстовиком
	pop ebx
	push ebx
; УСТАНОВКА КОМБОБОКСА ЗАКЛИНАНИЙ
    mov edi, rv(GetDlgItem,hWnd,ID_SPELL)
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Spells])   ; load file into memory	
	mov ebx, rv(lfcnt,esi)	
    mov rpos, 0                         ; zero the read position pointer	
	mov Counter, 0
goto_spells_names:		
    mov rpos, linein$(esi,ADDR buffer,rpos)
; Преобразуем набор символов для номера перед названием существа		
	invoke wsprintf, addr buffer2, addr StrMon, Counter, addr buffer
    fn SendMessage,edi,CB_ADDSTRING,0,ADDR buffer2
	inc Counter
	cmp Counter, ebx
	jl goto_spells_names
	pop ebx

; УСТАНОВКА КОМБОБОКСА НАЛОЖЕННЫХ ЗАКЛИНАНИЙ
	push ebx
    mov edi, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_1)
    mov Temp, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_2)
    mov Temp2, rv(GetDlgItem,hWnd,ID_IMPOSED_SPELL_3)

mov ecx, InputFile(dword ptr ds:[ebx*4+case_Monsters])
    mov eax, linein$(ecx,ADDR buffer,0)
    fn SendMessage,edi,CB_ADDSTRING,0,ADDR buffer
    fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer
    fn SendMessage,Temp2,CB_ADDSTRING,0,ADDR buffer

	mov ebx, rv(lfcnt,esi)	
        mov rpos, 0                         ; zero the read position pointer	
	mov Counter, 0
goto_spells_names2:		
    mov rpos, linein$(esi,ADDR buffer,rpos)
; Преобразуем набор символов для номера перед названием существа		
	invoke wsprintf, addr buffer2, addr StrMon, Counter, addr buffer
    fn SendMessage,edi,CB_ADDSTRING,0,ADDR buffer2
    fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer2
    fn SendMessage,Temp2,CB_ADDSTRING,0,ADDR buffer2
	inc Counter
	cmp Counter, ebx
	jl goto_spells_names2
	free esi	
	pop ebx
; УСТАНОВКА МНОЖЕСТВЕННОГО ИМЕНИ
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Plural])   ; load file into memory
	push ebx
	or ebx, -1; счётчик строк
	xor edi, edi; zero the read position pointer
@@:	
	inc ebx
	mov edi, linein$(esi,ADDR buffer,edi)
	cmp ebx, Positio; dword ptr ds:[Monsters]
	jnz @b
	invoke SendDlgItemMessage, hWnd, ID_PLURAL, WM_SETTEXT, ebx, ADDR buffer	
	free esi	
	pop ebx
; УСТАНОВКА описания
	push ebx
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Ability])   ; load file into memory
	or ebx, -1; счётчик строк
	xor edi, edi; zero the read position pointer
@@:	
	inc ebx
	mov edi, linein$(esi,ADDR buffer,edi)
	cmp ebx, Positio; dword ptr ds:[Monsters]
	jnz @b
	invoke SendDlgItemMessage, hWnd, ID_DESCRIPTION, WM_SETTEXT, ebx, ADDR buffer	
	free esi
	pop ebx	
; УСТАНОВКА КОМБОБОКСОВ С ИМЕНАМИ СУЩЕСТВ
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Monsters])   ; load file into memory	
    mov edi, rv(GetDlgItem,hWnd,ID_MONSTER_COMBOX); дескриптор комбобокса с именами существ	
	mov Temp, rv(GetDlgItem,hWnd,ID_UPGRADE); дескриптор апгрейда
	mov ebx, rv(GetDlgItem,hWnd,ID_TRANSFORMATOR); дескриптор Трансформатора
	mov Temp3, rv(GetDlgItem,hWnd,ID_DEMONOLOGY); дескриптор демонологии
    mov rpos, 0; zero the read position pointer	
	mov Counter, 0; обнулить счётчик строк
	mov rpos, linein$(esi,ADDR buffer,rpos)
	fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer; первая строка для апгрейда ("Нет" или "No")
	fn SendMessage,Temp3,CB_ADDSTRING,0,ADDR buffer; первая  ("Нет" или "No")
	invoke lfcnt,esi
	dec eax
	mov Temp2, eax
@@:	
    mov rpos, linein$(esi,ADDR buffer,rpos)
; Преобразуем набор символов для номера перед именем существа	
	invoke wsprintf, addr buffer2, addr StrMon, Counter, addr buffer		
    fn SendMessage,edi,CB_ADDSTRING,0,ADDR buffer
	fn SendMessage,Temp,CB_ADDSTRING,0,ADDR buffer2
	fn SendMessage,ebx,CB_ADDSTRING,0,ADDR buffer2
	fn SendMessage,Temp3,CB_ADDSTRING,0,ADDR buffer2	
	inc Counter
	mov eax, Temp2
	cmp Counter, eax
	jl @b
	free esi                           ; free the memory		
; Восстановить позиции комбобоксов
	mov ebx, ID_MONSTER_COMBOX
@@:	
	fn SendDlgItemMessage,hWnd,ebx,CB_SETCURSEL,dword ptr ds:[ebx*4-(ID_MONSTER_COMBOX*4)+Monsters],0
	inc ebx
	cmp ebx, ID_DEMONOLOGY
	jle @b
	fn SendDlgItemMessage,hWnd,ID_MONSTER_COMBOX,CB_SETCURSEL,Positio,0
	pop ebx
	pop edi
	pop esi
	ret
Change_Lang endp			  