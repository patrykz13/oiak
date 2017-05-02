BCKP=backup.s

all: wynik

wynik: laboratorium.o
	ld -m elf_i386 laboratorium.o -o wynik
laboratorium.o: laboratorium.s 	
	as -ggdb --32 -o laboratorium.o laboratorium.s
clean : 
	rm -rf *o wynik

backup : laboratorium.s
	cp laboratorium.s $(BCKP)





