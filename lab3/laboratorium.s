SYSEXIT = 1
EXIT_SUCCESS = 0
SYSWRITE = 4
STDOUT = 1
SYSREAD = 3
STDIN = 0

//rejestr Control Word -> |15...12|RC RC|PC PC|7... 0|
//zainicjalizowany :      |15...12|0  0 |1  1 |111111|
WDOL = 0b0000010000000000
WGOR = 0b0000100000000000
TRUN = 0b0000110000000000
PR24 = 0b1111110011111111
PR53 = 0b1111111011111111

.text
.data
	num1:
		.float 10.05
	num2:
		.float -5.04
	num3:
		.float 100.16
	zero:
		.float 0.00
	control_word:
		.short 0
	//1 - 24 bity, 2 - 53 bity, inne - 64 bity
	precyzja_wybor:
		.long 2
	//1 - w dol, 2 - w gore, 3 - do zera, inne - do najblizszej
	zaokraglanie_wybor:
		.long 0

.global _start
_start:

	//laduje control word do pamieci, zeruje eax i z pamieci do eax
	fstcw control_word
	mov $0, %eax
	movw control_word, %ax

	//decyzja
	mov zaokraglanie_wybor, %edx
	cmp $1, %edx
	je w_dol
	cmp $2, %edx
	je w_gore
	cmp $3, %edx
	je do_zera

precyzja:

	mov precyzja_wybor, %edx
	cmp $1, %edx
	je prec_24
	cmp $2, %edx
	je prec_53

kalkulator:


	//laduje ax do pamieci, z pamieci do rejestru control word
	movw %ax, control_word
	fldcw control_word

	//liczba/zero -> nieskonczonosc |0|1...1|0...0|
	fld num1
	fdiv zero

	//-liczba/zero -> -nieskonczonosc |1|1...1|0...0|
	fld num2
	fdiv zero

	//pierwiastek(-liczba) -> zespolone |1/0|1...1|x...1...x|
	fld num2
	fsqrt

	//zmiana znaku w 0 |0|0...0|0...0| --> |1|0...0|0...0|
	fld zero
	fchs

	//liczba+liczba -> liczba |0|x...x|x...x| 
	fld num1
	fadd num3

	//liczba-liczba -> liczba
	fld num3
	fsub num1

	//liczba pi*(-liczba) -> (-liczba)
	fldpi
	fmul num2

	#liczba/(-liczba) -> (liczba)
	fld num3
	fdiv num2

exit:
	mov $SYSEXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80

w_dol:
	mov $WDOL, %dx
	or %dx, %ax
jmp precyzja

w_gore:
	mov $WGOR, %dx
	or %dx, %ax
jmp precyzja

do_zera:
	mov $TRUN, %dx
	or %dx, %ax
jmp precyzja

prec_24:
	mov $PR24, %dx
	and %dx, %ax
jmp kalkulator

prec_53:
	mov $PR53, %dx
	and %dx, %ax
jmp kalkulator
