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
  tBanda1, tBanda2, tBanda3, tBanda4, tBanda5 : integer;
  tCoborareUmplere, tAsteptareUmplere, tRidicareUmplere,
  tCoborareInchidere, tAsteptareInchidere, tRidicareInchidere, tMiscareInchidereStanga, tMiscareInchidereDreapta,
  tAsteptareAmbalare : integer;

  //Parametri variabili x, y brat robotic antropomorfic
  x0_1, y0_1, x0_2, y0_2, x0_3, y0_3,
  x1_1, y1_1, x1_2, x1_3, y1_3,
  x2_1, y2_1, x2_2, y2_2, x2_3, y2_3,
  xp1_1, yp1_1, xp1_2, yp1_2, xp1_3, yp1_3, xp1_4, yp1_4, xp1_5, yp1_5,
  xp2_1, yp2_1, xp2_2, yp2_2,
  xp3_1, yp3_1, xp3_2, yp3_2: integer;

  {Parametri animatie}
  i : integer;
  etapa : integer = 0;

  //Parametri roboti
  movBanda1 : integer = 0;
  movBanda2 : integer = 0;
  movBanda3 : integer = 0;
  movBanda4 : integer = 0;
  movBanda5 : integer = 0;
  movRobotUmplere : integer = 0;
  movRobotInchidereX : integer = 0;
  movRobotInchidereY : integer = 0;

  //Parametri brat robotic antropomorfic
  movArticulatieUnuR1 : integer = 0;
  movArticulatieDoiR1 : integer = 0;
  movArticulatieTreiR1 : integer = 0;
  movArticulatiePrehensorR1 : integer = 0;
  movArtivulatieClemePR1 : integer = 0;

  //Parametri sticle
  movSticleGoale : integer = 0;
  movSticlePline : integer = 0;
  movSticleDop : integer = 0;

  //Parametri cutie
  movCutieX : integer = 0;
  movCutieY : integer = 0;
  movCutieInchisaX : integer = 0;
  culoareScotchR : integer = 153;
  culoareScotchG : integer = 76;
  culoareScotchB : integer = 0;

  //Led-uri
  culoareLedDepozitR : integer = 255;
  culoareLedDepozitG : integer = 0;
  culoareLedDepozitB : integer = 0;
  culoareLedUmplereR : integer = 255;
  culoareLedUmplereG : integer = 0;
  culoareLedUmplereB : integer = 0;
  culoareLedDopuriR : integer = 255;
  culoareLedDopuriG : integer = 0;
  culoareLedDopuriB : integer = 0;
  culoareLedAmbalareR : integer = 255;
  culoareLedAmbalareG : integer = 0;
  culoareLedAmbalareB : integer = 0;
  movStatusUmplereX : integer = 0;
  movStatusAmbalareY : integer = 0;

const
  r1 = 18;
  rp = 10;
  rd = 5;
  offsetSticleGoaleX = 180;
  offsetSticlePlineX = 210;
  offsetSticleDopX = 65;
  offsetSticleDopY = 65;
  offsetCutieX = 0;

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
                  Polygon([Point(240,540), Point(260,530), Point(80,530), Point(60,540)]);


                  {Perete - decor}
                  Brush.Color := rgb(102, 178, 255);
                  Polygon([Point(0,180), Point(1280,180), Point(1280,0), Point(0,0)]);


                  {Nume - Prenume - Grupa}
                  TextOut(30, 50, 'Serban Bogdan-Ionut - Grupa 4463');


                  {Depozit bidoane}
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(20,340), Point(200,340), Point(200,160), Point(20,160)]);
                  Polygon([Point(20,260), Point(40,260), Point(40,160), Point(20,160)]);
                  Brush.Color := rgb(204, 255, 255);
                  Polygon([Point(40,260), Point(180,260), Point(180,200), Point(40,200)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(20,160), Point(80,100), Point(260,100), Point(200,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(200,340), Point(200,160), Point(260,100), Point(260,280)]);
                  Polygon([Point(250,110), Point(260,100), Point(260,280), Point(250,290)]);

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


                  {Animatie - conveior 1}
                  for i := 0 to 10 do
                    begin
                        begin
                          moveto(250 + i * 30 + movBanda1, 240);
                          lineto(210 + i * 30 + movBanda1, 280);
                        if movBanda1 = 30 then
                          movBanda1 := 0;
                        end;
                  end;


                  {Sticle goale}
                  //Sticla 1
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(307 - offsetSticleGoaleX + movSticleGoale, 218, 314 - offsetSticleGoaleX + movSticleGoale, 222);
                  ellipse(300 - offsetSticleGoaleX + movSticleGoale, 256, 320 - offsetSticleGoaleX + movSticleGoale, 264);
                  Polygon([Point(307 - offsetSticleGoaleX + movSticleGoale,220), Point(313 - offsetSticleGoaleX + movSticleGoale,220), Point(313 - offsetSticleGoaleX + movSticleGoale,225), Point(307 - offsetSticleGoaleX + movSticleGoale,225)]);
                  Polygon([Point(307 - offsetSticleGoaleX + movSticleGoale,225), Point(313 - offsetSticleGoaleX + movSticleGoale,225), Point(320 - offsetSticleGoaleX + movSticleGoale,230), Point(300 - offsetSticleGoaleX + movSticleGoale,230)]);
                  Polygon([Point(300 - offsetSticleGoaleX + movSticleGoale,230), Point(320 - offsetSticleGoaleX + movSticleGoale,230), Point(320 - offsetSticleGoaleX + movSticleGoale,260), Point(300 - offsetSticleGoaleX + movSticleGoale,260)]);

                  //Sticla 2
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(332 - offsetSticleGoaleX + movSticleGoale, 218, 339 - offsetSticleGoaleX + movSticleGoale, 222);
                  ellipse(325 - offsetSticleGoaleX + movSticleGoale, 256, 345 - offsetSticleGoaleX + movSticleGoale, 264);
                  Polygon([Point(332 - offsetSticleGoaleX + movSticleGoale,220), Point(338 - offsetSticleGoaleX + movSticleGoale,220), Point(338 - offsetSticleGoaleX + movSticleGoale,225), Point(332 - offsetSticleGoaleX + movSticleGoale,225)]);
                  Polygon([Point(332 - offsetSticleGoaleX + movSticleGoale,225), Point(338 - offsetSticleGoaleX + movSticleGoale,225), Point(345 - offsetSticleGoaleX + movSticleGoale,230), Point(325 - offsetSticleGoaleX + movSticleGoale,230)]);
                  Polygon([Point(325 - offsetSticleGoaleX + movSticleGoale,230), Point(345 - offsetSticleGoaleX + movSticleGoale,230), Point(345 - offsetSticleGoaleX + movSticleGoale,260), Point(325 - offsetSticleGoaleX + movSticleGoale,260)]);

                  //Sticla 3
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(357 - offsetSticleGoaleX + movSticleGoale, 218, 364 - offsetSticleGoaleX + movSticleGoale, 222);
                  ellipse(350 - offsetSticleGoaleX + movSticleGoale, 256, 370 - offsetSticleGoaleX + movSticleGoale, 264);
                  Polygon([Point(357 - offsetSticleGoaleX + movSticleGoale,220), Point(363 - offsetSticleGoaleX + movSticleGoale,220), Point(363 - offsetSticleGoaleX + movSticleGoale,225), Point(357 - offsetSticleGoaleX + movSticleGoale,225)]);
                  Polygon([Point(357 - offsetSticleGoaleX + movSticleGoale,225), Point(363 - offsetSticleGoaleX + movSticleGoale,225), Point(370 - offsetSticleGoaleX + movSticleGoale,230), Point(350 - offsetSticleGoaleX + movSticleGoale,230)]);
                  Polygon([Point(350 - offsetSticleGoaleX + movSticleGoale,230), Point(370 - offsetSticleGoaleX + movSticleGoale,230), Point(370 - offsetSticleGoaleX + movSticleGoale,260), Point(350 - offsetSticleGoaleX + movSticleGoale,260)]);

                  //Sticla 4
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(382 - offsetSticleGoaleX + movSticleGoale, 218, 389 - offsetSticleGoaleX + movSticleGoale, 222);
                  ellipse(375 - offsetSticleGoaleX + movSticleGoale, 256, 395 - offsetSticleGoaleX + movSticleGoale, 264);
                  Polygon([Point(382 - offsetSticleGoaleX + movSticleGoale,220), Point(388 - offsetSticleGoaleX + movSticleGoale,220), Point(388 - offsetSticleGoaleX + movSticleGoale,225), Point(382 - offsetSticleGoaleX + movSticleGoale,225)]);
                  Polygon([Point(382 - offsetSticleGoaleX + movSticleGoale,225), Point(388 - offsetSticleGoaleX + movSticleGoale,225), Point(395 - offsetSticleGoaleX + movSticleGoale,230), Point(375 - offsetSticleGoaleX + movSticleGoale,230)]);
                  Polygon([Point(375 - offsetSticleGoaleX + movSticleGoale,230), Point(395 - offsetSticleGoaleX + movSticleGoale,230), Point(395 - offsetSticleGoaleX + movSticleGoale,260), Point(375 - offsetSticleGoaleX + movSticleGoale,260)]);


                  {Sticle depozit - fara animatie}
                  //Sticla 1
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(47, 218, 54, 222);
                  Polygon([Point(47,220), Point(53,220), Point(53,225), Point(47,225)]);
                  Polygon([Point(47,225), Point(53,225), Point(60,230), Point(40,230)]);
                  Polygon([Point(40,230), Point(60,230), Point(60,260), Point(40,260)]);

                  //Sticla 2
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(67, 218, 74, 222);
                  Polygon([Point(67,220), Point(73,220), Point(73,225), Point(67,225)]);
                  Polygon([Point(67,225), Point(73,225), Point(80,230), Point(60,230)]);
                  Polygon([Point(60,230), Point(80,230), Point(80,260), Point(60,260)]);

                  //Sticla 3
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(87, 218, 94, 222);
                  Polygon([Point(87,220), Point(93,220), Point(93,225), Point(87,225)]);
                  Polygon([Point(87,225), Point(93,225), Point(100,230), Point(80,230)]);
                  Polygon([Point(80,230), Point(100,230), Point(100,260), Point(80,260)]);

                  //Sticla 4
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(107, 218, 114, 222);
                  Polygon([Point(107,220), Point(113,220), Point(113,225), Point(107,225)]);
                  Polygon([Point(107,225), Point(113,225), Point(120,230), Point(100,230)]);
                  Polygon([Point(100,230), Point(120,230), Point(120,260), Point(100,260)]);

                  //Sticla 5
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(127, 218, 134, 222);
                  Polygon([Point(127,220), Point(133,220), Point(133,225), Point(127,225)]);
                  Polygon([Point(127,225), Point(133,225), Point(140,230), Point(120,230)]);
                  Polygon([Point(120,230), Point(140,230), Point(140,260), Point(120,260)]);

                  //Sticla 6
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(147, 218, 154, 222);
                  Polygon([Point(147,220), Point(153,220), Point(153,225), Point(147,225)]);
                  Polygon([Point(147,225), Point(153,225), Point(160,230), Point(140,230)]);
                  Polygon([Point(140,230), Point(160,230), Point(160,260), Point(140,260)]);

                  //Sticla 7
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(167, 218, 174, 222);
                  Polygon([Point(167,220), Point(173,220), Point(173,225), Point(167,225)]);
                  Polygon([Point(167,225), Point(173,225), Point(180,230), Point(160,230)]);
                  Polygon([Point(160,230), Point(180,230), Point(180,260), Point(160,260)]);

                  //Margini acoperire
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(20,340), Point(200,340), Point(200,260), Point(20,260)]);
                  Polygon([Point(180,260), Point(200,260), Point(200,160), Point(180,160)]);
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(200,340), Point(200,160), Point(210,150), Point(210,330)]);

                  //Panou comanda
                  //Cadru
                  Brush.Color := rgb(0, 204, 204);
                  RoundRect(30, 270, 190, 330, 10, 10);
                  //Afisaj
                  Brush.Color := rgb(255, 255, 255);
                  Polygon([Point(50,275), Point(80,275), Point(80,320), Point(50,320)]);
                  //LCD
                  Brush.Color := rgb(0, 25, 51);
                  Polygon([Point(52,280), Point(78,280), Point(78,310), Point(52,310)]);
                  //Butoane
                  Brush.Color := rgb(153, 153, 0);
                  ellipse(90, 280, 100, 290);
                  ellipse(110, 280, 120, 290);
                  ellipse(130, 280, 140, 290);
                  ellipse(150, 280, 160, 290);
                  //Led functionare
                  Brush.Color := rgb(culoareLedDepozitR, culoareLedDepozitG, culoareLedDepozitB);
                  ellipse(165, 305, 180, 320);

                  {Statie umplere}
                  //Suprafata frontala
                  Polygon([Point(400,340), Point(400,120), Point(650,120), Point(650,340)]);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(400,120), Point(460,60), Point(710,60), Point(650,120)]);

                  //Suprafata laterala
                  Polygon([Point(650,340), Point(650,120), Point(710,60), Point(710,280)]);

                  //Margini frontale
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
                  Polygon([Point(470,160), Point(470,180 + movRobotUmplere), Point(490,180 + movRobotUmplere), Point(490,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(490,180 + movRobotUmplere), Point(490,160), Point(495,160), Point(495,170 + movRobotUmplere)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(475,180 + movRobotUmplere), Point(475,190 + movRobotUmplere), Point(485,190 + movRobotUmplere), Point(485,180 + movRobotUmplere)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(478,190 + movRobotUmplere), Point(478,200 + movRobotUmplere), Point(482,200 + movRobotUmplere), Point(482,190 + movRobotUmplere)]);

                  //Dozator 2
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(510,160), Point(510,180 + movRobotUmplere), Point(530,180 + movRobotUmplere), Point(530,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(530,180 + movRobotUmplere), Point(530,160), Point(535,160), Point(535,170 + movRobotUmplere)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(515,180 + movRobotUmplere), Point(515,190 + movRobotUmplere), Point(525,190 + movRobotUmplere), Point(525,180 + movRobotUmplere)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(518,190 + movRobotUmplere), Point(518,200 + movRobotUmplere), Point(522,200 + movRobotUmplere), Point(522,190 + movRobotUmplere)]);

                  //Dozator 3
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(550,160), Point(550,180 + movRobotUmplere), Point(570,180 + movRobotUmplere), Point(570,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(570,180 + movRobotUmplere), Point(570,160), Point(575,160), Point(575,170 + movRobotUmplere)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(555,180 + movRobotUmplere), Point(555,190 + movRobotUmplere), Point(565,190 + movRobotUmplere), Point(565,180 + movRobotUmplere)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(558,190 + movRobotUmplere), Point(558,200 + movRobotUmplere), Point(562,200 + movRobotUmplere), Point(562,190 + movRobotUmplere)]);

                  //Dozator 4
                  //Brat

                  //Suprafata frontala
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(590,160), Point(590,180 + movRobotUmplere), Point(610,180 + movRobotUmplere), Point(610,160)]);

                  //Suprafata laterala
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(610,180 + movRobotUmplere), Point(610,160), Point(615,160), Point(615,170 + movRobotUmplere)]);

                  //Dozator
                  Brush.Color := rgb(255, 178, 102);
                  Polygon([Point(595,180 + movRobotUmplere), Point(595,190 + movRobotUmplere), Point(605,190 + movRobotUmplere), Point(605,180 + movRobotUmplere)]);
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(598,190 + movRobotUmplere), Point(598,200 + movRobotUmplere), Point(602,200 + movRobotUmplere), Point(602,190 + movRobotUmplere)]);


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

                  {Animatie - conveior 2}
                  for i := 0 to 10 do
                    begin
                        begin
                          moveto(695 + i * 30 + movBanda2, 240);
                          lineto(655 + i * 30 + movBanda2, 280);
                        if movBanda2 = 30 then
                          movBanda2 := 0;
                        end;
                  end;


                  {Sticle umplute}
                  //Sticla 1
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(687 - offsetSticlePlineX + movSticlePline, 228, 695 - offsetSticlePlineX + movSticlePline, 232);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(680 - offsetSticlePlineX + movSticlePline, 266, 700 - offsetSticlePlineX + movSticlePline, 274);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(687 - offsetSticlePlineX + movSticlePline,230), Point(694 - offsetSticlePlineX + movSticlePline,230), Point(694 - offsetSticlePlineX + movSticlePline,235), Point(687 - offsetSticlePlineX + movSticlePline,235)]);
                  Polygon([Point(687 - offsetSticlePlineX + movSticlePline,235), Point(694 - offsetSticlePlineX + movSticlePline,235), Point(700 - offsetSticlePlineX + movSticlePline,240), Point(680 - offsetSticlePlineX + movSticlePline,240)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(680 - offsetSticlePlineX + movSticlePline,240), Point(700 - offsetSticlePlineX + movSticlePline,240), Point(700 - offsetSticlePlineX + movSticlePline,270), Point(680 - offsetSticlePlineX + movSticlePline,270)]);

                  //Sticla 2
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(727 - offsetSticlePlineX + movSticlePline, 228, 735 - offsetSticlePlineX + movSticlePline, 232);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(720 - offsetSticlePlineX + movSticlePline, 266, 740 - offsetSticlePlineX + movSticlePline, 274);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(727 - offsetSticlePlineX + movSticlePline,230), Point(734 - offsetSticlePlineX + movSticlePline,230), Point(734 - offsetSticlePlineX + movSticlePline,235), Point(727 - offsetSticlePlineX + movSticlePline,235)]);
                  Polygon([Point(727 - offsetSticlePlineX + movSticlePline,235), Point(734 - offsetSticlePlineX + movSticlePline,235), Point(740 - offsetSticlePlineX + movSticlePline,240), Point(720 - offsetSticlePlineX + movSticlePline,240)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(720 - offsetSticlePlineX + movSticlePline,240), Point(740 - offsetSticlePlineX + movSticlePline,240), Point(740 - offsetSticlePlineX + movSticlePline,270), Point(720 - offsetSticlePlineX + movSticlePline,270)]);

                  //Sticla 3
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(767 - offsetSticlePlineX + movSticlePline, 228, 775 - offsetSticlePlineX + movSticlePline, 232);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(760 - offsetSticlePlineX + movSticlePline, 266, 780 - offsetSticlePlineX + movSticlePline, 274);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(767 - offsetSticlePlineX + movSticlePline,230), Point(774 - offsetSticlePlineX + movSticlePline,230), Point(774 - offsetSticlePlineX + movSticlePline,235), Point(767 - offsetSticlePlineX + movSticlePline,235)]);
                  Polygon([Point(767 - offsetSticlePlineX + movSticlePline,235), Point(774 - offsetSticlePlineX + movSticlePline,235), Point(780 - offsetSticlePlineX + movSticlePline,240), Point(760 - offsetSticlePlineX + movSticlePline,240)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(760 - offsetSticlePlineX + movSticlePline,240), Point(780 - offsetSticlePlineX + movSticlePline,240), Point(780 - offsetSticlePlineX + movSticlePline,270), Point(760 - offsetSticlePlineX + movSticlePline,270)]);

                  //Sticla 4
                  Brush.Color := rgb(204, 255, 229);
                  ellipse(807 - offsetSticlePlineX + movSticlePline, 228, 815 - offsetSticlePlineX + movSticlePline, 232);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(800 - offsetSticlePlineX + movSticlePline, 266, 820 - offsetSticlePlineX + movSticlePline, 274);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(807 - offsetSticlePlineX + movSticlePline,230), Point(814 - offsetSticlePlineX + movSticlePline,230), Point(814 - offsetSticlePlineX + movSticlePline,235), Point(807 - offsetSticlePlineX + movSticlePline,235)]);
                  Polygon([Point(807 - offsetSticlePlineX + movSticlePline,235), Point(814 - offsetSticlePlineX + movSticlePline,235), Point(820 - offsetSticlePlineX + movSticlePline,240), Point(800 - offsetSticlePlineX + movSticlePline,240)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(800 - offsetSticlePlineX + movSticlePline,240), Point(820 - offsetSticlePlineX + movSticlePline,240), Point(820 - offsetSticlePlineX + movSticlePline,270), Point(800 - offsetSticlePlineX + movSticlePline,270)]);

                  //Margini acoperire
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(650,300), Point(650,220), Point(655,215), Point(655,295)]);
                  Brush.Color := rgb(255, 255, 153);
                  Polygon([Point(400,260), Point(400,225), Point(650,225), Point(650,260)]);
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(400,160), Point(400,120), Point(650,120), Point(650,160)]);
                  Polygon([Point(400,340), Point(400,260), Point(650,260), Point(650,340)]);

                  //Panou comanda
                  //Cadru
                  Brush.Color := rgb(65, 123, 132);
                  RoundRect(410, 270, 450, 330, 10, 10);
                  RoundRect(500, 280, 600, 320, 10, 10);
                  //Afisaj
                  Brush.Color := rgb(255, 255, 255);
                  Polygon([Point(510,310), Point(510,290), Point(590,290), Point(590,310)]);
                  //Status bar
                  Brush.Color := rgb(0, 0, 204);
                  Polygon([Point(510,310), Point(510,290), Point(510 + movStatusUmplereX,290), Point(510 + movStatusUmplereX,310)]);
                  //Butoane
                  Brush.Color := rgb(51, 255, 153);
                  ellipse(425, 280, 435, 290);
                  Brush.Color := rgb(255, 0, 0);
                  ellipse(425, 310, 435, 320);
                  //Led functionare
                  Brush.Color := rgb(culoareLedUmplereR, culoareLedUmplereG, culoareLedUmplereB);
                  ellipse(625, 325, 610, 310);


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
                  Brush.Color := rgb(255, 255, 255);

                  //Gaura iesire
                  Brush.Color := rgb(63, 54, 74);
                  Polygon([Point(980,330), Point(980,280), Point(1080,280), Point(1080,330)]);
                  Brush.Color := rgb(255, 255, 255);


                  {Robot inchidere dopuri}
                  //Brat 1
                  //Suprafete frontale
                  Brush.Color := rgb(94, 94, 94);
                  Polygon([Point(1050 + movRobotInchidereX,160), Point(1050 + movRobotInchidereX,150), Point(1060 + movRobotInchidereX,150), Point(1060 + movRobotInchidereX,160)]);

                  //Suprafete laterale
                  Polygon([Point(1060 + movRobotInchidereX,160), Point(1060 + movRobotInchidereX,150), Point(1065 + movRobotInchidereX,150), Point(1065 + movRobotInchidereX,155)]);

                  //Brat 2
                  Brush.Color := rgb(0, 0, 0);
                  Polygon([Point(1055 + movRobotInchidereX,170 + movRobotInchidereY), Point(1055 + movRobotInchidereX,160), Point(1059 + movRobotInchidereX,160), Point(1059 + movRobotInchidereX,170 + movRobotInchidereY)]);

                  //Prehensor
                  Polygon([Point(1054 + movRobotInchidereX,170 + movRobotInchidereY), Point(1050 + movRobotInchidereX,178 + movRobotInchidereY), Point(1050 + movRobotInchidereX,185 + movRobotInchidereY), Point(1054 + movRobotInchidereX,185 + movRobotInchidereY), Point(1054 + movRobotInchidereX,180 + movRobotInchidereY), Point(1057 + movRobotInchidereX,178 + movRobotInchidereY), Point(1060 + movRobotInchidereX,180 + movRobotInchidereY), Point(1060 + movRobotInchidereX,185 + movRobotInchidereY), Point(1064 + movRobotInchidereX,185 + movRobotInchidereY), Point(1064 + movRobotInchidereX,178 + movRobotInchidereY), Point(1060 + movRobotInchidereX,170 + movRobotInchidereY)]);

                  {Conveior 3}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(980,330), Point(1080,330), Point(880,520), Point(780,520)]);
                  Brush.Color := rgb(50, 50, 50);
                  Polygon([Point(1080,330), Point(1080,340), Point(880,530), Point(880,520)]);
                  Brush.Color := rgb(255, 255, 255);

                  {Animatie - conveior 3}
                  for i := 0 to 6 do
                    begin
                        begin
                          moveto(980 - i * 32 - movBanda3, 330 + i * 30 + movBanda3);
                          lineto(1080 - i * 32 - movBanda3, 330 + i * 30 + movBanda3);
                        if movBanda3 = 30 then
                          movBanda3 := 0;
                        end;
                  end;

                  {Sticle cu dop}
                  //Sticla 4
                  Brush.Color := rgb(255, 51, 51);
                  ellipse(1062 + offsetSticleDopX - movSticleDop, 252 - offsetSticleDopY + movSticleDop, 1069 + offsetSticleDopX - movSticleDop, 257 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(1055 + offsetSticleDopX - movSticleDop, 291 - offsetSticleDopY + movSticleDop, 1075 + offsetSticleDopX - movSticleDop, 299 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(1062 + offsetSticleDopX - movSticleDop,255 - offsetSticleDopY + movSticleDop), Point(1068 + offsetSticleDopX - movSticleDop,255 - offsetSticleDopY + movSticleDop), Point(1068 + offsetSticleDopX - movSticleDop,260 - offsetSticleDopY + movSticleDop), Point(1062 + offsetSticleDopX - movSticleDop,260 - offsetSticleDopY + movSticleDop)]);
                  Polygon([Point(1062 + offsetSticleDopX - movSticleDop,260 - offsetSticleDopY + movSticleDop), Point(1068 + offsetSticleDopX - movSticleDop,260 - offsetSticleDopY + movSticleDop), Point(1075 + offsetSticleDopX - movSticleDop,265 - offsetSticleDopY + movSticleDop), Point(1055 + offsetSticleDopX - movSticleDop,265 - offsetSticleDopY + movSticleDop)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(1055 + offsetSticleDopX - movSticleDop,265 - offsetSticleDopY + movSticleDop), Point(1075 + offsetSticleDopX - movSticleDop,265 - offsetSticleDopY + movSticleDop), Point(1075 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop), Point(1055 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop)]);


                  //Sticla 3
                  Brush.Color := rgb(255, 51, 51);
                  ellipse(1047 + offsetSticleDopX - movSticleDop, 267 - offsetSticleDopY + movSticleDop, 1054 + offsetSticleDopX - movSticleDop, 272 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(1040 + offsetSticleDopX - movSticleDop, 306 - offsetSticleDopY + movSticleDop, 1060 + offsetSticleDopX - movSticleDop, 314 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(1047 + offsetSticleDopX - movSticleDop,270 - offsetSticleDopY + movSticleDop), Point(1053 + offsetSticleDopX - movSticleDop,270 - offsetSticleDopY + movSticleDop), Point(1053 + offsetSticleDopX - movSticleDop,275 - offsetSticleDopY + movSticleDop), Point(1047 + offsetSticleDopX - movSticleDop,275 - offsetSticleDopY + movSticleDop)]);
                  Polygon([Point(1047 + offsetSticleDopX - movSticleDop,275 - offsetSticleDopY + movSticleDop), Point(1053 + offsetSticleDopX - movSticleDop,275 - offsetSticleDopY + movSticleDop), Point(1060 + offsetSticleDopX - movSticleDop,280 - offsetSticleDopY + movSticleDop), Point(1040 + offsetSticleDopX - movSticleDop,280 - offsetSticleDopY + movSticleDop)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(1040 + offsetSticleDopX - movSticleDop,280 - offsetSticleDopY + movSticleDop), Point(1060 + offsetSticleDopX - movSticleDop,280 - offsetSticleDopY + movSticleDop), Point(1060 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop), Point(1040 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop)]);

                  //Sticla 2
                  Brush.Color := rgb(255, 51, 51);
                  ellipse(1032 + offsetSticleDopX - movSticleDop, 282 - offsetSticleDopY + movSticleDop, 1039 + offsetSticleDopX - movSticleDop, 287 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(1025 + offsetSticleDopX - movSticleDop, 321 - offsetSticleDopY + movSticleDop, 1045 + offsetSticleDopX - movSticleDop, 329 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(1032 + offsetSticleDopX - movSticleDop,285 - offsetSticleDopY + movSticleDop), Point(1038 + offsetSticleDopX - movSticleDop,285 - offsetSticleDopY + movSticleDop), Point(1038 + offsetSticleDopX - movSticleDop,290 - offsetSticleDopY + movSticleDop), Point(1032 + offsetSticleDopX - movSticleDop,290 - offsetSticleDopY + movSticleDop)]);
                  Polygon([Point(1032 + offsetSticleDopX - movSticleDop,290 - offsetSticleDopY + movSticleDop), Point(1038 + offsetSticleDopX - movSticleDop,290 - offsetSticleDopY + movSticleDop), Point(1045 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop), Point(1025 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(1025 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop), Point(1045 + offsetSticleDopX - movSticleDop,295 - offsetSticleDopY + movSticleDop), Point(1045 + offsetSticleDopX - movSticleDop,325 - offsetSticleDopY + movSticleDop), Point(1025 + offsetSticleDopX - movSticleDop,325 - offsetSticleDopY + movSticleDop)]);

                  //Sticla 1
                  Brush.Color := rgb(255, 51, 51);
                  ellipse(1017 + offsetSticleDopX - movSticleDop, 297 - offsetSticleDopY + movSticleDop, 1024 + offsetSticleDopX - movSticleDop, 302 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(51, 153, 255);
                  ellipse(1010 + offsetSticleDopX - movSticleDop, 336 - offsetSticleDopY + movSticleDop, 1030 + offsetSticleDopX - movSticleDop, 344 - offsetSticleDopY + movSticleDop);
                  Brush.Color := rgb(204, 255, 229);
                  Polygon([Point(1017 + offsetSticleDopX - movSticleDop,300 - offsetSticleDopY + movSticleDop), Point(1023 + offsetSticleDopX - movSticleDop,300 - offsetSticleDopY + movSticleDop), Point(1023 + offsetSticleDopX - movSticleDop,305 - offsetSticleDopY + movSticleDop), Point(1017 + offsetSticleDopX - movSticleDop,305 - offsetSticleDopY + movSticleDop)]);
                  Polygon([Point(1017 + offsetSticleDopX - movSticleDop,305 - offsetSticleDopY + movSticleDop), Point(1023 + offsetSticleDopX - movSticleDop,305 - offsetSticleDopY + movSticleDop), Point(1030 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop), Point(1010 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop)]);
                  Brush.Color := rgb(51, 153, 255);
                  Polygon([Point(1010 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop), Point(1030 + offsetSticleDopX - movSticleDop,310 - offsetSticleDopY + movSticleDop), Point(1030 + offsetSticleDopX - movSticleDop,340 - offsetSticleDopY + movSticleDop), Point(1010 + offsetSticleDopX - movSticleDop,340 - offsetSticleDopY + movSticleDop)]);

                  
                  //Margine frontala
                  Brush.Color := rgb(255, 255, 153);
                  Polygon([Point(960,240), Point(960,220), Point(1100,220), Point(1100,240)]);

                  //Margine laterala
                  Brush.Color := rgb(255, 255, 153);
                  Polygon([Point(1100,215), Point(1100,240), Point(1160,180), Point(1160,155)]);

                  //Margini acoperire
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(960,280), Point(960,240), Point(1100,240), Point(1100,280)]);
                  Polygon([Point(1080,280), Point(1080,340), Point(1100,340), Point(1100,280)]);
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(1100,340), Point(1100,240), Point(1160,180), Point(1160,280)]);

                  //Led functionare
                  Brush.Color := rgb(culoareLedDopuriR, culoareLedDopuriG, culoareLedDopuriB);
                  ellipse(1020, 255, 1040, 275);

                  {Statie etichetare}

                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(240,355), Point(320,355), Point(320,490), Point(240,490)]);

                  //Rola etichetare
                  Brush.Color := rgb(20, 20, 20);
                  Ellipse(240, 365, 280, 405);

                  //Suprafata superioara
                  Brush.Color := rgb(128, 128, 128);
                  Polygon([Point(220,375), Point(300,375), Point(320,355), Point(240,355)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(300,375), Point(300,400), Point(320,380), Point(320,355)]);


                  {Suport conveior 5}
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(495,455), Point(385,455), Point(385,490), Point(495,490)]);
                  Polygon([Point(150,455), Point(0,455), Point(0,490), Point(150,490)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(495,455), Point(495,490), Point(515,470), Point(515,435)]);
                  Polygon([Point(150,455), Point(150,490), Point(170,470), Point(170,435)]);


                  {Conveior 5}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(495,455), Point(515,435), Point(0,435), Point(0,455)]);
                  Brush.Color := rgb(50, 50, 50);
                  roundrect(495, 455, -3, 465, 10, 10);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(495, 455, 485, 465);
                  Brush.Color := rgb(255, 255, 255);

                  {Animatie - conveior 5}
                  for i := 0 to 20 do
                    begin
                        begin
                          moveto(495 - i * 30 - movBanda5, 455);
                          lineto(515 - i * 30 - movBanda5, 435);
                        if movBanda5 = 30 then
                          movBanda5 := 0;
                        end;
                  end;


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


                  {Suport conveior 4}
                  //Suprafata frontala
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(430,495), Point(490,495), Point(490,550), Point(430,550)]);

                  //Suprafata laterala
                  Brush.Color := rgb(160, 160, 160);
                  Polygon([Point(490,495), Point(490,550), Point(510,520), Point(510,475)]);


                  {Conveior 4}
                  Brush.Color := rgb(96, 96, 96);
                  Polygon([Point(750,495), Point(770,475), Point(450,475), Point(430,495)]);
                  Brush.Color := rgb(50, 50, 50);
                  roundrect(750, 495, 430, 505, 10, 10);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(430, 505, 440, 495);
                  Brush.Color := rgb(0, 0, 0);
                  ellipse(740, 495, 750, 505);
                  Brush.Color := rgb(255, 255, 255);

                  {Animatie - conveior 4}
                  for i := 0 to 8 do
                    begin
                        begin
                          moveto(730 - i * 30 - movBanda4, 495);
                          lineto(750 - i * 30 - movBanda4, 475);
                        if movBanda4 = 30 then
                          movBanda4 := 0;
                        end;
                  end;

                  //"Deget 2"
                  brush.color := rgb(204, 102, 0);
                  polygon([point(xp1_4, yp1_4), point(xp3_1, yp3_1), point(xp3_2, yp3_2), point(xp1_5, yp1_5)]);

                  {Cutie cu bidoane}
                  Brush.Color := rgb(153, 76, 0);
                  Polygon([Point(750 - movCutieX - movCutieInchisaX,493 - movCutieY), Point(750 - movCutieX - movCutieInchisaX,450 - movCutieY), Point(780 - movCutieX - movCutieInchisaX,450 - movCutieY), Point(780 - movCutieX - movCutieInchisaX,493 - movCutieY)]);
                  Brush.Color := rgb(102, 51, 0);
                  Polygon([Point(780 - movCutieX - movCutieInchisaX,450 - movCutieY), Point(780 - movCutieX - movCutieInchisaX,493 - movCutieY), Point(790 - movCutieX - movCutieInchisaX,483 - movCutieY), Point(790 - movCutieX - movCutieInchisaX,443 - movCutieY)]);
                  Brush.Color := rgb(culoareScotchR,culoareScotchG,culoareScotchB);
                  Polygon([Point(750 - movCutieX - movCutieInchisaX,450 - movCutieY), Point(780 - movCutieX - movCutieInchisaX,450 - movCutieY), Point(790 - movCutieX - movCutieInchisaX,443 - movCutieY), Point(760 - movCutieX - movCutieInchisaX,443 - movCutieY)]);
                  moveto(755 - movCutieX - movCutieInchisaX, 446 - movCutieY);
                  lineto(785 - movCutieX - movCutieInchisaX, 446 - movCutieY);

                  //Margini acoperire
                  Brush.Color := rgb(224, 224, 224);
                  Polygon([Point(300,375), Point(220,375), Point(220,400), Point(300,400)]);

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

                  //Panou comanda
                  //Cadru
                  Brush.Color := rgb(204, 204, 255);
                  RoundRect(760, 440, 870, 490, 10, 10);
                  //Afisaj
                  Brush.Color := rgb(255, 255, 255);
                  Polygon([Point(765,445), Point(790,445), Point(790,485), Point(765,485)]);
                  //Status bar
                  Brush.Color := rgb(0, 25, 51);
                  Polygon([Point(765,485 - movStatusAmbalareY), Point(790,485 - movStatusAmbalareY), Point(790,485), Point(765,485)]);
                  //Butoane
                  Brush.Color := rgb(153, 153, 0);
                  ellipse(800, 450, 810, 460);
                  ellipse(820, 450, 830, 460);
                  ellipse(840, 450, 850, 460);
                  //Led functionare
                  Brush.Color := rgb(culoareLedAmbalareR, culoareLedAmbalareG, culoareLedAmbalareB);
                  ellipse(895, 525, 910, 540);

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
                  x0_1 := trunc(380 + r1*sin(movArticulatieUnuR1/50));
                  y0_1 := trunc(400 + r1*sin(movArticulatieUnuR1/50));

                  x0_2 := trunc(380 + r1*sin(movArticulatieUnuR1/50));
                  y0_2 := trunc(410 + (r1 - 4)*sin(movArticulatieUnuR1/50));

                  x0_3 := trunc(383 + r1*sin(movArticulatieUnuR1/50));
                  y0_3 := trunc(397 + (r1 - 2)*sin(movArticulatieUnuR1/50));

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(325, 450), point(x0_1, y0_1), point(x0_2, y0_2), point(335, 450)]);

                  //Suprafata superioara
                  brush.color := rgb(255, 153, 51);
                  polygon([ point(335, 440), point(x0_3, y0_3), point(x0_1, y0_1), point(325, 450)]);
                  ellipse(325, 445, 335, 455);

                  //A doua articulatie
                  x1_1 := trunc(420 + r1*cos(movArticulatieDoiR1/50));
                  y1_1 := trunc(440 + (r1 + 20)*sin(movArticulatieDoiR1/50));

                  x1_2 := trunc(415 + r1*cos(movArticulatieDoiR1/50));

                  x1_3 := trunc(419 + r1*cos(movArticulatieDoiR1/50));
                  y1_3 := trunc(437 + (r1 + 20)*sin(movArticulatieDoiR1/50));

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(x0_1, y0_1), point(x1_1, y1_1), point(x1_2, y1_1), point(x0_2, y0_2)]);

                  //Suprafata superioara
                  brush.color := rgb(255, 153, 51);
                  polygon([point(x0_1, y0_1), point(x0_3, y0_3), point(x1_1, y1_1)]);
                  ellipse(x0_1 - 6, y0_1, x0_2 + 6, y0_2);

                  //A treia articulatie
                  x2_1 := trunc(440 + r1*cos(movArticulatieTreiR1/50));
                  y2_1 := trunc(437 + (r1 + 20)*sin(movArticulatieTreiR1/50));

                  x2_2 := trunc(440 + r1*cos(movArticulatieTreiR1/50));
                  y2_2 := trunc(443 + (r1 + 20)*sin(movArticulatieTreiR1/50));

                  //Suprafata frontala
                  brush.color := rgb(204, 102, 0);
                  polygon([point(x1_2, y1_1 - 3), point(x2_1, y2_1), point(x2_2, y2_2), point(x1_2, y1_1 + 3)]);
                  brush.color := rgb(255, 153, 51);
                  ellipse(x1_2, y1_1 - 5, x1_1, y1_1 + 5);

                  //Articulatie 1 prehensor
                  xp1_1 := trunc(x2_1 + 10 + rp*cos(movArticulatiePrehensorR1/80));
                  yp1_1 := trunc(y1_1 + 10 + rp*sin(movArticulatiePrehensorR1/80));

                  xp1_2 := trunc(x2_1 + 10 + rp*cos(movArticulatiePrehensorR1/80));
                  yp1_2 := trunc(y1_1 + 7 + rp*sin(movArticulatiePrehensorR1/80));

                  xp1_3 := trunc(x2_1 + 5 + rp*cos(movArticulatiePrehensorR1/80));
                  yp1_3 := trunc(y1_1 + rp*sin(movArticulatiePrehensorR1/80));

                  xp1_4 := trunc(x2_1 + 10 + rp*cos(movArticulatiePrehensorR1/80));
                  yp1_4 := trunc(y1_1 - 7 + rp*sin(movArticulatiePrehensorR1/80));

                  xp1_5 := trunc(x2_1 + 10 + rp*cos(movArticulatiePrehensorR1/80));
                  yp1_5 := trunc(y1_1 - 10 + rp*sin(movArticulatiePrehensorR1/80));

                  brush.color := rgb(204, 102, 0);
                  polygon([point(x2_1, y1_1 - 3), point(xp1_1, yp1_1), point(xp1_2, yp1_2), point(xp1_3, yp1_3), point(xp1_4, yp1_4), point(xp1_5, yp1_5), point(x2_1, y1_1 + 3)]);
                  brush.color := rgb(255, 153, 51);
                  ellipse(x2_1 - 4, y2_1, x2_2 + 4, y2_2);

                  //Articulatie 2/3 prehensor
                  xp2_1 := trunc(xp1_1 + 10 + rd*cos(movArtivulatieClemePR1/50));
                  yp2_1 := trunc(yp1_1 - rd*sin(movArtivulatieClemePR1/50));

                  xp2_2 := trunc(xp1_2 + 10 + rd*cos(movArtivulatieClemePR1/50));
                  yp2_2 := trunc(yp1_2 - rd*sin(movArtivulatieClemePR1/50));

                  xp3_1 := trunc(xp1_1 + 10 + rd*cos(movArtivulatieClemePR1/50));
                  yp3_1 := trunc(yp1_4 + rd*sin(movArtivulatieClemePR1/50));

                  xp3_2 := trunc(xp1_2 + 10 + rd*cos(movArtivulatieClemePR1/50));
                  yp3_2 := trunc(yp1_5 + rd*sin(movArtivulatieClemePR1/50));

                  //"Deget 1"
                  brush.color := rgb(204, 102, 0);
                  polygon([point(xp1_1, yp1_1), point(xp2_1, yp2_1), point(xp2_2, yp2_2), point(xp1_2, yp1_2)]);


                  {Podea - Decor}
                  Brush.Color := rgb(0, 51, 102);


                  {Animatie - roboti}
                  case etapa of

                    //Miscare banda 1
                    0:begin
                      movBanda1 := movBanda1 + 1;
                      movSticleGoale := movSticleGoale + 1;
                      tBanda1 := tBanda1 + 1;
                      culoareLedDepozitR := 0;
                      culoareLedDepozitG := 255;
                      culoareLedDepozitB := 0;
                      if tBanda1 = 300 then
                        etapa := 1;
                    end;

                    //Coborarare robot umplere
                    1:begin
                      movRobotUmplere := movRobotUmplere + 1;
                      tCoborareUmplere := tCoborareUmplere + 1;
                      culoareLedDepozitR := 255;
                      culoareLedDepozitG := 0;
                      culoareLedDepozitB := 0;
                      culoareLedUmplereR := 0;
                      culoareLedUmplereG := 255;
                      culoareLedUmplereB := 0;
                      if tCoborareUmplere = 30 then
                        etapa := 2;
                    end;

                    //Asteptare umplere
                    2:begin
                      tAsteptareUmplere := tAsteptareUmplere + 1;
                      if tAsteptareUmplere < 81 then
                        movStatusUmplereX :=  movStatusUmplereX + 1;
                      if tAsteptareUmplere = 100 then
                        etapa := 3;
                    end;

                    //Ridicare robot umplere
                    3:begin
                      movRobotUmplere := movRobotUmplere - 1;
                      tRidicareUmplere := tRidicareUmplere + 1;
                      if tRidicareUmplere < 41 then
                        movStatusUmplereX :=  movStatusUmplereX - 1;
                      if tRidicareUmplere = 45 then
                        etapa := 4;
                    end;

                    //Miscare banda 2
                    4:begin
                      movBanda2 := movBanda2 + 1;
                      movSticlePline := movSticlePline + 1;
                      tBanda2 := tBanda2 + 1;
                      culoareLedUmplereR := 255;
                      culoareLedUmplereG := 0;
                      culoareLedUmplereB := 0;
                      if tBanda2 < 41 then
                        movStatusUmplereX :=  movStatusUmplereX - 1;
                      if tBanda2 = 500 then
                          etapa := 5;
                    end;

                    //Coborare robot inchidere dopuri
                    5:begin
                      movRobotInchidereY := movRobotInchidereY + 1;
                      tCoborareInchidere := tCoborareInchidere + 1;
                      culoareLedDopuriR := 0;
                      culoareLedDopuriG := 255;
                      culoareLedDopuriB := 0;
                      if tCoborareInchidere = 40 then
                          etapa := 6;
                    end;

                    //Infiletare dopuri
                    //Miscare spre stanga
                    6:begin
                      movRobotInchidereX := movRobotInchidereX - 1;
                      tMiscareInchidereStanga := tMiscareInchidereStanga + 1;
                      if tMiscareInchidereStanga = 40 then
                          etapa := 7;
                    end;

                    //Revenire pozitie X initiala
                    7:begin
                      movRobotInchidereX := movRobotInchidereX + 1;
                      tMiscareInchidereDreapta := tMiscareInchidereDreapta + 1;
                      if tMiscareInchidereDreapta = 40 then
                          etapa := 8;
                    end;

                    //Ridicare robot inchidere dopuri
                    8:begin
                      movRobotInchidereY := movRobotInchidereY - 1;
                      tRidicareInchidere := tRidicareInchidere + 1;
                      if tRidicareInchidere = 40 then
                          etapa := 9;
                    end;

                    //Miscare banda 3
                    9:begin
                      movBanda3 := movBanda3 + 1;
                      movSticleDop := movSticleDop + 1;
                      tBanda3 := tBanda3 + 1;
                      culoareLedDopuriR := 255;
                      culoareLedDopuriG := 0;
                      culoareLedDopuriB := 0;
                      if tBanda3 = 250 then
                        etapa := 10;
                    end;

                    //Ambalare - asteptare
                   10:begin
                      tAsteptareAmbalare := tAsteptareAmbalare + 1;
                      culoareLedAmbalareR := 0;
                      culoareLedAmbalareG := 255;
                      culoareLedAmbalareB := 0;
                      if tAsteptareAmbalare < 41 then
                        movStatusAmbalareY := movStatusAmbalareY + 1;
                      if tAsteptareAmbalare = 100 then
                        etapa := 11;
                    end;

                    //Miscare banda 4
                    11:begin
                      movBanda4 := movBanda4 + 1;
                      movCutieX := movCutieX + 1;
                      tBanda4 := tBanda4 + 1;
                      culoareLedAmbalareR := 255;
                      culoareLedAmbalareG := 0;
                      culoareLedAmbalareB := 0;
                      if tBanda4 < 41 then
                        movStatusAmbalareY := movStatusAmbalareY - 1;;
                      if tBanda4 = 278 then
                        etapa := 12;
                    end;

                    //Deschidere prehensor
                    12:begin
                      movArtivulatieClemePR1 := movArtivulatieClemePR1 - 1;
                      if (movArtivulatieClemePR1 < -50) then
                        etapa := 13;
                    end;

                    //Coborare brat robotc
                    13:begin
                      movArticulatieUnuR1 := movArticulatieUnuR1 + 1;
                      movArticulatieDoiR1 := movArticulatieDoiR1 + 1;
                      movArticulatieTreiR1 := movArticulatieTreiR1 + 1;
                      movArticulatiePrehensorR1 := movArticulatiePrehensorR1 + 1;
                      if (movArticulatieTreiR1 > 50) then
                        etapa := 14;
                    end;

                    //Ridicare brat robotic
                    14:begin
                      movArticulatieUnuR1 := movArticulatieUnuR1 - 1;
                      movArticulatieDoiR1 := movArticulatieDoiR1 - 1;
                      movArticulatieTreiR1 := movArticulatieTreiR1 - 1;
                      movArticulatiePrehensorR1 := movArticulatiePrehensorR1 - 1;
                      if (movArticulatieTreiR1 < 46) then
                        movCutieY := movCutieY + 1;
                      if (movArticulatieTreiR1 = 0) then
                        etapa := 15;
                    end;

                    //Inchidere prehensor
                    15:begin
                      movArtivulatieClemePR1 := movArtivulatieClemePR1 + 1;

                      polygon([point(xp1_4, yp1_4), point(xp3_1, yp3_1), point(xp3_2, yp3_2), point(xp1_5, yp1_5)]);
                      if (movArtivulatieClemePR1 > 0) then
                        etapa := 16;
                    end;

                    //Miscare banda 5 + revenire etapa 0
                    16:begin
                      movCutieInchisaX := movCutieInchisaX + 1;
                      tBanda5 := tBanda5 + 1;
                      movBanda5 := movBanda5 + 1;

                      if tBanda5 = 220 then
                      begin
                        culoareScotchR := 80;
                        culoareScotchG := 50;
                        culoareScotchB := 21;
                      end;
                      if tBanda5 = 500 then
                        etapa := 17;

                    end;

                    17:begin
                      tBanda1 := 0;
                      tBanda2 := 0;
                      tBanda3 := 0;
                      tBanda4 := 0;
                      tBanda5 := 0;
                      tCoborareUmplere := 0;
                      tAsteptareUmplere := 0;
                      tRidicareUmplere := 0;
                      tCoborareInchidere := 0;
                      tAsteptareInchidere := 0;
                      tRidicareInchidere := 0;
                      tMiscareInchidereStanga := 0;
                      tMiscareInchidereDreapta  := 0;
                      tAsteptareAmbalare := 0;
                      movBanda1 := 0;
                      movBanda2 := 0;
                      movBanda3 := 0;
                      movBanda4 := 0;
                      movBanda5 := 0;
                      movRobotUmplere := 0;
                      movRobotInchidereX := 0;
                      movRobotInchidereY := 0;
                      movArticulatieUnuR1 := 0;
                      movArticulatieDoiR1 := 0;
                      movArticulatieTreiR1 := 0;
                      movArticulatiePrehensorR1 := 0;
                      movArtivulatieClemePR1 := 0;
                      movSticleGoale := 0;
                      movSticlePline := 0;
                      movSticleDop := 0;
                      movCutieX := 0;
                      movCutieY := 0;
                      movCutieInchisaX := 0;
                      culoareScotchR := 153;
                      culoareScotchG := 76;
                      culoareScotchB := 0;
                      movStatusAmbalareY := 0;
                      etapa := 0;
                    end;

                  end;

          end;
      end;
end.

