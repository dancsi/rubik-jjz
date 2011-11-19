Unit RubiksCube;

Interface

Type Face =   array[1..3,1..3] Of char;

Type Cube =   Record
    F, B, U, D, L, R:   Face;
End;

Const FaceNames =   ['F', 'B', 'U', 'D', 'L', 'R']; {Imena stranica}

Procedure TurnU(Var c: Cube); {Okrece stranu U u smeru kazaljke na satu}
Procedure TurnIU(Var c: Cube);
{Okrece stranu U u smeru suprotnom od smera kretanja kazaljke na satu}
Procedure TurnD(Var c: Cube); {Okrece stranu D u smeru kazaljke na satu}
Procedure TurnID(Var c: Cube);
{Okrece stranu D u smeru suprotnom od smera kretanja kazaljke na satu}
Procedure TurnF(Var c: Cube); {Okrece stranu F u smeru kazaljke na satu}
Procedure TurnIF(Var c: Cube);
{Okrece stranu F u smeru suprotnom od smera kretanja kazaljke na satu}
Procedure TurnB(Var c: Cube); {Okrece stranu B u smeru kazaljke na satu}
Procedure TurnIB(Var c: Cube);
{Okrece stranu B u smeru suprotnom od smera kretanja kazaljke na satu}
Procedure TurnR(Var c: Cube); {Okrece stranu R u smeru kazaljke na satu}
Procedure TurnIR(Var c: Cube);
{Okrece stranu R u smeru suprotnom od smera kretanja kazaljke na satu}
Procedure TurnL(Var c: Cube); {Okrece stranu L u smeru kazaljke na satu}
Procedure TurnIL(Var c: Cube);
{Okrece stranu L u smeru suprotnom od smera kretanja kazaljke na satu}

Procedure TurnFaceCW(Var f: Face);
{Okrece datu stranu f u smeru kretanja kazaljke na satu, ali pri tom ne dirajuci okolne strane}
Procedure TurnFaceCCW(Var f: Face);






{Okrece datu stranu f u smeru suprotnom od smera kretanja kazaljke na satu, ali pri tom ne dirajuci okolne strane}

Procedure StartingCube(Var c: Cube); {Podesava kocku na pocetni polozaj}
Procedure Swap(Var a, b:char); {Swapuje 2 karaktera}

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
    f := t;
End;

Procedure TurnU(Var c: Cube);
var
    pom : array [1..3] of char;
Begin
    TurnFaceCW(c.U);
    pom[1] := c.F[1, 1];
    pom[2] := c.F[1, 2];
    pom[3] := c.F[1, 3];
    c.F[1, 1] := c.R[1, 1];
    c.F[1, 2] := c.R[1, 2];
    c.F[1, 3] := c.R[1, 3];
    c.R[1, 1] := c.B[1, 1];
    c.R[1, 2] := c.B[1, 2];
    c.R[1, 3] := c.B[1, 3];
    c.B[1, 1] := c.L[1, 1];
    c.B[1, 2] := c.L[1, 2];
    c.B[1, 3] := c.L[1, 3];
    c.L[1, 1] := pom[1];
    c.L[1, 2] := pom[2];
    c.L[1, 3] := pom[3];
End;
Procedure TurnIU(Var c: Cube);
var
    pom : array [1..3] of char;
Begin
    TurnFaceCW(c.U);
    pom[1] := c.F[1, 1];
    pom[2] := c.F[1, 2];
    pom[3] := c.F[1, 3];
    c.F[1, 1] := c.L[1, 1];
    c.F[1, 2] := c.L[1, 2];
    c.F[1, 3] := c.L[1, 3];
    c.L[1, 1] := c.B[1, 1];
    c.L[1, 2] := c.B[1, 2];
    c.L[1, 3] := c.B[1, 3];
    c.B[1, 1] := c.R[1, 1];
    c.B[1, 2] := c.R[1, 2];
    c.B[1, 3] := c.R[1, 3];
    c.R[1, 1] := pom[1];
    c.R[1, 2] := pom[2];
    c.R[1, 3] := pom[3];
End;
Procedure TurnD(Var c: Cube);
Begin
End;
Procedure TurnID(Var c: Cube);
Begin
End;
Procedure TurnF(Var c: Cube);
Begin
End;
Procedure TurnIF(Var c: Cube);
Begin
End;
Procedure TurnB(Var c: Cube);
Begin
End;
Procedure TurnIB(Var c: Cube);
Begin
End;
Procedure TurnR(Var c: Cube);
var
    pom : array [1..3] of char;
Begin
    TurnFaceCW(c.R);
    a[1] := c.F[1, 3]; 
    a[2] := c.F[2, 3]; 
    a[3] := c.F[3, 3];
    c.F[1, 3] := c.D[1, 3]; 
    c.F[2, 3] := c.D[2, 3]; 
    c.F[3, 3] := c.D[3, 3];
    c.D[1, 3] := c.B[3, 1];
    c.D[2, 3] := c.B[2, 1];
    c.D[3, 3] := c.B[1, 1];
    c.B[1, 1] := c.U[3, 3];
	{ovo treba zavrsiti}
End;
Procedure TurnIR(Var c: Cube);
Begin
End;
Procedure TurnL(Var c: Cube);
Begin
End;
Procedure TurnIL(Var c: Cube);
Begin
End;

End.
