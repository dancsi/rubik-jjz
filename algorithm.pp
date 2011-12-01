
Unit algorithm;

Interface

Uses RubiksCube;

Procedure ExecuteString(s: String; Var c: Cube); {Izvrsava vise naredbi, npr "FUDLIF"}
Procedure ExecuteMove(move: String; Var c: Cube); {Izvrsava jednu naredbu, npr "R" ili "IR"}
Function Shuffle(Var c: Cube):   string; {Stavlja kocku u slucajan polozaj}
Function Solved(c: Cube):   boolean; {Da li je kocka resena}
Function Solve(Var c: Cube):   string; {Resava kocku. Samo ovo se poziva iz glavnog programa}
Function NextMove(Var c: Cube):   string;
{Odlucuje koji ce biti sledeci potez i vraca string sa naredbama}
Function DoUpperLayer(Var c: Cube):   string; {Slaze gornji sloj}
Function DoMiddleLayer(Var c: Cube):   string; {Slaze Srednji sloj}
Function DoLowerLayer(Var c: Cube):   string; {Slaze donji sloj}

Implementation

Procedure ExecuteString(s: String; Var c: Cube);

Var i:   integer;
    buf:   string;
Begin
    buf := '';
    For i:=1 To length(s) Do
        Begin
            If s[i] In (FaceNames + ['S', 'X'])   Then
                Begin
                    //write('moves: ');
                    ExecuteMove(buf+s[i], c);
                    writeln;
                    buf := '';
                End
            Else If s[i]='I' Then buf := 'I'
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
    Else If move='IR' Then TurnIR(c)
    Else If move='X' Then TurnUpsideDown(c)
    Else If move='S' Then Shuffle(c)
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

Var r, t:   string;
    n, i:   integer;
Begin
    writeln('Shuffle!');
    r := '';
    n := 1+random(20);
    t := 'FBUDLR';
    For i:=1 To n Do
        r := r+t[1+random(6)];
    ExecuteString(r, c);
    Shuffle := r;
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
