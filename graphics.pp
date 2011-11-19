
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, gl, glu, glut, crt, sysutils;

Const 
    AppWidth =   640;
    AppHeight =   480;
    CubieSide =   1.5;

Procedure InitializeGraphics;
Procedure DrawCube(c: Cube);
Procedure ReSizeGLScene(Width, Height: Integer);
cdecl;
Procedure ClearScreen;
Procedure SwapBuffers;
Procedure RotateCube(x, y:Real; c: Cube);
Procedure RedrawScreen(c: Cube);

Var YRot, XRot:   real;

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
    glutCreateWindow('Rubik''s Cube');
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
    yRot := -30;
    xRot := 20;
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
                   glColor3ub(255, 255, 0);
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
Begin
    For i:=1 To 3 Do
        Begin
            For j:=1 To 3 Do
                Begin
                    SetGLColor(f[i][j]);
                    DrawSquare((i-1)*CubieSide, (j-1)*CubieSide, CubieSide);
                End;
        End;
End;


Procedure DrawCube(c: Cube);

Var  scaleFactor:   Real;
    flipVectorP:   PGLFloat;
    flipVector:   Array[1..16] Of GLFloat;
Begin
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    glTranslatef(0, 0, -3*CubieSide);
    //glMatrixMode(GL_PROJECTION);
    glRotatef(xRot, 1, 0, 0);
    glRotatef(yRot, 0, 1, 0);
    writeln('Y rotation: ', yRot:5:2);
    //gluLookAt(0, 5, -5, 0, 0, 0, 1, 1, 1);
    //glMatrixMode(GL_MODELVIEW);
    scaleFactor := 0.3;
    glScalef(scaleFactor, scaleFactor, scaleFactor);

 {Strane B i F}
    glPushMatrix();
    glRotatef(180, 0, 1, 0);
    DrawFace(c.F);
    glTranslateF(CubieSide, 0, 3*CubieSide);
    glRotateF(180, 0, 1, 0);
    DrawFace(c.B);
    glPopMatrix();

 {Strane L i R}
    glPushMatrix();
    glTranslatef(CubieSide, 0, -2*CubieSide);
    glRotatef(-90, 0, 1, 0);
    DrawFace(c.R);
    glTranslatef(CubieSide, 0, 3*CubieSide);
    glRotatef(180, 0, 1, 0);
    DrawFace(c.L);
    glPopMatrix();

 {Strane U i D}
    glPushMatrix();
    //glRotatef(180, 0, 1, 0);
    glTranslatef(0, 2*CubieSide, -CubieSide);
    glRotatef(90, 1, 0, 0);
    glRotatef(180, 0, 0, 1);
    DrawFace(c.U);
    glTranslatef(0, CubieSide, 3*CubieSide);
    glRotatef(180, 1, 0, 0);
    DrawFace(c.D);
    glPopMatrix();

End;

Procedure RedrawScreen(c: Cube);
Begin
    ClearScreen;
    DrawCube(c);
    SwapBuffers;
End;

Procedure RotateCube(x, y:Real; c: Cube);
Begin
    XRot := XRot+x;
    YRot := YRot+y;
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
