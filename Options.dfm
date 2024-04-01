object FormOptions: TFormOptions
  Left = 321
  Top = 214
  BorderStyle = bsDialog
  Caption = 'FormOptions'
  ClientHeight = 177
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 40
    Width = 114
    Height = 16
    Caption = 'Number of Columns'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 95
    Height = 16
    Caption = 'Number of Rows'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 104
    Height = 16
    Caption = 'Amount of Bombs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 200
    Top = 16
    Width = 53
    Height = 16
    Caption = 'Difficulty:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 16
    Width = 49
    Height = 16
    Caption = 'Custom:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Columns: TMaskEdit
    Left = 128
    Top = 40
    Width = 25
    Height = 21
    EditMask = '!99;0;_'
    MaxLength = 2
    TabOrder = 0
  end
  object Rows: TMaskEdit
    Left = 128
    Top = 72
    Width = 25
    Height = 21
    EditMask = '!99;1;_'
    MaxLength = 2
    TabOrder = 1
    Text = '  '
  end
  object Bombs: TMaskEdit
    Left = 128
    Top = 104
    Width = 25
    Height = 21
    EditMask = '!999;1;_'
    MaxLength = 3
    TabOrder = 2
    Text = '   '
  end
  object btnOk: TBitBtn
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TBitBtn
    Left = 96
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object btBeginner: TRadioButton
    Left = 184
    Top = 40
    Width = 113
    Height = 17
    Caption = 'Beginner'
    TabOrder = 5
    OnClick = btBeginnerClick
  end
  object btIntermediate: TRadioButton
    Left = 184
    Top = 72
    Width = 113
    Height = 17
    Caption = 'Intermediate'
    TabOrder = 6
    OnClick = btIntermediateClick
  end
  object btAdvanced: TRadioButton
    Left = 184
    Top = 104
    Width = 113
    Height = 17
    Caption = 'Advanced'
    TabOrder = 7
    OnClick = btAdvancedClick
  end
end
