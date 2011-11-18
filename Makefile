SRCS = $(wildcard *.pas) $(wildcard *.pp)
all: format
	fpc -Sh rubik.pas
	rm *.o
	rm *.ppu
format:
	$(foreach FILE, $(SRCS), $( shell ptop -i 4 $(FILE) $(FILE)))