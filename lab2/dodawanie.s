
EXIT_SUCCESS= 0
SYSEXIT=1
.data
liczba1: .long 0xfedcba98, 0x87654321, 0x01234567, 0x89abcde1
liczba2: .long 0x87654321, 0x12345678, 0x01234567, 0x89abcde1

ilosc_bajtow = . - liczba2

.text
.global _start
_start:

	clc
	mov $ilosc_bajtow, %eax
	mov $4, %ebx
	div %ebx
dodaj:
	movl %eax,%ecx
	clc 
petla:
	movl %ecx,%edx
	decl %edx
	movl liczba1(,%edx,4),%eax
	movl liczba2(,%edx,4),%ebx
	adcl %eax,%ebx
	pushl %ebx
loop petla
	jnc bez_cf
	pushl $1
	jmp zakoncz

bez_cf:
	pushl $0
	jmp zakoncz

zakoncz:
	mov $SYSEXIT, %eax
	mov $EXIT_SUCCESS, %ebx
	int $0x80
