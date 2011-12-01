
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

Procedure TurnUpsideDown(Var c: Cube);{Okrece kocku naglavacke}

Procedure TurnFaceCW(Var f: Face);
{Okrece datu stranu f u smeru kretanja kazaljke na satu, ali pri tom ne dirajuci okolne strane}
Procedure TurnFaceCCW(Var f: Face);
{Okrece datu stranu f u smeru suprotnom od smera kretanja kazaljke na satu, ali pri tom ne dirajuci okolne strane}

Procedure DumpCube(c: Cube);

Procedure StartingCube(Var c: Cube); {Podesava kocku na pocetni polozaj}
Procedure Swap(Var a, b:char); {Swapuje 2 karaktera}

Implementation

Uses graphics;

Procedure Swap(Var a, b:char);

Var t:   char;
Begin
    t := a;
    a := b;
    b := t;
End;

Procedure DumpFace(f: Face);
Begin
    writeln(f[1, 1]:2, f[1, 2]:2, f[1, 3]:2);
    writeln(f[2, 1]:2, f[2, 2]:2, f[2, 3]:2);
    writeln(f[3, 1]:2, f[3, 2]:2, f[3, 3]:2);
End;

Procedure DumpCube(c: Cube);
Begin
    writeln('F');
    DumpFace(c.F);
    writeln('B');
    DumpFace(c.B);
    writeln('U');
    DumpFace(c.U);
    writeln('D');
    DumpFace(c.D);
    writeln('L');
    DumpFace(c.L);
    writeln('R');
    DumpFace(c.R);
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

Var 
    pom :   array [1..3] Of char;
Begin
    AnimateTurnU(c);
    write('TurnU ');
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

Var 
    pom :   array [1..3] Of char;
Begin
    AnimateTurnIU(c);
    write('IU ');
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

Var 
    a :   array[1..3] Of char;
Begin
    AnimateTurnD(c);
    write('D ');
    TurnFaceCW(c.D);
    a[1] := c.F[3,1];
    a[2] := c.F[3,2];
    a[3] := c.F[3,3];
    c.F[3,1] := c.L[3,1];
    c.F[3,2] := c.L[3,2];
    c.F[3,3] := c.L[3,3];
    c.L[3,1] := c.B[3,1];
    c.L[3,2] := c.B[3,2];
    c.L[3,3] := c.B[3,3];
    c.B[3,1] := c.R[3,1];
    c.B[3,2] := c.R[3,2];
    c.B[3,3] := c.R[3,3];
    c.R[3,1] := a[1];
    c.R[3,2] := a[2];
    c.R[3,3] := a[3];
End;
Procedure TurnID(Var c: Cube);

Var 
    a :   array[1..3] Of char;
Begin
    AnimateTurnID(c);
    write('ID ');
    TurnFaceCCW(c.D);
    a[1] := c.F[3,1];
    a[2] := c.F[3,2];
    a[3] := c.F[3,3];
    c.F[3,1] := c.R[3,1];
    c.F[3,2] := c.R[3,2];
    c.F[3,3] := c.R[3,3];
    c.R[3,1] := c.B[3,1];
    c.R[3,2] := c.B[3,2];
    c.R[3,3] := c.B[3,3];
    c.B[3,1] := c.L[3,1];
    c.B[3,2] := c.L[3,2];
    c.B[3,3] := c.L[3,3];
    c.L[3,1] := a[1];
    c.L[3,2] := a[2];
    c.L[3,3] := a[3];
End;
Procedure TurnF(Var c: Cube);

Var a1, a2, a3:   char;
Begin
    AnimateTurnF(c);
    TurnFaceCW(c.F);
    a1 := c.U[3, 1];
    a2 := c.U[3, 2];
    a3 := c.U[3, 3];
    c.U[3, 1] := c.L[1, 3];
    c.U[3, 2] := c.L[2, 3];
    c.U[3, 3] := c.L[3, 3];
    c.L[1, 3] := c.D[1, 1];
    c.L[2, 3] := c.D[1, 2];
    c.L[3, 3] := c.D[1, 3];
    c.D[1, 1] := c.R[3, 1];
    c.D[1, 2] := c.R[2, 1];
    c.D[1, 3] := c.R[1, 1];
    c.R[1, 1] := a1;
    c.R[2, 1] := a2;
    c.R[3, 1] := a3;
    write('F ');
End;
Procedure TurnIF(Var c: Cube);

Var a1, a2, a3:   char;
Begin
    AnimateTurnIF(c);
    TurnFaceCCW(c.F);
    a3 := c.R[3, 1];
    a2 := c.R[2, 1];
    a1 := c.R[1, 1];
    c.R[1, 1] := c.D[1, 3];
    c.R[2, 1] := c.D[1, 2];
    c.R[3, 1] := c.D[1, 1];
    c.D[1, 3] := c.L[3, 3];
    c.D[1, 2] := c.L[2, 3];
    c.D[1, 1] := c.L[1, 3];
    c.L[3, 3] := c.U[3, 3];
    c.L[2, 3] := c.U[3, 2];
    c.L[1, 3] := c.U[3, 1];
    c.U[3, 3] := a3;
    c.U[3, 2] := a2;
    c.U[3, 1] := a1;
    write('IF ');
End;
Procedure TurnB(Var c: Cube);
Begin
    AnimateTurnB(c);
    write('B ');
End;
Procedure TurnIB(Var c: Cube);
Begin
    AnimateTurnIB(c);
    write('IB ');
End;
Procedure TurnR(Var c: Cube);

Var 
    a :   array [1..3] Of char;
Begin
    AnimateTurnR(c);
    write('R ');
    TurnFaceCW(c.R);
    a[1] := c.F[1, 3];
    a[2] := c.F[2, 3];
    a[3] := c.F[3, 3];
    c.F[1,3] := c.D[1,3];
    c.F[2,3] := c.D[2,3];
    c.F[3,3] := c.D[3,3];
    c.D[1,3] := c.B[3,1];
    c.D[2,3] := c.B[2,1];
    c.D[3,3] := c.B[1,1];
    c.B[1,1] := c.U[3,3];
    c.B[2,1] := c.U[2,3];
    c.B[3,1] := c.U[1,3];
    c.U[1,3] := a[1];
    c.U[2,3] := a[2];
    c.U[3,3] := a[3];;
End;
Procedure TurnIR(Var c: Cube);

Var 
    a :   array [1..3] Of char;
Begin
    AnimateTurnIR(c);
    write('IR ');
    TurnFaceCCW(c.R);
    a[1] := c.F[1, 3];
    a[2] := c.F[2, 3];
    a[3] := c.F[3, 3];
    c.F[1,3] := c.U[1,3];
    c.F[2,3] := c.U[2,3];
    c.F[3,3] := c.U[3,3];
    c.U[1,3] := c.B[3,1];
    c.U[2,3] := c.B[2,1];
    c.U[3,3] := c.B[1,1];
    c.B[1,1] := c.D[3,3];
    c.B[2,1] := c.D[2,3];
    c.B[3,1] := c.D[1,3];
    c.D[1,3] := a[1];
    c.D[2,3] := a[2];
    c.D[3,3] := a[3];;
End;
Procedure TurnL(Var c: Cube);

Var 
    a:   array [1..3] Of char;
Begin
    AnimateTurnL(c);
    write('L ');
    TurnFaceCw(c.L);
    a[1] := c.F[1,1];
    a[2] := c.F[2,1];
    a[3] := c.F[3,1];
    c.F[1,1] := c.U[1,1];
    c.F[2,1] := c.U[2,1];
    c.F[3,1] := c.U[3,1];
    c.U[1,1] := c.B[3,3];
    c.U[2,1] := c.B[2,3];
    c.U[3,1] := c.B[1,3];
    c.B[1,3] := c.D[3,1];
    c.B[2,3] := c.D[2,1];
    c.B[3,3] := c.D[1,1];
    c.D[1,1] := a[1];
    c.D[2,1] := a[2];
    c.D[3,1] := a[3];
End;
Procedure TurnIL(Var c: Cube);

Var 
    a:   array[1..3] Of char;

Begin
    AnimateTurnIL(c);
    write('IL ');
    TurnFaceCCW(c.L);
    a[1] := c.D[3,1];
    a[2] := c.D[2,1];
    a[3] := c.D[1,1];
    c.D[3,1] := c.B[1,3];
    c.D[2,1] := c.B[2,3];
    c.D[1,1] := c.B[3,3];
    c.B[1,3] := c.U[3,1];
    c.B[2,3] := c.U[2,1];
    c.B[3,3] := c.U[1,1];
    c.U[1,1] := c.F[1,1];
    c.U[2,1] := c.F[2,1];
    c.U[3,1] := c.F[3,1];
    c.F[1,1] := a[3];
    c.F[2,1] := a[2];
    c.F[3,1] := a[1];

End;

Procedure TurnUpsideDown(Var c: Cube);{Okrece kocku naglavacke}

Var 
    i,j:   integer;
    a:   face;

Begin
    AnimateTurnUpsideDown(c);
    a := c.d;
    c.d := c.u;
    c.u := a;   {zamena gornje i donje strane}

    TurnFaceCW(c.r);
    turnfaceCW(c.r);        {rotiranje desne i leve strane}
    TurnFaceCCW(c.L);
    TurnFaceCCw(c.l);

    a := c.f;               {zamena prednje i zadnje strane}

    c.f[1,1] := c.b[3,3];
    c.f[1,2] := c.b[3,2];
    c.f[1,3] := c.b[3,1];
    c.f[2,1] := c.b[2,3];
    c.f[2,2] := c.b[2,2];
    c.f[2,3] := c.b[2,1];
    c.f[3,1] := c.b[1,3];
    c.f[3,2] := c.b[1,2];
    c.f[3,3] := c.b[1,1];


    c.b[1,1] := a[3,3];
    c.b[1,2] := a[3,2];
    c.b[1,3] := a[3,1];
    c.b[2,1] := a[2,3];
    c.b[2,2] := a[2,2];
    c.b[2,3] := a[2,1];
    c.b[3,1] := a[1,3];
    c.b[3,2] := a[1,2];
    c.b[3,3] := a[1,1];

End;

End.
