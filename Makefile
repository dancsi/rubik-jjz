SRCS = $(wildcard *.pas) $(wildcard *.pp)
all:
	fpc rubik.pas
	del *.o
	del *.ppu
%.pas:
	echo $<
	ptop -i 4 $< $<
%.pp:
	echo $<
	ptop -i 4 $< $<
.PHONY: %.pas %.pp