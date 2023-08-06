; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««
	  .686
	  .MMX
	  .XMM
      .model flat, stdcall      ; 32 bit memory model
      option casemap :none      ; case sensitive
	  
;     include files
;     ~~~~~~~~~~~~~
      include \masm32\include\oleaut32.inc
	  include \masm32\include\msvcrt.inc
      include \masm32\include\ole32.inc
      include \masm32\include\windows.inc
      include \masm32\include\masm32.inc
      include \masm32\include\gdi32.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc
      include \masm32\include\Comctl32.inc
      include \masm32\include\comdlg32.inc
      include \masm32\include\shell32.inc



      include \masm32\macros\pomacros.asm
      include \masm32\macros\macros.asm
;     libraries
;     ~~~~~~~~~
      includelib \masm32\lib\masm32.lib
      includelib \masm32\lib\gdi32.lib
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
      includelib \masm32\lib\Comctl32.lib
      includelib \masm32\lib\comdlg32.lib
      includelib \masm32\lib\shell32.lib
      includelib \masm32\lib\oleaut32.lib
      includelib \masm32\lib\ole32.lib
	  includelib \masm32\lib\msvcrt.lib
; Dialogs	  
	  include \masm32\include\dialogs.inc

; 16 * 1000 = 16000 данные о дефах
; 5 * 1000 = 5000 данные об озвучке
; 4 * 1000 = 4000 данных флагов
; 1000 = данные уровней
; 1000 = данные городов
FIVE_PARAM = 16000 + 5000 + 4000 + 1000 + 1000;
File_Size = 254000; размер конфига существ
Lang_File_Size = 3; размер конфига с параметром языка + позицией комбобокса выбора существа (1+2)

ID_LANG_ENG = 2001
ID_LANG_RUS = 2002

ID_MONSTER_COMBOX 			= 300
ID_UPGRADE 					= 301
ID_TRANSFORMATOR 			= 302
ID_SPELL 					= 303
ID_ARROW 					= 304
ID_RAY 						= 305
ID_CLOUD 					= 306
ID_CATAPULT 				= 307
ID_MAGIC1 					= 308
ID_MAGIC2 					= 309
ID_MAGIC3 					= 310
ID_MAGIC4 					= 311
ID_MAGIC5 					= 312
ID_IMMUN 					= 313
ID_HATE 					= 314
ID_RES_GOLEM 				= 315
ID_REBIRTH 					= 316
ID_IMPOSED_SPELL_1 = 317
ID_IMPOSED_SPELL_2 = 318
ID_IMPOSED_SPELL_3 = 319
ID_IMPOSED_SPELL_1_lvl = 320
ID_IMPOSED_SPELL_2_lvl = 321
ID_IMPOSED_SPELL_3_lvl = 322
ID_DEMONOLOGY = 323

ID_SAVE = 2100
ID_TO_UPGRADE = 2101
ID_DEF = 121
ID_WAV = 122
ID_FLAGS = 2019
ID_SHOOT = 2021
ID_ARTILLERY = 2024
ID_SIEGE_WEAPON = 2025
ID_RAY_SHOOT = 2030
ID_NO_MORAL = 2036
ID_ATTACK_ALL_AROUND = 2038
ID_ADV_SHOOT = 2039
ID_LEVEL = 151
ID_TOWN = 2008
ID_COUNTRE_STRIKES = 212
ID_NO_WALL_PENALTY = 2058
ID_ShootingAdjacent = 2059
ID_SNIPER = 2060
ID_Answer_back_Shooting = 2061
ID_STRIKE_RETURN = 2062
ID_FIRST_ATTACK = 2063
ID_RES_GNOM = 231
ID_ALWAYS_MORAL = 2073
ID_ALWAYS_LUCK = 2074
ID_FEAR = 2075
ID_FEARLESS = 2076
ID_CAVA_BONUS = 2077
ID_IMMUN_CAVA = 2078
ID_MAGIC_AURA = 2079
ID_ESPIONAGE = 2080
ID_FIRESHIELD = 2081
ID_MAGIC_MIRROR = 2082
ID_MAGIC_CHANNEL = 2083
ID_THREEHEAD = 2084
ID_DEATH_STRIKE = 245
ID_REGEN_PERCENT = 246
ID_REGEN_NUMBER = 247
ID_REDUCE_TARGET_DEFENCE = 248
ID_MANA_MINUS = 249
ID_MANA_PLUS = 250
ID_MANA_DRAIN = 251
ID_FLIGHT_ATTACK = 253
ID_AROUND1 = 254
ID_AROUND2 = 255
ID_DEAFEN = 256
ID_RANDOM_GENERATION = 2099
ID_FIREWALL = 2132


ID_PLURAL = 5000
ID_DESCRIPTION = 5001

ID_COST_WOOD    = 70
ID_COST_MERCURY = 71
ID_COST_ORE     = 72
ID_COST_SULFUR  = 73
ID_COST_CRYSTAL = 74
ID_COST_GEMS    = 75
ID_COST_GOLD    = 76
ID_FIGHT_VALUE  = 77
ID_AI_VALUE     = 78
ID_GROWTH       = 79
ID_HORDE        = 80
ID_HEALTH		= 81
ID_SPEED		= 82
ID_ATTACK		= 83
ID_DEFENSE		= 84
ID_DAMAGE_MIN	= 85
ID_DAMAGE_MAX	= 86
ID_SHOTS		= 87
ID_SPELLS		= 88
ID_ADV_LOW		= 89
ID_ADV_HIGH		= 90

ID_URMOX		= 91
ID_URMOY		= 92
ID_RMOX			= 93
ID_RMOY			= 94
ID_LRMOX		= 95
ID_LRMOY		= 96
ID_SHOOTPROT    = 97
ID_DEFENSEBONUS	= 98
ID_BLOCK_DAMAGE	= 99

ID_Missile_Frame_Angles = 5002

ID_Troop_Count_Location_Offset = 5014
ID_Attack_Climax_Frame = 5015
ID_Time_between_fidgets = 5016
ID_Walk_Animation_Time = 5017
ID_Attack_Animation_Time = 5018
ID_Flight_Animation_Distance = 5019


ID_COPY			= 10000
ID_PASTE	 	= 10001	
ID_PASTE_CRANIM	= 10002
; + 43000 - смещение до преобразований в Трансформаторе
; + 47000 - смещение до апгрейдов	  
      DlgProc PROTO :DWORD,:DWORD,:DWORD,:DWORD	  
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««	 	  
.data
	  EMonsters     db 'Eng\Monsters.txt',0; текстовик с названиями монстров (eng)
	  RMonsters     db 'Rus\Monsters.txt',0; текстовик с названиями монстров (rus)
	  ESpells       db 'Eng\Spells.txt',0; текстовик с названиями заклинаний (eng)
	  RSpells       db 'Rus\Spells.txt',0; текстовик с названиями заклинаний (rus)
	  ECommon       db 'Eng\Common.txt',0; основные строки (eng)
	  RCommon       db 'Rus\Common.txt',0; основные строки (rus)
	  EPlural		db 'Eng\Plural.txt',0; множественные имена (eng)
	  RPlural		db 'Rus\Plural.txt',0; множественные имена (rus)
	  EAbility		db 'Eng\Ability.txt',0; описания способностей (eng)
	  RAbility		db 'Rus\Ability.txt',0; описания способностей (rus)	  	  
	  Pictures      db '\Pic\%d.jpg',0; папка с портретами существ 
	  Lang          db 'Lang',0; название 1-байтового конфига для хранения статуса языка
	  BinFile       db 'MonstersSetup.mop',0; бинарный конфиг со всеми характеристиками существ
	  AmmoFile	db 'Ammo.mop',0; бинарный конфиг со снарядами существ
	  ImposedSpellsFile	db 'ImposedSpells.mop',0; бинарный конфиг c наложенными заклинаниями
	  FirewallFile	db 'Firewall.mop',0; бинарный конфиг с битовой маской огненной стены
	  DefenseBonusFile	db 'DefenseBonus.mop',0; бинарный конфиг с бонусом обороны
	  DemonologyFile	db 'Demonology.mop',0; бинарный конфиг с существами демонологии
	  BlockFile	db 'Block.mop',0; бинарный конфиг с параметрами Блока существ
	  icex			dd sizeof INITCOMMONCONTROLSEX, 0FFFFh; structure for Controls
	  case_Monsters dd offset EMonsters, offset RMonsters	
	  case_Spells   dd offset ESpells, offset RSpells	
      case_Common   dd offset ECommon, offset RCommon
	  case_Plural   dd offset EPlural, offset RPlural
	  case_Ability  dd offset EAbility, offset RAbility
	  StrMon        db '%03d %s', 0;	    
	  AEdit         db 'Edit',0
	  NewEdit		db 'NewEdit',0
	  FloatStr      db '%lf',0
	  float9000	    dd 9000.0
	  float500		dd 500.0
	  float115		dd 115.0
	  
.data?	  
	  MoPEdit		dd ?
	  Positio		dd ?	
	  MonNumText 	db 120 dup (?)	  
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««	  
MONSTER_SETUP STRUCT
	  DefName BYTE 16*1000 dup(?)
	  Wav	  BYTE 5*1000 dup(?)
MONSTER_SETUP ENDS	  
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««	  
.code		

Paint_Proc proc Position, hWnd

	LOCAL buffer[1000]  :BYTE
	LOCAL buffer2[1000]  :BYTE
	
	push ebx
	push edi
	push esi
; определяем имя для картинки:	
	invoke GetCurrentDirectory, -1, addr buffer
	invoke lstrcat, addr buffer, addr Pictures; путь + файл	
	invoke wsprintf, addr buffer2, addr buffer, Position	
    mov ebx, rv(GetDC,hWnd)
	mov edi, rv(CreateCompatibleDC,ebx)
	mov esi, rv(BitmapFromFile, addr buffer2)
.IF esi == 0
	mov esi, rv(BitmapFromResource, 0, 2000)
.ENDIF
    invoke SelectObject,edi,esi
    invoke BitBlt,ebx,13,236,58,64,edi,0,0,SRCCOPY; параметры картинки		
    invoke DeleteObject,esi
    invoke DeleteDC,edi
    invoke ReleaseDC,hWnd,ebx
	pop esi
	pop edi
	pop ebx
    ret
Paint_Proc endp

Paint_SMALLRES proc hWin, Icon_num, X_coor, Y_coor, PWidth, PHeight

    LOCAL hDC:DWORD
    LOCAL hBmp:DWORD
    LOCAL memDC:DWORD

                    invoke GetDC,hWin
                    mov hDC,eax
                    invoke CreateCompatibleDC,hDC
                    mov memDC,eax
                    invoke LoadImage,rv(GetModuleHandle,NULL),Icon_num,IMAGE_BITMAP,0,0,
                                         LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS
                    mov hBmp,eax
                    invoke SelectObject,memDC,hBmp
                    invoke BitBlt,hDC,X_coor, Y_coor,PWidth,PHeight,memDC,0,0,SRCCOPY
                    invoke DeleteObject,hBmp
                    invoke DeleteDC,memDC
                    invoke ReleaseDC,hWin,hDC
                    ret

Paint_SMALLRES endp

NewEditProc proc
  		push	ebp
  		mov	ebp,esp
  		sub	esp,00000018h
  		cmp	dword ptr [ebp+0Ch],00000102h
  		jnz	L00401361
  		cmp	dword ptr [ebp+10h],0000002Fh
  		jbe	L0040130B
  		cmp	dword ptr [ebp+10h],00000039h
  		jbe	L0040131F
 L0040130B:
  		cmp	dword ptr [ebp+10h],0000002Eh
  		jz 	L0040131F
  		cmp	dword ptr [ebp+10h],00000008h
  		jz 	L0040131F
  		cmp	dword ptr [ebp+10h],0000002Dh
  		jz 	L0040131F
  		jmp	L00401349
 L0040131F:
  		mov	eax,[ebp+14h]
  		mov	[esp+0Ch],eax
  		mov	eax,[ebp+10h]
  		mov	[esp+08h],eax
  		mov	eax,[ebp+0Ch]
  		mov	[esp+04h],eax
  		mov	eax,[ebp+08h]
  		mov	[esp],eax
  		mov	eax,MoPEdit
  		call	eax
  		sub	esp,00000010h
  		mov	[ebp-04h],eax
  		jmp	L00401389
 L00401349:
  		mov	dword ptr [esp],0FFFFFFFFh
  		call MessageBeep
  		sub	esp,00000004h
  		mov	dword ptr [ebp-04h],00000000h
  		jmp	L00401389
 L00401361:
  		mov	eax,[ebp+14h]
  		mov	[esp+0Ch],eax
  		mov	eax,[ebp+10h]
  		mov	[esp+08h],eax
  		mov	eax,[ebp+0Ch]
  		mov	[esp+04h],eax
  		mov	eax,[ebp+08h]
  		mov	[esp],eax
  		mov	eax,MoPEdit
  		call	eax
  		sub	esp,00000010h
  		mov	[ebp-04h],eax
 L00401389:
  		mov	eax,[ebp-04h]
  		leave
  		retn	0010h
NewEditProc endp
	
include CorrectStates.asm
include SetupMonsterAttrib.asm
include Language.asm
include Copy.asm
include Paste.asm
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««

; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««
DlgProc proc hWin,uMsg,wParam,lParam
   LOCAL Counter      :DWORD
   LOCAL Counter1     :DWORD
   LOCAL Counter2     :DWORD
   LOCAL pMem         :DWORD
   LOCAL rpos         :DWORD
   LOCAL buffer[1000]  :BYTE
  
switch uMsg
  
  case WM_PAINT
Painting_pic:  
  ; Рисуем портрет существа
  invoke Paint_Proc, rv (SendDlgItemMessage, hWin, ID_MONSTER_COMBOX, CB_GETCURSEL, 0, 0), hWin
  ; Рисуем иконки ресурсов
  invoke Paint_SMALLRES, hWin, 501, 762, 56, 20, 18
  invoke Paint_SMALLRES, hWin, 502, 824, 56, 20, 18
  invoke Paint_SMALLRES, hWin, 503, 885, 56, 20, 18
  invoke Paint_SMALLRES, hWin, 504, 947, 56, 20, 18
  invoke Paint_SMALLRES, hWin, 505, 762, 82, 20, 18
  invoke Paint_SMALLRES, hWin, 506, 824, 82, 20, 18 
  invoke Paint_SMALLRES, hWin, 507, 900, 82, 20, 18 
  invoke Paint_SMALLRES, hWin, 508, 760, 383, 248, 208; - постер

  case WM_INITDIALOG 
; Загрузка иконки 
    invoke SendMessage,hWin,WM_SETICON,1,rv(LoadIcon,rv(GetModuleHandle, NULL),500)		
	invoke Change_Lang, hWin; установка параметры языка		
; ограничиваем количество букв на озвучку	
	invoke SendDlgItemMessage, hWin, ID_WAV, EM_LIMITTEXT, 4, 0;
; ограничиваем количество букв на деф	
	invoke SendDlgItemMessage, hWin, ID_DEF, EM_LIMITTEXT, 15, 0;
; ограничиваем количество букв на снаряд	
	invoke SendDlgItemMessage, hWin, ID_ARROW, EM_LIMITTEXT, 15, 0;
; ограничиваем кол-во символов для уровня
	invoke SendDlgItemMessage, hWin, ID_LEVEL, EM_LIMITTEXT, 1, 0;
; устанавливаем экстремумы уровней
	invoke SendDlgItemMessage,hWin,1917,UDM_SETRANGE32,1,7
; ограничиваем кол-во символов для контрударов
	invoke SendDlgItemMessage, hWin, ID_COUNTRE_STRIKES, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы контрударов
	invoke SendDlgItemMessage,hWin,1918,UDM_SETRANGE32,0,255	
; ограничиваем кол-во символов для для гномьего сопротивления
	invoke SendDlgItemMessage, hWin, ID_RES_GNOM, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для гномьего сопротивления
	invoke SendDlgItemMessage,hWin,1919,UDM_SETRANGE32,0,100
; ограничиваем кол-во символов для Смертельного удара
	invoke SendDlgItemMessage, hWin, ID_DEATH_STRIKE, EM_LIMITTEXT, 3, 0;	
; устанавливаем экстремумы для Смертельного удара
	invoke SendDlgItemMessage,hWin,1920,UDM_SETRANGE32,0,100
; ограничиваем кол-во символов для % регенерации
	invoke SendDlgItemMessage, hWin, ID_REGEN_PERCENT, EM_LIMITTEXT, 3, 0;	
; устанавливаем экстремумы для  % регенерации
	invoke SendDlgItemMessage,hWin,1921,UDM_SETRANGE32,0,100
; ограничиваем кол-во символов для n регенерации
	invoke SendDlgItemMessage, hWin, ID_REGEN_NUMBER, EM_LIMITTEXT, 9, 0;	
; устанавливаем экстремумы для n регенерации
	invoke SendDlgItemMessage,hWin,1922,UDM_SETRANGE32,0,999999999
; ограничиваем кол-во символов для снижения защиты
	invoke SendDlgItemMessage, hWin, ID_REDUCE_TARGET_DEFENCE, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для снижения защиты
	invoke SendDlgItemMessage,hWin,1923,UDM_SETRANGE32,0,100	
; ограничиваем кол-во символов для удешевления маны
	invoke SendDlgItemMessage, hWin, ID_MANA_MINUS, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для удешевления маны
	invoke SendDlgItemMessage,hWin,1924,UDM_SETRANGE32,0,255
; ограничиваем кол-во символов для подорожания маны
	invoke SendDlgItemMessage, hWin, ID_MANA_PLUS, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для подорожания маны
	invoke SendDlgItemMessage,hWin,1925,UDM_SETRANGE32,0,255
; ограничиваем кол-во символов для кражи маны
	invoke SendDlgItemMessage, hWin, ID_MANA_DRAIN, EM_LIMITTEXT, 5, 0;
; устанавливаем экстремумы для кражи маны
	invoke SendDlgItemMessage,hWin,1926,UDM_SETRANGE32,0,65535	
; ограничиваем кол-во символов для Атаки Стаей
	invoke SendDlgItemMessage, hWin, ID_FLIGHT_ATTACK, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для Атаки Стаей
	invoke SendDlgItemMessage,hWin,1927,UDM_SETRANGE32,-1,100
; ограничиваем кол-во символов для атаки всех проносящихся мимо
	invoke SendDlgItemMessage, hWin, ID_AROUND1, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для атаки всех проносящихся мимо
	invoke SendDlgItemMessage,hWin,1928,UDM_SETRANGE32,-1,100
; ограничиваем кол-во символов для атаки всех, мимо кого проносится
	invoke SendDlgItemMessage, hWin, ID_AROUND2, EM_LIMITTEXT, 3, 0;
; устанавливаем экстремумы для атаки всех, мимо кого проносится
	invoke SendDlgItemMessage,hWin,1929,UDM_SETRANGE32,-1,100
; ограничиваем кол-во символов для Блока
	invoke SendDlgItemMessage, hWin, ID_BLOCK_DAMAGE, EM_LIMITTEXT, 3, 0;	
; устанавливаем экстремумы для Блока
	invoke SendDlgItemMessage,hWin,1978,UDM_SETRANGE32,0,100	
; устанавливаем экстремумы для ресурсов
	mov ebx, ID_COST_WOOD
@@:	invoke SendDlgItemMessage, hWin, ebx, EM_LIMITTEXT, 3, 0;
	lea eax, [ebx+1861]	
	invoke SendDlgItemMessage,hWin,eax,UDM_SETRANGE32,0,999
    inc ebx
	cmp ebx, ID_COST_GOLD
	jl @b
	invoke SendDlgItemMessage, hWin, ebx, EM_LIMITTEXT, 9, 0;
	invoke SendDlgItemMessage,hWin,1937,UDM_SETRANGE32,0, 999999999
; Fight Value
	invoke SendDlgItemMessage, hWin, ID_FIGHT_VALUE, EM_LIMITTEXT, 7, 0;
	invoke SendDlgItemMessage,hWin,1938,UDM_SETRANGE32,0, 9999999
; AI Value
	invoke SendDlgItemMessage, hWin, ID_AI_VALUE, EM_LIMITTEXT, 7, 0;
	invoke SendDlgItemMessage,hWin,1939,UDM_SETRANGE32,0, 9999999
; Прирост
	invoke SendDlgItemMessage, hWin, ID_GROWTH, EM_LIMITTEXT, 4, 0;
	invoke SendDlgItemMessage,hWin,1940,UDM_SETRANGE32,0, 9999
; Доп. Прирост
	invoke SendDlgItemMessage, hWin, ID_HORDE, EM_LIMITTEXT, 3, 0;
	invoke SendDlgItemMessage,hWin,1941,UDM_SETRANGE32,0, 999
; Здоровье
	invoke SendDlgItemMessage, hWin, ID_HEALTH, EM_LIMITTEXT, 7, 0;
	invoke SendDlgItemMessage,hWin,1942,UDM_SETRANGE32,0, 9999999
; скорость
	invoke SendDlgItemMessage, hWin, ID_SPEED, EM_LIMITTEXT, 5, 0;
	invoke SendDlgItemMessage,hWin,1943,UDM_SETRANGE32,0, 99999
; Атака
	invoke SendDlgItemMessage, hWin, ID_ATTACK, EM_LIMITTEXT, 5, 0;
	invoke SendDlgItemMessage,hWin,1944,UDM_SETRANGE32,0, 99999
; Защита
	invoke SendDlgItemMessage, hWin, ID_DEFENSE, EM_LIMITTEXT, 5, 0;
	invoke SendDlgItemMessage,hWin,1945,UDM_SETRANGE32,0, 99999
; мин и макс урон, боезапас, маг. заряды, кол-во на карте
	mov ebx, ID_DAMAGE_MIN
@@: invoke SendDlgItemMessage, hWin, ebx, EM_LIMITTEXT, 4, 0;
	lea eax, [ebx-(ID_DAMAGE_MIN-1946)]
	invoke SendDlgItemMessage,hWin,eax,UDM_SETRANGE32,0, 9999	
	inc ebx
	cmp ebx, ID_ADV_HIGH
	jle @b
; CRANIM	
; Upper-right Missile Offset, Right Missile Offset, Lower-right Missile Offset
	mov ebx, ID_URMOX
@@: invoke SendDlgItemMessage, hWin, ebx, EM_LIMITTEXT, 3, 0;
	lea eax, [ebx-(ID_URMOX-1952)]
	invoke SendDlgItemMessage,hWin,eax,UDM_SETRANGE32,-128, 127	
	inc ebx
	cmp ebx, ID_LRMOY
	jle @b
; Missile Frame Angles
	mov ebx, ID_Missile_Frame_Angles
@@: 
	invoke SendDlgItemMessage, hWin, ebx, EM_LIMITTEXT, 5, 0;	
	lea eax, [ebx-(ID_Missile_Frame_Angles-1958)]
	invoke SendDlgItemMessage,hWin,eax,UDM_SETRANGE32,-90, 90
	inc ebx
	cmp ebx, ID_Missile_Frame_Angles+11
	jle @b	
; Troop Count Location Offset
	invoke SendDlgItemMessage,hWin,ID_Troop_Count_Location_Offset,EM_LIMITTEXT,3, 0	
	invoke SendDlgItemMessage,hWin,1970,UDM_SETRANGE32,0, 100
; Attack Climax Frame
	invoke SendDlgItemMessage,hWin,ID_Attack_Climax_Frame,EM_LIMITTEXT,3, 0	
	invoke SendDlgItemMessage,hWin,1971,UDM_SETRANGE32,0, 100	
; Time between fidgets		
	invoke SendDlgItemMessage,hWin,ID_Time_between_fidgets,EM_LIMITTEXT,3, 0		
	invoke SendDlgItemMessage,hWin,1972,UDM_SETRANGE32,0, 100
; Walk Animation Time
	invoke SendDlgItemMessage,hWin,ID_Walk_Animation_Time,EM_LIMITTEXT,5, 0		
	invoke SendDlgItemMessage,hWin,1973,UDM_SETRANGE32,0, 100		
; Attack Animation Time
	invoke SendDlgItemMessage,hWin,ID_Attack_Animation_Time,EM_LIMITTEXT,5, 0		
	invoke SendDlgItemMessage,hWin,1974,UDM_SETRANGE32,0, 100
; Flight Animation Distance
	invoke SendDlgItemMessage,hWin,ID_Flight_Animation_Distance,EM_LIMITTEXT,5, 0	
	invoke SendDlgItemMessage,hWin,1975,UDM_SETRANGE32,0, 100
; устанавливаем экстремумы для защиты от стрел
	invoke SendDlgItemMessage,hWin,1976,UDM_SETRANGE32,-100,100
; устанавливаем экстремумы для бонуса обороны
	invoke SendDlgItemMessage,hWin,1977,UDM_SETRANGE32,0,255
; Установить начальную строку
	mov ebx, InputFile(addr Lang) ; загрузить 3-байтовый файл в память
	movsx edi, word ptr ds:[ebx+1]
	mov Positio, edi
	free ebx
	invoke Setup_Monster_attributes, edi, hWin; установка параметров для копейщика
	
  case WM_COMMAND

; Отключение демонологии, если выбраны другие ветки раздела "Магия"	
; маг. свойства №1	
	mov ebx, rv (SendDlgItemMessage, hWin, ID_MAGIC3, CB_GETCURSEL, 0,0)	
; маг. свойства №2
	mov edi, rv (SendDlgItemMessage, hWin, ID_MAGIC4, CB_GETCURSEL, 0,0)	
; маг. свойства №3
	mov esi, rv (SendDlgItemMessage, hWin, ID_MAGIC5, CB_GETCURSEL, 0,0)
.if ebx == 0 && edi == 0 && esi == 2
	push 1
.else
	invoke SendDlgItemMessage,hWin,ID_DEMONOLOGY,CB_SETCURSEL,0,0
	push 0
.endif
	push rv(GetDlgItem,hWin,ID_DEMONOLOGY)
	call EnableWindow
 		
    switch wParam
		
      case IDCANCEL
	  mov ebx, InputFile(addr Lang) ; загрузить 3-байтовый файл в память
	  ;fn SendDlgItemMessage, hWin, ID_MONSTER_COMBOX, CB_GETCURSEL, 0, 0
	  mov eax, Positio
	  mov word ptr ds:[ebx+1], ax		  
	  mov eax, OutputFile(addr Lang, ebx, Lang_File_Size); сохранить файл 	 	  
          invoke EndDialog,hWin,0	  

; Включение/выключение элемента "Снаряд" при манипуляции с флагом стрельбы	  
	  case ID_SHOOT
shoot_adv:	  
	  mov edi, rv(GetDlgItem,hWin,ID_ARROW)
	  mov ebx, rv (SendDlgItemMessage, hWin, ID_SHOOT, BM_GETCHECK, 0 ,0)
	  invoke EnableWindow, edi, ebx
	  invoke EnableWindow, rv(GetDlgItem,hWin,ID_NO_WALL_PENALTY), ebx; выключаем элемент
	  invoke EnableWindow, rv(GetDlgItem,hWin,ID_ShootingAdjacent), ebx; выключаем элемент
	  invoke EnableWindow, rv(GetDlgItem,hWin,ID_SNIPER), ebx; выключаем элемент	  
	  invoke EnableWindow, rv(GetDlgItem,hWin,ID_Answer_back_Shooting), ebx; выключаем элемент	  
	  test ebx, ebx
	  jnz VKL3
	  ;invoke SendMessage,edi,CB_SETCURSEL,16,0; устанавливаем отсутствие снаряда	  
	  mov edi, rv(GetDlgItem,hWin,ID_CLOUD)
	  invoke EnableWindow, edi, ebx; выключаем элемент расширенной стрельбы
	  invoke SendMessage,edi,CB_SETCURSEL,0,0; устанавливаем отсутствие расширенной стрельбы	  	  
	  invoke SendDlgItemMessage, hWin, ID_ADV_SHOOT, BM_SETCHECK, ebx,0; выключаем расширенную стрельбу
	  mov edi, rv(GetDlgItem,hWin,ID_RAY)
	  invoke EnableWindow, edi, ebx; выключаем элемент стрельбы лучом
	  invoke SendMessage,edi,CB_SETCURSEL,2,0; устанавливаем отсутствие расширенной стрельбы	  
	  invoke SendDlgItemMessage, hWin, ID_RAY_SHOOT, BM_SETCHECK, ebx,0; выключаем стрельбу лучом
	  mov edi, rv(GetDlgItem,hWin,ID_CATAPULT)
	  invoke EnableWindow, edi, ebx; выключаем элемент стрельбы лучом
	  invoke SendDlgItemMessage, hWin, ID_NO_WALL_PENALTY, BM_SETCHECK, ebx,0; выключаем
	  invoke SendDlgItemMessage, hWin, ID_ShootingAdjacent, BM_SETCHECK, ebx,0; выключаем
	  invoke SendDlgItemMessage, hWin, ID_SNIPER, BM_SETCHECK, ebx,0; выключаем
	  invoke SendDlgItemMessage, hWin, ID_Answer_back_Shooting, BM_SETCHECK, ebx,0; выключаем
	  invoke SendDlgItemMessage, hWin, ID_ARTILLERY, BM_SETCHECK, ebx,0; выключаем стрельбу лучом
;ID_ARTILLERY	  
VKL3:	  
	  	  
	  case ID_ADV_SHOOT
	  mov ebx, rv (SendDlgItemMessage, hWin, ID_ADV_SHOOT, BM_GETCHECK, 0 ,0); проверяем, установлена ли галочка расширенной стрельбы
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_GETCHECK, 0 ,0;
	  test eax, eax
	  jnz VKL
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_SETCHECK, BST_CHECKED,0; включаем элемент флага стрельбы, если выключен
VKL:	  
	  mov edi, rv(GetDlgItem,hWin,ID_CLOUD)
	  invoke EnableWindow, edi, ebx; включаем / выключаем элемент расширенной стрельбы	
	  test ebx, ebx
	  jnz VKL5
	  invoke SendMessage,edi,CB_SETCURSEL,0,0; устанавливаем отсутствие расширенной стрельбы	  
VKL5:	  
	  jmp shoot_adv
	  
	  case ID_RAY_SHOOT
	  invoke SendDlgItemMessage, hWin, ID_RAY_SHOOT, BM_GETCHECK, 0 ,0; проверяем, установлена ли галочка расширенной стрельбы
	  mov ebx, eax; запоминаем
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_GETCHECK, 0 ,0;
	  test eax, eax
	  jnz VKL2
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_SETCHECK, BST_CHECKED,0; включаем элемент флага стрельбы, если выключен
VKL2:
	  mov edi, rv(GetDlgItem,hWin,ID_RAY)
	  invoke EnableWindow, edi, ebx; включаем / выключаем элемент стрельбы лучом
	  test ebx, ebx
	  jnz VKL6
	  invoke SendMessage,edi,CB_SETCURSEL,2,0; устанавливаем отсутствие 	  
VKL6:	  
	  jmp shoot_adv	  
	  
	  case ID_ARTILLERY
	  invoke SendDlgItemMessage, hWin, ID_ARTILLERY, BM_GETCHECK, 0 ,0; проверяем, установлена ли галочка расширенной стрельбы
	  mov ebx, eax; запоминаем
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_GETCHECK, 0 ,0;
	  test eax, eax
	  jnz VKL4
	  invoke SendDlgItemMessage, hWin, ID_SHOOT, BM_SETCHECK, BST_CHECKED,0; включаем элемент флага стрельбы, если выключен
VKL4:
	  mov edi, rv(GetDlgItem,hWin,ID_CATAPULT)
	  invoke EnableWindow, edi, ebx; включаем / выключаем элемент
	  test ebx, ebx
	  jnz VKL7
	  invoke SendMessage,edi,CB_SETCURSEL,0,0; устанавливаем отсутствие 	  
VKL7:
	  
	  jmp shoot_adv
	  
	  case ID_SIEGE_WEAPON
	  mov edi, rv(GetDlgItem,hWin,ID_COUNTRE_STRIKES)
	  invoke SendDlgItemMessage, hWin, ID_SIEGE_WEAPON, BM_GETCHECK, 0 ,0
	  mov ebx, eax
	  test eax, eax
	  je VKL8
	  xor eax, eax
	  mov eax, sstr$(eax)
	  invoke SendMessage,edi,WM_SETTEXT,0,eax	  
VKL8:
	  xor ebx, 1
	  invoke EnableWindow, edi, ebx	  
	  
	  case ID_NO_MORAL
	  mov edi, rv(GetDlgItem,hWin,ID_ALWAYS_MORAL)
	  invoke SendDlgItemMessage, hWin, ID_NO_MORAL, BM_GETCHECK, 0 ,0
	  mov ebx, eax
	  xor ebx, 1
	  test ebx, ebx
	  jnz VKL9
	  invoke SendDlgItemMessage, hWin, ID_ALWAYS_MORAL, BM_SETCHECK, ebx,0;	  
VKL9:
	  invoke EnableWindow, edi, ebx
	  
	  case ID_ATTACK_ALL_AROUND
	  mov edi, rv(GetDlgItem,hWin,ID_THREEHEAD)
	  invoke SendDlgItemMessage, hWin, ID_ATTACK_ALL_AROUND, BM_GETCHECK, 0 ,0
	  mov ebx, eax
	  test ebx, ebx
	  jnz VKL10
	  invoke SendMessage, edi, BM_SETCHECK, ebx,0;	  
VKL10:
	  invoke EnableWindow, edi, ebx	  
  	  
	  case ID_TO_UPGRADE
	  dec rv (SendDlgItemMessage, hWin, ID_UPGRADE, CB_GETCURSEL, 0, 0)
.IF eax != -1
	  mov Positio, eax
	invoke Setup_Monster_attributes, eax, hWin; установка параметров для копейщика
.ENDIF

	  case ID_SAVE	
SAVING:	  
	  mov edi, Positio
	  mov esi, InputFile(addr BinFile)   ; load file into memory
; сохранение дефа:	
	  mov eax, edi
	  shl eax, 4; умножить на 16	
	  lea eax, [esi + eax + MONSTER_SETUP.DefName]  
	  invoke GetDlgItemText,hWin,ID_DEF,eax,16; получить текст дефа в диалоге
; сохранение озвучки
	  mov eax, edi
	  imul eax, 5; умножить на 5	
	  lea eax, [esi + eax + MONSTER_SETUP.Wav]
	  invoke GetDlgItemText,hWin,ID_WAV,eax,5; получить текст озвучки в диалоге
; сохранение флагов:
	  mov ebx, ID_FLAGS;
Loop_flags:	
	  invoke SendDlgItemMessage, hWin, ebx, BM_GETCHECK,0,0;
	  mov edx, ebx
	  sub edx, ID_FLAGS		  
	  test al, al  
	  je not_check
	  bts [esi + edi * 4 + 16000 + 5000], edx
	  jmp check
not_check:
	  btr [esi + edi * 4 + 16000 + 5000], edx
check:	  
	  inc ebx
	  cmp ebx, 2050
	  jle Loop_flags	  
; сохранение уровня
	  invoke GetDlgItemInt,hWin, ID_LEVEL, NULL,FALSE; получить текст кол-ва
	  dec eax
	  mov [esi + edi + 16000 + 5000 + 4000], al
; сохранение города
	  mov ebx, ID_TOWN
Loop_towns:  
	  invoke SendDlgItemMessage, hWin, ebx, BM_GETCHECK,0,0;
	  test al, al
	  je not_town
	  sub ebx, ID_TOWN
	  dec ebx
	  mov [esi + edi + 16000 + 5000 + 4000 + 1000], bl
	  jmp end_towns
not_town:	  
	  inc ebx
	  cmp ebx, ID_TOWN+9
	  jle Loop_towns	  
end_towns:
; сохранение апгрейда
	  dec rv (SendDlgItemMessage, hWin, ID_UPGRADE, CB_GETCURSEL, 0, 0)
	  mov [esi + edi * 4 + 47000], eax
; сохранение Трансформатора	  
	  mov [esi + edi * 4 + 43000], rv (SendDlgItemMessage, hWin, ID_TRANSFORMATOR, CB_GETCURSEL, 0, 0)	 	  
; сохранение контрударов	  
	  invoke GetDlgItemInt,hWin, ID_COUNTRE_STRIKES, NULL,FALSE; получить текст кол-ва
	  mov [esi + edi + FIVE_PARAM], al
; сохранение снарядов	  
	  invoke SendDlgItemMessage, hWin, ID_ARROW, CB_GETCURSEL, 0, 0
	  mov [esi + edi + FIVE_PARAM + 3000], al
; сохранение расширенной стрельбы
	  invoke SendDlgItemMessage, hWin, ID_CLOUD, CB_GETCURSEL, 0, 0
	  mov [esi + edi + FIVE_PARAM + 6000], al
; сохранение цвета луча	  
	  invoke SendDlgItemMessage, hWin, ID_RAY, CB_GETCURSEL, 0, 0
	  mov [esi + edi + 82000], al
; сохранение Артиллерии
	  invoke SendDlgItemMessage, hWin, ID_CATAPULT, CB_GETCURSEL, 0, 0
	  mov [esi + edi + FIVE_PARAM + 4000], al
; сохранение отсутствия штрафа преград
	  invoke SendDlgItemMessage, hWin, ID_NO_WALL_PENALTY, BM_GETCHECK, 0 ,0
	  mov [esi + edi + FIVE_PARAM + 10000], al
; сохранение Стрельбы вплотную	  
	  invoke SendDlgItemMessage, hWin, ID_ShootingAdjacent, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 74000], al
; сохранение Снайперства	  
	  invoke SendDlgItemMessage, hWin, ID_SNIPER, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 73000], al
; сохранение Ответного выстрела
	  invoke SendDlgItemMessage, hWin, ID_Answer_back_Shooting, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 81000], al	  
; сохранение атаки с возвратом
	  invoke SendDlgItemMessage, hWin, ID_STRIKE_RETURN, BM_GETCHECK, 0 ,0
	  mov ebx, eax
	  test ebx, ebx
	  je not_ret_str
	  invoke SendDlgItemMessage, hWin, ID_FLAGS, BM_GETCHECK, 0 ,0; проверка 2-клеточности
	  add ebx, eax
not_ret_str:	  
	  mov [esi + edi + FIVE_PARAM + 13000], bl
; сохранение Превентивный контрудар	 
	  invoke SendDlgItemMessage, hWin, ID_FIRST_ATTACK, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 80000], al  
; сохранение свойства при атаке №1
	  invoke SendDlgItemMessage, hWin, ID_MAGIC1, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 51000], al
; сохранение свойства при атаке №2
	  invoke SendDlgItemMessage, hWin, ID_MAGIC2, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 52000], al
; сохранение маг. свойств №1
	  invoke SendDlgItemMessage, hWin, ID_MAGIC3, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 53000], al
; сохранение маг. свойств №2
	  invoke SendDlgItemMessage, hWin, ID_MAGIC4, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 54000], al
; сохранение маг. свойств №3
	  invoke SendDlgItemMessage, hWin, ID_MAGIC5, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 55000], al	  
; сохранение заклинаний
	  invoke SendDlgItemMessage, hWin, ID_SPELL, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 59000], al	
; сохранение ненавистей
	  invoke SendDlgItemMessage, hWin, ID_HATE, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 60000], al
; сохранение иммунитет
	  invoke SendDlgItemMessage, hWin, ID_IMMUN, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 56000], al
; сохранение гномьего сопротивления
	  invoke GetDlgItemInt,hWin, ID_RES_GNOM, NULL,FALSE
	  mov [esi + edi + 57000], al
; сохранение големного сопротивления
	  invoke SendDlgItemMessage, hWin, ID_RES_GOLEM, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 58000], al
; сохранение + Морали	  
	  invoke SendDlgItemMessage, hWin, ID_ALWAYS_MORAL, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 28000], al 	  
; сохранение + Удачи	  
	  invoke SendDlgItemMessage, hWin, ID_ALWAYS_LUCK, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 29000], al 
; сохранение страха	  
	  invoke SendDlgItemMessage, hWin, ID_FEAR, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 35000], al
; сохранение бесстрашия	  
	  invoke SendDlgItemMessage, hWin, ID_FEARLESS, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 36000], al	  
; сохранение кавал. бонуса	  
	  invoke SendDlgItemMessage, hWin, ID_CAVA_BONUS, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 61000], al
; сохранение иммунитета к кавал. бонусу  
	  invoke SendDlgItemMessage, hWin, ID_IMMUN_CAVA, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 62000], al	  
; сохранение маг ауры 
	  invoke SendDlgItemMessage, hWin, ID_MAGIC_AURA, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 38000], al
; сохранение Шпионажа 
	  invoke SendDlgItemMessage, hWin, ID_ESPIONAGE, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 34000], al
; сохранение огненного Щита 
	  invoke SendDlgItemMessage, hWin, ID_FIRESHIELD, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 39000], al	
; сохранение Волшебное зеркало	  
	  invoke SendDlgItemMessage, hWin, ID_MAGIC_MIRROR, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 72000], al	  
; сохранение Магический Канал
	  invoke SendDlgItemMessage, hWin, ID_MAGIC_CHANNEL, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 71000], al
; сохранение Атака 3-мя головами	  
	  invoke SendDlgItemMessage, hWin, ID_THREEHEAD, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 68000], al
; сохранение смертельного удара
	  invoke GetDlgItemInt,hWin, ID_DEATH_STRIKE, NULL,FALSE
	  mov [esi + edi + 32000], al
; сохранение регенерации %
	  invoke GetDlgItemInt,hWin, ID_REGEN_PERCENT, NULL,FALSE
	  mov [esi + edi + 67000], al
; сохранение регенерации n
	  invoke GetDlgItemInt,hWin, ID_REGEN_NUMBER, NULL,FALSE
	  mov [esi + edi * 4 + 63000], eax
; сохранение снижения защиты	  
	  invoke GetDlgItemInt,hWin, ID_REDUCE_TARGET_DEFENCE, NULL,FALSE
	  mov [esi + edi + 75000], al 	  
; сохранение - маны	  
	  invoke GetDlgItemInt,hWin, ID_MANA_MINUS, NULL,FALSE
	  mov [esi + edi + FIVE_PARAM + 14000], al
; сохранение + маны	  
	  invoke GetDlgItemInt,hWin, ID_MANA_PLUS, NULL,FALSE
	  mov [esi + edi + FIVE_PARAM + 15000], al
; сохранение кража маны	  
	  invoke GetDlgItemInt,hWin, ID_MANA_DRAIN, NULL,FALSE
	  mov [esi + edi*2 + 69000], ax
; сохранение Возрождения
	  invoke SendDlgItemMessage, hWin, ID_REBIRTH, CB_GETCURSEL, 0 ,0
	  mov [esi + edi + 76000], al
; сохранение атаки стаей	  
	  invoke GetDlgItemInt,hWin, ID_FLIGHT_ATTACK, NULL,TRUE
	  mov [esi + edi + 77000], al
; сохранение Атака всех, мимо кого проносится
	  invoke GetDlgItemInt,hWin, ID_AROUND1, NULL,TRUE
	  mov [esi + edi + 78000], al
; сохранение Атака всех проносящихся мимо
	  invoke GetDlgItemInt,hWin, ID_AROUND2, NULL,TRUE
	  mov [esi + edi + 79000], al
; сохранение запрета генерации	  
	  invoke SendDlgItemMessage, hWin, ID_RANDOM_GENERATION, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 83000], al
; сохранение Оглушения
	  invoke GetDlgItemInt, hWin, ID_DEAFEN, NULL,TRUE
	  mov [esi + edi + 84000], al	
; сохранение запрета генерации	  
	  invoke SendDlgItemMessage, hWin, ID_RANDOM_GENERATION, BM_GETCHECK, 0 ,0
	  mov [esi + edi + 83000], al
; сохранение данных таблицы монстров (начиная с цены в дереве)
	  push esi
	  imul eax, edi, 84
	  lea esi, [eax+esi+85000]
	  xor ebx, ebx; счётчик ресурсов (ID - на смещении)
@@:	  
	  lea ecx, [ebx + ID_COST_WOOD]
	  invoke GetDlgItemInt, hWin, ecx, NULL,TRUE
	  mov [ebx*4+esi], eax	  
	  inc ebx
	  cmp ebx, 21
	  jl @b
	  pop esi
; Сохранение таблицы Cranim
; Upper-right Missile Offset, Right Missile Offset, Lower-right Missile Offset
	  push esi
	  imul eax, edi, 84
	  lea esi, [eax+esi+169000]
	  xor ebx, ebx
@@:
	  lea ecx, [ebx + ID_URMOX]
	  invoke GetDlgItemInt, hWin, ecx, NULL,TRUE
	  mov [ebx*2+esi], eax
	  inc ebx
	  cmp ebx, 6
	  jl @b
; Missile Frame Angles
@@:
	  lea ecx, [ebx+ID_Missile_Frame_Angles-6]
	  invoke GetDlgItemText, hWin, ecx, ADDR buffer,64; получить текст кол-ва
	  mov eax, a2r4(addr buffer)
	  mov eax, [eax]; получить число в integer 
	  lea ecx, [ebx-6]
	  mov [ecx*4+esi+12], eax
	  inc ebx
	  cmp ebx, 18
	  jl @b	
; Troop Count Location Offset
	  invoke GetDlgItemInt, hWin, ID_Troop_Count_Location_Offset, NULL,TRUE
	  mov [esi+60], eax	  
; Attack Climax Frame
	  invoke GetDlgItemInt, hWin, ID_Attack_Climax_Frame, NULL,TRUE
	  mov [esi+64], eax		
; Time between fidgets		
	  invoke GetDlgItemText, hWin, ID_Time_between_fidgets, ADDR buffer,64; получить текст кол-ва
	  mov eax, a2r4(addr buffer)
	  movss xmm[0], [eax]
	  mulss xmm[0], float9000
	  cvttss2si eax, xmm[0]	
	  mov [esi+68], eax
; Walk Animation Time
	  invoke GetDlgItemText, hWin, ID_Walk_Animation_Time, ADDR buffer,64; получить текст кол-ва
	  mov eax, a2r4(addr buffer)
	  movss xmm[0], [eax]
	  mulss xmm[0], float500
	  cvttss2si eax, xmm[0]	
	  mov [esi+72], eax		
; Attack Animation Time
	  invoke GetDlgItemText, hWin, ID_Attack_Animation_Time, ADDR buffer,64; получить текст кол-ва
	  mov eax, a2r4(addr buffer)
	  movss xmm[0], [eax]
	  mulss xmm[0], float500
	  cvttss2si eax, xmm[0]	
	  mov [esi+76], eax
; Flight Animation Distance
	  invoke GetDlgItemText, hWin, ID_Flight_Animation_Distance, ADDR buffer,64; получить текст кол-ва
	  mov eax, a2r4(addr buffer)
	  movss xmm[0], [eax]
	  mulss xmm[0], float115
	  cvttss2si eax, xmm[0]	
	  mov [esi+80], eax			  
	  pop esi
; Сохранение защиты от стрел	  
	  invoke GetDlgItemInt,hWin, ID_SHOOTPROT, NULL,TRUE
	  mov [esi + edi + 253000], al	  
; СОХРАНЕНИЕ БУФЕРА В ФАЙЛ	  
	  mov eax, OutputFile(addr BinFile,esi,File_Size);
	  free esi; free the memory
; Загрузка файла снарядов:
	  mov esi, InputFile(addr AmmoFile)   ; load file into memory
; Сохранение Снаряда:	
	  mov eax, edi
	  shl eax, 4; умножить на 16	
	  add eax, esi
	  invoke GetDlgItemText,hWin,ID_ARROW,eax,16; получить текст дефа в диалоге
; СОХРАНЕНИЕ БУФЕРА В ФАЙЛ	  
	  mov eax, OutputFile(addr AmmoFile,esi,16000);
	  free esi; free the memory
; Сохранение наложенных заклинаний:
	  mov esi, InputFile(addr ImposedSpellsFile)   ; load file into memory
	  imul eax, edi, 6
	  lea ebx, [eax+esi]
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_1, CB_GETCURSEL, 0 ,0
	  dec eax
	  mov [ebx], al
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_2, CB_GETCURSEL, 0 ,0
	  dec eax
	  mov [ebx+1], al
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_3, CB_GETCURSEL, 0 ,0
	  dec eax
	  mov [ebx+2], al
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_1_lvl, CB_GETCURSEL, 0 ,0
	  mov [ebx+3], al
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_2_lvl, CB_GETCURSEL, 0 ,0
	  mov [ebx+4], al
	  invoke SendDlgItemMessage, hWin, ID_IMPOSED_SPELL_3_lvl, CB_GETCURSEL, 0 ,0
	  mov [ebx+5], al
; СОХРАНЕНИЕ БУФЕРА В ФАЙЛ	  
	  mov eax, OutputFile(addr ImposedSpellsFile,esi,6000);
	  free esi; free the memory
; сохранение Огненной стены
	  mov esi, InputFile(addr FirewallFile)   ; load file into memory
	  invoke SendDlgItemMessage, hWin, ID_FIREWALL, BM_GETCHECK, 0,0
          mov edx, edi
          mov ecx, edx
          and edx, 1Fh
          shr ecx, 5
	.IF al == 1  
          bts [esi+ecx*4], edx 
	.ELSE
          btr [esi+ecx*4], edx 
	.ENDIF
; СОХРАНЕНИЕ БУФЕРА В ФАЙЛ	  
	  mov eax, OutputFile(addr FirewallFile,esi,125);
	  free esi; free the memory
; сохранение демонологии
	  mov esi, InputFile(addr DemonologyFile)   ; load file into memory
	  dec rv (SendDlgItemMessage, hWin, ID_DEMONOLOGY, CB_GETCURSEL, 0, 0)
	  mov [esi + edi * 2], ax  
	  mov eax, OutputFile(addr DemonologyFile,esi,2000);
	  free esi; free the memory
; сохранение Блока:
	  mov esi, InputFile(addr BlockFile)   ; load file into memory
	  invoke GetDlgItemInt,hWin, ID_BLOCK_DAMAGE, NULL,TRUE
	  mov [esi + edi], al
	  mov eax, OutputFile(addr BlockFile,esi,1000);
	  free esi; free the memory	  
; сохранение бонуса обороны
	  mov esi, InputFile(addr DefenseBonusFile)   ; load file into memory
	  invoke GetDlgItemInt,hWin, ID_DEFENSEBONUS, NULL,TRUE
	  mov [esi + edi], al	  
	  mov eax, OutputFile(addr DefenseBonusFile,esi,1000);
	  free esi; free the memory
; Пересохраняем все имена в текстовый файл	  
	  mov esi, alloc(1000000)
	  movsx ebx, byte ptr [InputFile(addr Lang)];
	  push ebx
	  free eax
	  mov rpos, 0
	  mov pMem, 0;-2; коррекция размера файла, а то выйдет отступ в конце, что приведёт к лишнему монстру
	  mov ebx, InputFile(dword ptr ds:[ebx*4+case_Monsters])   ; load file into memory
	  mov eax, linein$(ebx,ADDR buffer,0); первая строка для апгрейда ("Нет" или "No")	  
	  mov rpos, lineout$(ADDR buffer,esi,rpos,0); первая строка для апгрейда ("Нет" или "No")
	  add pMem, ecx	  
	  free ebx	
	  xor ebx, ebx; счётчик item-ов
@@:	  
	.if ebx == edi  
	  invoke GetDlgItemText,hWin, ID_MONSTER_COMBOX, ADDR buffer,64
	.else
	  fn SendDlgItemMessage, hWin, ID_MONSTER_COMBOX, CB_GETLBTEXT, ebx, addr buffer
	  cmp eax, CB_ERR
	  je @f
	.endif	  	  
	  mov rpos, lineout$(addr buffer,esi,rpos,0)
	  add pMem, ecx
	  inc ebx
	  jmp @b
@@:
	  pop ebx
	  mov eax, OutputFile(dword ptr ds:[ebx*4+case_Monsters], esi, pMem)
; Пересохраняем все множественные имена в текстовый файл	  
	  push ebx
	  mov rpos, 0; начальная позииция в файле-сорце
	  mov pMem, 0; кол-во записанных байт в блоке назначения
	  mov ebx, InputFile(dword ptr ds:[ebx*4+case_Plural])   ; load file into memory
	  mov Counter, 0; счётчик	
	  mov Counter1, 0	  
	  invoke lfcnt,ebx
	  mov Counter2, eax
@@:	 
	  mov rpos, linein$(ebx,ADDR buffer,rpos); первая строка для апгрейда ("Нет" или "No")
	.if Counter == edi
	  invoke GetDlgItemText,hWin, ID_PLURAL, ADDR buffer,64; получить текст кол-ва
	.endif 
	  mov Counter1, lineout$(ADDR buffer,esi,Counter1,0); первая строка для апгрейда ("Нет" или "No")
	  add pMem, ecx	  
	  inc Counter
	  mov eax, Counter
	  cmp eax, Counter2
	  jl @b
	  free ebx
	  pop ebx
	  mov eax, OutputFile(dword ptr ds:[ebx*4+case_Plural], esi, pMem) 	  
; Пересохраняем все описания в текстовый файл 
	  push ebx
	  mov rpos, 0; начальная позииция в файле-сорце
	  mov pMem, 0; кол-во записанных байт в блоке назначения
	  mov ebx, InputFile(dword ptr ds:[ebx*4+case_Ability])   ; load file into memory
	  mov Counter, 0; счётчик	
	  mov Counter1, 0	  
	  invoke lfcnt,ebx
	  mov Counter2, eax
@@:	 
	  mov rpos, linein$(ebx,ADDR buffer,rpos)
	.if Counter == edi
	  invoke GetDlgItemText,hWin, ID_DESCRIPTION, ADDR buffer,1000; получить текст кол-ва
	.endif	
	  mov Counter1, lineout$(ADDR buffer,esi,Counter1,0)
	  add pMem, ecx	  
	  inc Counter
	  mov eax, Counter
	  cmp eax, Counter2
	  jl @b
	  free ebx
	  pop ebx
	  mov eax, OutputFile(dword ptr ds:[ebx*4+case_Ability], esi, pMem)	  
	  free esi	  	  
	  fn Change_Lang, hWin
	  fn SendDlgItemMessage, hWin, ID_MONSTER_COMBOX, CB_SETCURSEL, edi, 0
	  	  
	  case ID_MONSTER_COMBOX or DT_MODIFYSTRING; изменение в комбобоксе	 
	  mov Positio, rv(SendDlgItemMessage, hWin, ID_MONSTER_COMBOX, CB_GETCURSEL, 0, 0)
	  invoke Setup_Monster_attributes, eax, hWin

	  case ID_LANG_ENG, ID_LANG_RUS
	  mov ebx, InputFile(addr Lang) ; загрузить 3-байтовый файл в память
	  invoke SendDlgItemMessage, hWin, ID_LANG_RUS, BM_GETCHECK,0,0;	  
	  mov byte ptr ds:[ebx], al		  
	  mov eax, OutputFile(addr Lang, ebx, Lang_File_Size); сохранить файл 
	  free ebx
	  fn Change_Lang, hWin
	  
	  case ID_COPY
	  mov _Copy, 1
	  fn Copy_states, Positio, hWin
	  	  	  
	  case ID_PASTE
	.IF _Copy == 1  
	  fn Paste_states, Positio, hWin
	.ENDIF

	  case ID_PASTE_CRANIM
	.IF _Copy == 1  
	  fn Paste_CrAnim, hWin
	.ENDIF	
	endsw	
endsw
return 0

DlgProc endp

start:
	  push ebp
	  mov ebp, esp
	  sub esp, 68h	  
	  mov dword ptr ds:[ebp-3Ch], 10h
	  mov ebx, rv(GetModuleHandle,NULL)
	  lea eax, [ebp-38h]
	  invoke GetClassInfoEx, 0, addr AEdit, eax
	  mov eax, [ebp-30h]
	  mov MoPEdit, eax
	  mov dword ptr [ebp-30h], NewEditProc
	  mov dword ptr [ebp-10h], offset NewEdit
	  mov [ebp-24h], ebx
	  mov dword ptr [EBP-38h], 30h
	  lea eax, [ebp-38h]
	  invoke RegisterClassEx, eax
  
      invoke InitCommonControlsEx,ADDR icex
      invoke ExitProcess, rv(DialogBoxParam,ebx,37,0,ADDR DlgProc,0)
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««
end start				