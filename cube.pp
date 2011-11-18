
Unit algorithm;

Interface

Type Face =   array[1..3,1..3] Of char;

Type Cube =   Record
    F, B, U, D, L, R:   Face;
End;

Procedure TurnU(Var c: Cube);
Procedure TurnIU(Var c: Cube);
Procedure TurnD(Var c: Cube);
Procedure TurnID(Var c: Cube);
Procedure TurnF(Var c: Cube);
Procedure TurnIF(Var c: Cube);
Procedure TurnB(Var c: Cube);
Procedure TurnIB(Var c: Cube);
Procedure TurnR(Var c: Cube);
Procedure TurnIR(Var c: Cube);
Procedure TurnL(Var c: Cube);
Procedure TurnIL(Var c: Cube);

Procedure TurnFaceCW(Var f: Face);
Procedure TurnFaceCCW(Var f: Face);

Procedure StartingCube(Var c: Cube);
Procedure Swap(Var a, b:char);

Implementation

Procedure Swap(Var a, b:char);

Var t:   char;
Begin
    t := a;
    a := b;
    b := t;
End;

Procedure FillFace(Var f: Face; color: Char);
Begin
    f[1, 1] := color;
    f[1, 2] := color;
    f[1, 3] := color;
    f[2, 1] := color;
    f[2, 2] := color;
    f[2, 3] := color;
    f[3, 1] := color;
    f[3, 2] := color;
    f[3, 3] := color;
End;

Procedure StartingCube(Var c: Cube);
Begin
	FillFace(c.F, 'G');
	FillFace(c.B, 'B');
	FillFace(c.U, 'W');
	FillFace(c.D, 'Y');
	FillFace(c.L, 'O');
	FillFace(c.R, 'R');
End;

Procedure TurnFaceCW(Var f: Face); {U smeru kazaljke na satu, centralno polje?}

Var   t:   Face;
Begin
    t[1, 3] := f[1, 1]; {3, 1 donji levi ugao kvadrata; 1, 1 gornji levi?}
    t[2, 3] := f[1, 2];
    t[3, 3] := f[1, 3];
    t[1, 2] := f[2, 1];
    t[2, 2] := f[2, 2];
    t[3, 2] := f[2, 3];
    t[1, 1] := f[3, 1];
    t[2, 1] := f[3, 2];
    t[3, 1] := f[3, 3];
    f := t;
End;

Procedure TurnFaceCCW(Var f: Face); {U obrnutom smeru od kazaljke na satu}

Var t:   Face;
Begin
    t[3, 1] := f[1, 1];
    t[2, 1] := f[1, 2];
    t[1, 1] := f[1, 3];
    t[3, 2] := f[2, 1];
    t[2, 2] := f[2, 2];
    t[1, 2] := f[2, 3];
    t[3, 3] := f[3, 1];
    t[2, 3] := f[3, 2];
    t[1, 3] := f[3, 3];
    t := f;
End;

Procedure TurnU(Var c: Cube);

Var i, j:   integer;
Begin

End;
Procedure TurnIU(Var c: Cube);
Procedure TurnD(Var c: Cube);
Procedure TurnID(Var c: Cube);
Procedure TurnF(Var c: Cube);
Procedure TurnIF(Var c: Cube);
Procedure TurnB(Var c: Cube);
Procedure TurnIB(Var c: Cube);
Procedure TurnR(Var c: Cube);
Procedure TurnIR(Var c: Cube);
Procedure TurnL(Var c: Cube);
Procedure TurnIL(Var c: Cube);

End.
