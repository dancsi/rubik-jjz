
Unit algorithm;

Interface

Uses RubiksCube;

Procedure ExecuteString(s: String; Var c: Cube); {Izvrsava vise naredbi, npr "FUDLIF"}
Procedure ExecuteMove(move: String; Var c: Cube); {Izvrsava jednu naredbu, npr "R" ili "IR"}
function Shuffle(var c: Cube): string; {Stavlja kocku u slucajan polozaj}
function Solved(c: Cube):boolean; {Da li je kocka resena}
function Solve(var c: Cube): string; {Resava kocku. Samo ovo se poziva iz glavnog programa}
procedure TurnUpsideDown(var c: Cube); {Okrece kocku naglavacke}
function NextMove(var c: Cube): string; {Odlucuje koji ce biti sledeci potez i vraca string sa naredbama}
function DoUpperLayer(var c: Cube): string; {Slaze gornji sloj}
function DoMiddleLayer(var c: Cube): string; {Slaze Srednji sloj}
function DoLowerLayer(var c: Cube): string; {Slaze donji sloj}

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

function NextMove(var c: Cube):string;
begin
	NextMove:='';
end;

function Solved(c: Cube): Boolean;
begin
	Solved:=false;
end;

function Shuffle(var c: Cube): string;
begin
	Shuffle:='';
end;

function Solve(var c: Cube): string;
var moves: string;
begin
	while not Solved(c) do begin
		moves:= moves+NextMove(c);
	end;
	Solve:=moves;
end;

procedure TurnUpsideDown(var c: Cube); {Okrece kocku naglavacke}
begin
end;

End.
