
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, gl, glu, glut, crt, sysutils;

Const 
    AppWidth =   800;
    AppHeight =   600;
    CubieSide =   1.5;
    ScaleFactor =   0.3;
    RotationStep =   3;

Procedure InitializeGraphics;
Procedure DrawCube(c: Cube);
Procedure ReSizeGLScene(Width, Height: Integer);
cdecl;
Procedure DrawAxes;
Procedure ClearScreen;
Procedure SwapBuffers;
Procedure RotateCube(x, y:Real; c: Cube);
Procedure RedrawScreen(c: Cube);
Procedure DrawFaceSlice(f: Face; StartI, StartJ, EndI, EndJ: Byte);
Procedure PrepareForDrawing;
Procedure Animate2ListsRotation(static, rotating: GLUint; rx, ry, rz: GLFloat);
Procedure AnimateTurnU(c: Cube);
Procedure AnimateTurnIU(c: Cube);
Procedure AnimateTurnD(c: Cube);
Procedure AnimateTurnID(c: Cube);
Procedure AnimateTurnL(c: Cube);
Procedure AnimateTurnIL(c: Cube);
Procedure AnimateTurnR(c: Cube);
Procedure AnimateTurnIR(c: Cube);
Procedure AnimateTurnF(c: Cube);
Procedure AnimateTurnIF(c: Cube);
Procedure AnimateTurnB(c: Cube);
Procedure AnimateTurnIB(c: Cube);
Procedure AnimateTurnUpsideDown(c: Cube);

Var YRot, XRot:   real;

Implementation

Uses WinCRT;

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

Procedure SetupLights;

Var  ambientLight :   array[1..4] Of GLFloat =   (0.2, 0.2, 0.2, 0.2);
    specularLight :   array[1..4] Of GLFloat =   (0.1, 0.1, 0.1, 0.1);
    position :   array[1..3] Of GLFloat =   (-1.5, 5, 5);
Begin
    glEnable (GL_LIGHTING);
    glEnable (GL_LIGHT0);
    //glEnable (GL_LIGHT1);
    glEnable(GL_COLOR_MATERIAL);
    glLightfv(GL_LIGHT1, GL_AMBIENT, @ambientLight);
    glLightfv(GL_LIGHT0, GL_SPECULAR, @specularLight);
    glLightfv(GL_LIGHT0, GL_POSITION, @position);
End;

Procedure InitializeGraphics;

Var 
    ScreenWidth, ScreenHeight:   Integer;
Begin
    glutInitPascal(True);
    glutInitDisplayMode(GLUT_DOUBLE Or GLUT_RGBA Or GLUT_DEPTH);
    glutInitWindowSize(AppWidth, AppHeight);
    ScreenWidth := glutGet(GLUT_SCREEN_WIDTH);
    ScreenHeight := glutGet(GLUT_SCREEN_HEIGHT);
    glutInitWindowPosition((ScreenWidth - AppWidth) div 2, (ScreenHeight - AppHeight) div 2);
    glutCreateWindow('Rubik''s Cube');
    glEnable(GL_DEPTH_TEST);
    glEnable (GL_LINE_SMOOTH);
    glDepthMask(GL_TRUE);
    yRot := -30;
    xRot := 20;
    glShadeModel (GL_SMOOTH);
    SetupLights;
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
                   glColor3ub(255, 64, 0);
               End;
        'R':
               Begin
                   glColor3ub(255, 0, 0);
               End;
    End;
End;

Procedure DrawLine(x1, y1, z1, x2, y2, z2, w:GLFloat);
Begin
    glDisable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glLineWidth(w);
    glBegin(GL_LINES);
    glVertex3f(x1, y1, z1);
    glVertex3f(x2, y2, z2);
    glEnd;
    glDisable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
End;

Procedure DrawSquare(x, y, l:Real);
Begin
    glBegin(GL_QUADS);
    glVertex3f(x, y, 0);
    glVertex3f(x, y+l, 0);
    glVertex3f(x+l, y+l, 0);
    glVertex3f(x+l, y, 0);
    glEnd;
    //OKVIR

    glDisable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glColor3f(0, 0, 0);
    glLineWidth(1);
    glBegin(GL_LINE_LOOP);
    glVertex3f(x, y, 0.0);
    glVertex3f(x, y+l, 0.0);
    glVertex3f(x+l, y+l, 0.0);
    glVertex3f(x+l, y, 0.0);
    glEnd;
    glDisable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);


{DrawLine(x, y, 0, x, y+l, 0, 2);
	DrawLine(x, y+l, 0, x+l, y+l, 0, 2);
	DrawLine(x+l, y+l, 0, x+l, y, 0, 2);
	DrawLine(x+l, y, 0, x, y, 0, 2);}
End;

Procedure DrawFaceSlice(f: Face; StartI, StartJ, EndI, EndJ: Byte);

Var i, j:   Byte;
Begin
    If (StartI<>0) Then
        Begin
            For i:= StartI To EndI Do
                Begin
                    For j:= StartJ To EndJ Do
                        Begin
                            SetGLColor(f[i][j]);
                            DrawSquare((i-1)*CubieSide, (j-1)*CubieSide, CubieSide);
                        End;
                End;
        End;
End;

Procedure DrawFace(f: Face);

Begin
    DrawFaceSlice(f, 1, 1, 3, 3);
End;

Procedure DrawAxes;
Begin
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glColor4f(0.2, 1, 1, 0.5);
    glutSolidSphere(0.5, 20, 20);
    glColor3f(0, 0, 1);
    DrawLine(0, 0, 0, 1, 0, 0, 5);
    glColor3f(1, 0, 0);
    DrawLine(0, 0, 0, 0, 0, 1, 5);
    glColor3f(0, 1, 0);
    DrawLine(0, 0, 0, 0, 1, 0, 5);
    glDisable(GL_BLEND);
End;

Procedure PrepareForDrawing();
Begin
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    glTranslatef(-0.7, 0.6, -3*CubieSide);
    glRotatef(xRot, 1, 0, 0);
    glRotatef(yRot, 0, 1, 0);
    glScalef(scaleFactor, scaleFactor, scaleFactor);
    glRotatef(-90, 0, 0, 1);
End;

Procedure DrawCube(c: Cube);

Var  scaleFactor:   Real;
    flipVectorP:   PGLFloat;
    flipVector:   Array[1..16] Of GLFloat;
Begin
    PrepareForDrawing;
 {Strane B i F}
    glPushMatrix();
    DrawFace(c.F);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotateF(180, 1, 0, 0);
    DrawFace(c.B);
    glPopMatrix();

 {Strane L i R}
    glPushMatrix();
    glTranslateF(0, 0, -3*CubieSide);
    glRotatef(90, 1, 0, 0);
    DrawFace(c.L);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotatef(180, 1, 0, 0);
    DrawFace(c.R);
    glPopMatrix();

 {Strane U i D}
    glPushMatrix();
    glTranslatef(3*CubieSide, 0, 0);
    glRotatef(90, 0, 1, 0);
    DrawFace(c.D);
    glTranslatef(3*CubieSide, 0, -3*CubieSide);
    glRotatef(180, 0, 1, 0);
    DrawFace(c.U);
    glPopMatrix();

End;

Procedure Animate2ListsRotation(static, rotating: GLUint; rx, ry, rz: GLFloat);

Var rotAngle:   GLFloat;
    tx:   GLFloat =   1.5*CubieSide;
    ty:   GLFloat =   1.5*CubieSide;
    tz:   GLFloat =   1.5*CubieSide;
Begin
    rotAngle := 0;
    tx := tx*(1-rx);
    ty := ty*(1-ry);
    tz := -tz*(1-rz);

    While (rotAngle<=90) Do
        Begin
            rotAngle := rotAngle+RotationStep;
            PrepareForDrawing;
            clearscreen;
            glCallList(static);
            PrepareForDrawing;
            glTranslatef(tx, ty, tz);
            //Delay(10000);
            //DrawAxes;
            glRotatef(rotAngle, rx, ry, rz);
            glTranslatef(-tx, -ty, -tz);
            glCallList(rotating);
            swapBuffers;
        End;
End;

Function CubeStaticPartDList(c: Cube; RotatedFace: char):   GLUint;

Var index:   GLUint;
    Ustarti:   Byte =   1;
    Ustartj:   Byte =   1;
    Uendi:   Byte =   3;
    Uendj:   Byte =   3;
    Dstarti:   Byte =   1;
    Dstartj:   Byte =   1;
    Dendi:   Byte =   3;
    Dendj:   Byte =   3;
    Lstarti:   Byte =   1;
    Lstartj:   Byte =   1;
    Lendi:   Byte =   3;
    Lendj:   Byte =   3;
    Rstarti:   Byte =   1;
    Rstartj:   Byte =   1;
    Rendi:   Byte =   3;
    Rendj:   Byte =   3;
    Fstarti:   Byte =   1;
    Fstartj:   Byte =   1;
    Fendi:   Byte =   3;
    Fendj:   Byte =   3;
    Bstarti:   Byte =   1;
    Bstartj:   Byte =   1;
    Bendi:   Byte =   3;
    Bendj:   Byte =   3;
Begin

    Case RotatedFace Of 
        'U':
               Begin
                   Fstarti := 2;
                   Rstarti := 2;
                   Bstarti := 2;
                   Lstarti := 2;

                   Ustarti := 0;
                   Ustartj := 0;
                   Uendi := 0;
                   Uendj := 0;
               End;
        'D':
               Begin
                   Fendi := 2;
                   Rendi := 2;
                   Bendi := 2;
                   Lendi := 2;

                   Dstarti := 0;
                   Dstartj := 0;
                   Dendi := 0;
                   Dendj := 0;
               End;
        'L':
               Begin
                   Ustartj := 2;
                   Dstartj := 2;
                   Fstartj := 2;
                   Bendj := 2;

                   Lstarti := 0;
                   Lstartj := 0;
                   Lendi := 0;
                   Lendj := 0;
               End;
        'R':
               Begin
                   Uendj := 2;
                   Dendj := 2;
                   Fendj := 2;
                   Bstartj := 2;

                   Rstarti := 0;
                   Rstartj := 0;
                   Rendi := 0;
                   Rendj := 0;
               End;
        'F':
               Begin
                   Uendi := 2;
                   Dstarti := 2;
                   Lendj := 2;
                   Rstartj := 2;

                   Fstarti := 0;
                   Fstartj := 0;
                   Fendi := 0;
                   Fendj := 0;
               End;
        'B':
               Begin
                   Ustarti := 2;
                   Dendi := 2;
                   Lstartj := 2;
                   Rendj := 2;

                   Bstarti := 0;
                   Bstartj := 0;
                   Bendi := 0;
                   Bendj := 0;
               End;
    End;

    index := glGenLists(1);
    glNewList(index, GL_COMPILE);
  {Strane B i F}
    glPushMatrix();
    DrawFaceSlice(c.F, Fstarti, Fstartj, Fendi, Fendj);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotateF(180, 1, 0, 0);
    DrawFaceSlice(c.B, Bstarti, Bstartj, Bendi, Bendj);
    glPopMatrix();

  {Strane L i R}
    glPushMatrix();
    glTranslateF(0, 0, -3*CubieSide);
    glRotatef(90, 1, 0, 0);
    DrawFaceSlice(c.L, Lstarti, Lstartj, Lendi, Lendj);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotatef(180, 1, 0, 0);
    DrawFaceSlice(c.R, Rstarti, Rstartj, Rendi, Rendj);
    glPopMatrix();

  {Strane U i D}
    glPushMatrix();
    glTranslatef(3*CubieSide, 0, 0);
    glRotatef(90, 0, 1, 0);
    DrawFaceSlice(c.D, Dstarti, Dstartj, Dendi, Dendj);
    glTranslatef(3*CubieSide, 0, -3*CubieSide);
    glRotatef(180, 0, 1, 0);
    DrawFaceSlice(c.U, Ustarti, Ustartj, Uendi, Uendj);
    glPopMatrix();
    glEndList;
    CubeStaticPartDList := index;
End;

Function CubeRotatingPartDList(c: Cube; RotatedFace: char):   GLUint;

Var index:   GLUint;
    Ustarti:   Byte =   1;
    Ustartj:   Byte =   1;
    Uendi:   Byte =   3;
    Uendj:   Byte =   3;
    Dstarti:   Byte =   1;
    Dstartj:   Byte =   1;
    Dendi:   Byte =   3;
    Dendj:   Byte =   3;
    Lstarti:   Byte =   1;
    Lstartj:   Byte =   1;
    Lendi:   Byte =   3;
    Lendj:   Byte =   3;
    Rstarti:   Byte =   1;
    Rstartj:   Byte =   1;
    Rendi:   Byte =   3;
    Rendj:   Byte =   3;
    Fstarti:   Byte =   1;
    Fstartj:   Byte =   1;
    Fendi:   Byte =   3;
    Fendj:   Byte =   3;
    Bstarti:   Byte =   1;
    Bstartj:   Byte =   1;
    Bendi:   Byte =   3;
    Bendj:   Byte =   3;
Begin

    Case RotatedFace Of 
        'U':
               Begin
                   Fendi := 1;
                   Rendi := 1;
                   Bendi := 1;
                   Lendi := 1;

                   Dstarti := 0;
                   Dstartj := 0;
                   Dendi := 0;
                   Dendj := 0;
               End;
        'D':
               Begin
                   Fstarti := 3;
                   Rstarti := 3;
                   Bstarti := 3;
                   Lstarti := 3;

                   Ustarti := 0;
                   Ustartj := 0;
                   Uendi := 0;
                   Uendj := 0;
               End;
        'L':
               Begin
                   Uendj := 1;
                   Dendj := 1;
                   Fendj := 1;
                   Bstartj := 3;

                   Rstarti := 0;
                   Rstartj := 0;
                   Rendi := 0;
                   Rendj := 0;
               End;
        'R':
               Begin
                   Ustartj := 3;
                   Dstartj := 3;
                   Fstartj := 3;
                   Bendj := 1;

                   Lstarti := 0;
                   Lstartj := 0;
                   Lendi := 0;
                   Lendj := 0;
               End;
        'F':
               Begin
                   Ustarti := 3;
                   Dendi := 1;
                   Lstartj := 3;
                   Rendj := 1;

                   Bstarti := 0;
                   Bstartj := 0;
                   Bendi := 0;
                   Bendj := 0;
               End;
        'B':
               Begin
                   Uendi := 1;
                   Dstarti := 3;
                   Lendj := 1;
                   Rstartj := 3;

                   Fstarti := 0;
                   Fstartj := 0;
                   Fendi := 0;
                   Fendj := 0;
               End;
    End;

    index := glGenLists(1);
    glNewList(index, GL_COMPILE);
  {Strane B i F}
    glPushMatrix();
    DrawFaceSlice(c.F, Fstarti, Fstartj, Fendi, Fendj);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotateF(180, 1, 0, 0);
    DrawFaceSlice(c.B, Bstarti, Bstartj, Bendi, Bendj);
    glPopMatrix();

  {Strane L i R}
    glPushMatrix();
    glTranslateF(0, 0, -3*CubieSide);
    glRotatef(90, 1, 0, 0);
    DrawFaceSlice(c.L, Lstarti, Lstartj, Lendi, Lendj);
    glTranslateF(0, 3*CubieSide, -3*CubieSide);
    glRotatef(180, 1, 0, 0);
    DrawFaceSlice(c.R, Rstarti, Rstartj, Rendi, Rendj);
    glPopMatrix();

  {Strane U i D}
    glPushMatrix();
    glTranslatef(3*CubieSide, 0, 0);
    glRotatef(90, 0, 1, 0);
    DrawFaceSlice(c.D, Dstarti, Dstartj, Dendi, Dendj);
    glTranslatef(3*CubieSide, 0, -3*CubieSide);
    glRotatef(180, 0, 1, 0);
    DrawFaceSlice(c.U, Ustarti, Ustartj, Uendi, Uendj);
    glPopMatrix();
    glEndList;
    CubeRotatingPartDList := index;
End;

Procedure AnimateTurnU(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'U'), CubeRotatingPartDList(c, 'U'), 1, 0, 0);
End;

Procedure AnimateTurnIU(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'U'), CubeRotatingPartDList(c, 'U'), -1, 0, 0);
End;

Procedure AnimateTurnD(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'D'), CubeRotatingPartDList(c, 'D'), -1, 0, 0);
End;

Procedure AnimateTurnID(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'D'), CubeRotatingPartDList(c, 'D'), 1, 0, 0);
End;

Procedure AnimateTurnL(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'L'), CubeRotatingPartDList(c, 'L'), 0, 1, 0);
End;

Procedure AnimateTurnIL(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'L'), CubeRotatingPartDList(c, 'L'), 0, -1, 0);
End;

Procedure AnimateTurnR(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'R'), CubeRotatingPartDList(c, 'R'), 0, -1, 0);
End;

Procedure AnimateTurnIR(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'R'), CubeRotatingPartDList(c, 'R'), 0, 1, 0);
End;

Procedure AnimateTurnF(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'F'), CubeRotatingPartDList(c, 'F'), 0, 0, -1);
End;

Procedure AnimateTurnIF(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'F'), CubeRotatingPartDList(c, 'F'), 0, 0, 1);
End;

Procedure AnimateTurnB(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'B'), CubeRotatingPartDList(c, 'B'), 0, 0, 1);
End;

Procedure AnimateTurnIB(c: Cube);
Begin
    Animate2ListsRotation(CubeStaticPartDList(c, 'B'), CubeRotatingPartDList(c, 'B'), 0, 0, -1);
End;

Procedure AnimateTurnUpsideDown(c: Cube);

Var rotAngle:   GLFloat;
    tx:   GLFloat =   1.5*CubieSide;
    ty:   GLFloat =   1.5*CubieSide;
    tz:   GLFloat =   1.5*CubieSide;
    rx:   GLFloat =   0.0;
    ry:   GLFloat =   1.0;
    rz:   GLFloat =   0.0;
    rotating:   GLUint;
Begin
    rotAngle := 0;
    tx := tx*(1-rx);
    ty := ty*(1-ry);
    tz := -tz*(1-rz);
    rotating := CubeRotatingPartDList(c, 'X');
    While (rotAngle<=180) Do
        Begin
            rotAngle := rotAngle+RotationStep;
            PrepareForDrawing;
            clearscreen;
            glTranslatef(tx, ty, tz);
            //Delay(10000);
            //DrawAxes;
            glRotatef(rotAngle, rx, ry, rz);
            glTranslatef(-tx, -ty, -tz);
            glCallList(rotating);
            swapBuffers;
        End;
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
    writeln('Resized: ', Width, ' ', Height);
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
