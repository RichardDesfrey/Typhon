.code
Setup_Monster_attributes proc Monster, hWnd

LOCAL buffer[1000] :BYTE

	push esi
	push edi
	push ebx
; ����� �������� ��������
	invoke wsprintf, addr buffer, offset MonNumText, Monster
	invoke SendDlgItemMessage, hWnd, 2003, WM_SETTEXT, 0, ADDR buffer;	
	
; ��������� ��������	
	invoke Paint_Proc, Monster,	hWnd	
; ��������� ������ �������		
	mov esi, InputFile(addr BinFile)   ; load file into memory
; ���
	mov eax, Monster	
	shl eax, 4; �������� �� 16	
	lea eax, [esi + eax]
	invoke SendDlgItemMessage, hWnd, ID_DEF, WM_SETTEXT, 0, eax	
; �������
	mov eax, Monster	
	imul eax, 5; �������� �� 5
	lea eax, [esi + eax + 16000]
	invoke SendDlgItemMessage, hWnd, ID_WAV, WM_SETTEXT, 0, eax 	
; �����
	xor ebx, ebx;
Loop_flags:	
	mov eax, Monster
	bt [esi + eax * 4 + 16000 + 5000], ebx
	lea eax, [ebx + ID_FLAGS]
	jnc not_check	
    invoke SendDlgItemMessage, hWnd, eax, BM_SETCHECK, BST_CHECKED ,0;
	jmp check
not_check:
	invoke SendDlgItemMessage, hWnd, eax, BM_SETCHECK, BST_UNCHECKED,0;
check:	
    inc ebx
	cmp ebx, 32
	jl Loop_flags
; �������:
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 16000 + 5000 + 4000]; �������� �������
	inc eax
    invoke SetDlgItemInt,hWnd,ID_LEVEL,eax, TRUE
; �����
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 16000 + 5000 + 4000 + 1000]; �������� �����
	lea eax, [eax + ID_TOWN + 1]
	invoke CheckRadioButton, hWnd, ID_TOWN, ID_TOWN+9, eax
; �������
	mov eax, Monster 
	mov eax, [esi+eax*4+47000]
	inc eax
    invoke SendDlgItemMessage,hWnd,ID_UPGRADE,CB_SETCURSEL,eax,0	
; �������������
	mov eax, Monster
    invoke SendDlgItemMessage,hWnd,ID_TRANSFORMATOR,CB_SETCURSEL,[esi+eax*4+43000],0
; ����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM]; �������� ����������
    invoke SetDlgItemInt,hWnd,ID_COUNTRE_STRIKES,eax,FALSE	
; �������
;	mov eax, Monster
;	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 3000]; �������� ������
;	invoke SendDlgItemMessage,hWnd,ID_ARROW,CB_SETCURSEL,eax,0
; ����������� ��������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 6000]; �������� �����
	invoke SendDlgItemMessage,hWnd,ID_CLOUD,CB_SETCURSEL,eax,0
; ���� ����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 82000]; �������� ������
	invoke SendDlgItemMessage,hWnd,ID_RAY,CB_SETCURSEL,eax,0	
; ����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 4000]; ��������
	invoke SendDlgItemMessage,hWnd,ID_CATAPULT,CB_SETCURSEL,eax,0	
; ��� ������ �������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 10000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_NO_WALL_PENALTY, BM_SETCHECK, eax,0;	
; �������� ��������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 74000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_ShootingAdjacent, BM_SETCHECK, eax,0;
; �����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 73000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_SNIPER, BM_SETCHECK, eax,0
; �������� �������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 81000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_Answer_back_Shooting, BM_SETCHECK, eax,0;
; ����� � ������������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 13000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_STRIKE_RETURN, BM_SETCHECK, eax,0;
; ������������ ���������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 80000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_FIRST_ATTACK, BM_SETCHECK, eax,0;
; �������� ��� ����� �1
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 51000]; ��������
	invoke SendDlgItemMessage,hWnd,ID_MAGIC1,CB_SETCURSEL,eax,0
; �������� ��� ����� �2
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 52000]; ��������
	invoke SendDlgItemMessage,hWnd,ID_MAGIC2,CB_SETCURSEL,eax,0
; ���. �������� �1	
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 53000]; ��������
	invoke SendDlgItemMessage,hWnd,ID_MAGIC3,CB_SETCURSEL,eax,0
; ���. �������� �2
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 54000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_MAGIC4,CB_SETCURSEL,eax,0
; ���. �������� �3
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 55000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_MAGIC5,CB_SETCURSEL,eax,0
; ����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 59000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_SPELL,CB_SETCURSEL,eax,0
; ���������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 60000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_HATE,CB_SETCURSEL,eax,0
; ���������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 56000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_IMMUN,CB_SETCURSEL,eax,0	
; ������������� ����� ������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 57000]; ��������
    invoke SetDlgItemInt,hWnd,ID_RES_GNOM,eax, FALSE
; ������������� ����� �������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 58000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_RES_GOLEM,CB_SETCURSEL,eax,0
; ������ + ������	
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 28000]; ��������	
	invoke SendDlgItemMessage, hWnd,ID_ALWAYS_MORAL, BM_SETCHECK, eax,0;
; ������ + �����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 29000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_ALWAYS_LUCK, BM_SETCHECK, eax,0;	
; �����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 35000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_FEAR, BM_SETCHECK, eax,0;
; ����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 36000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_FEARLESS, BM_SETCHECK, eax,0;
; ������������� �����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 61000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_CAVA_BONUS, BM_SETCHECK, eax,0;
; ��������� � ����� ������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 62000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_IMMUN_CAVA, BM_SETCHECK, eax,0;
; ���������� ����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 38000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_MAGIC_AURA, BM_SETCHECK, eax,0;
; �������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 34000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_ESPIONAGE, BM_SETCHECK, eax,0;
; �������� ���
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 39000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_FIRESHIELD, BM_SETCHECK, eax,0;
; ��������� �������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 72000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_MAGIC_MIRROR, BM_SETCHECK, eax,0;
; ���������� �����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 71000]; ��������	
	invoke SendDlgItemMessage, hWnd, ID_MAGIC_CHANNEL, BM_SETCHECK, eax,0;
; ����� 3-�� ��������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 68000]; ��������	
	invoke SendDlgItemMessage, hWnd,ID_THREEHEAD, BM_SETCHECK, eax, 0
; ����������� ����
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 32000]; ��������
    invoke SetDlgItemInt,hWnd,ID_DEATH_STRIKE,eax, FALSE
; %���� �����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 67000]; ��������
    invoke SetDlgItemInt,hWnd,ID_REGEN_PERCENT,eax, FALSE
; ����������� HP
	mov eax, Monster
    invoke SetDlgItemInt,hWnd,ID_REGEN_NUMBER,[esi + eax * 4 + 63000], FALSE
; �������� ������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 75000]; ��������
    invoke SetDlgItemInt,hWnd,ID_REDUCE_TARGET_DEFENCE,eax,FALSE
; ���� -
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 14000]; ��������
    invoke SetDlgItemInt,hWnd,ID_MANA_MINUS,eax,FALSE
; ���� +	
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + FIVE_PARAM + 15000]; ��������
    invoke SetDlgItemInt,hWnd,ID_MANA_PLUS,eax,FALSE
; ����� ����
	mov eax, Monster
	movzx eax, word ptr [esi + eax * 2 + 69000]; ��������
    invoke SetDlgItemInt,hWnd,ID_MANA_DRAIN,eax,FALSE
; �����������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 76000]; ��������	
	invoke SendDlgItemMessage,hWnd,ID_REBIRTH,CB_SETCURSEL,eax,0
; ����� �����
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 77000]; ��������
    invoke SetDlgItemInt,hWnd,ID_FLIGHT_ATTACK,eax,TRUE
; ����� ����, ���� ���� ����������
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 78000]; ��������	
    invoke SetDlgItemInt,hWnd,ID_AROUND1,eax,TRUE
; ����� ���� ������������ ����
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 79000]; ��������
    invoke SetDlgItemInt,hWnd,ID_AROUND2,eax,TRUE
; ���������
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 84000]; ��������
    invoke SetDlgItemInt,hWnd,ID_DEAFEN,eax,FALSE
; �������� ��� ���������
	mov eax, Monster
	movzx eax, byte ptr [esi + eax + 83000]; ��������
	invoke SendDlgItemMessage, hWnd, ID_RANDOM_GENERATION, BM_SETCHECK, eax,0;
; ��������� ��������� � ������ ���������� ������� ��������
	xor ebx, ebx
	imul edi, Monster, 84
@@:		
	lea ecx, [ebx+ID_COST_WOOD]
    invoke SetDlgItemInt,hWnd,ecx,dword ptr [esi + edi + 85000],FALSE
	add edi, 4
	inc ebx
	cmp ebx, 21
	jl @b
; ��������� CrAnim
; Upper-right Missile Offset, Right Missile Offset, Lower-right Missile Offset
	xor ebx, ebx	
	imul edi, Monster, 84
@@:	
	movsx eax, word ptr [esi + edi + 169000]
	lea ecx, [ebx+ID_URMOX]
	fn SetDlgItemInt,hWnd,ecx,eax,TRUE
	add edi, 2
	inc ebx
	cmp ebx, 6
	jl @b
; Missile Frame Angles
@@:
	mov eax, [esi + edi + 169000]
	mov eax, real4$(eax)
	mov byte ptr ds:[eax+5], 0	
	lea ecx, [ebx+ID_Missile_Frame_Angles-6]
	fn SendDlgItemMessage,hWnd,ecx,WM_SETTEXT,0,eax
	add edi, 4
	inc ebx
	cmp ebx, 18
	jl @b	
; Troop Count Location Offset
	;mov eax, sstr$([esi + edi + 169000])
	fn SetDlgItemInt,hWnd,ID_Troop_Count_Location_Offset,[esi + edi + 169000],FALSE
; Attack Climax Frame
	;mov eax, sstr$([esi + edi + 169000 + 4])
	fn SetDlgItemInt,hWnd,ID_Attack_Climax_Frame,[esi + edi + 169000 + 4],FALSE	
; Time between fidgets		
    cvtsi2ss xmm[0], [esi + edi + 169008]
    divss xmm[0], float9000
	movss [buffer], xmm[0]
	mov eax, dword ptr ds:[buffer]	
	mov eax, real4$(eax)
	mov byte ptr ds:[eax+5], 0
	fn SendDlgItemMessage,hWnd,ID_Time_between_fidgets,WM_SETTEXT,0,eax
; Walk Animation Time
    cvtsi2ss xmm[0], [esi + edi + 169012]
    divss xmm[0], float500
	movss [buffer], xmm[0]
	mov eax, dword ptr ds:[buffer]	
	mov eax, real4$(eax)
	mov byte ptr ds:[eax+5], 0
	fn SendDlgItemMessage,hWnd,ID_Walk_Animation_Time,WM_SETTEXT,0,eax		
; Attack Animation Time
    cvtsi2ss xmm[0], [esi + edi + 169016]
    divss xmm[0], float500
	movss [buffer], xmm[0]
	mov eax, dword ptr ds:[buffer]	
	mov eax, real4$(eax)
	mov byte ptr ds:[eax+5], 0
	fn SendDlgItemMessage,hWnd,ID_Attack_Animation_Time,WM_SETTEXT,0,eax
; Flight Animation Distance
    cvtsi2ss xmm[0], [esi + edi + 169020]
    divss xmm[0], float115
	movss [buffer], xmm[0]
	mov eax, dword ptr ds:[buffer]	
	mov eax, real4$(eax)
	mov byte ptr ds:[eax+5], 0
	fn SendDlgItemMessage,hWnd,ID_Flight_Animation_Distance,WM_SETTEXT,0,eax
; ������ �� �����
	mov eax, Monster
	movsx eax, byte ptr [esi + eax + 253000]; ��������
    invoke SetDlgItemInt,hWnd,ID_SHOOTPROT,eax,TRUE
; ���������� �������
	free esi
	invoke SendDlgItemMessage, hWnd, ID_MONSTER_COMBOX, CB_SETCURSEL, Monster,0;		
; ��������� �������������� �����
	movsx ebx, byte ptr [InputFile(addr Lang)]; �������� ���� (0 - ����������, 1 - �������)
	free eax; ���������� ������ � 1-�������� ������	
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Plural])   ; load file into memory
	push ebx
	or ebx, -1; ������� �����
	xor edi, edi; zero the read position pointer
@@:	
	inc ebx
	mov edi, linein$(esi,ADDR buffer,edi)
	cmp ebx, Monster
	jnz @b
	invoke SendDlgItemMessage, hWnd, ID_PLURAL, WM_SETTEXT, ebx, ADDR buffer	
	free esi	
	pop ebx
; ��������� ��������
	mov esi, InputFile(dword ptr ds:[ebx*4+case_Ability])   ; load file into memory
	or ebx, -1; ������� �����
	xor edi, edi; zero the read position pointer
@@:	
	inc ebx
	mov edi, linein$(esi,ADDR buffer,edi)
	cmp ebx, Monster
	jnz @b
	invoke SendDlgItemMessage, hWnd, ID_DESCRIPTION, WM_SETTEXT, ebx, ADDR buffer	
	free esi

; ������:			
	mov esi, InputFile(addr AmmoFile)   ; load file into memory
	mov eax, Monster	
	shl eax, 4; �������� �� 16	
	lea eax, [esi + eax]
	invoke SendDlgItemMessage, hWnd, ID_ARROW, WM_SETTEXT, 0, eax
	free esi
; ���������� ����������:
	mov esi, InputFile(addr ImposedSpellsFile)   ; load file into memory
	mov eax, Monster
	imul eax, 6
	lea edi, [esi + eax]
	movsx eax, byte ptr [edi]
	inc eax
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_1,CB_SETCURSEL,eax,0
	movsx eax, byte ptr [edi+1]
	inc eax
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_2,CB_SETCURSEL,eax,0
	movsx eax, byte ptr [edi+2]
	inc eax
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_3,CB_SETCURSEL,eax,0
	movsx eax, byte ptr [edi+3]
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_1_lvl,CB_SETCURSEL,eax,0
	movsx eax, byte ptr [edi+4]
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_2_lvl,CB_SETCURSEL,eax,0
	movsx eax, byte ptr [edi+5]
	invoke SendDlgItemMessage,hWnd,ID_IMPOSED_SPELL_3_lvl,CB_SETCURSEL,eax,0
	free esi
; �����������
	mov esi, InputFile(addr DemonologyFile)   ; load file into memory
	mov eax, Monster
	movsx eax, word ptr [eax*2+esi]
	inc eax
	invoke SendDlgItemMessage,hWnd,ID_DEMONOLOGY,CB_SETCURSEL,eax,0	
	free esi
; ����
	mov esi, InputFile(addr BlockFile)   ; load file into memory
	mov eax, Monster
	movsx eax, byte ptr [esi + eax]; ��������
    	invoke SetDlgItemInt,hWnd,ID_BLOCK_DAMAGE,eax,TRUE
	free esi
; �������� �����
	mov esi, InputFile(addr FirewallFile)   ; load file into memory
    mov edx, Monster
    mov ecx, edx
    and edx, 1Fh
    shr ecx, 5
	xor eax, eax
    bt [esi+ecx*4], edx 
	setc al
	invoke SendDlgItemMessage, hWnd, ID_FIREWALL, BM_SETCHECK, eax,0
	free esi
; ����� �������:
	mov esi, InputFile(addr DefenseBonusFile)   ; load file into memory
	mov eax, Monster
	movzx eax, byte ptr [esi+eax]
    invoke SetDlgItemInt,hWnd,ID_DEFENSEBONUS,eax,TRUE
	free esi
	invoke Correct_States, Monster, hWnd
	pop ebx
	pop edi
	pop esi
	ret
	
Setup_Monster_attributes endp