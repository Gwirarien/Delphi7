unit Laborator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    Procedure Timer1Timer(Sender:TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  t : integer;
  directie: boolean = true;

  //Parametri variabili x, y
  x0_1, y0_1, x0_2, y0_2, x0_3, y0_3,
  x1_1, y1_1, x1_2, x1_3, y1_3,
  x2_1, y2_1, x2_2, y2_2, x2_3, y2_3,
  xp1_1, yp1_1, xp1_2, yp1_2, xp1_3, yp1_3, xp1_4, yp1_4, xp1_5, yp1_5,
  xp2_1, yp2_1, xp2_2, yp2_2,
  xp3_1, yp3_1, xp3_2, yp3_2: integer;

  //Parametri brat robotic R1
  movArticulatieUnuR1 : integer = 0;
  movArticulatieDoiR1 : integer = 0;
  movArticulatieTreiR1 : integer = 0;
  movArticulatiePrehensorR1 : integer = 0;
  movArtivulatieClemePR1 : integer = 0;

const
  dmax = 30;
  
  r1 = 18;
  rp = 10;
  rd = 5;

implementation

{$R *.dfm}

    procedure TForm1.Timer1Timer(Sender:TObject);
      begin
        with Form1.Image1.Canvas do
          begin

            FillRect(ClientRect);

                  {Banda deimitare - decor}
                  Brush.Color := rgb(255, 255, 0);
                  Polygon([Point(980,600), Point(1000,600), Point(1420,180), Point(1400,180)]);
                  Polygon([Point(900,610), Point(880,620), Point(380,620), Point(400,610)]);


                  {Perete - decor}
                  Brush.Color := rgb(102, 178, 255);
                  Polygon([Point(0,180), Point(1280,180), Point(1280,0), Point(0,0)]);


                  {Depozit bidoane}
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(20,340), Point(200,340), Point(200,160), Point(20,160)]);
                  Brush.Color := rgb(204, 255, 255);
                  Polygon([Point(40,260), Point(180,260), Point(180,200), Point(40,200)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(20,160), Point(80,100), Point(260,100), Point(200,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(200,340), Point(200,160), Point(260,100), Point(260,280)]);

                  //Gaura iesire
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(210,280), Point(210,200), Point(250,160), Point(250,240)]);


                  {Conveior 1}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(210,280), Point(250,240), Point(440,240), Point(400,280)]);
                  Brush.Color := rgb(50, 50, 50);
                  roundrect(210, 280, 400, 290, 10, 10);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(210, 280, 220, 290);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(390, 280, 400, 290);
                  Brush.Color := rgb(255, 255, 255);


                  {Statie umplere}
                  //Suprafata frontala
                  Polygon([Point(400,340), Point(400,120), Point(650,120), Point(650,340)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(400,120), Point(460,60), Point(710,60), Point(650,120)]);

                  //Suprafata laterala
                  Polygon([Point(650,340), Point(650,120), Point(710,60), Point(710,280)]);

                  //Margini frontale
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(400,160), Point(400,120), Point(650,120), Point(650,160)]);
                  Polygon([Point(400,340), Point(400,260), Point(650,260), Point(650,340)]);
                  Brush.Color := rgb(255, 255, 153);
                  Polygon([Point(400,260), Point(400,230), Point(650,230), Point(650,260)]);
                  Brush.Color := rgb(204, 255, 255);
                  Polygon([Point(400,160), Point(400,230), Point(650,230), Point(650,160)]);

                  //Margini laterale
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(650,120), Point(710,60), Point(710,100), Point(650,160)]);
                  Polygon([Point(650,340), Point(650,300), Point(710,240), Point(710,280)]);
                  Brush.Color := rgb(255, 255, 102);
                  Polygon([Point(650,200), Point(650,220), Point(710,160), Point(710,140)]);
                  Brush.Color := rgb(255, 255, 255);

                  //Gaura iesire
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(655,220), Point(655,280), Point(705,240), Point(705,170)]);
                  Brush.Color := rgb(255, 255, 255);


                  {Robot umplere}
                  //Dozator 1
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(470,160), Point(470,180), Point(490,180), Point(490,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(490,180), Point(490,160), Point(495,160), Point(495,170)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(475,180), Point(475,190), Point(485,190), Point(485,180)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(478,190), Point(478,200), Point(482,200), Point(482,190)]);

                  //Dozator 2
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(510,160), Point(510,180), Point(530,180), Point(530,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(530,180), Point(530,160), Point(535,160), Point(535,170)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(515,180), Point(515,190), Point(525,190), Point(525,180)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(518,190), Point(518,200), Point(522,200), Point(522,190)]);

                  //Dozator 3
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(550,160), Point(550,180), Point(570,180), Point(570,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(570,180), Point(570,160), Point(575,160), Point(575,170)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(555,180), Point(555,190), Point(565,190), Point(565,180)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(558,190), Point(558,200), Point(562,200), Point(562,190)]);

                  //Dozator 4
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(590,160), Point(590,180), Point(610,180), Point(610,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(610,180), Point(610,160), Point(615,160), Point(615,170)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(595,180), Point(595,190), Point(605,190), Point(605,180)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(598,190), Point(598,200), Point(602,200), Point(602,190)]);


                  {Conveior 2}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(655,280), Point(695,240), Point(1000,240), Point(960,280)]);
                  Brush.Color := rgb(50, 50, 50);
                  roundrect(655, 280, 960, 290, 10, 10);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(655, 280, 665, 290);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(950, 280, 960, 290);
                  Brush.Color := rgb(255, 255, 255);


                  {Statie dopuri}
                  //Suprafata frontala
                  Brush.Color := rgb(204, 255, 255);
                  Polygon([Point(960,340), Point(960,120), Point(1100,120), Point(1100,340)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(960,120), Point(1020,60), Point(1160,60), Point(1100,120)]);
                  Brush.Color := rgb(255, 255, 255);

                  //Suprafata laterala
                  Brush.Color := rgb(204, 255, 255);
                  Polygon([Point(1100,340), Point(1100,120), Point(1160,60), Point(1160,280)]);

                  //Margini frontale
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(960,120), Point(960,150), Point(1100,150), Point(1100,120)]);
                  Polygon([Point(960,340), Point(960,240), Point(1100,240), Point(1100,340)]);
                  Brush.Color := rgb(255, 255, 255);

                  //Margini laterale
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(1100,150), Point(1100,120), Point(1160,60), Point(1160,90)]);
                  Polygon([Point(1100,340), Point(1100,240), Point(1160,180), Point(1160,280)]);
                  Brush.Color := rgb(255, 255, 255);

                  //Gaura iesire
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(980,330), Point(980,280), Point(1080,280), Point(1080,330)]);
                  Brush.Color := rgb(255, 255, 255);


                  {Robot inchidere dopuri}

                  //Brat 1
                  //Suprafete frontale
                  Brush.Color := rgb(94, 94, 94);
                  Polygon([Point(1050,160), Point(1050,150), Point(1060,150), Point(1060,160)]);

                  //Suprafete laterale
                  Polygon([Point(1060,160), Point(1060,150), Point(1065,150), Point(1065,155)]);

                  //Brat 2
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(1055,170), Point(1055,160), Point(1059,160), Point(1059,170)]);

                  //Prehensor
                  Polygon([Point(1054,170), Point(1050,178), Point(1050,185), Point(1054,185), Point(1054,180), Point(1057,178), Point(1060,180), Point(1060,185), Point(1064,185), Point(1064,178), Point(1060,170)]);


                  {Conveior 3}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(980,330), Point(1080,330), Point(880,520), Point(780,520)]);
                  Brush.Color := rgb(50, 50, 50);
                  Polygon([Point(1080,330), Point(1080,340), Point(880,530), Point(880,520)]);
                  Brush.Color := rgb(255, 255, 255);


                  {Statie impachetare}

                  //Ansamblu inferior
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(920,500), Point(920,550), Point(650,550), Point(650,500)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(920,500), Point(650,500), Point(670,480), Point(940,480)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(940,480), Point(920,500), Point(920,550), Point(940,530)]);

                  //Ansamblu superior
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(880,430), Point(880,500), Point(750,500), Point(750,430)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(880,430), Point(750,430), Point(770,410), Point(900,410)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(900,410), Point(880,430), Point(880,500), Point(900,480)]);


                  {Suport conveior 4}
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(430,495), Point(490,495), Point(490,550), Point(430,550)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(490,495), Point(490,550), Point(510,520), Point(510,475)]);


                  {Conveior 4}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(750,495), Point(750,475), Point(450,475), Point(430,495)]);
                  Brush.Color := rgb(50, 50, 50);
                  roundrect(750, 495, 430, 505, 10, 10);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(430, 505, 440, 495);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(740, 495, 750, 505);
                  Brush.Color := rgb(255, 255, 255);


                  {Modelare brat robotic R1}
                  //Baza
                  brush.color := rgb(87, 84, 84);
                  polygon([point(300, 500), point(340, 500), point(340, 540), point(300, 540)]);
                  polygon([point(300, 500), point(320, 480), point(360, 480), point(340, 500)]);
                  brush.color := rgb(70, 0 ,60);
                  polygon([point(340, 500), point(360, 480), point(360, 520), point(340, 540)]);

                  //Picior
                  brush.color := rgb(102, 51, 0);
                  ellipse(335, 435, 345, 445);
                  brush.color := rgb(204, 102, 0);
                  polygon([point(325, 495), point(335, 495), point(335, 450), point(325, 450)]);
                  brush.color := rgb(153, 76, 0);
                  polygon([point(335, 495) , point(340, 485), point(340, 440), point(335, 450)]);

                  //Prima articulatie
                  x0_1 := trunc(380);
                  y0_1 := trunc(400);

                  x0_2 := trunc(380);
                  y0_2 := trunc(410);

                  x0_3 := trunc(383);
                  y0_3 := trunc(397);

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(325, 450), point(x0_1, y0_1), point(x0_2, y0_2), point(335, 450)]);

                  //Suprafata superioara
                  brush.color := rgb(255, 153, 51);
                  polygon([ point(335, 440), point(x0_3, y0_3), point(x0_1, y0_1), point(325, 450)]);
                  ellipse(325, 445, 335, 455);

                  //A doua articulatie
                  x1_1 := trunc(420);
                  y1_1 := trunc(440);

                  x1_2 := trunc(415);

                  x1_3 := trunc(419);
                  y1_3 := trunc(437);

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(x0_1, y0_1), point(x1_1, y1_1), point(x1_2, y1_1), point(x0_2, y0_2)]);

                  //Suprafata superioara
                  brush.color := rgb(255, 153, 51);
                  polygon([point(x0_1, y0_1), point(x0_3, y0_3), point(x1_1, y1_1)]);
                  ellipse(x0_1 - 6, y0_1, x0_2 + 6, y0_2);

                  //A treia articulatie
                  x2_1 := trunc(440);
                  y2_1 := trunc(437);

                  x2_2 := trunc(440);
                  y2_2 := trunc(443);

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(x1_2, y1_1 - 3), point(x2_1, y2_1), point(x2_2, y2_2), point(x1_2, y1_1 + 3)]);
                  brush.color := rgb(255, 153, 51);
                  ellipse(x1_2, y1_1 - 5, x1_1, y1_1 + 5);

                  //Articulatie 1 prehensor
                  xp1_1 := trunc(x2_1 + 10);
                  yp1_1 := trunc(y1_1 + 10);

                  xp1_2 := trunc(x2_1 + 10);
                  yp1_2 := trunc(y1_1 + 7);

                  xp1_3 := trunc(x2_1 + 5);
                  yp1_3 := trunc(y1_1);

                  xp1_4 := trunc(x2_1 + 10);
                  yp1_4 := trunc(y1_1 - 7);

                  xp1_5 := trunc(x2_1 + 10);
                  yp1_5 := trunc(y1_1 - 10);

                  brush.color := rgb(204, 102, 0);
                  polygon([point(x2_1, y1_1 - 3), point(xp1_1, yp1_1), point(xp1_2, yp1_2), point(xp1_3, yp1_3), point(xp1_4, yp1_4), point(xp1_5, yp1_5), point(x2_1, y1_1 + 3)]);
                  brush.color := rgb(255, 153, 51);
                  ellipse(x2_1 - 4, y2_1, x2_2 + 4, y2_2);

                  //Articulatie 2/3 prehensor
                  xp2_1 := trunc(xp1_1 + 10);
                  yp2_1 := trunc(yp1_1);

                  xp2_2 := trunc(xp1_2 + 10);
                  yp2_2 := trunc(yp1_2);

                  xp3_1 := trunc(xp1_1 + 10);
                  yp3_1 := trunc(yp1_4);

                  xp3_2 := trunc(xp1_2 + 10);
                  yp3_2 := trunc(yp1_5);

                  //"Deget 1"
                  brush.color := rgb(204, 102, 0);
                  polygon([point(xp1_1, yp1_1), point(xp2_1, yp2_1), point(xp2_2, yp2_2), point(xp1_2, yp1_2)]);

                  //"Deget 2"
                  brush.color := rgb(204, 102, 0);
                  polygon([point(xp1_4, yp1_4), point(xp3_1, yp3_1), point(xp3_2, yp3_2), point(xp1_5, yp1_5)]);

                  brush.color:=clWhite;

                  Brush.Color := rgb(0, 51, 102);
          end;
      end;
end.

