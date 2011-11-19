
Unit input;

Interface

Uses RubiksCube, algorithm;

var buff: string;
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
procedure ProcessMouse(button, state, x ,y:longint; var c: Cube);
begin

end;
procedure ProcessMouseMotion(x, y:Longint; var c: Cube);
begin
	
end;

End.
