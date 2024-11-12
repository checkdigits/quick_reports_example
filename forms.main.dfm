object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Quick Report Example'
  ClientHeight = 188
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDefault
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 188
    Align = alClient
    TabOrder = 0
    object PreviewButton: TButton
      Left = 24
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Preview'
      TabOrder = 0
      OnClick = PreviewButtonClick
    end
    object CheckListBox1: TCheckListBox
      Left = 105
      Top = 24
      Width = 185
      Height = 145
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 21
      Items.Strings = (
        'Show thumbs'
        'Show zoom buttons'
        'Start zoomed'
        'Show load button')
      ParentFont = False
      TabOrder = 1
    end
    object PDFButton: TButton
      Left = 24
      Top = 55
      Width = 75
      Height = 25
      Caption = 'PDF'
      TabOrder = 2
      OnClick = PDFButtonClick
    end
  end
  object FileSaveDialog1: TFileSaveDialog
    FavoriteLinks = <>
    FileName = 'C:\comps\QR6-RAD-10-3-Rio\Web-Control-Samples\myreport.pdf'
    FileTypes = <
      item
        DisplayName = 'PDF Documents'
        FileMask = '*.pdf'
      end
      item
        DisplayName = 'All files'
        FileMask = '*.*'
      end>
    Options = []
    Left = 48
    Top = 96
  end
end
