
Unit algorithm;

Interface

Uses RubiksCube;

Procedure ExecuteString(s: String; Var c: Cube); {Izvrsava vise naredbi, npr "FUDLIF"}
Procedure ExecuteMove(move: String; Var c: Cube); {Izvrsava jednu naredbu, npr "R" ili "IR"}

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
					writeln('Will execute ', buf+s[i]);
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
