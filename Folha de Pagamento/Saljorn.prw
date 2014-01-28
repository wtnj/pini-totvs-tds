USER FUNCTION SALJORN()
Local N
MPVERBAS := {}
ano := year(mv_par09)
mes := month(mv_par09)
if mes== 1
	mes := 12
	ano := ano-1
else
	MES := MES -1
ENDIF
XDATA := STRZERO(ANO,4)+STRZERO(MES,2)
DBSELECTAREA("SRX")
DBSETORDER(1)
DBSEEK(XFILIAL()+"19"+XDATA)
HRNORMAIS := VAL(SUBS(SRX->RX_TXT,1,6))
HRDSR     := VAL(SUBS(SRX->RX_TXT,8,5))
XVALOR := SRA->RA_SALARIO*.6/HRNORMAIS*HRDSR
IF XVALOR <> 0
	dbselectarea("SRC")
	DBSETORDER(1)
	IF !DBSEEK(SRA->RA_FILIAL+SRA->RA_MAT+"219")
		RECLOCK("SRC",.T.)
		SRC->RC_FILIAL := sra->ra_filial
		src->rc_mat    := sra->ra_mat
		src->rc_pd     := "219"
		src->rc_tipo1  := "V"
		src->rc_valor  := XVALOR
		src->rc_cc     := sra->ra_cc
		src->rc_tipo2  := "I"
		msunlock()
	ENDIF
	XVALHE := SRA->RA_SALARIO*.6-XVALOR
	IF !DBSEEK(SRA->RA_FILIAL+SRA->RA_MAT+"106")
		RECLOCK("SRC",.T.)
		SRC->RC_FILIAL := sra->ra_filial
		src->rc_mat    := sra->ra_mat
		src->rc_pd     := "106"
		src->rc_tipo1  := "V"
		src->rc_valor  := XVALHE
		src->rc_cc     := sra->ra_cc
		src->rc_tipo2  := "I"
		msunlock()
	ENDIF
ENDIF
RETURN