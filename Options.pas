unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TFormOptions = class(TForm)
    Columns: TMaskEdit;
    Rows: TMaskEdit;
    Bombs: TMaskEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btBeginner: TRadioButton;
    btIntermediate: TRadioButton;
    btAdvanced: TRadioButton;
    Label4: TLabel;
    Label5: TLabel;
    procedure btAdvancedClick(Sender: TObject);
    procedure btIntermediateClick(Sender: TObject);
    procedure btBeginnerClick(Sender: TObject);
    procedure UpdateRadioButton(RadioButton : TRadioButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOptions: TFormOptions;

implementation

{$R *.dfm}

procedure TFormOptions.btAdvancedClick(Sender: TObject);
begin                                         
  formOptions.Rows.Text    := IntToStr(24);
  formOptions.Columns.Text := IntToStr(24);
  formOptions.Bombs.Text   := IntToStr(99);
end;

procedure TFormOptions.btIntermediateClick(Sender: TObject);
begin       
  formOptions.Rows.Text    := IntToStr(16);
  formOptions.Columns.Text := IntToStr(16);
  formOptions.Bombs.Text   := IntToStr(40);
end;

procedure TFormOptions.btBeginnerClick(Sender: TObject);
begin
  formOptions.Rows.Text    := IntToStr(9);
  formOptions.Columns.Text := IntToStr(9);
  formOptions.Bombs.Text   := IntToStr(10);
end;

procedure TFormOptions.UpdateRadioButton(RadioButton: TRadioButton);
var
 i : Integer;
begin
  for i := 0 to FormOptions.ComponentCount - 1 do
  begin
  if FormOptions.Components[i] is TRadioButton then
    if TRadioButton(FormOptions.Components[i]) <> RadioButton then
       TRadioButton(FormOptions.Components[i]).Checked := False;
  end;
end;
end.
