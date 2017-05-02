EXIT_SUCCESS= 0
SYSEXIT=1
.data

liczba1: .long             0x00000002, 0x00000002,0x00000002,0x00000002
ilosc_bajtow_liczby1 = (. - liczba1)/4
 
liczba2: .long             0x00000002, 0x00000002,0x00000002,0x00000002
ilosc_bajtow_liczby2 = (. - liczba2)/4
 
wynik: .quad 0x0, 0x0, 0x0, 0x0
ilosc_bajtow_wyniku = (. - wynik)/4

licznik: .long 0x0000000
licznik2:.long 0x0000000


.text
.global _start
_start:
movl $ilosc_bajtow_liczby2, licznik
movl $ilosc_bajtow_wyniku, %ecx
decl %ecx
mnozenie:
petla_pobieranie_liczby2:
	movl licznik,%edi
	decl %edi
	movl liczba2(,%edi,4),%ebx

	movl $ilosc_bajtow_liczby2, licznik2
petla_mnozenie_drugiej_przez_liczbe1:

	movl licznik2,%esi
	decl %esi
	movl liczba1(,%esi,4),%eax
	imull %ebx
	add %eax,wynik(,%ecx,4)
	decl %ecx
	add %edx,wynik(,%ecx,4)
	decl licznik2
	movl $0, %esi
	cmpl licznik2,%esi
	jne petla_mnozenie_drugiej_przez_liczbe1

	movl $ilosc_bajtow_liczby2,%eax
	sbb $1,%eax
	loop:
	incl %ecx
	decl %eax
	cmpl $0, %eax
	jne loop

	decl licznik
	movl $0, %esi
	cmp licznik,%esi
	jne petla_pobieranie_liczby2

 
 
 
zakoncz:
    mov $SYSEXIT, %eax
    mov $EXIT_SUCCESS, %ebx
    int $0x80
