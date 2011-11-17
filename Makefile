SRCS = $(wildcard *.pas) $(wildcard *.pp)
all: format
	fpc rubik.pas
	rm *.o
	rm *.ppu
format:
	$(foreach FILE, $(SRCS), ptop $(FILE) $(FILE))