Unit RubiksCube;

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

Procedure ExecuteString(s: String; Var c: Cube);
Procedure ExecuteMove(move: String; Var c: Cube);

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
Begin

End;
Procedure TurnIU(Var c: Cube);
begin
end;
Procedure TurnD(Var c: Cube);
begin
end;
Procedure TurnID(Var c: Cube);
begin
end;
Procedure TurnF(Var c: Cube);
begin
end;
Procedure TurnIF(Var c: Cube);
begin
end;
Procedure TurnB(Var c: Cube);
begin
end;
Procedure TurnIB(Var c: Cube);
begin
end;
Procedure TurnR(Var c: Cube);
begin
end;
Procedure TurnIR(Var c: Cube);
begin
end;
Procedure TurnL(Var c: Cube);
begin
end;
Procedure TurnIL(Var c: Cube);
begin
end;

Procedure ExecuteString(s: String; Var c: Cube); {Sve je to lepo ali fale komentari (na srpskom) ipak radis u "timu" :D}

Var i:   integer;
    buf:   string;
Begin
    buf := '';
    For i:=1 To length(s) Do
        Begin
            If s[i] In ['F', 'B', 'U', 'D', 'L', 'R'] Then
                Begin
                    ExecuteMove(buf+s[i], c);
                    buf := '';
                End
            Else If s[i]='I' Then buf := buf+'I';
        End;
End;

Procedure ExecuteMove(move: String; Var c: Cube);
Begin
    If move='F' Then TurnF(c)
    Else If move='IF' Then TurnIF(c)
    Else If move='B' Then TurnB(c)
    Else If move='IB' Then TurnIB(c)
    Else If move='U' Then TurnU(c)
    Else If move='IU' Then TurnIU(c)
    Else If move='D' Then TurnD(c)
    Else If move='ID' Then TurnID(c)
    Else If move='L' Then TurnL(c)
    Else If move='IL' Then TurnIL(c)
    Else If move='R' Then TurnR(c)
    Else If move='IR' Then TurnIR(c);
End;

End.
