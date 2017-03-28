unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ExtCtrls, StdCtrls;

type
  TfrmMain = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    N1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure SetTrayFlash(IsFlash : Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


procedure TfrmMain.SetTrayFlash(IsFlash: Boolean);
begin
  TrayIcon1.Animate := IsFlash;
  if not IsFlash then TrayIcon1.IconIndex := 0
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
       SetTrayFlash(true)
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
      SetTrayFlash(false)
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
  application.Terminate
end;

end.
