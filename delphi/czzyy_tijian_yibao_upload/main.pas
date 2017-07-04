unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComObj, Grids, ComCtrls,
    XLSComment5,
  XLSDrawing5, Xc12Utils5, Xc12Manager5,
  XLSReadWriteII5, XLSSheetData5;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    ProgressBar1: TProgressBar;
    btnUpload: TButton;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    XLS: TXLSReadWriteII5;
    Button2: TButton;
    procedure btnUploadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function buildCMD(p1,p7 :string;p2:string='0010';p3:string='7122';p6:string='0000';p4:string='';p8:string='1'):string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  g_count :integer;
  g_List_err: TStringList;
  g_List_data: TStringList;

  function INIT(para_out:pchar):integer;stdcall;external 'SiInterface.dll';
  function BUSINESS_HANDLE(para_in,para_out:pchar):integer;stdcall;external 'SiInterface.dll';

implementation

{$R *.dfm}

function TForm1.buildCMD(p1,p7 :string;p2:string='0010';p3:string='7122';p6:string='0000';p4:string='';p8:string='1'):string;
var
  p5 : string;
begin
  inc(g_count);
  p5 := formatdatetime('yyyymmddhhmmss',now)+ '-' + p2 + '-' + Format('%.4d',[g_count]);
  result := p1 + '^' + p2 + '^' +p3 + '^' +p4 + '^' + p5 + '^' + p6 + '^' + p7 + '^' + p8 + '^';
end;

function UpLoadData(p: Pointer): Integer; stdcall;
var
  ret,i : integer;
  str_in : string;
  str_out : array[0..2048] of Char;
begin
  g_list_data.Clear;
  for i := 0 to g_list_err.Count-1 do
  begin
      g_list_data.Add(g_list_err[i]);
  end;
  g_list_err.Clear;

  form1.ProgressBar1.Min := 0;
  form1.ProgressBar1.Max := g_list_data.Count;

  result := 0;
  for i := 0 to g_list_data.Count-1 do
  begin
    form1.ProgressBar1.Position := i+1;
    form1.StatusBar1.Panels[1].Text := '正在上传'+inttostr(i+1)+'/'+inttostr(g_list_data.Count)+'......';
    str_in := TForm1(p).buildCMD('6002',g_list_data[i]);
    ret :=  BUSINESS_HANDLE(pchar(str_in),str_out) ;

    if ret <> 0 then
    begin
      g_list_err.Add(g_list_data[i]);
      form1.memo1.Lines.Add(g_list_data[i])  ;
    end;
  end;

  form1.StatusBar1.Panels[1].Text := '上传结束！共'+inttostr(g_list_data.Count)+'条,失败'+inttostr(g_list_err.Count)+'条';

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  str_out : array[0..2048] of Char;
  str_in : string;
begin

  g_List_err := TStringList.Create;
  g_List_data := TStringList.Create;

  memo1.Clear;

  g_count := 0;
  ProgressBar1.Parent := StatusBar1;
  ProgressBar1.Left := StatusBar1.Width-ProgressBar1.Width;
  ProgressBar1.Top := 4;

  StatusBar1.Panels[0].Width := StatusBar1.Width-ProgressBar1.Width-180;
  StatusBar1.Panels[1].Width := 180;

  INIT(str_out);
  str_in := buildCMD('9100','');
  BUSINESS_HANDLE(pchar(str_in),str_out) ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  str_out : array[0..2048] of Char;
  str_in : string;
begin
  str_in := buildCMD('9110','');
  BUSINESS_HANDLE(pchar(str_in),str_out) ;
end;

procedure TForm1.btnUploadClick(Sender: TObject);
var
  ID: THandle;
begin
  progressbar1.Min := 0;
  progressbar1.Max := 100;
  progressbar1.Position := -1;
  memo1.Clear ;
  memo1.Lines.Add('上传失败数据');
  CreateThread(nil, 0, @UpLoadData, TForm1, 0, ID);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Row,Col,gridCol,i : Integer;
  str_data,str_tmp : string;
begin

if OpenDialog1.Execute then
  begin
    StatusBar1.Panels[0].Text := OpenDialog1.FileName ;
    XLS.Filename := OpenDialog1.FileName;
  end
  else
    exit;

  g_list_err.Clear;
  g_list_data.Clear;

  XLS.Read;
  stringgrid1.RowCount := xls.Sheets[0].LastRow+1;
  stringgrid1.ColCount := 16;

  form1.StatusBar1.Panels[1].Text := '正在加载......';

  str_tmp := '';
  str_data := '';

  for Row := 0 to xls.Sheets[0].LastRow do begin
    for Col := 0 to xls.Sheets[0].LastCol+1 do begin
        if Row = 0  then
          stringGrid1.Cells[0,Row] := '医院编号'
       else
          stringGrid1.Cells[0,Row] :=  '0010';

          case col of
            4  : gridCol := 1;
            13 : gridCol := 2;
            1  : gridCol := 3;
            14 : gridCol := 4;
            15 : gridCol := 5;
            19 : gridCol := 6;
            20 : gridCol := 7;
            21 : gridCol := 8;
            22 : gridCol := 9;
            23 : gridCol := 10;
            24 : gridCol := 11;
            25 : gridCol := 12;
            26 : gridCol := 13;
            18 : gridCol := 14;
            27 : gridCol := 15;
            else gridCol := -1;
          end;
          if gridCol >0 then stringgrid1.Cells[gridCol,row] := xls.Sheets[0].AsString[col-1,row];
      end;
      if (Row mod 100) = 0 then Application.ProcessMessages;
      if row >0 then
      begin
        str_data := '';
        for i := 0 to 15 do begin
           str_data := str_data + form1.stringGrid1.Cells[i,row] + '|';
        end;
        g_List_err.Add(str_data);
      end;
    end;
    form1.StatusBar1.Panels[1].Text := '加载完成';
end;

end.
