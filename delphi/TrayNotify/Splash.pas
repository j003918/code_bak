unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
    LblStatus: TLabel;
  private
    { Private declarations }
    FParam:Pointer;
  public
    { Public declarations }
    class function Execute(AParam:Pointer):Boolean;
    procedure SetStatusText(Value: string);
  published
    property StatusText : string write SetStatusText;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

class function TfrmSplash.Execute(AParam:Pointer): Boolean;
begin
  with TfrmSplash.Create(nil) do
  try
    FParam := AParam;
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmSplash.SetStatusText(Value: string);
begin
  LblStatus.Caption := Value;
  Update;  //这句非常重要，不加的话，界面会阻塞，文字也就不会更新显示
  Sleep(1000); //这句根据自己实际情况来调整，主要是怕闪屏太快关闭，达不到效果
end;

end.
