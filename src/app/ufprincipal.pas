unit ufprincipal;

{$mode objfpc}{$H+}

interface

uses
  Forms, Dialogs, Controls, ucjuego, Classes,
  Graphics, ExtCtrls, Grids, Menus, sysutils;

type

  { TFPrincipal }

  TFPrincipal = class(TForm)
    imageList: TImageList;
    mNuevo: TMenuItem;
    mSalir: TMenuItem;
    mJuego: TMenuItem;
    mMenu: TMainMenu;
    mPrincipal: TMenuItem;
    Panel1: TPanel;
    sgTablero: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure mNuevoClick(Sender: TObject);
    procedure mSalirClick(Sender: TObject);
    procedure sgTableroDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure sgTableroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { private declarations }
    juego: CJuego;
  public
    { public declarations }
    procedure nuevoJuego;
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.lfm}

{ TFPrincipal }

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
   DoubleBuffered:= True;
   juego:= CJuego.create();
end;

procedure TFPrincipal.mNuevoClick(Sender: TObject);
begin
  nuevoJuego;
end;

procedure TFPrincipal.mSalirClick(Sender: TObject);
begin
  FPrincipal.Close;
end;

procedure TFPrincipal.sgTableroDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  sgTablero.Canvas.Brush.Color := clBackground;
  sgTablero.Canvas.FillRect(aRect);
  if (sgTablero.Cells[aCol, aRow]<> '') then begin
    imageList.Draw(sgTablero.Canvas,aRect.Left,aRect.Top,
                   StrToInt(sgTablero.Cells[aCol, aRow]), True);
    if (gdFocused in aState) then
    begin
      sgTablero.Canvas.DrawFocusRect(aRect);
    end;
  end;
end;

procedure TFPrincipal.sgTableroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (juego.mover(Key)) then begin
     juego.pintar(sgTablero);
  end else begin
     if (juego.isFinish) then begin
       ShowMessage('Juego Terminado');
       juego.pintar(sgTablero);
     end;
  end;
end;

procedure TFPrincipal.nuevoJuego;
var row,col: Word;  error:String;
begin
  error:= 'El valor intoducido no es el correcto' + #13;
  error:= error + 'se asignara un numero por defeecto';

  try
    row := StrToInt(InputBox('Nro Filas','Insertar # de Filas','6'));
  except
    on EConvertError do begin
      row := 8;
      ShowMessage(error);
    end;
  end;

  try
   col := StrToInt(InputBox('Nro Columnas','Insertar # de Columnas','6'));
  except
    on EConvertError do begin
      col:= 8;
      ShowMessage(error);
    end;
  end;

 juego.init(row, col, sgTablero);
 juego.pintar(sgTablero);
end;

end.

