
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, gl, glu, glut;

Const 
    AppWidth =   640;
    AppHeight =   480;

Procedure InitializeGraphics;
Procedure DrawCube(c: Cube);
Procedure ReSizeGLScene(Width, Height: Integer);
cdecl;
Procedure ClearScreen;
Procedure SwapBuffers;

Implementation

Procedure glutInitPascal(ParseCmdLine: Boolean);

Var 
    Cmd:   array Of PChar;
    CmdCount, I:   Integer;
Begin
    If ParseCmdLine Then
        CmdCount := ParamCount + 1
    Else
        CmdCount := 1;
    SetLength(Cmd, CmdCount);
    For I := 0 To CmdCount - 1 Do
        Cmd[I] := PChar(ParamStr(I));
    glutInit(@CmdCount, @Cmd);
End;

Procedure InitializeGraphics;

Var 
    ScreenWidth, ScreenHeight:   Integer;
Begin
    glutInitPascal(True);
    glutInitDisplayMode(GLUT_DOUBLE Or GLUT_RGB Or GLUT_DEPTH);
    glutInitWindowSize(AppWidth, AppHeight);
    ScreenWidth := glutGet(GLUT_SCREEN_WIDTH);
    ScreenHeight := glutGet(GLUT_SCREEN_HEIGHT);
    glutInitWindowPosition((ScreenWidth - AppWidth) div 2, (ScreenHeight - AppHeight) div 2);
    glutCreateWindow('rubik-jjz');
    glClearColor(0, 0, 0, 0);
End;

Procedure DrawCube(c: Cube);
Begin
End;

Procedure ReSizeGLScene(Width, Height: Integer);
cdecl;
Begin
    If Height = 0 Then
        Height := 1;

    glViewport(0, 0, Width, Height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    gluPerspective(45, Width / Height, 0.1, 1000);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
End;

Procedure ClearScreen;
Begin
    glClear(GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT);
End;

Procedure SwapBuffers;
Begin
    glutSwapBuffers();
End;

initialization

{$IFDEF CPU386}
Set8087CW($133F);
{$ENDIF}
InitializeGraphics;

finalization

End.
