
Program rubik;

Uses algorithm, RubiksCube, input, graphics, glut;

Var c:   Cube;

Procedure DrawCallback;
cdecl;
Begin
    ClearScreen();
    DrawCube(c);
    SwapBuffers();
End;

Procedure KeyboardCallback(Key: Byte; X, Y: Longint);
cdecl;
begin
	ProcessKeyboard(key, X, Y, c);
end;

procedure MouseCallback(button, state, x ,y:longint); cdecl;
begin
	writeln(button);
	writeln(state);
	writeln(x, ' ', y);
	ProcessMouse(button, state, x, y, c);
end;

procedure MotionCallback(x, y:longint); cdecl;
begin
	writeln(x, ' ', y);
	ProcessMouseMotion(x, y, c);
end;

Begin
    StartingCube(c);

    glutDisplayFunc(@DrawCallback);
    glutReshapeFunc(@ReSizeGLScene);
    glutKeyboardFunc(@KeyboardCallback);
	glutMouseFunc(@MouseCallback);
	glutMotionFunc(@MotionCallback);
	
    glutMainLoop;
End.
