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
    pom[1] := F[1, 1];
    pom[2] := F[1, 2];
    pom[3] := F[1. 3];
    F[1, 1] := R[1, 1];
    F[1, 2] := R[1, 2];
    F[1, 3] := R[1, 3];
    R[1, 1] := B[1, 1];
    R[1, 2] := B[1, 2];
    R[1, 3] := B[1, 3];
    B[1, 1] := L[1, 1];
    B[1, 2] := L[1, 2];
    B[1, 3] := L[1, 3];
    L[1, 1] := pom[1];
    L[1, 2] := pom[2];
    L[1, 3] := pom[3];
End;
Procedure TurnIU(Var c: Cube);
var
    pom : array [1..3] of char;
Begin
    TurnFaceCCW(c.U);
    pom[1] := F[1, 1];
    pom[2] := F[1, 2];
    pom[3] := F[1. 3];
    F[1, 1] := L[1, 1];
    F[1, 2] := L[1, 2];
    F[1, 3] := L[1, 3];
    L[1, 1] := B[1, 1];
    L[1, 2] := B[1, 2];
    L[1, 3] := B[1, 3];
    B[1, 1] := R[1, 1];
    B[1, 2] := R[1, 2];
    B[1, 3] := R[1, 3];
    R[1, 1] := pom[1];
    R[1, 2] := pom[2];
    R[1, 3] := pom[3];
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
    a[1] := F[1, 3]; 
    a[2] := F[2, 3]; 
    a[3] := F[3, 3];
    F[1, 3] := D[1, 3]; 
    F[2, 3] := D[2, 3]; 
    F[3, 3] := D[3, 3];
    D[1, 3] := B[3, 1];
    D[2, 3] := B[2, 1];
    D[3, 3] := B[1, 1];
    B[1, 1] := U[3, 3];
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
