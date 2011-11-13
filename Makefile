<<<<<<< HEAD
SRCS = $(wildcard *.pas) $(wildcard *.pp)
=======
>>>>>>> aa6a5a219708f517e0f3ee6ac5a1010ed093dc6f
all:
	fpc rubik.pas
	del *.o
	del *.ppu
<<<<<<< HEAD
%.pas:
	echo $<
	ptop -i 4 $< $<
%.pp:
	echo $<
	ptop -i 4 $< $<
.PHONY: %.pas %.pp
=======
	rmdir /S /Q obj
>>>>>>> aa6a5a219708f517e0f3ee6ac5a1010ed093dc6f
