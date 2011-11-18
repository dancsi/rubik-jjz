
Unit graphics;

{$mode objfpc}{$H+}

Interface

Uses 
RubiksCube, dglOpenGL;

Const 
    AppWidth =   640;
    AppHeight =   480;

Procedure InitializeGraphics;
Procedure FinalizeGraphics;
Procedure DrawCube(c: Cube);

Implementation

Procedure InitializeGraphics;
Begin

End;

Procedure DrawCube(c: Cube);
Begin
End;

Procedure FinalizeGraphics;
Begin
End;

initialization

{$IFDEF CPU386}
Set8087CW($133F);
{$ENDIF}
InitializeGraphics;

finalization

FinalizeGraphics;

End.
