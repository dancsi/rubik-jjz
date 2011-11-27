Unit algorithm;

Interface

Uses RubiksCube;

Procedure ExecuteString(s: String; Var c: Cube); {Izvrsava vise naredbi, npr "FUDLIF"}
Procedure ExecuteMove(move: String; Var c: Cube); {Izvrsava jednu naredbu, npr "R" ili "IR"}
Function Shuffle(Var c: Cube):   string; {Stavlja kocku u slucajan polozaj}
Function Solved(c: Cube):   boolean; {Da li je kocka resena}
Function Solve(Var c: Cube):   string; {Resava kocku. Samo ovo se poziva iz glavnog programa}
Procedure TurnUpsideDown(Var c: Cube); {Okrece kocku naglavacke}
Function NextMove(Var c: Cube):   string;
{Odlucuje koji ce biti sledeci potez i vraca string sa naredbama}
Function DoUpperLayer(Var c: Cube):   string; {Slaze gornji sloj}
Function DoMiddleLayer(Var c: Cube):   string; {Slaze Srednji sloj}
Function DoLowerLayer(Var c: Cube):   string; {Slaze donji sloj}

Implementation

Procedure ExecuteString(s: String; Var c: Cube);
{Sve je to lepo ali fale komentari (na srpskom) ipak radis u "timu" :D}

Var i:   integer;
    buf:   string;
Begin
    buf := '';
    For i:=1 To length(s) Do
        Begin
            If s[i] In FaceNames Then
                Begin
                    write('moves: ');
                    ExecuteMove(buf+s[i], c);
                    writeln;
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

Function NextMove(Var c: Cube):   string;
Begin
    NextMove := '';
End;

Function Solved(c: Cube):   Boolean;
Begin
    Solved := false;
End;

Function Shuffle(Var c: Cube):   string;
Begin
    Shuffle := '';
End;

Function Solve(Var c: Cube):   string;

Var moves:   string;
Begin
    While Not Solved(c) Do
        Begin
            moves := moves+NextMove(c);
        End;
    Solve := moves;
End;

Procedure TurnUpsideDown(Var c: Cube);{Okrece kocku naglavacke}

Var 
    i,j:   integer;
    a:   face;

Begin
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


    c.b[1,1] := c.a[3,3];
    c.b[1,2] := c.a[3,2];
    c.b[1,3] := c.a[3,1];
    c.b[2,1] := c.a[2,3];
    c.b[2,2] := c.a[2,2];
    c.b[2,3] := c.a[2,1];
    c.b[3,1] := c.a[1,3];
    c.b[3,2] := c.a[1,2];
    c.b[3,3] := c.a[1,1];

End;

Function DoUpperLayer(Var c: Cube):   string; {Slaze gornji sloj}
Begin
    DoUpperLayer := '';
End;
Function DoMiddleLayer(Var c: Cube):   string; {Slaze Srednji sloj}
Begin
    DoMiddleLayer := '';
End;
Function DoLowerLayer(Var c: Cube):   string; {Slaze donji sloj}
Begin
    DoLowerLayer := '';
End;

End.
