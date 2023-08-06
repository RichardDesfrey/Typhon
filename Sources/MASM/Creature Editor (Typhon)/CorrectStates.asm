.code
Correct_States proc uses ebx edi esi, Monster, hWnd
; если это Стрелковая Башня - деактивируем окно дефа и озвучки
	mov edi, rv(GetDlgItem,hWnd,ID_DEF)
	mov esi, rv(GetDlgItem,hWnd,ID_WAV)
	xor ebx, ebx
	cmp Monster, 149; если Стрелковая башня, то деактивируем окно 
	setne bl
	invoke EnableWindow, edi, ebx 
	invoke EnableWindow, esi, ebx 
.IF ebx == 0
	fn SendMessage,edi,WM_SETTEXT,0,0
	fn SendMessage,esi,WM_SETTEXT,0,0
.ENDIF
; если это боевая машина - деактивируем окно контрударов
	mov edi, rv(GetDlgItem,hWnd,ID_COUNTRE_STRIKES)
	mov ebx, rv(SendDlgItemMessage, hWnd, ID_SIEGE_WEAPON, BM_GETCHECK, 0 ,0)
	xor ebx, 1
	invoke EnableWindow, edi, ebx
.IF ebx == 0
	fn SendMessage,edi,WM_SETTEXT,0,0
.ENDIF	
; Отключение элемента снаряда, если существо не умеет стрелять
	push rv(SendDlgItemMessage, hWnd, ID_SHOOT, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_ARROW)	
	call EnableWindow
; Отключение, если не включен флаг расширенной стрельбы	
	push rv(SendDlgItemMessage, hWnd, ID_ADV_SHOOT, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_CLOUD)
	call EnableWindow
; Отключение, если не включен флаг луча
	push rv(SendDlgItemMessage, hWnd, ID_RAY_SHOOT, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_RAY)
	call EnableWindow
; Отключение, если не включен флаг Артиллерии
	push rv(SendDlgItemMessage, hWnd, ID_ARTILLERY, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_CATAPULT)
	call EnableWindow	
; Отключение, если отключена стрельба	
	push rv(SendDlgItemMessage, hWnd, ID_SHOOT, BM_GETCHECK, 0 ,0)	
	push rv(GetDlgItem,hWnd,ID_NO_WALL_PENALTY)
	call EnableWindow	
; Отключение, если отключена стрельба
	push rv(SendDlgItemMessage, hWnd, ID_SHOOT, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_ShootingAdjacent)	
	call EnableWindow	
; Отключение, если отключена стрельба
	push rv(SendDlgItemMessage, hWnd, ID_SHOOT, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_SNIPER)
	call EnableWindow
; Отключение, если отключена стрельба
	push rv(SendDlgItemMessage, hWnd, ID_SHOOT, BM_GETCHECK, 0 ,0)	
	push rv(GetDlgItem,hWnd,ID_Answer_back_Shooting)	
	call EnableWindow
; Отключение, если включен флаг	"Нет Морали"
	xor rv(SendDlgItemMessage, hWnd, ID_NO_MORAL, BM_GETCHECK, 0,0), 1
	push eax
	push rv(GetDlgItem,hWnd,ID_ALWAYS_MORAL)
	call EnableWindow
; Отключение, если отключен флаг "круговая атака"
	push rv(SendDlgItemMessage, hWnd, ID_ATTACK_ALL_AROUND, BM_GETCHECK, 0 ,0)
	push rv(GetDlgItem,hWnd,ID_THREEHEAD)	
	call EnableWindow
; Отключение демонологии, если выбраны другие ветки раздела "Магия"	
; маг. свойства №1	
	mov ebx, rv (SendDlgItemMessage, hWnd, ID_MAGIC3, CB_GETCURSEL, 0,0)	
; маг. свойства №2
	mov edi, rv (SendDlgItemMessage, hWnd, ID_MAGIC4, CB_GETCURSEL, 0,0)	
; маг. свойства №3
	mov esi, rv (SendDlgItemMessage, hWnd, ID_MAGIC5, CB_GETCURSEL, 0,0)
.if ebx == 0 && edi == 0 && esi == 2
	push 1
.else
	invoke SendDlgItemMessage,hWnd,ID_DEMONOLOGY,CB_SETCURSEL,0,0
	push 0
.endif
	push rv(GetDlgItem,hWnd,ID_DEMONOLOGY)
	call EnableWindow	
	ret
Correct_States endp

