unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComObj, Grids, ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    ProgressBar1: TProgressBar;
    btnLoad: TButton;
    btnUpload: TButton;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    procedure btnUploadClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  g_list_data.Text := g_list_err.Text;
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

function LoadData(p: Pointer): Integer; stdcall;
var
  ExcelApp :Variant;
  i,j :integer;
  lastrow,lastcol : integer;
  str_tmp,str_data : string;
begin
  result := -1;

  g_List_data.Clear;
  g_list_err.Clear;

  if form1.OpenDialog1.Execute then
    form1.StatusBar1.Panels[0].Text := form1.OpenDialog1.FileName
  else
    exit;

  ExcelApp := CreateOleObject('Excel.Application');
  ExcelApp.WorkBooks.Open(form1.OpenDialog1.FileName);
  ExcelApp.WorkSheets[1].Activate;

  LastRow := ExcelApp.ActiveSheet.UsedRange.Rows.Count;
  LastCol := ExcelApp.ActiveSheet.UsedRange.Columns.Count;

  if LastCol < 16 then
  begin
    form1.StatusBar1.Panels[1].Text := '文件格式错误';
    exit;
  end;

  form1.progressbar1.Min := 1;
  form1.progressbar1.Max := LastRow;

  form1.stringgrid1.RowCount := LastRow;
  //form1.stringgrid1.ColCount := LastCol;
  form1.stringgrid1.ColCount := 16;

  form1.StatusBar1.Panels[1].Text := '数据加载中......';

  //4	13	1	14	15	19	20	21	22	23	24	25	26	15
  for i:=1 to lastrow do
    begin
       str_data := '';
       str_tmp := ExcelApp.Cells[i,1].value;
       if length(trim(str_tmp)) = 0 then continue;

       if i = 1 then
          form1.stringGrid1.Cells[0,i-1] := '医院编号'
       else
          form1.stringGrid1.Cells[0,i-1] :=  '0010';//ExcelApp.Cells[i,0].value;
       form1.stringGrid1.Cells[1,i-1] :=  ExcelApp.Cells[i,4].value;
       form1.stringGrid1.Cells[2,i-1] :=  ExcelApp.Cells[i,13].value;
       form1.stringGrid1.Cells[3,i-1] :=  ExcelApp.Cells[i,1].value;
       form1.stringGrid1.Cells[4,i-1] :=  ExcelApp.Cells[i,14].value;
       form1.stringGrid1.Cells[5,i-1] :=  ExcelApp.Cells[i,15].value;
       form1.stringGrid1.Cells[6,i-1] :=  ExcelApp.Cells[i,19].value;
       form1.stringGrid1.Cells[7,i-1] :=  ExcelApp.Cells[i,20].value;
       form1.stringGrid1.Cells[8,i-1] :=  ExcelApp.Cells[i,21].value;
       form1.stringGrid1.Cells[9,i-1] :=  ExcelApp.Cells[i,22].value;
       form1.stringGrid1.Cells[10,i-1] :=  ExcelApp.Cells[i,23].value;
       form1.stringGrid1.Cells[11,i-1] :=  ExcelApp.Cells[i,24].value;
       form1.stringGrid1.Cells[12,i-1] :=  ExcelApp.Cells[i,25].value;
       form1.stringGrid1.Cells[13,i-1] :=  ExcelApp.Cells[i,26].value;
       form1.stringGrid1.Cells[14,i-1] :=  ExcelApp.Cells[i,18].value;
       form1.stringGrid1.Cells[15,i-1] :=  ExcelApp.Cells[i,27].value;

       form1.progressbar1.Position := i;

       for j:=0 to 15 do
        begin
          str_tmp := form1.stringGrid1.Cells[j,i-1];
          str_data := str_data + trim(str_tmp) + '|';
        end;
        
        if i > 1 then g_list_err.Add(str_data);

      end;

  form1.StatusBar1.Panels[1].Text := '数据加载完成';

  ExcelApp.WorkBooks.Close;
  ExcelApp.Quit;
  ExcelApp := Unassigned;
  Result := 0;
end;


procedure TForm1.btnLoadClick(Sender: TObject);
var 
  ID: THandle;
begin
  CreateThread(nil, 0, @LoadData, nil, 0, ID);
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

end.
