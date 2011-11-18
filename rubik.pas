
Program rubik;

Uses algorithm, RubiksCube, input, graphics, glut;

Var c:   Cube;
    comm:   string;

Procedure DrawGLScene;
cdecl;
Begin
    ClearScreen();
    DrawCube(c);
    SwapBuffers();
End;

Procedure GLKeyboard(Key: Byte; X, Y: Longint);
cdecl;

Var ch:   char;
Begin
    If Key = 27 Then
        Halt(0);
    ch := chr(key);
    If ch In FaceNames Then
        Begin
            ExecuteString(comm, c);
            comm :=   '';
        End
    Else If ch='I' Then comm := 'I';
    writeln(ch);
End;

Begin
    StartingCube(c);

    glutDisplayFunc(@DrawGLScene);
    glutReshapeFunc(@ReSizeGLScene);
    glutKeyboardFunc(@GLKeyboard);

    glutMainLoop;
End.
