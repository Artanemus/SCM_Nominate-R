program SCM_Nominate;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmNominate in 'frmNominate.pas' {Nominate},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgSCMOptions in 'dlgSCMOptions.pas' {scmOptions},
  scmMemberNom in 'scmMemberNom.pas',
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas',
  exeinfo in '..\SCM_SHARED\exeinfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TNominate, Nominate);
  Application.Run;
end.
