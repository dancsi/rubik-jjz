
Program rubik;

Uses algorithm, RubiksCube, input, graphics, glut;

Var c:   Cube;

Procedure DrawCallback;
cdecl;
Begin
    RedrawScreen(c);
End;

Procedure KeyboardCallback(Key: Byte; X, Y: Longint);
cdecl;
Begin
    ProcessKeyboard(key, X, Y, c);
    DrawCallback;
End;

Procedure MouseCallback(button, state, x ,y:longint);
cdecl;
Begin
    writeln(button);
    writeln(state);
    writeln(x, ' ', y);
    ProcessMouse(button, state, x, y, c);
End;

Procedure MotionCallback(x, y:longint);
cdecl;
Begin
    writeln(x, ' ', y);
    ProcessMouseMotion(x, y, c);
End;

Begin
    StartingCube(c);
	
    glutDisplayFunc(@DrawCallback);
    glutReshapeFunc(@ReSizeGLScene);
    glutKeyboardFunc(@KeyboardCallback);
    glutMouseFunc(@MouseCallback);
    glutMotionFunc(@MotionCallback);

    glutMainLoop;
End.
