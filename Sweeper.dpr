program Sweeper;

uses
  Forms,
  MineSweeper in 'MineSweeper.pas' {Main},
  Options in 'Options.pas' {FormOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
