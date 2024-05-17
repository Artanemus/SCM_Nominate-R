unit frmNominate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.ListBox, FMX.Edit,
  FMX.TabControl, System.ImageList, FMX.ImgList, dmSCM, System.Actions,
  FMX.ActnList, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.Contnrs, scmMemberNom, ProgramSetting;

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
    btnConfirmNominated: TButton;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnNumPadBackSpace: TButton;
    btnNumPadClear: TButton;
    btnNumPadOK: TButton;
    btnPost: TButton;
    btnRefresh: TButton;
    btnToggle: TButton;
    chkboxShowConfirmationDlg: TCheckBox;
    chkbSessionVisibility: TCheckBox;
    chkbUseOsAuthentication: TCheckBox;
    cmbSessionList: TComboBox;
    cmbSwimClubList: TComboBox;
    edtMemberFullName: TEdit;
    edtMembershipNum: TEdit;
    edtPassword: TEdit;
    edtServerName: TEdit;
    edtUser: TEdit;
    FlowLayout1: TFlowLayout;
    FlowLayoutBreak1: TFlowLayoutBreak;
    FlowLayoutBreak2: TFlowLayoutBreak;
    FlowLayoutBreak3: TFlowLayoutBreak;
    FlowLayoutBreak5: TFlowLayoutBreak;
    Image1: TImage;
    Label1: TLabel;
    Label12: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    layConnectButtons: TLayout;
    layFooter: TLayout;
    layLoginToServer: TLayout;
    layMemberShipNum: TLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    laySelectSession: TLayout;
    layTabs: TLayout;
    lblAniIndicatorStatus: TLabel;
    lblStatusBar: TLabel;
    lblSelectSession: TLabel;
    lblSelectSwimClub: TLabel;
    lbxNominate: TListBox;
    LinkListControlToField1: TLinkListControlToField;
    ScaledLayout1: TScaledLayout;
    SizeGrip1: TSizeGrip;
    StyleBook1: TStyleBook;
    StyleBook2: TStyleBook;
    tabConfimNominated: TTabItem;
    TabControl1: TTabControl;
    tabLoginSession: TTabItem;
    tabMembershipNum: TTabItem;
    tabNominate: TTabItem;
    Timer1: TTimer;
    bsEvent: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnToggleModeExecute(Sender: TObject);
    procedure actnToggleModeUpdate(Sender: TObject);
    procedure btn00Click(Sender: TObject);
    procedure btn01Click(Sender: TObject);
    procedure btn02Click(Sender: TObject);
    procedure btn03Click(Sender: TObject);
    procedure btn04Click(Sender: TObject);
    procedure btn05Click(Sender: TObject);
    procedure btn06Click(Sender: TObject);
    procedure btn07Click(Sender: TObject);
    procedure btn08Click(Sender: TObject);
    procedure btn09Click(Sender: TObject);
    procedure btnConfirmNominatedClick(Sender: TObject);
    procedure btnNumPadBackSpaceClick(Sender: TObject);
    procedure btnNumPadClearClick(Sender: TObject);
    procedure btnNumPadOKClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure chkbSessionVisibilityClick(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure edtMembershipNumKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbxNominateChangeCheck(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
  const
    CONNECTIONTIMEOUT = 48;
  var
    fConnectionCountdown: Integer;
    fLoginTimeOut: Integer;
    fCurrMemberID: Integer;
    fHideClosedSessions: Boolean;
    fIsBuildinglbx: Boolean;
    fMemberNomObjects: TObjectList; // used by lbxNominate
    fShowConfirmationDlg: Boolean;
    procedure btnBKSClickTerminate(Sender: TObject);
    procedure ConnectOnTerminate(Sender: TObject);

    function GetSCMVerInfo(): string;
    procedure LoadFromSettings; // JSON Program Settings
    procedure LoadSettings; // JSON Program Settings
    procedure SaveToSettings; // JSON Program Settings

    // ---- WIP introduced from timekeeper...
    procedure Status_ConnectionDescription;
    procedure Status_EventDescription;
    procedure Update_EntrantStat;
    procedure Update_Layout;
    procedure Update_SessionVisibility;
    procedure Update_TabSheetCaptions;
    // ---- WIP introduced from timekeeper...

    procedure scmBuildlbxItems(objList: TObjectList);
    procedure scmBuildMemberNomObjects(MemberID: Integer);

    procedure PostNominations;
  public
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
  System.IniFiles, System.IOUtils, FireDAC.Stan.Param
  , Data.DB, ExeInfo, SCMSimpleConnect, SCMUtility;

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
  Update_Layout;
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
var
  EventID: Integer;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // disable listviews
    SCM.qryEvent.DisableControls;
    // store the current database record identities
    EventID := SCM.qryEvent.FieldByName('EventID').AsInteger;
    // run the queries
    SCM.qryEvent.Close;

    SCM.qryEvent.Open;
    if SCM.qryEvent.Active then
    Begin
      lblStatusBar.Text := 'SCM Refreshed.';
      // restore database record indexes
      SCM.LocateEventID(EventID);
    End;
    // performs full ReQuery of lane table.
    // scmRefreshLane;
  end;
  SCM.qryEvent.EnableControls;
end;

procedure TNominate.actnRefreshUpdate(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.IsActive) then
    actnRefresh.Enabled := true
  else
    actnRefresh.Enabled := false;
end;

procedure TNominate.actnToggleModeExecute(Sender: TObject);
var
passed: Boolean;
begin
  // NOTE : AutoCheck is disabled
  passed := true;
  // if the current mode is AdminMode
  if actnToggleMode.Checked = false then
  begin
    // The datamodule must be created
    // A connection is required ...
    if not(Assigned(SCM) and SCM.IsActive) then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'A connection is required to toggle mode!';
      passed := false;
    end;
    // A session must be selected
    if cmbSessionList.ItemIndex = -1 then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'A session must be selected to toggle mode!';
      passed := false;
    end;
    // The selected session must be open
    if (SCM.qrySession.FieldByName('SessionStatusID').AsInteger <> 1) then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'The session must be active to toggle mode!';
      passed := false;
    end;
  end;

  if passed then
  begin
    actnToggleMode.Checked := not actnToggleMode.Checked;
    lblStatusBar.Text := '';
  end;

  // in administration mode - only tabLoginSession is visible
  if actnToggleMode.Checked = false then
  begin
    if  TabControl1.TabIndex = 2 then
    begin
      // TODO: postchanges OR abort changes?
      // PostChanges
    end;

    tabLoginSession.Visible := true;
    tabMembershipNum.Visible := false;
    tabNominate.Visible := false;
    tabConfimNominated.Visible := false;
    TabControl1.TabIndex := 0;
  end
  // in nominate mode - tabLoginSession not visible
  else
  begin
    tabLoginSession.Visible := false;
    tabMembershipNum.Visible := true;
    tabNominate.Visible := false;
    TabControl1.TabIndex := 1;
    edtMembershipNum.Text := '';
    // ASSERT ... user cannot select
    tabMembershipNum.CanFocus := false;
    edtMembershipNum.SetFocus;
  end;

end;

procedure TNominate.actnToggleModeUpdate(Sender: TObject);
begin
  // do something ...
end;

procedure TNominate.btn00Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD0;
  KeyChar := '0';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn01Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD1;
  KeyChar := '1';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn02Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD2;
  KeyChar := '2';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn03Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD3;
  KeyChar := '3';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn04Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD4;
  KeyChar := '4';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn05Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD5;
  KeyChar := '5';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn06Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD6;
  KeyChar := '6';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn07Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD7;
  KeyChar := '7';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn08Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD8;
  KeyChar := '8';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btn09Click(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
begin
  Key := VK_NUMPAD9;
  KeyChar := '9';
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
end;

procedure TNominate.btnBKSClickTerminate(Sender: TObject);
begin
  edtMembershipNum.SetFocus;
  edtMembershipNum.Repaint;
end;

procedure TNominate.btnConfirmNominatedClick(Sender: TObject);
begin
    // switch to MembershipNum Tab
    tabConfimNominated.Visible := false;
    tabNominate.Visible := false;
    edtmembershipNum.Text := '';
    fCurrMemberID := 0;
    tabMembershipNum.Visible := true;
    TabControl1.TabIndex := 1;
end;

procedure TNominate.btnNumPadBackSpaceClick(Sender: TObject);
var
  Key: Word;
  KeyChar: Char;
  ShiftState: TShiftState;
  Thread: TThread;
begin
  // Note: don't use VK_BACK; - Windows API only
  Key := vkBack; // System.UITypes - Universal, multi-platform.
  KeyChar := Char(vkBack); // KeyChar := #08;
  lblStatusBar.Text := '';
  if edtMembershipNum.IsFocused then
  begin
    // Note:
    // Backspace doesn't perform correctly unless we run a thread and
    // include the following termination procedure.
    Thread := TThread.CreateAnonymousThread(
      procedure
      begin
        try
          edtMembershipNum.BeginUpdate;
          KeyDown(Key, KeyChar, ShiftState);
        finally
          edtMembershipNum.EndUpdate;
        end;
      end);
    Thread.OnTerminate := btnBKSClickTerminate;
    Thread.Start;
  end;
end;

procedure TNominate.btnNumPadClearClick(Sender: TObject);
begin
  lblStatusBar.Text := '';
  edtMembershipNum.Text := '';
end;

procedure TNominate.btnNumPadOKClick(Sender: TObject);
var
  Number: Integer;
begin
  lblStatusBar.Text := '';
  // Are we connected?
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    // extract integer.
    Number := StrToIntDef(edtMembershipNum.Text, 0);
    // Does the membership number exist?
    if ((Number > 0) and SCM.IsValidMembershipNum(Number)) then
    begin
      // Get the member's ID from membership number
      // BSA FIX: 2023.03.07
      // The member must NOT be archived. Must be active or is a swimmer.
      fCurrMemberID := SCM.GetMemberID(Number);
      // Is the MemberID VALID?
      if fCurrMemberID <> 0 then
      begin
        // Has the TObjectList been constructed?
        if Assigned(fMemberNomObjects) then
        begin
          // this populates fMemberNomObjects with event,
          // member, nomination and 'IsQualified' data
          scmBuildMemberNomObjects(fCurrMemberID);
          // Do we have events?
          if fMemberNomObjects.Count > 0 then
          begin
            // re-create the ListBox Items and assign objects
            scmBuildlbxItems(fMemberNomObjects);
            // get the members fullname ...
            edtMemberFullName.Text := SCM.GetMemberFName(fCurrmemberID);
            // switch to tab showing Nomination ListBox.
            tabMembershipNum.Visible := false;
            tabNominate.Visible := true;
            TabControl1.TabIndex := 2;
          end
          else
          begin
{$IFDEF MSWINDOWS}
            MessageBeep(MB_ICONERROR);
{$ENDIF}
            lblStatusBar.Text := 'No events found in this session!';
          end;
        end
        else
        begin
{$IFDEF MSWINDOWS}
          MessageBeep(MB_ICONERROR);
{$ENDIF}
          lblStatusBar.Text := 'Unexpected error. ObjectList invalid.';
        end;
      end
      else
      begin
{$IFDEF MSWINDOWS}
        MessageBeep(MB_ICONERROR);
{$ENDIF}
        lblStatusBar.Text := 'Member''s ID not found or not a swimmer or not active or is archived.';
      end;
    end
    else
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblStatusBar.Text := 'The membership number wasn''t found.';
    end;
  end
end;

procedure TNominate.btnPostClick(Sender: TObject);

begin
  // Process nomination ....
  // Iterate over TMemberNom and SYNC MSSQLEXPRESS Nominate table data.
  PostNominations;

  if fShowConfirmationDlg then
  begin
    // show confirmation tabsheet
    tabNominate.Visible := false;
    tabConfimNominated.Visible := true;
    TabControl1.TabIndex := 3;
  end
  else
  begin
    // switch to MembershipNum Tab
    tabNominate.Visible := false;
    tabConfimNominated.Visible := false;
    edtmembershipNum.Text := '';
    fCurrMemberID := 0;
    tabMembershipNum.Visible := true;
    TabControl1.TabIndex := 1;
  end;

end;

procedure TNominate.chkbSessionVisibilityClick(Sender: TObject);
begin
  if (Assigned(SCM) and SCM.scmConnection.Connected) then
    Update_SessionVisibility();
end;

procedure TNominate.cmbSessionListChange(Sender: TObject);
begin
  lblStatusBar.Text := '';
  if (Assigned(SCM) and SCM.IsActive) then
  begin
      if Assigned(fMemberNomObjects) then
      begin
        // re-create the objects for the ListBox
        scmBuildMemberNomObjects(0);
        // re-create the ListBox Items and assign objects
        scmBuildlbxItems(fMemberNomObjects);
      end;
  end;
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
      Update_SessionVisibility;
      // I N I T  ....
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
  Update_Layout;

end;

procedure TNominate.edtMembershipNumKeyDown(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    // test for DONE.
    if edtMembershipNum.ReturnKeyType = TReturnKeyType.Done then
    begin
      btnNumPadOKClick(Self);
    end;
  end;
end;

procedure TNominate.FormCreate(Sender: TObject);
begin
  // Initialization of params.
  application.ShowHint := true;
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
  btnDisconnect.Visible := false;
  fConnectionCountdown := CONNECTIONTIMEOUT;
  fShowConfirmationDlg := false;
  Timer1.Enabled := false;
  lblAniIndicatorStatus.Visible := false;
  fCurrMemberID := 0;
  fIsBuildinglbx := false;

  // A Class that uses JSON to read and write application configuration
  if Settings = nil then
    Settings := TPrgSetting.Create;

  cmbSessionList.Items.Clear;
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

  // TAB_SHEET : DEFAULT: Login-Session
  TabControl1.TabIndex := 0;

  // Connection status - located in footer bar.
  lblStatusBar.Text := 'NOT CONNECTED';

  edtMembershipNum.Text := '';
  // actnToggleMode.AutoChecked is disabled - ASSERT AdminMode.
  actnToggleMode.Checked := false;
  // only login visible on boot
  tabLoginSession.Visible := true;
  tabConfimNominated.Visible := false;
  tabMembershipNum.Visible := false;
  tabNominate.Visible := false;


  // prep lbxNominate
  fMemberNomObjects := TObjectList.Create(true);
  FMemberNomObjects.OwnsObjects := true;
end;

procedure TNominate.FormDestroy(Sender: TObject);
begin
  // finalise any out standing nominations?
  if TabControl1.TabIndex = 2 then
    fShowConfirmationDlg := false;

  // C L E A N   U P   N O M I N A T I O N  L I S T B O X
  // remove ptrs to objects in list
  lbxNominate.Items.Clear;
  // destroy lbxNominate objects
  if Assigned(fMemberNomObjects) then
  begin
    fMemberNomObjects.Clear; // destroys objects
    FreeAndNil(fMemberNomObjects);
  end;

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

procedure TNominate.lbxNominateChangeCheck(Sender: TObject);
var
obj: TMemberNom;
begin
  if fIsBuildinglbx = false then
  begin
    if Assigned(fMemberNomObjects) then
    begin
      obj := TMemberNom(lbxNominate.Items.Objects[lbxNominate.ItemIndex]);
      if Assigned(obj) then
        obj.IsNominated := lbxNominate.ListItems[lbxNominate.ItemIndex].IsChecked;
    end;
  end;
end;

procedure TNominate.LoadFromSettings;
begin
  edtServerName.Text := Settings.Server;
  edtUser.Text := Settings.User;
  edtPassword.Text := Settings.Password;
  chkbUseOsAuthentication.IsChecked := Settings.OSAuthent;
  chkbSessionVisibility.IsChecked := Settings.SessionVisibility;
  chkboxShowConfirmationDlg.IsChecked := Settings.ShowConfirmationDlg;
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
  Settings.LoginTimeOut := fLoginTimeOut;
  Settings.SaveToFile();
end;

procedure TNominate.scmBuildlbxItems(objList: TObjectList);
var
I, index: integer;
obj: TMemberNom;
lbxi: TListBoxItem;
begin
    lbxNominate.Items.Clear;
    for I := 0 to objList.Count -1 do
    begin
      obj := TMemberNom(objList.Items[I]);
      // fill lbx with items
      index := lbxNominate.Items.AddObject(obj.Title, obj);
      lbxi := lbxNominate.ListItems[index];
      lbxi.ItemData.Detail := obj.Description;
      fIsBuildinglbx := true;
      lbxNominate.ListItems[index].IsChecked := obj.IsNominated;
      fIsBuildinglbx := false;
    end;
end;

procedure TNominate.scmBuildMemberNomObjects(MemberID: Integer);
var
  obj: TMemberNom;
begin

  if (Assigned(SCM) and SCM.IsActive) then
  begin
    if Assigned(fMemberNomObjects) then
    begin
      fMemberNomObjects.Clear;

      // REQUERY (SESSION MAY HAVE CHANGED)
      if SCM.qryEvent.Active then
        SCM.qryEvent.Close;

      SCM.qryEvent.Open;
      if SCM.qryEvent.Active then
      begin
        if not SCM.qryEvent.IsEmpty then
        begin
          SCM.qryEvent.First;
          while not SCM.qryEvent.Eof do
          begin
            obj := TMemberNom.Create;
            obj.SessionID := SCM.qryEvent.FieldByName('SessionID').AsInteger;
            obj.EventID := SCM.qryEvent.FieldByName('EventID').AsInteger;
            obj.DistanceID := SCM.qryEvent.FieldByName('DistanceID').AsInteger;
            obj.StrokeID := SCM.qryEvent.FieldByName('StrokeID').AsInteger;
            obj.Title := SCM.qryEvent.FieldByName('ListTextStr').AsString;
            obj.Description := SCM.qryEvent.FieldByName('ListDetailStr').AsString;
            obj.MemberID := MemberID;
            obj.EventStatusID := SCM.qryEvent.FieldByName('EventStatusID').AsInteger;

            // CALL SQLEXPRESS SCALAR FUNCTION
            // NOTE : uses scmConnection.ExecSQLScalar
            if SCM.IsMemberQualified(MemberID, obj.DistanceID, obj.StrokeID) then
            begin
              obj.Description := '(Qualified) ' + obj.Description;
              obj.IsQualified := true; // on create - default is false;
            end;

            // CALL SQLEXPRESS SCALAR FUNCTION
            // NOTE : uses scmConnection.ExecSQLScalar
            obj.IsNominated := SCM.IsMemberNominated(MemberID, obj.EventID);

            fMemberNomObjects.Add(obj); // note: owns objects
            SCM.qryEvent.Next;
          end;
        end;
      end;
    end;
  end;
end;


procedure TNominate.PostNominations;
var
  EntrantID, i: Integer;
  obj: TMemberNom;
  IsNominatedInDB: boolean;
begin
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    if Assigned(fMemberNomObjects) then
    begin
      for i := 0 to fMemberNomObjects.Count - 1 do
      begin
        // WHAT THE MEMBER ELECTED TO DO ...
        obj := TMemberNom(fMemberNomObjects.Items[i]);
        // WHAT THE MEMBER'S NOMINATION STATUS IS IN THE DATABASE ...
        IsNominatedInDB := SCM.IsMemberNominated(obj.MemberID, obj.EventID);

        // The member is nominated in this event in the DATABASE ...
        if IsNominatedInDB  then
        begin
          // SYNCED nothing to do ...
          if obj.IsNominated then
            continue
          else
          // THE MEMBER HAS ELECTED TO REMOVE NOMINATION
          // -------------------------------------------------------------
          // If member is an entrant in the event (they've been given
          // a lane),  then the record must be removed prior to deleting
          // the nomination.
          begin
            // TEST if member is an entrant in the event
            EntrantID := SCM.IsMemberEntrant(obj.MemberID, obj.EventID);
            if EntrantID > 0 then
            begin
              // remove the lane data
              SCM.commandDeleteSplit(EntrantID); // REMOVE split data records
              SCM.commandDeleteEntrant(EntrantID); // REMOVE entrant record
            end;
            // remove the nomination record in the database
            SCM.commandDeleteNomination(obj.MemberID, obj.EventID);
          end;
        end
        else
        // The member is NOT nominated in the DATABASE ...
        begin
          // SYNCED nothing to do ...
          if not obj.IsNominated then
            continue
          else
          // the member has elected to NOMINATE for this event
          // -------------------------------------------------------------
          begin
            // create a new nomination record
            // NOTE: TTB, PB and SeedDate not assigned in record
            // TODO: check that autocreate heat fills the missing data ...
            SCM.commandCreateNomination(obj.MemberID, obj.EventID);
          end;
        end;
      end;
    end;
  end;
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
  end;
end;

procedure TNominate.Status_EventDescription;
begin
  if Assigned(SCM) and SCM.IsActive then
  begin
    // S T A T U S   L I N E .
    // E V E N T   D E S C R I P T I O  N  .
    // Distance Stroke, NOM and ENT count ....
    lblStatusBar.Text := bsEvent.DataSet.FieldByName
      ('ListDetailStr').AsString;
  end
  else
      lblStatusBar.Text := '';
end;

procedure TNominate.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex = 1 then
  begin
    edtMembershipNum.SetFocus;
  end;
end;

procedure TNominate.Update_EntrantStat;
begin

end;

procedure TNominate.Update_Layout;
begin

end;

procedure TNominate.Update_SessionVisibility;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qrySession.DisableControls;
    // remove all the strings held in the combobox
    // note cmbSessionList.Clear doesn't work here.
    cmbSessionList.Items.Clear;
    SCM.qrySession.Close;
    // ASSIGN PARAM to display or hide CLOSED sessions
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean :=
      chkbSessionVisibility.IsChecked;
    SCM.qrySession.Prepare;
    SCM.qrySession.Open;
    SCM.qrySession.EnableControls
  end

  // the datamodule exists but qrySession isn't connected..
  else if (Assigned(SCM)) then
  begin
    // qrySession ISN'T ACTIVE ....
    // update state of qryLane PARAM
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean :=
      chkbSessionVisibility.IsChecked;
  end;
end;

procedure TNominate.Update_TabSheetCaptions;
begin

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
