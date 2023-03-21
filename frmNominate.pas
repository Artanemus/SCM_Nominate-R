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
  System.Contnrs, scmMemberNom;

type
  TNominate = class(TForm)
    StyleBook2: TStyleBook;
    layTopBar: TLayout;
    layTitle: TLayout;
    lblSessionTitle: TLabel;
    lblSwimClubTitle: TLabel;
    laySummary: TLayout;
    lblSelectedEntrant: TLabel;
    lblSelectedEvent: TLabel;
    layCenteredButtons: TLayout;
    btnOptions: TButton;
    btnRefresh: TButton;
    layFooter: TLayout;
    SizeGrip1: TSizeGrip;
    lblConnectionStatus: TLabel;
    layTabs: TLayout;
    TabControl1: TTabControl;
    tabLoginSession: TTabItem;
    layLoginToServer: TLayout;
    layConnectButtons: TLayout;
    btnConnect: TButton;
    btnDisconnect: TButton;
    Label7: TLabel;
    edtServer: TEdit;
    Label8: TLabel;
    edtUser: TEdit;
    Label12: TLabel;
    edtPassword: TEdit;
    chkOsAuthent: TCheckBox;
    Label18: TLabel;
    AniIndicator1: TAniIndicator;
    lblAniIndicatorStatus: TLabel;
    laySelectSession: TLayout;
    lblSelectSession: TLabel;
    cmbSessionList: TComboBox;
    tabMembershipNum: TTabItem;
    Layout1: TLayout;
    FlowLayout1: TFlowLayout;
    btn01: TButton;
    btn02: TButton;
    btn03: TButton;
    FlowLayoutBreak1: TFlowLayoutBreak;
    btn04: TButton;
    btn05: TButton;
    btn06: TButton;
    FlowLayoutBreak2: TFlowLayoutBreak;
    btn07: TButton;
    btn08: TButton;
    btn09: TButton;
    FlowLayoutBreak3: TFlowLayoutBreak;
    btn00: TButton;
    btnNumPadBackSpace: TButton;
    btnNumPadClear: TButton;
    btnNumPadOK: TButton;
    FlowLayoutBreak5: TFlowLayoutBreak;
    layMemberShipNum: TLayout;
    edtMembershipNum: TEdit;
    Label1: TLabel;
    tabNominate: TTabItem;
    ScaledLayout1: TScaledLayout;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnRefresh: TAction;
    actnQualify: TAction;
    actnSCMOptions: TAction;
    Timer1: TTimer;
    Layout2: TLayout;
    edtMemberFullName: TEdit;
    Layout3: TLayout;
    lbxNominate: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    btnPost: TButton;
    actnToggleMode: TAction;
    actnNominateOk: TAction;
    Layout4: TLayout;
    Layout5: TLayout;
    Label2: TLabel;
    btnToggle: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    BindSourceDB2: TBindSourceDB;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    Layout6: TLayout;
    lblInfoMsg01: TLabel;
    Layout7: TLayout;
    tabConfimNominated: TTabItem;
    Layout8: TLayout;
    btnConfirmNominated: TButton;
    Image1: TImage;
    Label3: TLabel;
    Layout9: TLayout;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure actnConnectExecute(Sender: TObject);
    procedure actnConnectUpdate(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnDisconnectUpdate(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnSCMOptionsExecute(Sender: TObject);
    procedure actnSCMOptionsUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn01Click(Sender: TObject);
    procedure btn02Click(Sender: TObject);
    procedure btn03Click(Sender: TObject);
    procedure btn04Click(Sender: TObject);
    procedure btn05Click(Sender: TObject);
    procedure btn06Click(Sender: TObject);
    procedure btn07Click(Sender: TObject);
    procedure btn08Click(Sender: TObject);
    procedure btn09Click(Sender: TObject);
    procedure btn00Click(Sender: TObject);
    procedure btnNumPadBackSpaceClick(Sender: TObject);
    procedure btnNumPadClearClick(Sender: TObject);
    procedure btnNumPadOKClick(Sender: TObject);
    procedure actnToggleModeExecute(Sender: TObject);
    procedure actnToggleModeUpdate(Sender: TObject);
    procedure edtMembershipNumKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure TabControl1Change(Sender: TObject);
    procedure lbxNominateChangeCheck(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure cmbSessionListChange(Sender: TObject);
    procedure btnConfirmNominatedClick(Sender: TObject);

  private const
    SCMCONFIGFILENAME = 'SCMConfig.ini';
    CONNECTIONTIMEOUT = 48;

  private
    { Private declarations }
    fShowConfirmationDlg: Boolean;
    fHideClosedSessions: Boolean;
    fConnectionCountdown: Integer;
    fCurrMemberID: Integer;
    fMemberNomObjects: TObjectList; // used by lbxNominate
    // used to modify notify event - OnChangeeCheck behaviour,
    // when building the items used by TListBox:lbxNominate
    fIsBuildinglbx: Boolean;

    procedure ConnectOnTerminate(Sender: TObject);
    procedure btnBKSClickTerminate(Sender: TObject);
    procedure scmUpdateButtonState;

    procedure scmBuildMemberNomObjects(MemberID: Integer);
    procedure scmPostNominations;
    procedure scmBuildlbxItems(objList: TObjectList);
//    procedure scmUpdatelbxNominateItems;
//    procedure scmUpdatelbxNominateChecks;
//    procedure scmUpdatelbxNominateQualified;

    procedure GetSCMVerInfo();

  public
    { Public declarations }

    procedure scmOptionsLoad;
    procedure scmUpdateHideClosedSessions;
    procedure scmUpdateTabSheetsImages;

    property HideClosedsessions: Boolean read fHideClosedSessions;

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
  System.IniFiles, System.IOUtils, dlgSCMOptions, FireDAC.Stan.Param
  , Data.DB, SCMExeInfo;

procedure TNominate.actnConnectExecute(Sender: TObject);
var
    myThread: TThread;
begin
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblAniIndicatorStatus.Text := 'Connecting';
    fConnectionCountdown := CONNECTIONTIMEOUT;
    AniIndicator1.Visible := true; // progress timer
    AniIndicator1.Enabled := true; // start spinning
    lblAniIndicatorStatus.Visible := true; // a label with countdown
    // lock this button - so user won't start another thread!
    btnConnect.Enabled := false;
    Timer1.Enabled := true; // start the countdown

    application.ProcessMessages;

    myThread := TThread.CreateAnonymousThread(
      procedure
      begin
        try
          SCM.SimpleMakeTemporyFDConnection(edtServer.Text, edtUser.Text,
            edtPassword.Text, chkOsAuthent.IsChecked);
        finally
          Timer1.Enabled := false;
          lblAniIndicatorStatus.Visible := false;
          AniIndicator1.Enabled := false;
          AniIndicator1.Visible := false;
          btnConnect.Enabled := true;
        end;
      end);
    myThread.OnTerminate := ConnectOnTerminate;
    myThread.Start;
  end;

end;

procedure TNominate.actnConnectUpdate(Sender: TObject);
begin
  // toggle visibility of Connect button.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      begin
      actnConnect.Visible := false;
      lblInfoMsg01.Visible := false;
      end
    else
      actnConnect.Visible := true
  else
    actnConnect.Visible := true;
end;

procedure TNominate.actnDisconnectExecute(Sender: TObject);
begin
  // IF DATA-MODULE EXISTS ... break the current connection.
  if Assigned(SCM) then
  begin
    SCM.DeActivateTable;
    SCM.scmConnection.Connected := false;
    lblConnectionStatus.Text := 'No connection.';
  end;
  // Hides..unhides visibility of icons in tabLoginSession
  scmUpdateTabSheetsImages;
  scmUpdateButtonState;
  AniIndicator1.Visible := false;
  lblAniIndicatorStatus.Visible := false;
  AniIndicator1.Enabled := false;

end;

procedure TNominate.actnDisconnectUpdate(Sender: TObject);
begin
  // toggle visibility of Disconnect button.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      actnDisconnect.Visible := true
    else
    begin
      actnDisconnect.Visible := false;
      lblInfoMsg01.Visible := true;
    end
  else
    actnDisconnect.Visible := false;
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
      lblConnectionStatus.Text := 'SCM Refreshed.';
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

procedure TNominate.actnSCMOptionsExecute(Sender: TObject);
var
  dlg: TscmOptions;
begin
{$IFNDEF ANDROID}
  dlg := TscmOptions.Create(self);
  dlg.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      // ... Do something.

      // Always reload SCM options from the scmConfig.ini file.
      // There is no CANCEL for this modal form. What ever the user does,
      // the input values are accepted.
      scmOptionsLoad;
      // update the visibility of the accessory item in the ListViewLane
      // safe - doesn't require connection.
      // scmUpdateNomination(fEnableNomination);
      // little status images used on the tabsheets
      // scmUpdateTabSheetsImages;
      // Update the visibility of closed sessions in qrySession
      // by modifying it's param HIDECLOSED.
      // This uses value fHideClosedSessions and is best done after a fresh
      // read of the scmConfig.ini values.
      scmUpdateHideClosedSessions;
      // update the visibility of the accessory icon
      // if fEnableNomination then
      // ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.Visible := true
      // else
      // ListViewLane.ItemAppearanceObjects.ItemObjects.Accessory.
      // Visible := false;

      // Update GUI state
      actnSCMOptionsUpdate(self);
    end);

{$ELSE}
  { TODO : Create an android popup window for options? }
  // ANDROID platform doesn't do Modal Forms.
{$ENDIF}
  (*
    IMPORTANT NOTE : DIALOGUE IS DESTROYED IN TscmOption.FormClose
  *)
end;

procedure TNominate.actnSCMOptionsUpdate(Sender: TObject);
begin
  // if (Assigned(SCM) and SCM.IsActive) then
  // ListViewLane.Enabled := true
  // else
  // ListViewLane.Enabled := true;
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
      lblConnectionStatus.Text := 'A connection is required to toggle mode!';
      passed := false;
    end;
    // A session must be selected
    if cmbSessionList.ItemIndex = -1 then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblConnectionStatus.Text := 'A session must be selected to toggle mode!';
      passed := false;
    end;
    // The selected session must be open
    if (SCM.qrySession.FieldByName('SessionStatusID').AsInteger <> 1) then
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblConnectionStatus.Text := 'The session must be active to toggle mode!';
      passed := false;
    end;
  end;

  if passed then
  begin
    actnToggleMode.Checked := not actnToggleMode.Checked;
    lblConnectionStatus.Text := '';
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
  // toggle visibility of topbar buttons
  scmUpdateButtonState;
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
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
  lblConnectionStatus.Text := '';
  if edtMembershipNum.IsFocused then
    KeyDown(Key, KeyChar, ShiftState);
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
  lblConnectionStatus.Text := '';
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

procedure TNominate.btnNumPadClearClick(Sender: TObject);
begin
  lblConnectionStatus.Text := '';
  edtMembershipNum.Text := '';
end;

procedure TNominate.btnPostClick(Sender: TObject);

begin
  // Process nomination ....
  // Iterate over TMemberNom and SYNC MSSQLEXPRESS Nominate table data.
  scmPostNominations;

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

procedure TNominate.btnNumPadOKClick(Sender: TObject);
var
  Number: Integer;
begin
  lblConnectionStatus.Text := '';
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
            lblConnectionStatus.Text := 'No events found in this session!';
          end;
        end
        else
        begin
{$IFDEF MSWINDOWS}
          MessageBeep(MB_ICONERROR);
{$ENDIF}
          lblConnectionStatus.Text := 'Unexpected error. ObjectList invalid.';
        end;
      end
      else
      begin
{$IFDEF MSWINDOWS}
        MessageBeep(MB_ICONERROR);
{$ENDIF}
        lblConnectionStatus.Text := 'Member''s ID not found or not a swimmer or not active or is archived.';
      end;
    end
    else
    begin
{$IFDEF MSWINDOWS}
      MessageBeep(MB_ICONERROR);
{$ENDIF}
      lblConnectionStatus.Text := 'The membership number wasn''t found.';
    end;
  end
end;

procedure TNominate.cmbSessionListChange(Sender: TObject);
begin
  lblConnectionStatus.Text := '';
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
  if TThread(Sender).FatalException <> nil then
  begin
    // something went wrong
    // Exit;
  end;

  // Tidy-up display
  // lblAniIndicatorStatus.Visible := false;
  // AniIndicator1.Enabled := false;
  // AniIndicator1.Visible := false;
  if Assigned(SCM) then
  begin
    // Make tables active
    if (SCM.scmConnection.Connected) then
    begin
      SCM.ActivateTable;
      // ALL TABLES SUCCESSFULLY MADE ACTIVE ...
      if (SCM.IsActive = true) then
      begin
        lblConnectionStatus.Text := 'Connected to SwimClubMeet.';
        // TODO: FIRST TIME INIT
        // scmRefreshLane;
      end
      else
        lblConnectionStatus.Text :=
          'Connected to SwimClubMeet but not all tables are active!';
    end;
  end;

  // FINAL CHECKS
  if (Assigned(SCM) and (SCM.scmConnection.Connected = false)) then
  begin
    lblConnectionStatus.Text := 'No connection.';
  end;

  // Toggle button state.
  scmUpdateButtonState;
  // Label showing application and database version
  GetSCMVerInfo;

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
var
  AValue, ASection, AName: String;

begin
  // Initialization of params.
  application.ShowHint := true;
  ASection := 'MSSQL_SwimClubMeet';
  AniIndicator1.Visible := false;
  AniIndicator1.Enabled := false;
  btnDisconnect.Visible := false;
  fConnectionCountdown := CONNECTIONTIMEOUT;
  fShowConfirmationDlg := false;
  Timer1.Enabled := false;
  lblAniIndicatorStatus.Visible := false;
  fCurrMemberID := 0;
  fIsBuildinglbx := false;


  // note cmbSessionList.Clear doesn't work here.
  cmbSessionList.Items.Clear;
  lbxNominate.Items.Clear;

  // clean-up the top bar captions
  lblSwimClubTitle.Text := String.Empty;
  lblSessionTitle.Text := String.Empty;
  lblSelectedEvent.Text := String.Empty;
  lblSelectedEntrant.Text := String.Empty;

  // clean-up TabSheet3
  // lblEntrantsHeatNum.Text := 'Entrants ...';

  // ON CREATION SETS - SCM->scmConnection->Active = false;
  SCM := TSCM.Create(self);

  // Read last successful connection params and load into controls
  AName := 'Server';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtServer.Text := AValue;
  AName := 'User';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtUser.Text := AValue;
  AName := 'Password';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);
  edtPassword.Text := AValue;
  AName := 'OsAuthent';
  SCM.SimpleLoadSettingString(ASection, AName, AValue);

  if ((UpperCase(AValue) = 'YES') or (UpperCase(AValue) = 'TRUE')) then
    chkOsAuthent.IsChecked := true
  else
    chkOsAuthent.IsChecked := false;

  // Connection status - located in footer bar.
  lblConnectionStatus.Text := '';


  // Login-Session
  TabControl1.TabIndex := 0;
  // read user options
  scmOptionsLoad;
  // update the visibility of the accessory item in the ListViewLane
  // safe - doesn't require connection.
  // scmUpdateNomination(fEnableNomination);
  // update the images to use in each tabsheet
  // scmUpdateTabSheetsImages;
  // Update the visibility of closed sessions in qrySession
  // by modifying it's param HIDECLOSED.
  // This uses value fHideClosedSessions and is best done after a fresh
  // read of the scmConfig.ini values.
  // scmUpdateHideClosedSessions;
  // TIDY ALL TLISTVIEW DISPLAYS - (fixes TViewListLane)
  // on startup SCM will be set to disconnected.
  if Assigned(SCM) then
    SCM.DeActivateTable;

  // Hide controls used by entrant details
  // scmRefreshEntrant_Detail;
  // Hide big buttons.
  // scmRefreshBigButtons;

  edtMembershipNum.Text := '';
  // actnToggleMode.AutoChecked is disabled - ASSERT AdminMode.
  actnToggleMode.Checked := false;
  // only login visible on boot
  tabLoginSession.Visible := true;
  tabConfimNominated.Visible := false;
  tabMembershipNum.Visible := false;
  tabNominate.Visible := false;
  scmUpdateButtonState;

  // prep lbxNominate
  fMemberNomObjects := TObjectList.Create(true);
  FMemberNomObjects.OwnsObjects := true;
end;

procedure TNominate.FormDestroy(Sender: TObject);
begin
  if TabControl1.TabIndex = 2 then
  begin
    fShowConfirmationDlg := false;
    // finalizes any nominations
    // TODO : post changes or abort?
    // PostChanges
  end;
  // remove ptrs to objects in list
  lbxNominate.Items.Clear;
  // destroy lbxNominate objects
  if Assigned(fMemberNomObjects) then
  begin
    fMemberNomObjects.Clear; // destroys objects
    FreeAndNil(fMemberNomObjects);
  end;
  // IF DATA-MODULE EXISTS ... break the current connection.
  if Assigned(SCM) then
  begin
    SCM.DeActivateTable;
    SCM.scmConnection.Connected := false;
  end;
  // CLEAN MEMORY
  SCM.Free;
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

procedure TNominate.scmOptionsLoad;
var
  ini: TIniFile;
  Section: String;
begin
  Section := 'NominateOptions';
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    fShowConfirmationDlg := ini.ReadBool(Section, 'ShowConfirmationDlg', false);
    fHideClosedSessions := ini.ReadBool(Section, 'HideClosedSessions', true);
  finally
    ini.Free;
  end;

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
            obj.Title := SCM.qryEvent.FieldByName('Title').AsString;
            obj.Description := SCM.qryEvent.FieldByName('Description').AsString;
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


procedure TNominate.scmUpdateButtonState;
begin

  btnOptions.Visible := true;
  btnRefresh.Visible := true;
  btnToggle.Visible := true;

  // DATAMODULE OFFLINE
  if not (Assigned(SCM) and SCM.IsActive) then
  begin
    btnToggle.Visible := false;
    btnRefresh.Visible := false;
  end
  else
  begin
    // ADMIN MODE
    if not (actnToggleMode.Checked) then
    begin
      btnOptions.Visible := true;
    // The selected session must be open
    if cmbSessionList.ItemIndex = -1 then
      btnRefresh.Visible := false;
    end
    else
    // NOMINATE MODE
    begin
      btnOptions.Visible := false;
      btnRefresh.Visible := false;
    end
  end;
end;



procedure TNominate.scmUpdateHideClosedSessions;
begin
  if Assigned(SCM) and SCM.qrySession.Active then
  begin
    SCM.qrySession.DisableControls;
    // remove all the strings held in the combobox
    // note cmbSessionList.Clear doesn't work here.
    cmbSessionList.Items.Clear;
    SCM.qrySession.Close;
    // ASSIGN PARAM to display or hide CLOSED sessions
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean := fHideClosedSessions;
    SCM.qrySession.Prepare;
    SCM.qrySession.Open;
    SCM.qrySession.EnableControls
  end
  // the datamodule exists but qrySession isn't connected..
  else if (Assigned(SCM)) then
  begin
    // qrySession ISN'T ACTIVE ....
    // update state of qryLane PARAM
    SCM.qrySession.ParamByName('HIDECLOSED').AsBoolean := fHideClosedSessions;
  end;

end;

//procedure TNominate.scmUpdatelbxNominateChecks;
//var
//  i: Integer;
//  obj: TMemberNom;
//  lbxi: TListBoxItem;
//begin
//  for i := 0 to lbxNominate.Items.Count - 1 do
//  begin
//    obj := TMemberNom(lbxNominate.Items.Objects[i]);
//    lbxi := lbxNominate.ListItems[i];
//    lbxi.IsChecked := scmIsMemberNominated(obj.MemberID, obj.SessionID,
//      obj.DistanceID, obj.StrokeID);
//  end;
//end;

//procedure TNominate.scmUpdatelbxNominateItems;
//var
//  i, index: Integer;
//  obj: TMemberNom;
//  lbxi: TListBoxItem;
//begin
//
//  lbxNominate.Items.Clear;
//  if Assigned(fMemberNomObjects) then
//  begin
//    for i := 0 to fMemberNomObjects.Count - 1 do
//    begin
//      obj := TMemberNom(fMemberNomObjects.Items[i]);
//      index := lbxNominate.Items.AddObject(obj.Title, obj);
//      lbxi := lbxNominate.ListItems[index];
//      // Note: may include the comment '(Qualified)'
//      lbxi.ItemData.Detail := obj.Description;
//      lbxi.IsChecked := scmIsMemberNominated(obj.MemberID, obj.SessionID,
//        obj.DistanceID, obj.StrokeID);
//    end;
//  end;
//end;

//procedure TNominate.scmUpdatelbxNominateQualified;
//var
//  i: Integer;
//  obj: TMemberNom;
//  lbxi: TListBoxItem;
//begin
//  for i := 0 to lbxNominate.Items.Count - 1 do
//  begin
//    obj := TMemberNom(lbxNominate.Items.Objects[i]);
//    lbxi := lbxNominate.ListItems[i];
//    lbxi.IsChecked := scmIsMemberQualified(obj.MemberID, obj.DistanceID,
//      obj.StrokeID);
//  end;
//end;

procedure TNominate.scmUpdateTabSheetsImages;
begin
  // Update image indicators in the tabsheets.
  if (Assigned(SCM) and SCM.IsActive) then
  begin
    if (fShowConfirmationDlg) then
    begin
      if (fShowConfirmationDlg) then
        // small red pin on tabsheet
        tabNominate.ImageIndex := 1
      else
        // small white pin on tabsheet
        tabNominate.ImageIndex := 0
    end;

    if (fHideClosedSessions) then
      tabLoginSession.ImageIndex := 3
    else
      tabLoginSession.ImageIndex := 2;

  end
  // Not connect - hide all
  else
  begin
    tabNominate.ImageIndex := -1;
    tabLoginSession.ImageIndex := -1;
    tabMembershipNum.ImageIndex := -1;
  end;
end;

procedure TNominate.scmPostNominations;
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

procedure TNominate.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex = 1 then
  begin
    edtMembershipNum.SetFocus;
  end;
end;

procedure TNominate.GetSCMVerInfo;
{$IF defined(MSWINDOWS)}
var
  myExeInfo: TExeInfo;
{$ENDIF}
begin
  // if connected - display the application version
  // and the SwimClubMeet database version.
  if Assigned(SCM) then
    if SCM.scmConnection.Connected then
      Label4.Text := 'DB v' + SCM.GetDBVerInfo
    else
      Label4.Text := '';

{$IF defined(MSWINDOWS)}
  // get the application version number
  myExeInfo := TExeInfo.Create(self);
  Label4.Text := 'App v' + myExeInfo.FileVersion + ' - ' +
    Label4.Text;
  myExeInfo.Free;

{$ENDIF}
end;

end.
