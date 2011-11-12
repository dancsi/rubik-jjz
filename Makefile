all: units
	fpc rubik.pas
units:
	fpc algorithm.pp -FE./obj
	fpc output.pp -FE./obj
clean:
	del /Q obj
	rmdir obj
	del *.o
	del *.ppu