unit algorithm;

interface

type Face=array[1..3,1..3] of char;
procedure sayHelloA;

implementation

procedure sayHelloA;
begin
	writeln('Hello from algorithm');
end;

end.