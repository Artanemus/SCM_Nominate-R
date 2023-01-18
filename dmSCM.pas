unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.IniFiles, System.IOUtils;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    tblSwimClub: TFDTable;
    tblSwimClubSwimClubID: TFDAutoIncField;
    tblSwimClubCaption: TWideStringField;
    tblSwimClubNickName: TWideStringField;
    tblSwimClubEmail: TWideStringField;
    tblSwimClubContactNum: TWideStringField;
    tblSwimClubWebSite: TWideStringField;
    tblSwimClubHeatAlgorithm: TIntegerField;
    tblSwimClubEnableTeamEvents: TBooleanField;
    tblSwimClubEnableSwimOThon: TBooleanField;
    tblSwimClubEnableExtHeatTypes: TBooleanField;
    tblSwimClubNumOfLanes: TIntegerField;
    tblSwimClubEnableMembershipStr: TBooleanField;
    tblSwimClubLenOfPool: TIntegerField;
    dsSwimClub: TDataSource;
    dsSession: TDataSource;
    dsEvent: TDataSource;
    dsMember: TDataSource;
    qrySession: TFDQuery;
    qryEvent: TFDQuery;
    qryMember: TFDQuery;
    qryIsQualified_ORG: TFDQuery;
    qryIsQualified: TFDQuery;
    qryIsNominated: TFDQuery;
    cmdDeleteSplit: TFDCommand;
    cmdDeleteEntrant: TFDCommand;
    cmdCreateNomination: TFDCommand;
    cmdDeleteNomination: TFDCommand;
    qryIsEntrant: TFDQuery;

  private const
    SCMCONFIGFILENAME = 'SCMConfig.ini';

  private
    FIsActive: Boolean;
    { Private declarations }

  public
    { Public declarations }
    function IsMemberNominated(MemberID, EventID: Integer): Boolean;
    function IsMemberEntrant(MemberID, EventID: Integer): Integer;
    function IsMemberQualified(MemberID, DistanceID, StrokeID: Integer)
      : Boolean;


    function IsValidMembershipNum(MemberShipNumber: Integer): Boolean;


    function GetMemberID(MemberShipNumber: Integer): Integer;
    function GetMemberFName(MemberID: Integer): String;
    function LocateEventID(EventID: Integer): Boolean;

    procedure commandCreateNomination(MemberID, EventID: Integer);
    procedure commandDeleteNomination(MemberID, EventID: Integer);
    procedure commandDeleteSplit(EntrantID: Integer);
    procedure commandDeleteEntrant(EntrantID: Integer);


    procedure SimpleMakeTemporyFDConnection(Server, User, Password: String;
      OsAuthent: Boolean);
    procedure SimpleSaveSettingString(Section, Name, Value: String);
    procedure SimpleLoadSettingString(Section, Name: String; var Value: String);

    property IsActive: Boolean read FIsActive;
    procedure ActivateTable();
    procedure DeActivateTable();

  end;

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.Variants;

{ TSCM }

procedure TSCM.ActivateTable;
begin
  FIsActive := false;
  // enable active on all datasets
  tblSwimClub.Open;
  if tblSwimClub.Active then
  begin
    // ASSERT - first item is Boonah swim club (default)
    tblSwimClub.First;
    // SESSION
    qrySession.Open;
    if qrySession.Active then
    begin
      qryEvent.Open; // EVENT ordered by EventNum
      if qryEvent.Active then
        FIsActive := True;
    end;
  end;
end;

procedure TSCM.commandCreateNomination(MemberID, EventID: Integer);
begin
  cmdCreateNomination.ParamByName('MEMBERID').AsInteger := MemberID;
  cmdCreateNomination.ParamByName('EVENTID').AsInteger := EventID;
  cmdCreateNomination.Prepare;
  cmdCreateNomination.Execute;
end;

procedure TSCM.commandDeleteEntrant(EntrantID: Integer);
begin
  cmdDeleteEntrant.ParamByName('ENTRANTID').AsInteger := EntrantID;
  cmdDeleteEntrant.Prepare;
  cmdDeleteEntrant.Execute;
end;

procedure TSCM.commandDeleteNomination(MemberID, EventID: Integer);
begin
  cmdDeleteNomination.ParamByName('MEMBERID').AsInteger := MemberID;
  cmdDeleteNomination.ParamByName('EVENTID').AsInteger := EventID;
  cmdDeleteNomination.Prepare;
  cmdDeleteNomination.Execute;
end;

procedure TSCM.commandDeleteSplit(EntrantID: Integer);
begin
  cmdDeleteSplit.ParamByName('ENTRANTID').AsInteger := EntrantID;
  cmdDeleteSplit.Prepare;
  cmdDeleteSplit.Execute;
end;

procedure TSCM.DeActivateTable;
begin
  FIsActive := false;
  qryEvent.Close;
  qrySession.Close;
  tblSwimClub.Close;
end;

function TSCM.GetMemberFName(MemberID: Integer): String;
begin
  result := '';
  if scmConnection.Connected then
  begin
    if qryMember.Active then
      qryMember.Close;
    qryMember.ParamByName('MEMBERID').AsInteger := MemberID;
    qryMember.Prepare;
    qryMember.Open;
    if qryMember.Active then
    begin
      if qryMember.RecordCount > 0 then
        result := qryMember.FieldByName('FName').AsString;
    end;
    qryMember.Close;
  end;
end;

function TSCM.GetMemberID(MemberShipNumber: Integer): Integer;
var
  rtn: Integer;
begin
  result := 0;
  if scmConnection.Connected then
  begin
    rtn := scmConnection.ExecSQLScalar
      ('USE SwimClubMeet; SET NOCOUNT ON; Select MemberID from Member where MembershipNum = :Num',
      [MemberShipNumber]);
    if rtn > 0 then
      result := rtn;
  end;
end;

// TRUE: EntrantID ... FALSE: zero.
function TSCM.IsMemberEntrant(MemberID, EventID: Integer): Integer;
begin
  result := 0;
  if scmConnection.Connected then
  begin
    if qryIsEntrant.Active then
      qryIsEntrant.Close;

    qryIsEntrant.ParamByName('MEMBERID').AsInteger := MemberID;
    qryIsEntrant.ParamByName('EVENTID').AsInteger := EventID;
    qryIsEntrant.Prepare;

    qryIsEntrant.Open;
    if qryIsEntrant.Active then
    begin
      if qryIsEntrant.RecordCount > 0 then
        result := qryIsEntrant.FieldByName('EntrantID').AsInteger;
    end;
  end;
    qryIsEntrant.Close;
end;

function TSCM.IsMemberNominated(MemberID, EventID: Integer): Boolean;
begin
  result := false;
  if scmConnection.Connected then
  begin
    if qryIsNominated.Active then
      qryIsNominated.Close;

    qryIsNominated.ParamByName('MEMBERID').AsInteger := MemberID;
    qryIsNominated.ParamByName('EVENTID').AsInteger := EventID;
    qryIsNominated.Prepare;

    qryIsNominated.Open;
    if qryIsNominated.Active then
    begin
      if qryIsNominated.RecordCount > 0 then
        result := True;
    end;
  end;
    qryIsNominated.Close;
end;


function TSCM.IsMemberQualified(MemberID, DistanceID, StrokeID: Integer): Boolean;
begin
  result := false;
  if scmConnection.Connected then
  begin
    if qryIsQualified.Active then
      qryIsQualified.Close;

    qryIsQualified.ParamByName('MEMBERID').AsInteger := MemberID;
    qryIsQualified.ParamByName('DISTANCEID').AsInteger := DistanceID;
    qryIsQualified.ParamByName('STROKEID').AsInteger := StrokeID;
    qryIsQualified.Prepare;

    // this FireDAC query calls a ScalarFunction dbo.IsMemberQualified
    // returns bit.
    qryIsQualified.Open;
    if qryIsQualified.Active then
    begin
      if qryIsQualified.FieldByName('QUALIFIED').AsBoolean = true then
        result := True;
    end;

    qryIsQualified.Close;

  end;
end;

function TSCM.IsValidMembershipNum(MemberShipNumber: Integer): Boolean;
var
  rtn: Integer;
begin
  result := false;
  if scmConnection.Connected then
  begin
    rtn := scmConnection.ExecSQLScalar
      ('USE SwimClubMeet; SET NOCOUNT ON; Select MembershipNum from Member where MembershipNum = :Num',
      [MemberShipNumber]);
    if rtn > 0 then
      result := True;
  end;
end;

{$REGION 'LOCATE SPECIFIC RECORD'}

function TSCM.LocateEventID(EventID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  result := false;
  if not qryEvent.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qryEvent.Locate('EventID', VarArrayOf([EventID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  result := LocateSuccess;

end;

{$ENDREGION}

procedure TSCM.SimpleLoadSettingString(Section, Name: String;
  var Value: String);
var
  ini: TIniFile;
begin
  // Note: OneDrive enabled: 'Personal'
  // The routine TPath.GetDocumentsPath normally returns ...
  // C:\Users\<username>\Documents (Windows Vista or later)
  // but is instead mapped to C:\Users\<username>\OneDrive\Documents.
  //
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    Value := ini.ReadString(Section, Name, '');
  finally
    ini.Free;
  end;

end;

procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: String;
  OsAuthent: Boolean);
var
  Value, Section: String;
begin

  if (scmConnection.Connected) then
    scmConnection.Connected := false;

  scmConnection.Params.Clear();
  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if OsAuthent then
    Value := 'Yes'
  else
    Value := 'No';
  scmConnection.Params.Add('OSAuthent=' + Value);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmMarshall');
  scmConnection.Connected := True;

  // ON SUCCESS - Save connection details.
  if scmConnection.Connected Then
  begin
    Section := 'MSSQL_SwimClubMeet';
    Name := 'Server';
    SimpleSaveSettingString(Section, Name, Server);
    Name := 'User';
    SimpleSaveSettingString(Section, Name, User);
    Name := 'Password';
    SimpleSaveSettingString(Section, Name, Password);
    Name := 'OSAuthent';
    SimpleSaveSettingString(Section, Name, Value);
  end
end;

procedure TSCM.SimpleSaveSettingString(Section, Name, Value: String);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.Free;
  end;

end;

end.
