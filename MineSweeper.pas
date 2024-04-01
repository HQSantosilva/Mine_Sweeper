unit MineSweeper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, JvExControls, JvgDigits, Menus;

type
  TButtonState = (bsHidden, bsEmpty, bsBomb, bsFlag, bsNumber);

  TBitBtn = class(Buttons.TBitBtn)
  private
    FTagPrevious: Integer;
    FRow: Integer;
    FCol: Integer;
  public
    property TagPrevious: Integer read FTagPrevious write FTagPrevious;
  end;

  TMain = class(TForm)
    Panel1: TPanel;
    BombCounter: TJvgDigits;
    MainMenu1: TMainMenu;
    Reset: TMenuItem;
    N1: TMenuItem;
    btFace: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btResetClick(Sender: TObject);
    procedure HandleButtonClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    RowCount: Integer;
    ColCount: Integer;
    BombCount: Integer;
    FieldCount: Integer;
    BombCol: array of Integer;
    BombRow: array of Integer;
    Fields: array of TBitBtn;
    GameStarted: Boolean;
    procedure CreateButtons;
    procedure PositionButtons;
    procedure SetBombValues;
    function CheckNumbers(Col,Row : Integer): Integer;
    function CheckBombs(Row, Col: Integer): Boolean;
    procedure LeftButtonClick(Sender: TObject);
    procedure RightButtonClick(Sender: TObject);
    procedure RevealButton(Button: TBitBtn);
    procedure RevealEmptyButtons(Row, Col: Integer);  
    procedure RevealAdjacentButtons(Row, Col: Integer);
    procedure RevealAdjacentNumbers(Row, Col: Integer);
    end;

var
  Main: TMain;

implementation

uses
  Options, Math;

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
begin
  randomize();
  GameStarted := False;
  BombCounter.BackgroundColor := clBlack;
  btFace.Glyph.LoadFromFile('Face_Neutral.bmp');
end;

procedure TMain.btResetClick(Sender: TObject);
  procedure CreateWindowVariables;
  begin
    SetLength(Fields, 0);
    GameStarted := True;
    Application.CreateForm(TFormOptions, formOptions);
    formOptions.Left := Left;
    formOptions.Top := Top;
  end;
  procedure SetGameVariables;
  begin
    BombCounter.BackGroundColor := clBlack;
    BombCounter.Value := BombCount;
    FieldCount := RowCount * ColCount;
    SetBombValues;
    CreateButtons;
    PositionButtons;
    btFace.Glyph.LoadFromFile('Face_Neutral.bmp');
  end;
begin    
  SetLength(BombCol, 0);
  SetLength(BombRow, 0);     
  SetLength(Fields, 0);
  CreateWindowVariables;
  if  RowCount <> 0 then
  begin
    formOptions.Rows.Text    := IntToStr(RowCount);
    formOptions.Columns.Text := IntToStr(ColCount);
    formOptions.Bombs.Text   := IntToStr(BombCount);
  end;
  if Sender is TMenuItem then
  begin
    if formOptions.ShowModal = mrOk then
    begin
      RowCount  := StrToInt(Trim(formOptions.Rows.Text));
      ColCount  := StrToInt(Trim(formOptions.Columns.Text));
      BombCount := StrToInt(Trim(formOptions.Bombs.Text));
    end;
  end
  else
  begin
    if  RowCount = 0 then
    begin
      RowCount := 9;
      ColCount := 9;
      BombCount:= 10;
    end;
  end;
  SetGameVariables;
end;

procedure TMain.SetBombValues;
var
 BombAmount : Integer;
begin
  SetLength(BombCol, BombCount);
  SetLength(BombRow, BombCount);

  for BombAmount := 0 to BombCount - 1 do
  begin
    BombCol[BombAmount] := RandomRange(0,ColCount);
    BombRow[BombAmount] := RandomRange(0,RowCount);
  end;
end;

procedure TMain.CreateButtons;
var
  i: Integer;
begin
  SetLength(Fields, FieldCount);
  for i := 0 to FieldCount - 1 do
  begin
    Fields[i] := TBitBtn.Create(Self);
    Fields[i].Parent      := Main;
    Fields[i].Width       := 25;
    Fields[i].Height      := 25;
    Fields[i].Caption     := EmptyStr;
    Fields[i].Visible     := True;
    Fields[i].Enabled     := True;
    Fields[i].Tag         := Integer(bsHidden);
    Fields[i].TagPrevious := Integer(bsHidden);
    Fields[i].Spacing     := 0;
    Fields[i].OnMouseDown := HandleButtonClick;
    Fields[i].OnMouseUp := HandleMouseUp;
  end;
end;

procedure TMain.PositionButtons;
var
  Count, pTop, pLeft, Col, Row, Number: Integer;
  FoundBomb : Boolean;
  procedure SetNumber;
  begin
    Number := CheckNumbers(Col,Row);
    if (Number > 0 )then
    begin
      Fields[Count].FTagPrevious := Ord(bsNumber);
      Fields[Count].HelpKeyWord := IntToStr(Number);
    end
    else
       Fields[Count].FTagPrevious := Ord(bsEmpty);
  end;
  procedure SetBomb;
  var
    i : Integer;
  begin
    FoundBomb := False;
    for i := 0 to BombCount - 1 do
    begin   
      if (BombCol[i] = Col) and
        (BombRow[i] = Row)then
      begin                                 
        Fields[Count].FTagPrevious := Ord(bsBomb);
        FoundBomb := True;
      end;
    end;
    if not FoundBomb then
       SetNumber;
  end;
begin
  pLeft := 0;
  Count := 0;
  pTop := 52;
  for Row := 0 to RowCount - 1 do
  begin
    pLeft := 0;
    for Col := 0 to ColCount - 1 do
    begin
      Fields[Count].FRow := Row;
      Fields[Count].FCol := Col;
      Fields[Count].Top := pTop;
      Fields[Count].Left := pLeft;
      pLeft := pLeft + 25;
      SetBomb;
      Inc(Count);
    end;
    pTop := pTop + 25;
  end;
  Height := pTop + 50;
  Width := pLeft;
  btFace.Left := Round(pLeft / 2) - 20;
end;

function TMain.CheckNumbers(Col, Row: Integer): Integer;
begin
Result := 0;

if CheckBombs(Row - 1,Col) then
  Inc(Result);

if CheckBombs(Row + 1,Col) then
  Inc(Result);

if CheckBombs(Row,Col + 1) then
  Inc(Result);

if CheckBombs(Row,Col - 1) then
  Inc(Result);

if CheckBombs(Row - 1,Col + 1) then
  Inc(Result);

if CheckBombs(Row + 1,Col - 1) then
  Inc(Result);

if CheckBombs(Row - 1,Col - 1) then
  Inc(Result);

if CheckBombs(Row + 1,Col + 1) then
  Inc(Result);
end;

function TMain.CheckBombs(Row, Col: Integer): Boolean;
var
 BombAmount : Integer;
begin
Result:= False;
  for BombAmount := 0 to BombCount - 1 do
  begin
    if (BombCol[BombAmount] = Col) and
      (BombRow[BombAmount] = Row) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TMain.HandleButtonClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ButtonClicked: TBitBtn;
begin
  if GameStarted then
  begin
    ButtonClicked := Sender as TBitBtn;
    if Button = mbRight then
      RightButtonClick(ButtonClicked)
    else
      btFace.Glyph.LoadFromFile('Face_Surprise.bmp');
  end;
end;

procedure TMain.LeftButtonClick(Sender: TObject);
var
  Button: TBitBtn;
  i : Integer;
begin
  Button := Sender as TBitBtn;

  case TButtonState(Button.FTagPrevious) of
    bsBomb:
      begin
        for i := 0 to FieldCount - 1 do
        begin
          if Fields[i].TagPrevious = Ord(bsBomb) then
            RevealButton(Fields[i]);
        end;
          GameStarted := False;
        btFace.Glyph.LoadFromFile('Face_Game_Over.bmp');
      end;
  else
       RevealButton(Button);
  end;
    
  if GameStarted then
    btFace.Glyph.LoadFromFile('Face_Neutral.bmp');
end;

procedure TMain.RightButtonClick(Sender: TObject);
var
  Counter: Double;
  Button: TBitBtn;
begin
  Button := Sender as TBitBtn;
  Counter:= BombCounter.Value;
  if GameStarted then
  begin
    case TButtonState(Button.FTagPrevious) of
      bsHidden:
      begin
        Button.Tag := Integer(bsHidden);
        Button.FTagPrevious := Integer(bsFlag);
        Button.Glyph.LoadFromFile('Flag.bmp');
      end;
      bsFlag:
      begin
        case TButtonState(Button.Tag) of
         bsHidden:
           Button.FTagPrevious := Integer(bsHidden);
         bsNumber:
           Button.FTagPrevious := Integer(bsNumber);
         bsEmpty:
           Button.FTagPrevious := Integer(bsEmpty);
        end;
        Button.Glyph := nil; // Remove a imagem de bandeira
      end;   
      bsNumber:
      begin
        Button.Tag := Integer(bsNumber);
        Button.FTagPrevious := Integer(bsFlag);
        Button.Glyph.LoadFromFile('Flag.bmp');
      end;
      bsBomb:
      begin
        Counter:= Counter -1;
        BombCounter.Value := Counter;
        BombCounter.BackgroundColor := clBlack;
        Button.FTagPrevious := Integer(bsFlag);
        Button.Glyph.LoadFromFile('Flag.bmp');
        if Counter = 0 then
        begin
          ShowMessage('You win');
          GameStarted := False;
        end;
      end;
      bsEmpty:
      begin
        Button.Tag := Integer(bsEmpty);
        Button.FTagPrevious := Integer(bsFlag);
        Button.Glyph.LoadFromFile('Flag.bmp');
      end;
    end;
  end;                                     
  BombCounter.BackgroundColor := clBlack;
end;

procedure TMain.RevealButton(Button: TBitBtn);
begin
  case TButtonState(Button.FTagPrevious) of
    bsEmpty:
    begin
      Button.Glyph.LoadFromFile('White.bmp');
      RevealEmptyButtons(Button.FRow, Button.FCol);
    end;
    bsNumber:
    begin
      Button.Enabled := False;
      Button.Caption := Button.HelpKeyWord;
    end;
    bsBomb:
    begin
      Button.Glyph.LoadFromFile('Bomb.bmp');
      RevealEmptyButtons(Button.FRow, Button.FCol);
    end;
  end;
end;

procedure TMain.RevealEmptyButtons(Row, Col: Integer);
begin
  RevealAdjacentButtons(Row - 1, Col);
  RevealAdjacentButtons(Row + 1, Col);
  RevealAdjacentButtons(Row, Col - 1);
  RevealAdjacentButtons(Row, Col + 1);
end;

procedure TMain.RevealAdjacentButtons(Row, Col: Integer);
var
  i: Integer;
begin
  if (Row >= 0) and (Row < RowCount) and (Col >= 0) and (Col < ColCount) then
  begin
    for i := 0 to FieldCount - 1 do
    begin
      if (Fields[i].FRow = Row) and (Fields[i].FCol = Col) and
         (TButtonState(Fields[i].FTagPrevious) = bsEmpty) and Fields[i].Enabled then
      begin
        Fields[i].Glyph.LoadFromFile('White.bmp');
        Fields[i].Enabled := False;
        RevealEmptyButtons(Row, Col);
        RevealAdjacentNumbers(Row, Col);
      end;
    end;
  end;
end;

procedure TMain.RevealAdjacentNumbers(Row, Col: Integer);
var
  DeltaRow, DeltaCol, i: Integer;
begin
  for DeltaRow := -1 to 1 do
  begin
    for DeltaCol := -1 to 1 do
    begin
      if (DeltaRow <> 0) or (DeltaCol <> 0) then
      begin
        if (Row + DeltaRow >= 0) and (Row + DeltaRow < RowCount) and
           (Col + DeltaCol >= 0) and (Col + DeltaCol < ColCount) then
        begin
          for i := 0 to FieldCount - 1 do
          begin
            if (Fields[i].FRow = Row + DeltaRow) and (Fields[i].FCol = Col + DeltaCol) and
               (TButtonState(Fields[i].FTagPrevious) = bsNumber) and Fields[i].Enabled then
            begin
              RevealButton(Fields[i]);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMain.HandleMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);   
var
  ButtonClicked: TBitBtn;
begin
  if GameStarted then
  begin              
    btFace.Glyph.LoadFromFile('Face_Neutral.bmp');
    ButtonClicked := Sender as TBitBtn;
    if Button = mbLeft then
      LeftButtonClick(ButtonClicked);
  end
  else
    btFace.Glyph.LoadFromFile('Face_Game_Over.bmp');
end;

end.
