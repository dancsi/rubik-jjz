Unit algorithm;

Interface

Type Face =   array[1..3,1..3] Of char;
Type Cube = record
              F, B, U, D, L, R:Face;
            end;

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

procedure TurnFaceCW(var f: Face);
procedure TurnFaceCCW(var f: Face);

Procedure Swap(var a, b:char);

Implementation

Procedure Swap(var a, b:char);
var t:char;
begin
	t:=a;
	a:=b;
	b:=t;
end;

procedure TurnFaceCW(var f: Face);
var		i, j:integer;
			t: Face;
begin
	for i:=1 to 3 do begin
		for j:=1 to 3 do begin
			t[3, 1]:=f[1, 1];
			t[2, 3]:=f[][]
		end;
	end;
end;

procedure TurnFaceCCW(var f: Face);
var tmp: Face;
		i, j:integer;
begin

end;

Procedure TurnU(var c: Cube);
var i, j:integer;
begin
	
end;
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

End.
