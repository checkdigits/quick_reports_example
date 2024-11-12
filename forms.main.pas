unit forms.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    PreviewButton: TButton;
    CheckListBox1: TCheckListBox;
    PDFButton: TButton;
    FileSaveDialog1: TFileSaveDialog;
    procedure PreviewButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PDFButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses forms.report, locationmemory;

const
  ShowThumbs      = 0;
  ShowZoomButtons = 1;
  StartZoomed     = 2;
  ShowLoadButton  = 3;


procedure TMainForm.PreviewButtonClick(Sender: TObject);
var
  MyOptions: TMyReportOptions;
begin
  MyOptions.ShowThumbs      := CheckListBox1.Checked[ShowThumbs];
  MyOptions.ShowZoomButtons := CheckListBox1.Checked[ShowZoomButtons];
  MyOptions.StartZoomed     := CheckListBox1.Checked[StartZoomed];
  MyOptions.ShowLoadButton  := CheckListBox1.Checked[ShowLoadButton];
  DoPreview(Self, MyOptions);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SaveFormLoc;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  LoadFormLoc;
  CheckListBox1.CheckAll(cbChecked);
end;

procedure TMainForm.PDFButtonClick(Sender: TObject);
begin
  FileSaveDialog1.FileName := ExtractFilePath(ParamStr(0)) + 'myreport.pdf';
  if FileSaveDialog1.Execute then
    DoExport(FileSaveDialog1.FileName);
end;


end.
