unit locationmemory;
interface
uses Forms;

// VERY SIMPLE unit which implements a class helper to save and restores
// the form's position
// NOTE doesn't take into account monitors which have disappeared
// since the last session or DPI which has changes

type TFormSaverHelper = class helper for TForm
  procedure SaveFormLoc;
  procedure LoadFormLoc;
end;

implementation
uses IniFiles, SysUtils, System.IOUtils;

const
  Key = 'memory';

function FormSaveName: string;
begin
  var tmpName: string := TPath.GetFileNameWithoutExtension(Application.ExeName);
  Result := TPath.GetHomePath + TPath.DirectorySeparatorChar + tmpName + TPath.DirectorySeparatorChar;
  ForceDirectories(Result);
  Result := TPath.ChangeExtension(Result + tmpName, '.ini');
end;

procedure TFormSaverHelper.SaveFormLoc;
var
  Settings: TIniFile;
begin
  Settings := TIniFile.Create(FormSaveName);
  try
    Settings.WriteInteger(Key, 'Left', Self.Left);
    Settings.WriteInteger(Key, 'Top',  Self.Top);
  finally
    Settings.Free;
  end;
end;

procedure TFormSaverHelper.LoadFormLoc;
var
  Settings: TIniFile;
  iLeft, iTop: integer;
begin
  Settings := TIniFile.Create(FormSaveName);
  try
    iLeft := Settings.ReadInteger(Key, 'Left', Self.Left);
    iTop := Settings.ReadInteger(Key, 'Top', Self.Top);
  finally
    Settings.Free;
  end;
  Self.SetBounds(iLeft, iTop, Self.Width, Self.Height);
end;

end.
