EXIT_SUCCESS= 0
SYSEXIT=1
.data
liczba1: .long 0xccdcba98, 0x87654321, 0x91234567, 0x89abcde1
liczba2: .long 0xa7654321, 0x12345678, 0x81234567, 0x89abcde1

ilosc_liczb = (. - liczba2)/4

.text
.global _start
_start:

dodaj:
	movl $ilosc_liczb,%ecx
	clc 
petla:
	movl %ecx,%edx
	decl %edx
	movl liczba1(,%edx,4),%eax
	movl liczba2(,%edx,4),%ebx
	sbb %ebx,%eax
	pushl %eax
loop petla
	jnc bez_cf
	mov $ilosc_liczb, %ecx
zdejmowanie:
	popl %eax
loop zdejmowanie
	mov $ilosc_liczb, %ecx
	clc
	jmp odejmij_odwrotnie

odejmij_odwrotnie:
	movl %ecx,%edx
	decl %edx
	movl liczba1(,%edx,4),%eax
	movl liczba2(,%edx,4),%ebx
	sbb %eax,%ebx
	pushl %ebx
loop odejmij_odwrotnie
	pushl $1
	jmp zakoncz

bez_cf:


	jmp zakoncz

zakoncz:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
