.code
Paste_states proc Monster, hWnd
	push ebx
; Деф
	invoke SetDlgItemText, hWnd, ID_DEF, offset Copy_DEF
; Снаряд
	invoke SetDlgItemText, hWnd, ID_ARROW, offset Copy_ammo
; Озвучка
	invoke SetDlgItemText, hWnd, ID_WAV, offset Copy_WAV	
; Флаги
	mov ebx, ID_FLAGS;
Loop_flags:	
	movsx eax, [Copy_Flags+ebx-ID_FLAGS] 
	invoke SendDlgItemMessage,hWnd,ebx,BM_SETCHECK,eax,0
	inc ebx
	cmp ebx, 2050
	jle Loop_flags	
	pop ebx
; Уровень
	invoke SetDlgItemText, hWnd, ID_LEVEL, offset Copy_Level
; Город
	invoke CheckRadioButton, hWnd, ID_TOWN, ID_TOWN+9, Copy_Town
; Апгрейд
	invoke SendDlgItemMessage,hWnd,ID_UPGRADE,CB_SETCURSEL,Copy_Upgrade,0
; Трансформатор
	invoke SendDlgItemMessage,hWnd,ID_TRANSFORMATOR,CB_SETCURSEL,Copy_Transformer,0
; Контрудары	
	invoke SendDlgItemMessage,hWnd,ID_COUNTRE_STRIKES,WM_SETTEXT,0,offset Copy_Countre_strikes
; Расширенная стрельба
	invoke SendDlgItemMessage,hWnd,ID_CLOUD,CB_SETCURSEL,Copy_Cloud,0
; Цвет луча
	invoke SendDlgItemMessage,hWnd,ID_RAY,CB_SETCURSEL,Copy_Ray,0
; Артиллерия
	invoke SendDlgItemMessage,hWnd,ID_CATAPULT,CB_SETCURSEL,Copy_Catapult,0
; Отсутствие штрафа преград	
	invoke SendDlgItemMessage, hWnd, ID_NO_WALL_PENALTY, BM_SETCHECK, Copy_No_Wall_Penalty,0
; Стрельба вплотную
	invoke SendDlgItemMessage, hWnd, ID_ShootingAdjacent, BM_SETCHECK, Copy_ShootingAdjacent,0	
; Снайперство
	invoke SendDlgItemMessage, hWnd, ID_SNIPER, BM_SETCHECK, Copy_Sniper,0
; Ответный выстрел
	invoke SendDlgItemMessage, hWnd, ID_Answer_back_Shooting, BM_SETCHECK, Copy_Answer_back_Shooting,0
; Атака с возвращением
	invoke SendDlgItemMessage, hWnd, ID_STRIKE_RETURN, BM_SETCHECK, Copy_Strike_Return,0
; Превентивный контрудар
	invoke SendDlgItemMessage, hWnd, ID_FIRST_ATTACK, BM_SETCHECK, Copy_First_Attack,0
; свойства при атаке №1		
	invoke SendDlgItemMessage,hWnd,ID_MAGIC1,CB_SETCURSEL,Copy_Magic1,0
; свойства при атаке №2		
	invoke SendDlgItemMessage,hWnd,ID_MAGIC2,CB_SETCURSEL,Copy_Magic2,0	
; маг. свойства №1		
	invoke SendDlgItemMessage,hWnd,ID_MAGIC3,CB_SETCURSEL,Copy_Magic3,0
; маг. свойства №2		
	invoke SendDlgItemMessage,hWnd,ID_MAGIC4,CB_SETCURSEL,Copy_Magic4,0	
; маг. свойства №3	
	invoke SendDlgItemMessage,hWnd,ID_MAGIC5,CB_SETCURSEL,Copy_Magic5,0	
; заклинание
	invoke SendDlgItemMessage,hWnd,ID_SPELL,CB_SETCURSEL,Copy_Spell,0
; Ненависть
	invoke SendDlgItemMessage,hWnd,ID_HATE,CB_SETCURSEL,Copy_Hate,0
; Иммунитет
	invoke SendDlgItemMessage,hWnd,ID_IMMUN,CB_SETCURSEL,Copy_Immun,0
; гномье сопротивление
	invoke SetDlgItemText, hWnd, ID_RES_GNOM, offset Copy_Res_Gnom
; големное сопротивление
	invoke SendDlgItemMessage, hWnd, ID_RES_GOLEM, CB_SETCURSEL, Copy_Res_Golem, 0	
; + Мораль и другие до 3-головой атаки
	mov ebx, ID_ALWAYS_MORAL
Loop_Luck:
	invoke SendDlgItemMessage, hWnd, ebx, BM_SETCHECK, dword ptr ds:[ebx*4-(ID_ALWAYS_MORAL*4)+offset Copy_Always_Moral],0
	inc ebx
	cmp ebx, ID_THREEHEAD
	jle Loop_Luck	
; Смертельный Удар
	invoke SetDlgItemText, hWnd, ID_DEATH_STRIKE, offset Copy_Death_Strike
; Регенерация %
	invoke SetDlgItemText, hWnd, ID_REGEN_PERCENT, offset Copy_Regen_Percent
; Регенерация HP
	invoke SetDlgItemText, hWnd, ID_REGEN_NUMBER, offset Copy_Regen_HP
; снижение защиты цели
	invoke SetDlgItemText, hWnd, ID_REDUCE_TARGET_DEFENCE, offset Copy_Reduce_Defence
; Мана +
	invoke SetDlgItemText, hWnd, ID_MANA_PLUS, offset Copy_Mana_Plus
; Мана -
	invoke SetDlgItemText, hWnd, ID_MANA_MINUS, offset Copy_Mana_Minus
; Кража маны
	invoke SetDlgItemText, hWnd, ID_MANA_DRAIN, offset Copy_Mana_Drain
; Возрождение
	invoke SendDlgItemMessage,hWnd,ID_REBIRTH,CB_SETCURSEL,Copy_Rebirth,0		
; Атака стаей
	invoke SetDlgItemText, hWnd, ID_FLIGHT_ATTACK, offset Copy_Pack_Attack
; Атака всех, мимо кого проносится
	invoke SetDlgItemText, hWnd, ID_AROUND1, offset Copy_Around1	
; Атака всех проносящихся мимо	
	invoke SetDlgItemText, hWnd, ID_AROUND2, offset Copy_Around2		
; Запрет генерации
	invoke SendDlgItemMessage, hWnd, ID_RANDOM_GENERATION, BM_SETCHECK, Copy_Random_Generation,0
; Оглушение	
	invoke SetDlgItemText, hWnd, ID_DEAFEN, offset Copy_Stun
; Защита от стрел
	invoke SetDlgItemText, hWnd, ID_SHOOTPROT, offset Copy_Shoot_Protect
; Наложенные заклинания
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_1,CB_SETCURSEL,Copy_IMPOSED_SPELL_1,0
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_2,CB_SETCURSEL,Copy_IMPOSED_SPELL_2,0
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_3,CB_SETCURSEL,Copy_IMPOSED_SPELL_3,0
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_1_lvl,CB_SETCURSEL,Copy_IMPOSED_SPELL_1_lvl,0
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_2_lvl,CB_SETCURSEL,Copy_IMPOSED_SPELL_2_lvl,0
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_3_lvl,CB_SETCURSEL,Copy_IMPOSED_SPELL_3_lvl,0
; Огненная стена
	invoke SendDlgItemMessage, hWnd, ID_FIREWALL, BM_SETCHECK, Copy_FIREWALL,0
; бонус обороны
	invoke SetDlgItemText, hWnd, ID_DEFENSEBONUS, offset Copy_DEFENSEBONUS
; Демонология
	invoke SendDlgItemMessage,hWnd,ID_DEMONOLOGY,CB_SETCURSEL,Copy_Demonology,0
; Смертельный Удар
	invoke SetDlgItemText, hWnd, ID_BLOCK_DAMAGE, offset Copy_Block
; Параметры монстров (начиная с цены в дереве)	
	mov ebx, ID_COST_WOOD
Loop_param:
	invoke SetDlgItemInt, hWnd, ebx, dword ptr ds:[ebx*4-(ID_COST_WOOD*4)+Copy_Main_Param], FALSE
	inc ebx
	cmp ebx, ID_COST_WOOD+21
	jl Loop_param		
	
; СrAnim
	push hWnd
	call Paste_CrAnim	
; Имя
	invoke SendDlgItemMessage, hWnd, ID_MONSTER_COMBOX, CB_DELETESTRING, Monster,0;
	invoke SendDlgItemMessage, hWnd, ID_MONSTER_COMBOX, CB_INSERTSTRING, Monster,offset Copy_Name;
	fn SendDlgItemMessage,hWnd,ID_MONSTER_COMBOX,CB_SETCURSEL,Monster,0	
; Множественное число 	
	invoke SetDlgItemText, hWnd, ID_PLURAL, offset Copy_Plural
; Описание
	invoke SetDlgItemText, hWnd, ID_DESCRIPTION, offset Copy_Description
; Корректируем все статы по окончании копирования	
	invoke Correct_States, Monster, hWnd
	pop ebx
	ret
Paste_states endp

Paste_CrAnim proc hWnd
	push ebx
; Upper-right Missile Offset, Right Missile Offset, Lower-right Missile Offset	
	mov ebx, ID_URMOX
@@:
	lea ecx, [ebx*8-(ID_URMOX*8)+Copy_Cr_Anim]
	invoke SetDlgItemText, hWnd, ebx, ecx	
	inc ebx
	cmp ebx, ID_LRMOY+1
	jl @b
; Missile Frame Angles
	mov ebx, ID_Missile_Frame_Angles
@@:
	lea ecx, [ebx*8-(ID_Missile_Frame_Angles*8)+Copy_Cr_Anim+(6*8)]
	invoke SetDlgItemText, hWnd, ebx, ecx	
	inc ebx
	cmp ebx, ID_Flight_Animation_Distance+1
	jl @b	
	pop ebx
	ret
Paste_CrAnim endp