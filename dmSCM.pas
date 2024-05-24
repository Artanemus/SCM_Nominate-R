unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.IniFiles, System.IOUtils, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TSCM = class(TDataModule)
    cmdCreateNomination: TFDCommand;
    cmdDeleteEntrant: TFDCommand;
    cmdDeleteNomination: TFDCommand;
    cmdDeleteSplit: TFDCommand;
    dsEvent: TDataSource;
    dsMember: TDataSource;
    dsSCMSystem: TDataSource;
    dsSession: TDataSource;
    dsSwimClub: TDataSource;
    qryEvent: TFDQuery;
    qryIsEntrant: TFDQuery;
    qryIsNominated: TFDQuery;
    qryIsQualified: TFDQuery;
    qryMember: TFDQuery;
    qrySCMSystem: TFDQuery;
    qrySession: TFDQuery;
    scmConnection: TFDConnection;
    tblSwimClub: TFDTable;
    tblSwimClubCaption: TWideStringField;
    tblSwimClubContactNum: TWideStringField;
    tblSwimClubEmail: TWideStringField;
    tblSwimClubEnableExtHeatTypes: TBooleanField;
    tblSwimClubEnableMembershipStr: TBooleanField;
    tblSwimClubEnableSwimOThon: TBooleanField;
    tblSwimClubEnableTeamEvents: TBooleanField;
    tblSwimClubHeatAlgorithm: TIntegerField;
    tblSwimClubLenOfPool: TIntegerField;
    tblSwimClubNickName: TWideStringField;
    tblSwimClubNumOfLanes: TIntegerField;
    tblSwimClubSwimClubID: TFDAutoIncField;
    tblSwimClubWebSite: TWideStringField;
    qrySessionNominations: TFDQuery;
    qryEventEventID: TFDAutoIncField;
    qryEventEventNum: TIntegerField;
    qryEventSessionID: TIntegerField;
    qryEventStrokeID: TIntegerField;
    qryEventDistanceID: TIntegerField;
    qryEventEventStatusID: TIntegerField;
    qryMemberMemberID: TFDAutoIncField;
    qryMemberMembershipNum: TIntegerField;
    qryMemberMembershipStr: TWideStringField;
    qryMemberFirstName: TWideStringField;
    qryMemberLastName: TWideStringField;
    qryMemberDOB: TSQLTimeStampField;
    qryMemberIsArchived: TBooleanField;
    qryMemberIsActive: TBooleanField;
    qryMemberIsSwimmer: TBooleanField;
    qryMemberEmail: TWideStringField;
    qryMemberEnableEmailOut: TBooleanField;
    qryMemberGenderID: TIntegerField;
    qryMemberSwimClubID: TIntegerField;
    qryMemberFName: TWideStringField;
    qrySessionSessionID: TFDAutoIncField;
    qrySessionSessionStart: TSQLTimeStampField;
    qrySessionSwimClubID: TIntegerField;
    qrySessionSessionStatusID: TIntegerField;
    qrySessionSessionStatusStr: TStringField;
    qrySessionCaption: TWideStringField;
    qrySessionSessionStartStr: TWideStringField;
    qrySessionSessionDetailStr: TWideStringField;
    qryEventTitle: TWideStringField;
    qryEventDetail: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
  const
    SCMCONFIGFILENAME = 'SCMConfig.ini';
  var
    fDBModel, fDBVersion, fDBMajor, fDBMinor: integer;
    FIsActive: Boolean;
  public
    procedure ActivateTable();
    // SQL commands .
    procedure commandCreateNomination(MemberID, EventID: Integer);
    procedure commandDeleteEntrant(EntrantID: Integer);
    procedure commandDeleteNomination(MemberID, EventID: Integer);
    procedure commandDeleteSplit(EntrantID: Integer);
    procedure DeActivateTable();
    procedure Refresh_ALL;
    procedure Refresh_Events;
    function GetDBVerInfo: string;
    function GetMemberFName(MemberID: Integer): String;
    function GetMemberID(MemberShipNumber: Integer): Integer;
    function IsMemberEntrant(MemberID, EventID: Integer): Integer;
    function IsMemberNominated(MemberID, EventID: Integer): Boolean;
    function GetMembersSessionNominations(SessionID, MemberID: Integer): Boolean;
    function IsMemberQualified(MemberID, DistanceID, StrokeID: Integer)
      : Boolean;
    function IsValidMembershipNum(MemberShipNumber: Integer): Boolean;
    function LocateEventID(EventID: Integer): Boolean;
    function LocateSwimClubID(SwimClubID: Integer): Boolean;
    function LocateSessionID(SessionID: Integer): Boolean;
    property IsActive: Boolean read FIsActive;
  end;

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.Variants;

procedure TSCM.DataModuleCreate(Sender: TObject);
begin
  if scmConnection.Connected then
    scmConnection.Connected := false;
end;

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
  if qryEvent.Active then qryEvent.Close;
  if qrySession.Active then qrySession.Close;
  if tblSwimClub.Active then tblSwimClub.Close;
end;

function TSCM.GetDBVerInfo: string;
begin
  result := '';
  if scmConnection.Connected then
  begin
    with qrySCMSystem do
    begin
      Connection := scmConnection;
      Open;
      if Active then
      begin
        fDBModel := FieldByName('SCMSystemID').AsInteger;
        fDBVersion := FieldByName('DBVersion').AsInteger;
        fDBMajor := FieldByName('Major').AsInteger;
        fDBMinor := FieldByName('Minor').AsInteger;
        result := IntToStr(fDBModel) + '.' + IntToStr(fDBVersion) + '.' +
          IntToStr(fDBMajor) + '.' + IntToStr(fDBMinor);
      end;
      Close;
    end;
  end;
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
      ('USE SwimClubMeet; SET NOCOUNT ON; Select MemberID from Member where MembershipNum = :Num  AND ([IsArchived] <> 1) AND ([IsActive] = 1) AND  ([IsSwimmer] = 1)',
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

function TSCM.IsValidMembershipNum(MemberShipNumber: integer): Boolean;
var
  rtn: integer;
begin
  result := false;
  if scmConnection.Connected then
  begin
    rtn := scmConnection.ExecSQLScalar('USE SwimClubMeet; SET NOCOUNT ON; ' +
      'SELECT MembershipNum FROM Member WHERE (MembershipNum = :Num) AND ' +
      '(IsActive=1) AND (IsSwimmer=1) AND (IsArchived=0)', [MemberShipNumber]);

    if rtn > 0 then
      result := True;
  end;
end;

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

function TSCM.LocateSessionID(SessionID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  result := false;
  if not qrySession.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := qrySession.Locate('SessionID', VarArrayOf([SessionID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  result := LocateSuccess;
end;

function TSCM.LocateSwimClubID(SwimClubID: Integer): Boolean;
var
  LocateSuccess: Boolean;
  SearchOptions: TLocateOptions;

begin
  result := false;
  if not tblSwimClub.Active then
    exit;
  SearchOptions := [loPartialKey];
  try
    LocateSuccess := tblSwimClub.Locate('SwimClubID', VarArrayOf([SwimClubID]),
      SearchOptions);
  except
    on E: Exception do
      LocateSuccess := false
  end;
  result := LocateSuccess;
end;

procedure TSCM.Refresh_ALL;
var
EventID, SessionID, SwimClubID: integer;
begin
  if IsActive then
  begin
    qryEvent.DisableControls;
    qrySession.DisableControls;
    tblSwimClub.DisableControls;
    // store the current database record identities
    EventID := qryEvent.FieldByName('EventID').AsInteger;
    SessionID := qrySession.FieldByName('SessionID').AsInteger;
    SwimClubID := tblSwimClub.FieldByName('SwimClubID').AsInteger;
    qryEvent.Close;
    qrySession.Close;
    tblSwimClub.Close;

    tblSwimClub.Open;
    if tblSwimClub.Active then
      LocateSwimClubID(SwimClubID);

    qrySession.Open;
    if qrySession.Active then
      LocateSessionID(SessionID);

    qryEvent.Open;
    if qryEvent.Active then
      LocateEventID(EventID);

    tblSwimClub.EnableControls;
    qrySession.EnableControls;
    qryEvent.EnableControls;
  end;
end;

procedure TSCM.Refresh_Events;
var
EventID: integer;
begin
  if IsActive then
  begin
    EventID := qryEvent.FieldByName('EventID').AsInteger;
    qryEvent.Close;
    qryEvent.DisableControls;
    qryEvent.EnableControls;
    qryEvent.Open;
    if qryEvent.Active then
      LocateEventID(EventID);
  end;
end;

function TSCM.GetMembersSessionNominations(SessionID, MemberID: Integer): Boolean;
begin
  result := false;
  if scmConnection.Connected then
  begin
    if qrySessionNominations.Active then
      qrySessionNominations.Close;

    qrySessionNominations.ParamByName('MEMBERID').AsInteger := MemberID;
    qrySessionNominations.ParamByName('SESSIONID').AsInteger := SessionID;
    qrySessionNominations.Prepare;

    qrySessionNominations.Open;
    if qrySessionNominations.Active then
        result := True;
  end;
end;

end.
