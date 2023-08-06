.data?
	  _Copy						db ?; ���� �� �����������	  
; ����� �����������	  
	  Copy_DEF					db 16 dup (?); ����� ����
	  Copy_WAV					db 05 dup (?); ����� �������
	  Copy_ammo					db 16 dup (?); ����� �������
	  Copy_Flags				db 32 dup (?); ����� ������
	  Copy_Level				db 02 dup (?); ����� ������
	  Copy_Town					dd ?
	  Copy_Upgrade				dd ?
	  Copy_Transformer			dd ?
	  Copy_Countre_strikes		dd ?
	  Copy_Cloud				dd ?
	  Copy_Ray					dd ?
	  Copy_Catapult				dd ?
	  Copy_No_Wall_Penalty		dd ?
	  Copy_ShootingAdjacent		dd ?
	  Copy_Sniper				dd ?
	  Copy_Answer_back_Shooting	dd ?
	  Copy_Strike_Return		dd ?
	  Copy_First_Attack			dd ?
	  Copy_Magic1				dd ?
	  Copy_Magic2				dd ?
	  Copy_Magic3				dd ?
	  Copy_Magic4				dd ?
	  Copy_Magic5				dd ?
	  Copy_Spell				dd ?
	  Copy_Hate					dd ?
	  Copy_Immun				dd ?
	  Copy_Res_Gnom				dd ?
	  Copy_Res_Golem			dd ?
	  Copy_Always_Moral			dd 12 dup (?); �� 3-������� �����
	  Copy_Death_Strike			dd ?
	  Copy_Regen_Percent		dd ?
	  Copy_Regen_HP				db 10 dup (?); 9 �������� 
	  Copy_Reduce_Defence		dd ?
	  Copy_Mana_Plus			dd ?
	  Copy_Mana_Minus			dd ?
	  Copy_Mana_Drain			db 6 dup (?)
	  Copy_Rebirth				dd ?
	  Copy_Pack_Attack			dd ?
	  Copy_Around1				dd ?
	  Copy_Around2				dd ?
	  Copy_Random_Generation	dd ?
	  Copy_Stun					dd ?
	  Copy_Shoot_Protect dd ?
	  Copy_Main_Param			dd 21 dup (?)  
	  Copy_Cr_Anim				dd 24*2 dup (?); ����� ���������� ��������	  
	  Copy_Name					db 64 dup (?); ����� ����� 
	  Copy_Plural				db 64 dup (?); ����� �������������� �����
	  Copy_Description			db 512 dup (?); ����� ��������
	  Copy_IMPOSED_SPELL_1			dd ?
	  Copy_IMPOSED_SPELL_2				dd ?
	  Copy_IMPOSED_SPELL_3			dd ?
	  Copy_IMPOSED_SPELL_1_lvl		dd ?
	  Copy_IMPOSED_SPELL_2_lvl		dd ?
	  Copy_IMPOSED_SPELL_3_lvl		dd ?
	  Copy_DEFENSEBONUS		dd ?
	  Copy_FIREWALL		dd ?
	  Copy_Demonology		dd ?
	  Copy_Block	dd ?
.code
Copy_states proc Monster, hWnd
	push ebx
; ���	
	invoke GetDlgItemText,hWnd,ID_DEF,offset Copy_DEF,16
; ������
	invoke GetDlgItemText,hWnd,ID_ARROW,offset Copy_ammo,16
; �������
	invoke GetDlgItemText,hWnd,ID_WAV,offset Copy_WAV,5	
; �����
	mov ebx, ID_FLAGS;
Loop_flags:	
	invoke SendDlgItemMessage,hWnd,ebx,BM_GETCHECK,0,0
	mov [Copy_Flags+ebx-ID_FLAGS], al
	inc ebx
	cmp ebx, 2050
	jle Loop_flags
; �������
	invoke GetDlgItemText, hWnd, ID_LEVEL, offset Copy_Level, 2
; �����
	mov ebx, ID_TOWN
Loop_towns:  
	invoke SendDlgItemMessage, hWnd, ebx, BM_GETCHECK,0,0;
	test al, al
	je not_town
	mov [Copy_Town], ebx
	jmp end_towns
not_town:	  
	inc ebx
	cmp ebx, ID_TOWN+9
	jle Loop_towns
end_towns:
; �������
	mov Copy_Upgrade, rv (SendDlgItemMessage, hWnd, ID_UPGRADE, CB_GETCURSEL, 0, 0)
; �������������
	mov Copy_Transformer, rv (SendDlgItemMessage, hWnd, ID_TRANSFORMATOR, CB_GETCURSEL, 0, 0)
; ����������
	invoke GetDlgItemText,hWnd, ID_COUNTRE_STRIKES, offset Copy_Countre_strikes, 4
; ����������� ��������
	mov Copy_Cloud, rv (SendDlgItemMessage, hWnd, ID_CLOUD, CB_GETCURSEL, 0, 0)
; ���� ����
	mov Copy_Ray, rv (SendDlgItemMessage, hWnd, ID_RAY, CB_GETCURSEL, 0, 0)
; ����������
	mov Copy_Catapult, rv (SendDlgItemMessage, hWnd, ID_CATAPULT, CB_GETCURSEL, 0, 0)
; ���������� ������ �������
	mov Copy_No_Wall_Penalty, rv (SendDlgItemMessage, hWnd, ID_NO_WALL_PENALTY, BM_GETCHECK, 0,0)
; �������� ��������
	mov Copy_ShootingAdjacent, rv (SendDlgItemMessage, hWnd, ID_ShootingAdjacent, BM_GETCHECK, 0,0)
; �����������
	mov Copy_Sniper, rv (SendDlgItemMessage, hWnd, ID_SNIPER, BM_GETCHECK, 0,0)
; �������� �������	
	mov Copy_Answer_back_Shooting, rv (SendDlgItemMessage, hWnd, ID_Answer_back_Shooting, BM_GETCHECK, 0,0)
; ����� � ������������
	mov Copy_Strike_Return, rv (SendDlgItemMessage, hWnd, ID_STRIKE_RETURN, BM_GETCHECK, 0,0)
; ������������ ���������	
	mov Copy_First_Attack, rv (SendDlgItemMessage, hWnd, ID_FIRST_ATTACK, BM_GETCHECK, 0,0)	
; �������� ��� ����� �1	
	mov Copy_Magic1, rv (SendDlgItemMessage, hWnd, ID_MAGIC1, CB_GETCURSEL, 0,0)	
; �������� ��� ����� �2	
	mov Copy_Magic2, rv (SendDlgItemMessage, hWnd, ID_MAGIC2, CB_GETCURSEL, 0,0)
; ���. �������� �1	
	mov Copy_Magic3, rv (SendDlgItemMessage, hWnd, ID_MAGIC3, CB_GETCURSEL, 0,0)	
; ���. �������� �2
	mov Copy_Magic4, rv (SendDlgItemMessage, hWnd, ID_MAGIC4, CB_GETCURSEL, 0,0)	
; ���. �������� �3
	mov Copy_Magic5, rv (SendDlgItemMessage, hWnd, ID_MAGIC5, CB_GETCURSEL, 0,0)
; ����������
	mov Copy_Spell, rv (SendDlgItemMessage, hWnd, ID_SPELL, CB_GETCURSEL, 0,0)
; ���������
	mov Copy_Hate, rv (SendDlgItemMessage, hWnd, ID_HATE, CB_GETCURSEL, 0,0)
; ���������
	mov Copy_Immun, rv (SendDlgItemMessage, hWnd, ID_IMMUN, CB_GETCURSEL, 0,0)
; ������ �������������	
	invoke GetDlgItemText,hWnd, ID_RES_GNOM,offset Copy_Res_Gnom,4; �������� ����� ���-��
; �������� �������������
	mov Copy_Res_Golem, rv (SendDlgItemMessage, hWnd, ID_RES_GOLEM, CB_GETCURSEL, 0,0)
; + ������ � ������ �� 3-������� �����
	mov ebx, ID_ALWAYS_MORAL
Loop_Luck:
	mov dword ptr ds:[ebx*4-(ID_ALWAYS_MORAL*4)+offset Copy_Always_Moral], rv (SendDlgItemMessage, hWnd, ebx, BM_GETCHECK, 0,0)	
	inc ebx
	cmp ebx, ID_THREEHEAD
	jle Loop_Luck
; ����������� ����	
	invoke GetDlgItemText,hWnd, ID_DEATH_STRIKE, offset Copy_Death_Strike,4; �������� ����� ���-��
; ����������� %
	invoke GetDlgItemText,hWnd, ID_REGEN_PERCENT, offset Copy_Regen_Percent,4; �������� ����� ���-��
; ����������� HP
	invoke GetDlgItemText,hWnd, ID_REGEN_NUMBER, offset Copy_Regen_HP,10; �������� ����� ���-��
; �������� ������ ����
	invoke GetDlgItemText,hWnd, ID_REDUCE_TARGET_DEFENCE, offset Copy_Reduce_Defence,4; �������� ����� ���-��	
; ���� +
	invoke GetDlgItemText,hWnd, ID_MANA_PLUS, offset Copy_Mana_Plus,4; �������� ����� ���-��
; ���� -
	invoke GetDlgItemText,hWnd, ID_MANA_MINUS, offset Copy_Mana_Minus,4; �������� ����� ���-��
; ����� ����
	invoke GetDlgItemText,hWnd, ID_MANA_DRAIN, offset Copy_Mana_Drain,6; �������� ����� ���-��
; �����������
	mov Copy_Rebirth, rv (SendDlgItemMessage, hWnd, ID_REBIRTH, CB_GETCURSEL, 0,0)
; ����� �����
	invoke GetDlgItemText,hWnd, ID_FLIGHT_ATTACK, offset Copy_Pack_Attack,4; �������� ����� ���-��
; ����� ����, ���� ���� ����������
	invoke GetDlgItemText,hWnd, ID_AROUND1, offset Copy_Around1,4; �������� ����� ���-��	
; ����� ���� ������������ ����	
	invoke GetDlgItemText,hWnd, ID_AROUND2, offset Copy_Around2,4; �������� ����� ���-��		
; ������ ���������
	mov Copy_Random_Generation, rv (SendDlgItemMessage, hWnd, ID_RANDOM_GENERATION, BM_GETCHECK, 0,0)
; ���������	
	invoke GetDlgItemText,hWnd, ID_DEAFEN, offset Copy_Stun,4; �������� ����� ���-��	
; ������ �� �����
        invoke GetDlgItemText,hWnd, ID_SHOOTPROT, offset Copy_Shoot_Protect,4; �������� ����� ���-��
; ���������� ����������
	mov Copy_IMPOSED_SPELL_1, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_1, CB_GETCURSEL, 0,0)
	mov Copy_IMPOSED_SPELL_2, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_2, CB_GETCURSEL, 0,0)
	mov Copy_IMPOSED_SPELL_3, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_3, CB_GETCURSEL, 0,0)
	mov Copy_IMPOSED_SPELL_1_lvl, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_1_lvl, CB_GETCURSEL, 0,0)
	mov Copy_IMPOSED_SPELL_2_lvl, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_2_lvl, CB_GETCURSEL, 0,0)
	mov Copy_IMPOSED_SPELL_3_lvl, rv (SendDlgItemMessage, hWnd, ID_IMPOSED_SPELL_3_lvl, CB_GETCURSEL, 0,0)
; �������� �����
	mov Copy_FIREWALL, rv (SendDlgItemMessage, hWnd, ID_FIREWALL, BM_GETCHECK, 0,0)
; ����� �������
        invoke GetDlgItemText,hWnd, ID_DEFENSEBONUS, offset Copy_DEFENSEBONUS,4; �������� ����� ���-��
; �����������
	mov Copy_Demonology, rv (SendDlgItemMessage, hWnd, ID_DEMONOLOGY, CB_GETCURSEL, 0, 0)
; ����	
	invoke GetDlgItemText,hWnd, ID_BLOCK_DAMAGE, offset Copy_Block,4; �������� ����� ���-��
; ��������� �������� (������� � ���� � ������)
	mov ebx, ID_COST_WOOD
Loop_param:
	mov dword ptr ds:[ebx*4-(ID_COST_WOOD*4)+Copy_Main_Param], rv (GetDlgItemInt, hWnd, ebx, NULL, FALSE)
	inc ebx
	cmp ebx, ID_COST_WOOD+21
	jl Loop_param	
; �rAnim	
	push hWnd 
	call Copy_CrAnim;,hWnd	
; ���
	invoke GetDlgItemText,hWnd, ID_MONSTER_COMBOX, offset Copy_Name,64
; ������������� �����
	invoke GetDlgItemText,hWnd, ID_PLURAL, offset Copy_Plural,64
; ��������
	invoke GetDlgItemText,hWnd, ID_DESCRIPTION, offset Copy_Description,512		
	pop ebx	
	ret
Copy_states endp	

Copy_CrAnim proc hWnd
	push ebx
	mov ebx, ID_URMOX
; Upper-right Missile Offset, Right Missile Offset, Lower-right Missile Offset	
@@:
	lea ecx, [ebx*8-(ID_URMOX*8)+Copy_Cr_Anim]
	invoke GetDlgItemText, hWnd, ebx, ecx,64	
	inc ebx
	cmp ebx, ID_LRMOY+1
	jl @b
; Missile Frame Angles
	mov ebx, ID_Missile_Frame_Angles
@@:
	lea ecx, [ebx*8-(ID_Missile_Frame_Angles*8)+Copy_Cr_Anim+(6*8)]
	invoke GetDlgItemText, hWnd, ebx, ecx, 64
	inc ebx
	cmp ebx, ID_Flight_Animation_Distance+1
	jl @b	
	  
	pop ebx
	ret
Copy_CrAnim endp