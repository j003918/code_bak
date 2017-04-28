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
    Button1: TButton;
    procedure btnUploadClick(Sender: TObject);
    //procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure XLSReadCell(ACell: TXLSEventCell);
  private
    { Private declarations }

    function loadDateToList() : Integer;
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

function TForm1.loadDateToList() : Integer;
var
  row,col : Integer;
  str_data : string;
begin
  result := 1;
  str_data := '';

  g_list_err.Clear;
  for Row := 1 to stringGrid1.RowCount-1 do begin
    for Col := 0 to stringGrid1.ColCount-1 do begin
        str_data := str_data + stringGrid1.Cells[col,row] + '|';
    end;
    g_list_data.Add(str_data);
    str_data := '';
  end;
end;

function UpLoadData(p: Pointer): Integer; stdcall;
var
  ret,i : integer;
  str_in : string;
  str_out : array[0..2048] of Char;
begin

  g_list_err.Clear;
  g_list_data.Clear;
  form1.loadDateToList();

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
  //ret : integer;
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
  //ret :=
  BUSINESS_HANDLE(pchar(str_in),str_out) ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  str_out : array[0..2048] of Char;
  str_in : string;
  //ret : integer;
begin
  str_in := buildCMD('9110','');
  //ret :=
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    StatusBar1.Panels[0].Text := OpenDialog1.FileName ;
    XLS.Filename := OpenDialog1.FileName;
  end
  else
    exit;
  XLS.DirectRead := True;
  stringgrid1.RowCount := 0;
  stringgrid1.ColCount := 15;
  XLS.Read;
end;

procedure TForm1.XLSReadCell(ACell: TXLSEventCell);
begin
  if (acell.Row mod 100) = 0 then begin
    Application.ProcessMessages;
  end;

  form1.StatusBar1.Panels[1].Text := 'load '+intToStr(acell.Row) + ',' + intToStr(acell.Col);

  stringgrid1.RowCount := acell.Row+1;

  case acell.Col of
    0:
      begin
        if acell.Row = 0  then
          stringGrid1.Cells[0,acell.Row] := '医院编号'
       else
          stringGrid1.Cells[0,acell.Row] :=  '0010';
      end;
    4:
      begin
        stringGrid1.Cells[1,acell.Row] :=  acell.AsString;
      end;
    13:
      begin
        stringGrid1.Cells[2,acell.Row] :=  acell.AsString;
      end;
    1:
      begin
        stringGrid1.Cells[3,acell.Row] :=  acell.AsString;
      end;
    15:
      begin
        stringGrid1.Cells[4,acell.Row] :=  acell.AsString;
      end;
    19:
      begin
        stringGrid1.Cells[5,acell.Row] :=  acell.AsString;
      end;
    20:
      begin
        stringGrid1.Cells[6,acell.Row] :=  acell.AsString;
      end;
    21:
      begin
        stringGrid1.Cells[7,acell.Row] :=  acell.AsString;
      end;
    22:
      begin
        stringGrid1.Cells[8,acell.Row] :=  acell.AsString;
      end;
    23:
      begin
        stringGrid1.Cells[9,acell.Row] :=  acell.AsString;
      end;
    24:
      begin
        stringGrid1.Cells[10,acell.Row] :=  acell.AsString;
      end;
    25:
      begin
        stringGrid1.Cells[11,acell.Row] :=  acell.AsString;
      end;
    26:
      begin
        stringGrid1.Cells[12,acell.Row] :=  acell.AsString;
      end;
    18:
      begin
        stringGrid1.Cells[13,acell.Row] :=  acell.AsString;
      end;
    17:
      begin
        stringGrid1.Cells[14,acell.Row] :=  acell.AsString;
      end;
    else
      begin   end;
  end;
end;

end.
