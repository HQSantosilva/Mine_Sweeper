object Main: TMain
  Left = 408
  Top = 209
  BorderStyle = bsSingle
  Caption = 'Mine Sweeper'
  ClientHeight = 407
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 393
    Height = 52
    Align = alTop
    TabOrder = 0
    object BombCounter: TJvgDigits
      Left = 8
      Top = 8
      Width = 40
      Height = 36
      DigitSize.X = 10
      DigitSize.Y = 21
      ActiveColor = clRed
      Alignment = taRightJustify
      Bevel.Inner = bvSpace
      Bevel.Outer = bvNone
      Bevel.Bold = True
      Gradient.FromColor = clBlack
      Gradient.Active = False
      Gradient.Orientation = fgdHorizontal
    end
    object btFace: TBitBtn
      Left = 160
      Top = 0
      Width = 50
      Height = 50
      TabOrder = 0
      OnClick = btResetClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 360
    Top = 8
    object Reset: TMenuItem
      Caption = 'New Game'
      OnClick = btResetClick
    end
    object N1: TMenuItem
    end
  end
end
