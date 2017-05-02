all: dodawanie odejmowanie mnozenie


mnozenie: mnozenie.o
	ld -m elf_i386 -o mnozenie mnozenie.o
	
mnozenie.o: mnozenie.s 	
	as -ggdb --32 -o mnozenie.o mnozenie.s

dodawanie: dodawanie.o
	ld -m elf_i386 -o dodawanie dodawanie.o
	
dodawanie.o: dodawanie.s 	
	as -ggdb --32 -o dodawanie.o dodawanie.s


odejmowanie: odejmowanie.o
	ld -m elf_i386 -o odejmowanie odejmowanie.o
	
odejmowanie.o: odejmowanie.s 	
	as -ggdb --32 -o odejmowanie.o odejmowanie.s


