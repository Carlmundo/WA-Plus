#define AppName "Worms Armageddon Plus"
#define AppVersion "1.1.1"
#define AppProcess "WA.exe"
#define Game "Worms Armageddon"
#define RegPath "Software\Team17SoftwareLTD\WormsArmageddon"

[Setup]
AppId={{B90927CD-E317-466C-8B6B-BC9042E2F1D2}
AppName={#AppName}
AppVersion={#AppVersion}
DefaultDirName={code:GetDefaultDir}
DisableProgramGroupPage=yes
DirExistsWarning=no
DisableDirPage=no
AppendDefaultDirName=no
DisableReadyPage=no
AlwaysShowDirOnReadyPage=yes
CloseApplications=yes
OutputBaseFilename={#AppName} {#AppVersion}
SetupIconFile=image-icon.ico
WizardImageFile=image-large.bmp
WizardImageStretch=no
WizardSmallImageFile=image-small.bmp
Compression=lzma
SolidCompression=yes
Uninstallable=no
PrivilegesRequired=admin
UsedUserAreasWarning=no

[InstallDelete]
;Remove obsolete modules from 1.0
Type: files; Name: "{app}\wkD3D9Wnd.dll"
Type: files; Name: "{app}\wkD3D9Wnd.ini"
Type: files; Name: "{app}\wkD3D9Wnd_readme.txt"

[Files]
;Patch files
Source: "..\Patch\*"; DestDir: "{app}\"; Flags: ignoreversion recursesubdirs createallsubdirs;
;VC Redist 2015-2019
Source: "..\Redist\VC_redist.x86.exe"; DestDir: {tmp}; Flags: deleteafterinstall

[Run]
Filename: {tmp}\VC_redist.x86.exe; Parameters: "/quiet /norestart"; StatusMsg: "Installing VC++ 2015-2019 Redistributables..."

[Registry]
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "Renderer"; ValueData: 4
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "LoadWormKitModules"; ValueData: 1
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "SkipIntro"; ValueData: 1
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "Vsync"; ValueData: 0
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "AssistedVsync"; ValueData: 0
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "WindowedMode"; ValueData: 1
Root: HKCU; Subkey: "{#RegPath}\Options"; ValueType: dword; ValueName: "LocalProgressOverride"; ValueData: 1878586903

[Code]
function IsAppRunning(const FileName: string): Boolean;
var
  FWMIService: Variant;
  FSWbemLocator: Variant;
  FWbemObjectSet: Variant;
begin
  Result := false;
  FSWbemLocator := CreateOleObject('WBEMScripting.SWBEMLocator');
  FWMIService := FSWbemLocator.ConnectServer('', 'root\CIMV2', '', '');
  FWbemObjectSet := FWMIService.ExecQuery(Format('SELECT Name FROM Win32_Process Where Name="%s"',[FileName]));
  Result := (FWbemObjectSet.Count > 0);
  FWbemObjectSet := Unassigned;
  FWMIService := Unassigned;
  FSWbemLocator := Unassigned;
end;

function InitializeSetup: boolean;
begin
  Result := not IsAppRunning('{#AppProcess}');
  if not Result then
  MsgBox('{#Game} is running. Please close the game before installing the patch.', mbError, MB_OK);
end;

function GetDefaultDir(def: string): string;
var InstalledDir, Default_Path, GOG_Path : string;
begin

  Default_Path := '{#RegPath}';  
  GOG_Path := 'SOFTWARE\GOG.com\Games\1462173886';

  if RegQueryStringValue(HKCU, Default_Path, 'PATH', InstalledDir) then
  begin
  end
  else if RegQueryStringValue(HKCU32, Default_Path, 'PATH', InstalledDir) then
  begin
  end
  else if RegQueryStringValue(HKCU64, Default_Path, 'PATH', InstalledDir) then
  begin
  end
  else if RegQueryStringValue(HKLM, GOG_Path, 'PATH', InstalledDir) then
  begin
  end
  else if RegQueryStringValue(HKLM32, GOG_Path, 'PATH', InstalledDir) then
  begin
  end
  else if RegQueryStringValue(HKLM64, GOG_Path, 'PATH', InstalledDir) then
  begin
  end;    
  Result := InstalledDir;    
end;

function NextButtonClick(PageId: Integer): Boolean;
begin
    Result := True;
    if (PageId = wpSelectDir) and (
    not FileExists(ExpandConstant('{app}\WA.exe'))
    ) then
    begin
        MsgBox('{#Game} could not be found in that folder. If it is the correct folder, please try reinstalling the game.', mbError, MB_OK);
        Result := False;
        exit;
    end
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
SetupAppTitle={#AppName} {#AppVersion}
SetupWindowTitle={#AppName} {#AppVersion} 
WelcomeLabel1={#AppName} {#AppVersion} 
SelectDirLabel3=Setup will try to detect where {#Game} is installed.
SelectDirBrowseLabel=If it has not been detected, click Browse to specify the folder.
FinishedHeadingLabel=Patch Complete