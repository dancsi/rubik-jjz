Program rubik;

Uses algorithm, RubiksCube, input, graphics;

var c: Cube;
	comm: string;
Begin
	InitializeGraphics();
	StartingCube(c);
	while true do begin
		readln(comm);
		ExecuteString(comm, c);
		DrawCube(c);
	end;
End.
