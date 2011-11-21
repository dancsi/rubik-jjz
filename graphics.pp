
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, gl, glu, glut, crt, sysutils;

Const 
    AppWidth =   800;
    AppHeight =   600;
    CubieSide =   1.5;
	ScaleFactor = 0.3;
	RotationStep = 3;
	
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

Var YRot, XRot:   real;

Implementation

uses WinCRT;

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
var	param:GLInt;
	ambientLight : array[1..4] of GLFloat = (0.2, 0.2, 0.2, 0.2);
	specularLight : array[1..4] of GLFloat = (0.1, 0.1, 0.1, 0.1);
	position : array[1..3] of GLFloat = (-1.5, 5, 5);
begin
	glEnable (GL_LIGHTING);
    glEnable (GL_LIGHT0);
	//glEnable (GL_LIGHT1);
	glEnable(GL_COLOR_MATERIAL);
	glLightfv(GL_LIGHT1, GL_AMBIENT, @ambientLight);
	glLightfv(GL_LIGHT0, GL_SPECULAR, @specularLight);
	glLightfv(GL_LIGHT0, GL_POSITION, @position);
end;

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
                   glColor3ub(255, 180, 0);
               End;
        'R':
               Begin
                   glColor3ub(255, 0, 0);
               End;
    End;
End;

Procedure DrawLine(x1, y1, z1, x2, y2, z2, w:GLFloat);
begin
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
end;

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
var i, j: Byte;
Begin
	if(StartI<>0) then begin
    for i:= StartI to EndI do
        Begin
            for j:= StartJ to EndJ do
                Begin
                    SetGLColor(f[i][j]);
                    DrawSquare((i-1)*CubieSide, (j-1)*CubieSide, CubieSide);
                End;
        End;
	end;
End;

Procedure DrawFace(f: Face);

Begin
    DrawFaceSlice(f, 1, 1, 3, 3);
End;

Procedure DrawAxes;
begin
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
end;

procedure PrepareForDrawing;
begin
	glMatrixMode(GL_MODELVIEW);
    glLoadIdentity;
    glTranslatef(-0.7, 0.6, -3*CubieSide);
    glRotatef(xRot, 1, 0, 0);
    glRotatef(yRot, 0, 1, 0);
    glScalef(scaleFactor, scaleFactor, scaleFactor);
	glRotatef(-90, 0, 0, 1);
end;

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
var rotAngle: GLFloat;
	tx: GLFloat = 1.5*CubieSide;
	ty: GLFloat = 1.5*CubieSide;
	tz: GLFloat = 1.5*CubieSide;
begin
	rotAngle:=0;
	tx:=tx*(1-rx);
	ty:=ty*(1-ry);
	tz:=-tz*(1-rz);
	
	while(rotAngle<=90) do begin
		rotAngle:=rotAngle+RotationStep;
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
		//Delay(100);
	end;
end;

function CubeStaticPartDList(c: Cube; RotatedFace: char): GLUint;
var index: GLUint;
	Ustarti: Byte = 1; Ustartj: Byte = 1; Uendi: Byte = 3; Uendj: Byte = 3;  
	Dstarti: Byte = 1; Dstartj: Byte = 1; Dendi: Byte = 3; Dendj: Byte = 3;  
	Lstarti: Byte = 1; Lstartj: Byte = 1; Lendi: Byte = 3; Lendj: Byte = 3; 
	Rstarti: Byte = 1; Rstartj: Byte = 1; Rendi: Byte = 3; Rendj: Byte = 3; 
	Fstarti: Byte = 1; Fstartj: Byte = 1; Fendi: Byte = 3; Fendj: Byte = 3; 
	Bstarti: Byte = 1; Bstartj: Byte = 1; Bendi: Byte = 3; Bendj: Byte = 3; 
begin
	
	case RotatedFace of
		'U': begin
			Fstarti:=2;
			Rstarti:=2;
			Bstarti:=2;
			Lstarti:=2;
			
			Ustarti:=0;
			Ustartj:=0;
			Uendi:=0;
			Uendj:=0;
		end;
		'D': begin
			Fendi:=2;
			Rendi:=2;
			Bendi:=2;
			Lendi:=2;
			
			Dstarti:=0;
			Dstartj:=0;
			Dendi:=0;
			Dendj:=0;
		end;
		'L': begin
			Ustartj:=2;
			Dstartj:=2;
			Fstartj:=2;
			Bendj:=2;
			
			Lstarti:=0;
			Lstartj:=0;
			Lendi:=0;
			Lendj:=0;
		end;
		'R': begin
			Uendj:=2;
			Dendj:=2;
			Fendj:=2;
			Bstartj:=2;
			
			Rstarti:=0;
			Rstartj:=0;
			Rendi:=0;
			Rendj:=0;
		end;
		'F': begin
			Uendi:=2;
			Dstarti:=2;
			Lendj:=2;
			Rstartj:=2;
			
			Fstarti:=0;
			Fstartj:=0;
			Fendi:=0;
			Fendj:=0;
		end;
		'B': begin
			Ustarti:=2;
			Dendi:=2;
			Lstartj:=2;
			Rendj:=2;
			
			Bstarti:=0;
			Bstartj:=0;
			Bendi:=0;
			Bendj:=0;
		end;
	end;
	
	index:=glGenLists(1);
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
	CubeStaticPartDList:=index;
end;

function CubeRotatingPartDList(c: Cube; RotatedFace: char): GLUint;
var index: GLUint;
	Ustarti: Byte = 1; Ustartj: Byte = 1; Uendi: Byte = 3; Uendj: Byte = 3;  
	Dstarti: Byte = 1; Dstartj: Byte = 1; Dendi: Byte = 3; Dendj: Byte = 3;  
	Lstarti: Byte = 1; Lstartj: Byte = 1; Lendi: Byte = 3; Lendj: Byte = 3; 
	Rstarti: Byte = 1; Rstartj: Byte = 1; Rendi: Byte = 3; Rendj: Byte = 3; 
	Fstarti: Byte = 1; Fstartj: Byte = 1; Fendi: Byte = 3; Fendj: Byte = 3; 
	Bstarti: Byte = 1; Bstartj: Byte = 1; Bendi: Byte = 3; Bendj: Byte = 3; 
begin
	
	case RotatedFace of
		'U': begin
			Fendi:=1;
			Rendi:=1;
			Bendi:=1;
			Lendi:=1;
			
			Dstarti:=0;
			Dstartj:=0;
			Dendi:=0;
			Dendj:=0;
		end;
		'D': begin
			Fstarti:=3;
			Rstarti:=3;
			Bstarti:=3;
			Lstarti:=3;
			
			Ustarti:=0;
			Ustartj:=0;
			Uendi:=0;
			Uendj:=0;
		end;
		'L': begin
			Uendj:=1;
			Dendj:=1;
			Fendj:=1;
			Bstartj:=3;
			
			Rstarti:=0;
			Rstartj:=0;
			Rendi:=0;
			Rendj:=0;
		end;
		'R': begin
			Ustartj:=3;
			Dstartj:=3;
			Fstartj:=3;
			Bendj:=1;
			
			Lstarti:=0;
			Lstartj:=0;
			Lendi:=0;
			Lendj:=0;
		end;
		'F': begin
			Ustarti:=3;
			Dendi:=1;
			Lstartj:=3;
			Rendj:=1;
			
			Bstarti:=0;
			Bstartj:=0;
			Bendi:=0;
			Bendj:=0;
		end;
		'B': begin
			Uendi:=1;
			Dstarti:=3;
			Lendj:=1;
			Rstartj:=3;
			
			Fstarti:=0;
			Fstartj:=0;
			Fendi:=0;
			Fendj:=0;
		end;
	end;
	
	index:=glGenLists(1);
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
	CubeRotatingPartDList:=index;
end;

procedure AnimateTurnU(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'U'), CubeRotatingPartDList(c, 'U'), 1, 0, 0);
end;

procedure AnimateTurnIU(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'U'), CubeRotatingPartDList(c, 'U'), -1, 0, 0);
end;

procedure AnimateTurnD(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'D'), CubeRotatingPartDList(c, 'D'), -1, 0, 0);
end;

procedure AnimateTurnID(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'D'), CubeRotatingPartDList(c, 'D'), 1, 0, 0);
end;

procedure AnimateTurnL(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'L'), CubeRotatingPartDList(c, 'L'), 0, 1, 0);
end;

procedure AnimateTurnIL(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'L'), CubeRotatingPartDList(c, 'L'), 0, -1, 0);
end;

procedure AnimateTurnR(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'R'), CubeRotatingPartDList(c, 'R'), 0, -1, 0);
end;

procedure AnimateTurnIR(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'R'), CubeRotatingPartDList(c, 'R'), 0, 1, 0);
end;

procedure AnimateTurnF(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'F'), CubeRotatingPartDList(c, 'F'), 0, 0, 1);
end;

procedure AnimateTurnIF(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'F'), CubeRotatingPartDList(c, 'F'), 0, 0, -1);
end;

procedure AnimateTurnB(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'B'), CubeRotatingPartDList(c, 'B'), 0, 0, -1);
end;

procedure AnimateTurnIB(c: Cube);
begin
	Animate2ListsRotation(CubeStaticPartDList(c, 'B'), CubeRotatingPartDList(c, 'B'), 0, 0, 1);
end;

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
