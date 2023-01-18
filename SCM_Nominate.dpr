program SCM_Nominate;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmNominate in 'frmNominate.pas' {Nominate},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgSCMOptions in 'dlgSCMOptions.pas' {scmOptions},
  scmMemberNom in 'scmMemberNom.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TNominate, Nominate);
  Application.Run;
end.
