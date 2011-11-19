
Unit input;

Interface

Uses RubiksCube, algorithm, glut;

var buff: string;
	prevX, prevY:longint;
	TrackingMouseMovement: boolean;
procedure ProcessKeyboard(Key: Byte; X, Y: Longint; var c: Cube);
procedure ProcessMouse(button, state, x ,y:longint; var c: Cube);
procedure ProcessMouseMotion(x, y:Longint; var c: Cube);

Implementation

procedure ProcessKeyboard(Key: Byte; X, Y: Longint; var c: Cube);
Var ch:   char;
Begin
    If Key = 27 Then
        Halt(0);
    ch := chr(key);
    If ch In FaceNames Then
        Begin
            ExecuteString(buff, c);
            buff :=   '';
        End
    Else If ch='I' Then buff := 'I';
    writeln(ch);
End;

procedure StartUpdatingRotation(x, y:longint);
begin
	TrackingMouseMovement:=true;
	prevX:=x;
	prevY:=y;
end;

procedure StopUpdatingRotation();
begin
	TrackingMouseMovement:=false;
end;

procedure ProcessMouse(button, state, x ,y:longint; var c: Cube);
begin
	if (button=GLUT_LEFT_BUTTON) and (state=GLUT_DOWN) then begin
		StartUpdatingRotation(x, y);
	end else if (button=GLUT_LEFT_BUTTON) and (state=GLUT_DOWN) then begin
		StopUpdatingRotation();
	end;
end;
procedure ProcessMouseMotion(x, y:Longint; var c: Cube);
begin
	if 
end;

End.
