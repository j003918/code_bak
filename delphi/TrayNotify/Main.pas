unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, ExtCtrls, StdCtrls;

type
  TfrmMain = class(TForm)
    TrayIcon1: TTrayIcon;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure TrayIcon1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure SetTrayFlash(IsFlash : Boolean);
    procedure HideToTray;
    procedure ShowToDesktop;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


procedure TfrmMain.Button1Click(Sender: TObject);
begin
  trayicon1.BalloonHint := '有人找';
  trayicon1.BalloonTitle := '标题';
  SetTrayFlash(true);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  SetTrayFlash(false)
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  HideToTray;
  CanClose:=False;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
Style: Integer;
begin
Style := GetWindowLong(Handle, GWL_EXSTYLE);
SetWindowLong(Handle, GWL_EXSTYLE, Style and (not WS_EX_APPWINDOW));
ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmMain.HideToTray;
begin
    Application.Minimize;
    ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
application.Terminate
end;

procedure TfrmMain.ShowToDesktop;
begin
    ShowWindow(Application.Handle, SW_RESTORE);
end;

procedure TfrmMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  inherited;
  if Msg.CmdType = SC_MINIMIZE then
  begin
    HideToTray;
  end;
end;

procedure TfrmMain.SetTrayFlash(IsFlash: Boolean);
begin

  if TrayIcon1.Animate = IsFlash then exit;

  TrayIcon1.Animate := IsFlash;
  if IsFlash then trayicon1.ShowBalloonHint;
  if not IsFlash then TrayIcon1.IconIndex := 0;
end;

procedure TfrmMain.TrayIcon1Click(Sender: TObject);
begin
  ShowToDesktop;
end;

end.
