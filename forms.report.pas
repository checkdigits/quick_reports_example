unit forms.report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt,
  QRCtrls, Vcl.Imaging.pngimage,
  QRQRBarcode, QRXMLSFilt, QRNewXLSXFilt, QRPDFFilt, QRExport, qrprntr,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type TMyReportOptions = record
  ShowThumbs:      boolean;
  ShowZoomButtons: boolean;
  StartZoomed:     boolean;
  ShowLoadButton:  boolean;
end;

type
  TMyReport = class(TForm)
    QuickRep1: TQuickRep;
    FDQuery1: TFDQuery;
    TitleBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRSysData2: TQRSysData;
    QRQRBarcode1: TQRQRBarcode;
    QRPDFFilter1: TQRPDFFilter;
    QRExcelFilter1: TQRExcelFilter;
    QRXLSXFilter1: TQRXLSXFilter;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRPreviewController1: TQRPreviewController;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    FDConnection1: TFDConnection;
    FDQuery1mem_id: TIntegerField;
    FDQuery1mem_forename: TWideMemoField;
    FDQuery1mem_surname: TWideMemoField;
    FDQuery1mem_address: TWideMemoField;
    FDQuery1mem_postcode: TWideMemoField;
    FDQuery1mem_email: TWideMemoField;
    Panel1: TPanel;
    QRLabel7: TQRLabel;
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRSysData2Print(sender: TObject; var Value: string);
    procedure QRSysData1Print(sender: TObject; var Value: string);
    procedure FormCreate(Sender: TObject);
  end;

  procedure DoPreview(OwnerForm: TForm; TheOptions: TMyReportOptions);
  procedure DoExport(const TheFileName: string);

var
  MyReport: TMyReport;

implementation
uses modules.demohelper, System.IOUtils;

{$R *.dfm}

procedure DoPreview(OwnerForm: TForm; TheOptions: TMyReportOptions);
begin
  MyReport := TMyReport.Create(OwnerForm);
  MyReport.QRPreviewController1.ShowThumbs            := TheOptions.ShowThumbs;
  MyReport.QuickRep1.PrevShowSearch                   := TheOptions.ShowThumbs;
  MyReport.QRPreviewController1.ShowFindButton        := TheOptions.ShowThumbs;
  MyReport.QRPreviewController1.ShowZoomFitButton     := TheOptions.ShowZoomButtons;
  MyReport.QRPreviewController1.ShowZoom100Button     := TheOptions.ShowZoomButtons;
  MyReport.QRPreviewController1.ShowZoomPickButton    := TheOptions.ShowZoomButtons;
  MyReport.QRPreviewController1.ShowZoomToWidthButton := TheOptions.ShowZoomButtons;
  if TheOptions.StartZoomed then
    MyReport.QRPreviewController1.PrevInitZoom := qrZoomToFit
  else
    if MyReport.QRPreviewController1.ShowZoomPickButton then
      MyReport.QRPreviewController1.PrevInitZoom := qrZoom100
    else
      MyReport.QRPreviewController1.PrevInitZoom := qrZoomToWidth;
  MyReport.QRPreviewController1.ShowLoadReportButton := TheOptions.ShowLoadButton;
  MyReport.QRPreviewController1.ShowSaveReportButton := TheOptions.ShowLoadButton;
  MyReport.QuickRep1.Preview;
end;

procedure DoExport(const TheFileName: string);
var
  aPDF : TQRPDFDocumentFilter;
begin
  MyReport := TMyReport.Create(Application.MainForm);
  MyReport.QuickRep1.Prepare;
  aPDF := TQRPDFDocumentFilter.Create(TheFileName);
  try
    MyReport.QuickRep1.ExportToFilter(aPDF);
  finally
    aPDF.Free;
    MyReport.QuickRep1.QRPrinter.Free;
  end;
  MyReport.QuickRep1.QRPrinter := nil;
  RunProg(TheFileName, '');
end;


procedure TMyReport.DetailBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRQRBarcode1.BarcodeText := FDQuery1mem_forename.AsString + ' ' + FDQuery1mem_surname.AsString + ' Emp ID: ' + FDQuery1mem_id.AsString;
end;

procedure TMyReport.FormCreate(Sender: TObject);
begin
  FDConnection1.Params.Database := TPath.GetDirectoryName(Application.ExeName)+ TPath.DirectorySeparatorChar + 'example_data.sqlite';
  if not FileExists(FDConnection1.Params.Database) then
    ShowMessage('The example database "' + FDConnection1.Params.Database + '" can''t be found.')
  else
    begin
      FDConnection1.Connected := True;
      FDQuery1.Active         := True;
    end;
end;

procedure TMyReport.QRSysData1Print(sender: TObject; var Value: string);
begin
  Value := 'Page ' + Value;
end;

procedure TMyReport.QRSysData2Print(sender: TObject; var Value: string);
begin
  Value := 'Printed on ' + Value;
end;

end.
