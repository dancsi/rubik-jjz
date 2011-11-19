
Unit input;

Interface

Uses RubiksCube, algorithm, glut, gl, graphics;

Var buff:   string;
    prevX, prevY:   longint;
    TrackingMouseMovement:   boolean;
Procedure ProcessKeyboard(Key: Byte; X, Y: Longint; Var c: Cube);
Procedure ProcessMouse(button, state, x ,y:longint; Var c: Cube);
Procedure ProcessMouseMotion(x, y:Longint; Var c: Cube);

Const MouseRotationScaleX =   0.1;
    MouseRotationScaleY =   -0.1;

Implementation

Procedure ProcessKeyboard(Key: Byte; X, Y: Longint; Var c: Cube);

Var ch:   char;
Begin
    If Key = 27 Then
        Halt(0);
    ch := chr(key);
    If ch In FaceNames Then
        Begin
            ExecuteString(buff + ch, c);
            buff :=   '';
        End
    Else If ch='I' Then buff := 'I';
    writeln(ch);
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
