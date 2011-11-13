all:
	fpc rubik.pas
units:
	mkdir -p obj
	fpc algorithm.pp -FE./obj
	fpc output.pp -FE./obj
clean:
	del *.o
	del *.ppu
	rmdir /S /Q obj
