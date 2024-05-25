unit dlgSCMConfirmation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TSCMConfirmation = class(TForm)
    StyleBook2: TStyleBook;
    Layout3: TLayout;
    btnClose: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SCMConfirmation: TSCMConfirmation;

implementation

{$R *.fmx}

procedure TSCMConfirmation.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close();
end;

procedure TSCMConfirmation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
