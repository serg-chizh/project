unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeeProcs, TeEngine, Chart, ExtCtrls, StdCtrls, ComCtrls, Series;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Chart1: TChart;
    Button1: TButton;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    RadioButton4: TRadioButton;
    Label4: TLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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

procedure TForm1.Button1Click(Sender: TObject);
begin
  if timer1.Enabled=false then timer1.Enabled:=true
                          else timer1.Enabled:=false;
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

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
label1.Caption:='Площадь: '+inttostr(TrackBar1.Position)+' кв.м';
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
var ff:TFormatSettings;
begin
ff.CurrencyDecimals:=1;
label2.Caption:='Плотность воздуха: '+floattostr(TrackBar2.Position/10)+' куб.м';
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
label3.Caption:='Скорость ветра: '+inttostr(TrackBar3.Position)+' м/с';
end;

end.
