unit frmNominate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.ListBox, FMX.Edit,
  FMX.TabControl, System.ImageList, FMX.ImgList, dmSCM, System.Actions,
  FMX.ActnList, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.Contnrs, scmMemberNom, ProgramSetting, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type

  TDefaultFont = class(TInterfacedObject, IFMXSystemFontService)
  public
    function GetDefaultFontFamilyName: string;
    function GetDefaultFontSize: Single;
  end;

  TNominate = class(TForm)
    ActionList1: TActionList;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnNominateOk: TAction;
    actnQualify: TAction;
    actnRefresh: TAction;
    actnSCMOptions: TAction;
    actnToggleMode: TAction;
    AniIndicator1: TAniIndicator;
    BindingsList1: TBindingsList;
    bsEvent: TBindSourceDB;
    bsSession: TBindSourceDB;
    bsSwimClub: TBindSourceDB;
    btn00: TButton;
    btn01: TButton;
    btn02: TButton;
    btn03: TButton;
    btn04: TButton;
    btn05: TButton;
    btn06: TButton;
    btn07: TButton;
    btn08: TButton;
    btn09: TButton;
    btnBackSpace: TButton;
    btnClear: TButton;
    btnConfirmNominated: TButton;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnEnter: TButton;
    btnGetTime: TButton;
    btnPost: TButton;
    btnRefresh: TButton;
    btnToggle: TButton;
    chkboxShowConfirmationDlg: TCheckBox;
    chkboxVerbose: TCheckBox;
    chkbSessionVisibility: TCheckBox;
    chkbUseOsAuthentication: TCheckBox;
    cmbSessionList: TComboBox;
    cmbSwimClubList: TComboBox;
    edtPassword: TEdit;
    edtServerName: TEdit;
    edtUser: TEdit;
    GridPanelLayout1: TGridPanelLayout;
    Image1: TImage;
    ImageControl2: TImageControl;
    ImageList1: TImageList;
    imgBackSpaceCntrl: TImageControl;
    Label1: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    layConnectButtons: TLayout;
    layContents: TLayout;
    layFooter: TLayout;
    layLoginToServer: TLayout;
    layMemberShipNum: TLayout;
    Layout1: TLayout;
    Layout11: TLayout;
    Layout3: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    layPost: TLayout;
    layPostButton: TLayout;
    layPostMessage: TLayout;
    laySelectSession: TLayout;
    layTabs: TLayout;
    lblAniIndicatorStatus: TLabel;
    lblSelectSession: TLabel;
    lblSelectSwimClub: TLabel;
    lblStatusBar: TLabel;
    lbxNominate: TListView;
    LinkListControlToField1: TLinkListControlToField;
    LinkListControlToField2: TLinkListControlToField;
    Rectangle1: TRectangle;
    ScaledLayout1: TScaledLayout;
    SizeGrip1: TSizeGrip;
    StyleBook1: TStyleBook;
    tabConfirmNominated: TTabItem;
    TabControl1: TTabControl;
    tabLoginSession: TTabItem;
    tabMembershipNum: TTabItem;
    tabNominate: TTabItem;
    Timer1: TTimer;
    txtEnterNumberMsg: TLabel;
    txtMemberFullName: TText;
    txtNumber: TText;
    txtPostToCompleteMsg: TLabel;
    LinkListControlToField3: TLinkListControlToField;
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnToggleModeExecute(Sender: TObject);
    procedure actnToggleModeUpdate(Sender: TObject);
    procedure btnBackSpaceClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnConfirmNominatedClick(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnNumClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure chkboxVerboseChange(Sender: TObject);
    procedure chkbSessionVisibilityChange(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure cmbSwimClubListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxNominateItemClickEx(const Sender: TObject; ItemIndex: Integer;
        const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure lbxNominateMouseUp(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Single);
    procedure lbxNominateUpdateObjects(const Sender: TObject; const AItem:
        TListViewItem);
    procedure TabControl1Change(Sender: TObject);
  private
    fConnectionCountdown: Integer;
    fCurrMemberID: Integer;
    FListOfNominatedEvents: TList<Integer>; // for current member.
    fLoginTimeOut: Integer;
    fShowConfirmationDlg: Boolean;
    isMouseUpState: Boolean;
    procedure ConnectOnTerminate(Sender: TObject);
    function GetSCMVerInfo(): string;
    procedure LoadFromSettings; // JSON Program Settings
    procedure LoadSettings; // JSON Program Settings
    procedure PostNominations;
    procedure Refresh_Events;
    procedure Refresh_Session;
    procedure Refresh_SwimClub;
    procedure Refresh_ALL;
    procedure SaveToSettings; // JSON Program Settings
    procedure Status_ConnectionDescription;
    procedure Update_ListOfNominatedEvents;
    procedure Update_PromptText;
  end;

var
  Nominate: TNominate;

implementation

{$R *.fmx}

uses
{$IFDEF MSWINDOWS}
  // needed for call to winapi MessageBeep & Beep
  Winapi.Windows,
  // needed to show virtual keyboard in windows 10 32/64bit
  // Shellapi,
{$ENDIF}
  // FOR scmLoadOptions
  System.IOUtils, FireDAC.Stan.Param, Data.DB, ExeInfo, SCMSimpleConnect,
  SCMUtility;

procedure TNominate.actnConnectExecute(Sender: TObject);
var
  myThread: TThread;
  sc: TSimpleConnect;
begin
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblAniIndicatorStatus.Text := 'Connecting';
    fConnectionCountdown := fLoginTimeOut;
    AniIndicator1.Visible := true; // progress timer
    AniIndicator1.Enabled := true; // start spinning
    lblAniIndicatorStatus.Visible := true; // a label with countdown
    Timer1.Enabled := true; // start the countdown
    actnConnect.Visible := false;
    application.ProcessMessages;

    myThread := TThread.CreateAnonymousThread(
      procedure
      begin
        // can only be assigned if not connected
        SCM.scmConnection.Params.Values['LoginTimeOut'] :=
          IntToStr(fLoginTimeOut);

        sc := TSimpleConnect.CreateWithConnection(Self, SCM.scmConnection);
        sc.DBName := 'SwimClubMeet'; // DEFAULT
        sc.SaveConfigAfterConnection := false; // using JSON not System.IniFiles
        sc.SimpleMakeTemporyConnection(edtServerName.Text, edtUser.Text,
          edtPassword.Text, chkbUseOsAuthentication.IsChecked);
        Timer1.Enabled := false;
        sc.Free
      end);

    myThread.OnTerminate := ConnectOnTerminate;
    myThread.Start;
  end;

end;

procedure TNominate.actnConnectUpdate(Sender: TObject);
begin
  // verbose code - stop unecessary repaints ...
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected and actnConnect.Visible then
      actnConnect.Visible := false;
    if not SCM.scmConnection.Connected and not actnConnect.Visible then
      actnConnect.Visible := true;
  end
  else // D E F A U L T  I N I T  . Data module not created.
  begin
    if not actnConnect.Visible then
      actnConnect.Visible := true;
  end;
end;

procedure TNominate.actnDisconnectExecute(Sender: TObject);
begin
  // IF DATA-MODULE EXISTS ... break the current connection.
  if Assigned(SCM) then
  begin
    SCM.DeActivateTable;
    SCM.scmConnection.Connected := false;
    lblStatusBar.Text := 'No connection.';
  end;
  // Hides..unhides visibility of icons in tabLoginSession
  AniIndicator1.Visible := false;
  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;
  SaveToSettings; // As this was a OK connection - store parameters.
  UpdateAction(actnDisconnect);
  UpdateAction(actnConnect);
end;

procedure TNominate.actnDisconnectUpdate(Sender: TObject);
begin
  // verbose code - stop unecessary repaints ...
  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected and not actnDisconnect.Visible then
      actnDisconnect.Visible := true;
    if not SCM.scmConnection.Connected and actnDisconnect.Visible then
      actnDisconnect.Visible := false;
  end
  else // D E F A U L T  I N I T  . Data module not created.
  begin
    if actnDisconnect.Visible then
      actnDisconnect.Visible := false;
  end;
end;

procedure TNominate.actnRefreshExecute(Sender: TObject);
begin
  Refresh_ALL;
end;

procedure TNominate.actnRefreshUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    actnRefresh.Enabled := true
  else
    actnRefresh.Enabled := false;
  case TabControl1.TabIndex of
    0:
      if not actnRefresh.Visible then
        actnRefresh.Visible := true;
    1, 2, 3:
      if actnRefresh.Visible then
        actnRefresh.Visible := false;
  end;
end;

procedure TNominate.actnToggleModeExecute(Sender: TObject);
begin
  if TabControl1.TabIndex = 0 then
  begin
    // A session must be selected.
    if cmbSessionList.ItemIndex = -1 then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'A session must be selected to toggle mode.';
      exit;
    end;
    // The selected session must be open
    if (SCM.qrySession.FieldByName('SessionStatusID').AsInteger <> 1) then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'The session mustn''t be locked to toggle mode.';
      exit;
    end;
    // the session must have events
    if bsEvent.DataSet.IsEmpty then
    begin
      lblStatusBar.Text := 'No events in this session.';
      exit;
    end;
    TabControl1.Next(TTabTransition.Slide);
  end
  else
  begin
    TabControl1.First(TTabTransition.Slide);
  end;
end;

procedure TNominate.actnToggleModeUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    actnToggleMode.Enabled := true
  else
    actnToggleMode.Enabled := false;
end;

procedure TNominate.btnBackSpaceClick(Sender: TObject);
var
  s: string;
begin
  s := txtNumber.Text;
  Delete(s, Length(s), 1);
  txtNumber.Text := s;
end;

procedure TNominate.btnClearClick(Sender: TObject);
begin
  txtNumber.Text := '';
end;

procedure TNominate.btnConfirmNominatedClick(Sender: TObject);
begin
  txtNumber.Text := '';
  fCurrMemberID := 0;
  // switch to: Enter membership number
  TabControl1.GotoVisibleTab(1);
end;

procedure TNominate.btnEnterClick(Sender: TObject);
var
  MembershipNum: Integer;
begin
  lblStatusBar.Text := '';
  if not Assigned(SCM) then
    exit;
  if not SCM.IsActive then
    exit;
  if bsEvent.DataSet.IsEmpty then
  begin
    lblStatusBar.Text := 'No events found in this session!';
    exit;
  end;

  // extract integer.
  MembershipNum := StrToIntDef(txtNumber.Text, 0);
  if (MembershipNum = 0) then
    exit;

  // Does the membership number exist?
  // Get the member's ID from membership number
  if not SCM.IsValidMembershipNum(MembershipNum) then
  begin
{$IFDEF MSWINDOWS}
    MessageBeep(MB_ICONERROR);
{$ENDIF}
    lblStatusBar.Text :=
      'Member''s ID not found or not a swimmer or not active or is archived.';
    fCurrMemberID := 0;
  end;

  fCurrMemberID := SCM.GetMemberID(MembershipNum);
  if (fCurrMemberID > 0) then
  begin
    txtMemberFullName.Text := SCM.GetMemberFName(fCurrMemberID);
    // BUILD THE LIST OF NOMINATIONS
    // The current member has been found. Re-build the
    // list collection of integers holding nominated events for current member.
    Update_ListOfNominatedEvents;
    TabControl1.Next;
  end;

end;

procedure TNominate.btnNumClick(Sender: TObject);
var
  s: string;
begin
  s := txtNumber.Text;
  s := s + TButton(Sender).Text;
  txtNumber.Text := s;
end;

procedure TNominate.btnPostClick(Sender: TObject);
begin
  PostNominations;
  if chkboxShowConfirmationDlg.IsChecked then
  begin
    TabControl1.GoToVisibleTab(3);
  end
  else
  begin
    txtNumber.Text := '';
    fCurrMemberID := 0;
    TabControl1.GoToVisibleTab(1);
  end;
end;

procedure TNominate.chkboxVerboseChange(Sender: TObject);
begin
  // p r o m p t    m e s s a g e s .
  Update_PromptText;
end;

procedure TNominate.chkbSessionVisibilityChange(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.scmConnection.Connected) then
  begin
//    FILTER: SessionStatusID = 1
    bsSession.DataSet.DisableControls;
    if chkbSessionVisibility.IsChecked then
      bsSession.DataSet.Filtered := true
    else
      bsSession.DataSet.Filtered := false;
    bsSession.DataSet.EnableControls;
  end;
end;

procedure TNominate.cmbSessionListChange(Sender: TObject);
begin
  lblStatusBar.Text := '';
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    Refresh_Events;
  end;
end;

procedure TNominate.cmbSwimClubListChange(Sender: TObject);
begin
//  if Assigned(SCM) and SCM.scmConnection.Connected then
//  begin
//  if bsSession.DataSet.Active then
//  begin
//    bsSession.DataSet.Refresh;
//    bsSession.EmptyDataLink;
//    bsSession.ResetNeeded;
//  end;
//  end;
//  Refresh_Session;
end;

procedure TNominate.ConnectOnTerminate(Sender: TObject);
begin
  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;
  AniIndicator1.Visible := false;

  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    // Exit;
  end;

  if not Assigned(SCM) then
    exit;

  // C O N N E C T E D  .
  if (SCM.scmConnection.Connected) then
  begin
    SCM.ActivateTable;
    // ALL TABLES SUCCESSFULLY MADE ACTIVE ...
    if (SCM.IsActive = true) then
    begin
      // Set the visibility of closed sessions.
      bsSession.DataSet.DisableControls;
      if chkbSessionVisibility.IsChecked then
        bsSession.DataSet.Filtered := true
      else
        bsSession.DataSet.Filtered := false;
      bsSession.DataSet.EnableControls;
    end;
  end;

  if not SCM.scmConnection.Connected then
  begin
    // Attempt to connect failed.
    lblStatusBar.Text :=
      'A connection couldn''t be made. (Check you input values.)';
  end;

  // Disconnect button vivibility
  UpdateAction(actnDisconnect);
  // Connect button vivibility
  UpdateAction(actnConnect);
  // Display of layout panels (holding TListView grids).

  Status_ConnectionDescription;

end;

procedure TNominate.FormCreate(Sender: TObject);
begin
  // Initialization of params.
  application.ShowHint := true;
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
  btnDisconnect.Visible := false;
  fLoginTimeOut := CONNECTIONTIMEOUT; // DEFAULT 20 - defined in ProgramSetting
  fConnectionCountdown := CONNECTIONTIMEOUT;
  fShowConfirmationDlg := false;
  Timer1.Enabled := false;
  lblAniIndicatorStatus.Visible := false;
  fCurrMemberID := 0;
  txtNumber.Text := '';
  FListOfNominatedEvents := TList<Integer>.Create;
  isMouseUpState := false;

  // r e m o v e   p r o m p t    m e s s a g e s .
  // minimal clutter in the display.
  txtEnterNumberMsg.Visible := false;
  txtPostToCompleteMsg.Visible := false;

  // A Class that uses JSON to read and write application configuration
  if Settings = nil then
    Settings := TPrgSetting.Create;

  cmbSessionList.Items.Clear;
  cmbSwimClubList.Items.Clear;
  lbxNominate.Items.Clear;

  // C R E A T E   T H E   D A T A M O D U L E .
  if NOT Assigned(SCM) then
    SCM := TSCM.Create(Self);
  if SCM.scmConnection.Connected then
    SCM.scmConnection.Connected := false;

  // READ APPLICATION   C O N F I G U R A T I O N   PARAMS.
  // JSON connection settings. Windows location :
  // %SYSTEMDRIVE\%%USER%\%USERNAME%\AppData\Roaming\Artanemus\SwimClubMeet\Nominate
  LoadSettings;

  // p r o m p t    m e s s a g e s .
  Update_PromptText;

  // TAB_SHEET : DEFAULT: Login-Session
  TabControl1.TabIndex := 0;

  // Connection status - located in footer bar.
  Status_ConnectionDescription;

  // T A B  V I S I B I L I T Y .
  TabControl1.TabPosition := TTabPosition.None;
end;

procedure TNominate.FormDestroy(Sender: TObject);
begin
  FListOfNominatedEvents.Free;

  if Assigned(SCM) then
  begin
    if SCM.scmConnection.Connected then
    begin
      SaveToSettings;
      SCM.scmConnection.Connected := false;
    end;
    SCM.Free;
  end;

end;

function TNominate.GetSCMVerInfo(): String;
{$IF defined(MSWINDOWS)}
var
  myExeInfo: TExeInfo;
{$ENDIF}
begin
  result := '';
  // if connected - display the application version
  // and the SwimClubMeet database version.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      result := 'DB v' + SCM.GetDBVerInfo;
{$IF defined(MSWINDOWS)}
  // get the application version number
  myExeInfo := TExeInfo.Create(Self);
  result := 'App v' + myExeInfo.FileVersion + ' - ' + result;
  myExeInfo.Free;
{$ENDIF}
end;

procedure TNominate.lbxNominateItemClickEx(const Sender: TObject; ItemIndex:
    Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
var
ASize: TSizef;
AItem: TListViewItem;
AEventID: integer;
begin
  ASize.cx := 48;
  ASize.cy := 48;
  if Assigned(ItemObject) then
  begin
    // Will only accepts a single mouse event from the mouse up/dowm combo.
    // If this isn't done. the toggle is nullified.
    if (ItemObject.Name = 'imgBigCheck') AND  isMouseUpState then
    begin
      AItem := TListView(Sender).Items[ItemIndex];
      AEventID :=  bsEvent.DataSet.FieldByName('EventID').AsInteger;
      if Assigned(AItem) then
      begin
        AItem.BeginUpdate;
        if FListOfNominatedEvents.Contains(AEventID) then
        begin
          FListOfNominatedEvents.Remove(AEventID);
          AItem.Data['imgBigCheck'] := ImageList1.Bitmap(ASize, 0) // checked.
        end
        else
        begin
          FListOfNominatedEvents.Add(AEventID);
          AItem.Data['imgBigCheck'] := ImageList1.Bitmap(ASize, 1) // checked.
        end;
        AItem.EndUpdate;
      end;
      isMouseUpState := false;
    end;
  end;
  Application.ProcessMessages;
end;

procedure TNominate.lbxNominateMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Single);
begin
  // WHY?
  // A mouse down and then a mouse up creates two mouse click events!!!!!!
  // I'm using this boolean to flag the end of a mouse event.
  // lbxNominateItemClickEx then check it's state (true). Thereby avoiding the
  // problem of the procedure being call twice, one after the other,
  // nullifing the imgBigCheck toggled state.
  isMouseUpState := true;
end;

procedure TNominate.lbxNominateUpdateObjects(const Sender: TObject; const
    AItem: TListViewItem);
var
ASize: TSizef;
ADistanceID, AStrokeID, AEventID: integer;
MyEventDetailString: string;
begin
  ASize.cx := 48;
  ASize.cy := 48;
  ADistanceID :=  bsEvent.DataSet.FieldByName('DistanceID').AsInteger;
  AStrokeID :=  bsEvent.DataSet.FieldByName('StrokeID').AsInteger;
  AEventID :=  bsEvent.DataSet.FieldByName('EventID').AsInteger;
  MyEventDetailString := bsEvent.DataSet.FieldByName('Detail').AsString;
  if (SCM.IsMemberQualified(fCurrMemberID, ADistanceID, AStrokeID)) then
  begin
    AItem.Data['imgQualified'] := ImageList1.Bitmap(ASize, 2);
    // working but only in the first instance after creation .....
    // AItem.Data['Detail'] := 'QUALIFIED ' +  MyEventDetailString;
  end
  else
    AItem.Data['imgQualified'] := nil;

  if FListOfNominatedEvents.Contains(AEventID) then
    AItem.Data['imgBigCheck'] := ImageList1.Bitmap(ASize, 1) // checked.
  else
    AItem.Data['imgBigCheck'] := ImageList1.Bitmap(ASize, 0);
end;

procedure TNominate.LoadFromSettings;
begin
  edtServerName.Text := Settings.Server;
  edtUser.Text := Settings.User;
  edtPassword.Text := Settings.Password;
  chkbUseOsAuthentication.IsChecked := Settings.OSAuthent;
  chkbSessionVisibility.IsChecked := Settings.SessionVisibility;
  chkboxShowConfirmationDlg.IsChecked := Settings.ShowConfirmationDlg;
  chkboxVerbose.IsChecked := Settings.ShowExtraText;
  fLoginTimeOut := Settings.LoginTimeOut;
end;

procedure TNominate.LoadSettings;
begin
  if Settings = nil then
    Settings := TPrgSetting.Create;
  if not FileExists(Settings.GetDefaultSettingsFilename()) then
  begin
    ForceDirectories(Settings.GetSettingsFolder());
    Settings.SaveToFile();
  end;
  Settings.LoadFromFile();
  LoadFromSettings();
end;

procedure TNominate.PostNominations;
var
  EntrantID, EventID: Integer;
  IsNominatedInDB: Boolean;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    bsEvent.DataSet.First;
    While not bsEvent.DataSet.Eof do
    begin
      EventID := bsEvent.DataSet.FieldByName('EventID').AsInteger;
      // WHAT THE MEMBER'S NOMINATION STATUS IS IN THE DATABASE ...
      IsNominatedInDB := SCM.IsMemberNominated(fCurrmemberID, EventID);

      if IsNominatedInDB then // N O M I N A T E D .
      begin
        if not FListOfNominatedEvents.Contains(EventID) then
        // THE MEMBER HAS ELECTED TO REMOVE NOMINATION
        // -------------------------------------------------------------
        // If member is an entrant in the event (they've been given
        // a lane),  then the record must be removed prior to deleting
        // the nomination.
        begin
          // TEST if member is an entrant in the event
          EntrantID := SCM.IsMemberEntrant(fCurrmemberID, EventID);
          if EntrantID > 0 then
          begin
            // remove the lane data
            SCM.commandDeleteSplit(EntrantID); // REMOVE split data records
            SCM.commandDeleteEntrant(EntrantID); // REMOVE entrant record
          end;
          // remove the nomination record in the database
          SCM.commandDeleteNomination(fCurrmemberID, EventID);
        end;
      end
      else // N O T   n o m i n a t e d .
      begin
        if FListOfNominatedEvents.Contains(EventID) then
        // the member has elected to NOMINATE for this event
        // -------------------------------------------------------------
        begin
          // create a new nomination record.
          // NOTE: TTB, PB and SeedDate not assigned in record.
          SCM.commandCreateNomination(fCurrmemberID, EventID);
        end;
      end;

      // C U E   T O   N E X T   E V E N T .
      SCM.qryEvent.Next;
    end;
  end;
end;

procedure TNominate.Refresh_ALL;
var
EventID, SessionID, SwimClubID: integer;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qryEvent.DisableControls;
    SCM.qrySession.DisableControls;
    SCM.tblSwimClub.DisableControls;
    // store the current database record identities
    EventID := SCM.qryEvent.FieldByName('EventID').AsInteger;
    SessionID := SCM.qrySession.FieldByName('SessionID').AsInteger;
    SwimClubID := SCM.tblSwimClub.FieldByName('SwimClubID').AsInteger;
    SCM.qryEvent.Close;
    SCM.qrySession.Close;
    SCM.tblSwimClub.Close;
    SCM.tblSwimClub.Open;
    if SCM.tblSwimClub.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateSwimClubID(SwimClubID);
    End;

    SCM.qrySession.Open;
    if SCM.qrySession.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateSessionID(SessionID);
    End;

    SCM.qryEvent.Open;
    if SCM.qryEvent.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateEventID(EventID);
    End;
    SCM.tblSwimClub.EnableControls;
    SCM.qrySession.EnableControls;
    SCM.qryEvent.EnableControls;
  end;
end;

procedure TNominate.Refresh_Events;
var
EventID: integer;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qryEvent.DisableControls;
    EventID := SCM.qryEvent.FieldByName('EventID').AsInteger;
    SCM.qryEvent.Close;
    SCM.qryEvent.Open;
    if SCM.qryEvent.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateEventID(EventID);
    End;
    SCM.qryEvent.EnableControls;
  end;
end;

procedure TNominate.Refresh_Session;
var
SessionID: integer;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qrySession.DisableControls;
    SessionID := SCM.qrySession.FieldByName('SessionID').AsInteger;
    SCM.qrySession.Close;
    SCM.qrySession.Open;
    if SCM.qrySession.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateSessionID(SessionID);
    End;
    SCM.qrySession.EnableControls;
  end;
end;

procedure TNominate.Refresh_SwimClub;
var
SwimClubID: integer;
begin
  if Assigned(SCM) and SCM.tblSwimClub.Active then
  begin
    SCM.tblSwimClub.DisableControls;
    SwimClubID := SCM.tblSwimClub.FieldByName('SwimClubID').AsInteger;
    SCM.tblSwimClub.Close;
    SCM.tblSwimClub.Open;
    if SCM.tblSwimClub.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      SCM.LocateSwimClubID(SwimClubID);
    End;
    SCM.tblSwimClub.EnableControls;
  end;
end;

procedure TNominate.SaveToSettings;
begin
  Settings.Server := edtServerName.Text;
  Settings.User := edtUser.Text;
  Settings.Password := edtPassword.Text;
  if chkbUseOsAuthentication.IsChecked then
    Settings.OSAuthent := true
  else
    Settings.OSAuthent := false;
  Settings.SessionVisibility := chkbSessionVisibility.IsChecked;
  Settings.ShowConfirmationDlg := chkboxShowConfirmationDlg.IsChecked;
  Settings.ShowExtraText := chkboxVerbose.IsChecked;
  Settings.LoginTimeOut := fLoginTimeOut;
  Settings.SaveToFile();
end;

procedure TNominate.Status_ConnectionDescription;
begin
  if Assigned(SCM) and SCM.IsActive then
  begin
    // STATUS BAR CAPTION.
    lblStatusBar.Text := 'Connected to SwimClubMeet. ';
    lblStatusBar.Text := lblStatusBar.Text + GetSCMVerInfo;
    lblStatusBar.Text := lblStatusBar.Text + sLineBreak +
      bsSwimClub.DataSet.FieldByName('Caption').AsString;
  end
  else
    lblStatusBar.Text := 'NOT CONNECTED. ';
end;

procedure TNominate.TabControl1Change(Sender: TObject);
begin
  case TabControl1.TabIndex of
    0: // INITIALIZATION.
      begin
        Status_ConnectionDescription;
        FListOfNominatedEvents.Clear;
        fCurrMemberID := 0;
        txtNumber.Text := '';
      end;
    1: // MEMBERSHIP NUMBER
      begin
        lblStatusBar.Text := '';
        txtNumber.SetFocus;
      end;
    2: // NOMINATE FOR EVENT
      begin
        lblStatusBar.Text := '';
      end;
    3: // CONFIRMATION MESSAGE
      begin
        lblStatusBar.Text := '';
        fCurrMemberID := 0;
        txtNumber.Text := '';
      end;
  end;
end;

procedure TNominate.Update_ListOfNominatedEvents;
var
SessionID: integer;
success: boolean;
begin
  // NOTE: fCurrMemberID must be correctly in itialized.
  FListOfNominatedEvents.Clear;
  if (fCurrMemberID = 0)  then exit;
  SessionID := bsSession.DataSet.FieldByName('SessionID').AsInteger;
  success := SCM.UpdateSessionNominations(SessionID, fCurrMemberID);
  if success then
  begin
    While not SCM.qrySessionNominations.Eof do
    begin
      FListOfNominatedEvents.Add(SCM.qrySessionNominations.FieldByName('EventID').AsInteger);
      SCM.qrySessionNominations.Next;
    end;
  end;
end;

procedure TNominate.Update_PromptText;
begin
  if chkboxVerbose.IsChecked then
  begin
    // r e m o v e   p r o m p t    m e s s a g e s .
    // minimal clutter in the display.
    txtEnterNumberMsg.Visible := true;
    txtPostToCompleteMsg.Visible := true;
  end
  else
  begin
    // r e m o v e   p r o m p t    m e s s a g e s .
    // minimal clutter in the display.
    txtEnterNumberMsg.Visible := false;
    txtPostToCompleteMsg.Visible := false;
  end;
end;


{ TDefaultFont }

function TDefaultFont.GetDefaultFontFamilyName: string;
begin
  result := 'Tahoma';
end;

function TDefaultFont.GetDefaultFontSize: Single;
begin
  result := 16.0; // Set the default font size here
end;

initialization

TFont.FontService := TDefaultFont.Create;

end.
