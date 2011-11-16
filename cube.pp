Unit algorithm;

Interface

Type Face =   array[1..3,1..3] Of char;
Type Cube = record
              F, B, U, D, L, R:Face;
            end;

Procedure sayHelloA;
Procedure TurnU(var c: Cube);
Procedure TurnIU(var c: Cube);
Procedure TurnD(var c: Cube);
Procedure TurnID(var c: Cube);
Procedure TurnF(var c: Cube);
procedure TurnIF(var c: Cube);
procedure TurnB(var c: Cube);
procedure TurnIB(var c: Cube);
procedure TurnR(var c: Cube);
procedure TurnIR(var c: Cube);
procedure TurnL(var c: Cube);
procedure TurnIL(var c: Cube);

Implementation

Procedure sayHelloA;
Begin
writeln('Hello from algorithm');
End;

End.
