
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, gl, glu, glut, crt, sysutils;

Const 
    AppWidth =   640;
    AppHeight =   480;

Procedure InitializeGraphics;
Procedure DrawCube(c: Cube);
Procedure ReSizeGLScene(Width, Height: Integer); cdecl;
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
    glutCreateWindow('RubiksCube');
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
End;

Procedure SetGLColor(c: char);
Begin
    Case c Of 
        'G':
               Begin
                   glColor3ub(0, 153, 0);
               End;
        'B':
               Begin
                   glColor3ub(0, 0, 204);
               End;
        'W':
               Begin
                   glColor3ub(255, 255, 255);
               End;
        'Y':
               Begin
                   glColor3ub(0, 255, 255);
               End;
        'O':
               Begin
                   glColor3ub(255, 180, 0);
               End;
        'R':
               Begin
                   glColor3ub(255, 0, 0);
               End;
    End;
End;

Procedure DrawSquare(x, y, l:Real);
Begin
    glBegin(GL_QUADS);
    glVertex3f(x, y, 0);
    glVertex3f(x, y-l, 0);
    glVertex3f(x-l, y-l, 0);
    glVertex3f(x-l, y, 0);
    glEnd;
    glColor3f(0, 0, 0);
    glLineWidth(2);
    glBegin(GL_LINE);
    glVertex3f(x, y, 0);
    glVertex3f(x, y-l, 0);
    glVertex3f(x-l, y-l, 0);
    glVertex3f(x-l, y, 0);
    glEnd;
End;

Procedure DrawFace(f: Face);

Var i, j:   integer;
    side:   real;
Begin
    side := 1.5;
    For i:=1 To 3 Do
        Begin
            For j:=1 To 3 Do
                Begin
                    SetGLColor(f[i][4-j]);
                    DrawSquare((i-1)*side, (j-1)*side, side);
                End;
        End;
End;


Procedure DrawCube(c: Cube);

Var  scaleFactor:   Real;
Begin
    glLoadIdentity;
    glTranslatef(0, 0, -5);
    //glMatrixMode(GL_PROJECTION);
    glRotatef(20, 1, 0, 0);
    glRotatef(-30, 0, 1, 0);
    //gluLookAt(0, 5, -5, 0, 0, 0, 1, 1, 1);
    //glMatrixMode(GL_MODELVIEW);
    scaleFactor := 0.3;
    glScalef(scaleFactor, scaleFactor, scaleFactor);

{glColor3f(1, 0, 0);
	DrawSquare(0, 0, 4.5);
	//glTranslatef(3*1.5, 0, 0);
	glRotatef(-90, 0, 1, 0);
	glColor3f(0, 1, 0);
	DrawSquare(0, 0, 4.5);}

 {Strane B i F}
    glColor3f(1, 1, 0);
    //DrawSquare(0, 0, 4.5);
    glTranslateF(0, 0, -4.5);
    DrawFace(c.B);
    glTranslateF(0, 0, 4.5);
    DrawFace(c.F);

 {Strane L i R}
    glTranslatef(3, 0, 0);
    glRotatef(90, 0, 1, 0);
    glColor3f(1, 1, 0);
    glTranslatef(1.5, 0, 0);
    //glutSolidCube(3);
    //DrawSquare(0, 0, 4.5);
    DrawFace(c.R);
    glTranslateF(0, 0, -4.5);
    DrawFace(c.L);
    glTranslatef(0, 0, 4.5);

 {Strane U i D}
    glRotatef(90, 1, 0, 0);
    glTranslatef(0, -3, -3);
    DrawFace(c.U);
    glTranslatef(0, 0, 0);
    DrawFace(c.D);

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