unit modules.demohelper;

interface

procedure RunProg(const TheProg, TheParams: String);

implementation
uses System.SysUtils, WinAPI.ShellAPI, Windows;

procedure RunProg(const TheProg, TheParams: String);
var
  seiLauncher: TShellExecuteInfo;
  nLauncherSize: Integer;
begin
  nLauncherSize := SizeOf(seiLauncher);
  FillChar(seiLauncher, nLauncherSize, 0);
  with seiLauncher do
  begin
    cbSize := nLauncherSize;
    fMask := SEE_MASK_NOCLOSEPROCESS;
    lpFile := PChar(TheProg);
    lpParameters := PChar(TheParams);
    nShow := SW_SHOWNORMAL;
  end;
  try
    ShellExecuteEx(@seiLauncher);
  except
    on E: Exception do OutputDebugString(PChar('Exception when opening "' + TheProg + '": "' + E.Message + '"'));
  end;
end;

end.
