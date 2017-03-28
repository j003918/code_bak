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
  Update;  //���ǳ���Ҫ�����ӵĻ������������������Ҳ�Ͳ��������ʾ
  Sleep(1000); //�������Լ�ʵ���������������Ҫ��������̫��رգ��ﲻ��Ч��
end;

end.
