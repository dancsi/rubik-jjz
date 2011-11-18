
Program rubik;

Uses algorithm, RubiksCube, input, graphics;

Var c:   Cube;
    comm:   string;
Begin
    InitializeGraphics();
    StartingCube(c);
    While true Do
        Begin
            readln(comm);
            ExecuteString(comm, c);
            DrawCube(c);
        End;
End.
