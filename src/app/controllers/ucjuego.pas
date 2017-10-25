{
	@author(Juan Vladimir Ramirez Flores <juanvladimir13@gmail.com>)  

	https://www.youtube.com/channel/UCk9R_mLgbcENR_BPF9M9asQ?view_as=subscriber
	https://www.facebook.com/juanvladimir13 
	https://twitter.com/juanvladimir13 
	https://www.instagram.com/juanvladimir13 
	https://www.linkedin.com/in/juanvladimir13

	https://github.com/juanvladimir13/
	https://bitbucket.org/juanvladimir13 

	http://juanvladimir13.wordpress.com
	http://juanvladimir13.blogspot.com/

	Periscope @juanvladimir13
	Telegram @juanvladimir13
}
unit ucjuego;

{$mode objfpc}{$H+}

interface

uses
    Graphics, umatriz, utablero,ujugador, sysutils, Controls, Grids, uutils, Dialogs;
type

  { CJuego }

  CJuego = class
    tablero: TTablero;
    jugador: TJugador;
    isFinish : Boolean;
    name : String;
    private

    public
      constructor create();
      procedure init(nroFilas:Word; nroColumna:Word; sgTablero: TStringGrid);
      procedure pintar(sgTablero: TStringGrid);
      function mover(Key:Word):Boolean;
      function isCompleted:Boolean;
      function getTablero():TTablero;

  end;

implementation

{ CJuego }

constructor CJuego.create;
begin
  Self.tablero:= TTablero.create();
  Self.jugador:= TJugador.create();
  Self.isFinish:= False;
  Self.name:= 'Juego Controllers';
end;

procedure CJuego.init(nroFilas: Word; nroColumna: Word; sgTablero: TStringGrid);
begin
  Self.isFinish:= False;
  tablero.init(nroFilas,nroColumna);
  tablero.construirMuros();
  tablero.addJugador(jugador);
  tablero.setJugador();
  tablero.addGhost();

  sgTablero.RowCount:= nroFilas;
  sgTablero.ColCount:= nroColumna;
end;

procedure CJuego.pintar(sgTablero: TStringGrid);
var row,col:Word; matriz:TMatriz;
begin
  matriz:= tablero.getMatriz();
  for row := 0 to matriz.getNroFilas()-1 do begin
    for col := 0 to matriz.getNroColumnas()-1 do begin
       sgTablero.Cells[col,row] := IntToStr(matriz.getValue(row,col));
    end;
  end;
end;

function CJuego.mover(Key:Word):Boolean;
var state:Boolean;
begin
  state:= False;
  if ( not jugador.removed ) then begin
    case Key of
      37: state:= jugador.moverIzquierda();
      38: state:= jugador.moverArriba();
      39: state:= jugador.moverDerecha();
      40: state:= jugador.moverAbajo();
    end;
  end else begin
    isFinish:= True;
  end;
  Result:= state;
end;

function CJuego.isCompleted: Boolean;
begin
end;

function CJuego.getTablero: TTablero;
begin
  Result:= Self.tablero;
end;

end.

