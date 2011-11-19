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

procedure TurnUpsideDown(var c: Cube);{Okrece kocku naglavacke}
var
 i,j:integer;
a:face;

begin
  for i := 1 to 3 do
    for j := 1 to 3 do
     a[i,j]:=c.d[i,j];
for i := 1 to 3 do
  for j:= 1 to 3 do begin
  c.d[i,j]:=c.u[i,j];
  c.u[i,j]:=a[i,j];
end;
TurnFaceCW(c.r); turnfaceCW(c.r);
TurnFaceCCW(c.L); TurnFaceCCw(c.l);

for i := 1 to 3 do
  for j := 1 to 3 do begin
    a[i,j]:=f.l[i,j];
c.f[1,1]:=c.b[3,3];
c.f[1,2]:=c.b[3,2];
c.f[1,3]:=c.b[3,1];
c.f[2,1]:=c.b[2,3];
c.f[2,2]:=c.b[2,2];
c.f[2,3]:=c.b[2,1];
c.f[3,1]:=c.b[1,3];
c.f[3,2]:=c.b[1,2];
c.f[3,3]:=c.b[1,1];
end;
end;

End.
