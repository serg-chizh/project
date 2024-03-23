unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Vcl.ComCtrls,
  Vcl.StdCtrls, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Imaging.GIFImg;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    Button1: TButton;
    function Moschost(z:byte; p:real; s:integer; v:real):real;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure UpdGrafik;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if timer1.Enabled=false then timer1.Enabled:=true
                          else timer1.Enabled:=false;
end;

function TForm1.Moschost(z:byte; p:real; s:integer; v:real): real;
  var t:real;
begin

case z of
{работа Савониуса 1-тип генератора
 с 1 метра начинает работать до 4 потом потолок до шести потом тормозной механизм останнавливается для пердотвращения разрушения}
  1: begin
       t:=0.15;
       if (v>=1)and (v<=4) then result:= 0.5*t*p*s*(v*v*v)
                          else if (v>4) and (v<=6) then
                                                     begin
                                                       v:=4;
                                                       result:= 0.5*t*p*s*(v*v*v);
                                                     end
                                                   else
                                                     begin
                                                       v:=0;
                                                       result:= 0.5*t*p*s*(v*v*v);
                                                     end;

     end;
{работа Дарье
 с 5 метров работает до 10 метров после тормозной механизм останнавливается для пердотвращения разрушения}
  2: begin
       t:=0.30;
       if (v>=5)and (v<=10) then result:= 0.5*t*p*s*(v*v*v)
                           else
                             begin
                               v:=0;
                               result:= 0.5*t*p*s*(v*v*v);
                             end;

     end;

{работа горизонтальный
 с 5 метров работает до 15 растет нормально потом тормозной механизм останнавливается для пердотвращения разрушения}
  3: begin
       t:=0.45;
       if (v>=5)and (v<=15) then result:= 0.5*t*p*s*(v*v*v)
                           else
                             begin
                               v:=0;
                               result:= 0.5*t*p*s*(v*v*v);
                             end;
     end;
end {case};

end {func};


procedure TForm1.Panel1Click(Sender: TObject);
begin
//(Image1.Picture.Graphic as TGIFImage).Animate := True;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
UpdGrafik;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
UpdGrafik;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
UpdGrafik;
end;

procedure TForm1.RadioButton4Click(Sender: TObject);
begin
UpdGrafik;
end;

procedure TForm1.UpdGrafik;
var i:byte;
begin
  for i:=0 to 2 do
    chart1.Series[i].Clear;
  TrackBar3.Position:=0;
  if radiobutton4.Checked then chart1.Legend.Visible:=true
                          else chart1.Legend.Visible:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if radiobutton1.Checked then chart1.Series[0].AddXY(TrackBar3.Position, Moschost(1, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));
if radiobutton2.Checked then chart1.Series[1].AddXY(TrackBar3.Position, Moschost(2, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));
if radiobutton3.Checked then chart1.Series[2].AddXY(TrackBar3.Position, Moschost(3, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));

if radiobutton4.Checked then
  begin
    chart1.Series[0].AddXY(TrackBar3.Position, Moschost(1, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));
    chart1.Series[1].AddXY(TrackBar3.Position, Moschost(2, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));
    chart1.Series[2].AddXY(TrackBar3.Position, Moschost(3, TrackBar2.Position/10, TrackBar1.Position, TrackBar3.Position));
  end;

 TrackBar3.Position:=TrackBar3.Position+1;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
label1.Caption:='Площадь: '+inttostr(TrackBar1.Position)+' кв.м';
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
var ff:TFormatSettings;
begin
ff.CurrencyDecimals:=1;
label2.Caption:='Плотность воздуха: '+floattostr(TrackBar2.Position/10)+' кг/куб.м';
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
label3.Caption:='Скорость ветра: '+inttostr(TrackBar3.Position)+' м/с';
end;

end.
