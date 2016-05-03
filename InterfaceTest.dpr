program InterfaceTest;

{$APPTYPE CONSOLE}

uses
  Military in 'Military.pas';

var
  Military: TMilitary;

begin
  Military := TMilitary.Create;
  try
    Military.KillTheEnemy;
  finally
    Military.Free;
  end;

end.
