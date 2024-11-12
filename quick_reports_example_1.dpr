program quick_reports_example_1;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  forms.report in 'forms.report.pas' {MyReport},
  forms.main in 'forms.main.pas' {MainForm},
  modules.demohelper in 'modules.demohelper.pas',
  locationmemory in 'locationmemory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
