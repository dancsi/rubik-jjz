
Unit input;

Interface

Uses RubiksCube, algorithm, glut, gl, graphics;

Var buff:   string;
    prevX, prevY:   longint;
    TrackingMouseMovement:   boolean;
Procedure ProcessKeyboard(Key: Byte; X, Y: Longint; Var c: Cube);
Procedure ProcessMouse(button, state, x ,y:longint; Var c: Cube);
Procedure ProcessMouseMotion(x, y:Longint; Var c: Cube);
Procedure UpperCase(var c: Char);

Const MouseRotationScaleX =   0.1;
    MouseRotationScaleY =   -0.1;
	AtomicCubeRotation = 2;

Implementation

Procedure UpperCase(var c: Char);
begin
	if c in ['a'..'z'] then c:=chr(ord(c)+ord('A')-ord('a'));
end;

Procedure ProcessKeyboard(Key: Byte; X, Y: Longint; Var c: Cube);

Var ch:   char;
Begin
    If Key = 27 Then
        Halt(0);
    ch := chr(key);
	UpperCase(ch);
    If ch In FaceNames Then
        Begin
            ExecuteString(buff + ch, c);
            buff :=   '';
        End
    Else If ch='I' Then buff := 'I' else begin
		case ch of
			'8': begin
				 RotateCube(AtomicCubeRotation, 0, c);
			end;
			'5': begin 
				RotateCube(-AtomicCubeRotation, 0, c);
			end;
			'4': begin
				RotateCube(0, -AtomicCubeRotation, c);
			end;
			'6': begin
				RotateCube(0, AtomicCubeRotation, c);
			end;
			'7': begin
				yRot := -30;
				xRot := 20;
			end;
		end;
	end;
	//DumpCube(c);
End;

Procedure StartUpdatingRotation(x, y:longint);
Begin
    TrackingMouseMovement := true;
    prevX := x;
    prevY := y;
End;

Procedure StopUpdatingRotation();
Begin
    TrackingMouseMovement := false;
End;

Procedure ProcessMouse(button, state, x ,y:longint; Var c: Cube);
Begin
    If (button=GLUT_LEFT_BUTTON) And (state=GLUT_DOWN) Then
        Begin
            StartUpdatingRotation(x, y);
            RedrawScreen(c);
            writeln('click ''n'' redraw');
        End
    Else If (button=GLUT_LEFT_BUTTON) And (state=GLUT_DOWN) Then
             Begin
                 StopUpdatingRotation();
             End;
End;
Procedure ProcessMouseMotion(x, y:Longint; Var c: Cube);
Begin
    If (TrackingMouseMovement) Then
        Begin
            RotateCube(MouseRotationScaleX*(x-PrevX), MouseRotationScaleY*(y-PrevY), c);
            RedrawScreen(c);
        End;
End;

End.
