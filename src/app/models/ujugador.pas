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
unit ujugador;

{$mode objfpc}{$H+}

interface

uses umatriz, uutils, Dialogs, sysutils;

type

  { TJugador }

  TJugador = class (TObject)
    posRow : Word;
    posCol : Word;
    removed : Boolean;
    name: String;
    private
      matriz:TMatriz;
    public
      constructor create();
      function getPosRow():Word;
      function getPosCol():Word;

      procedure setMatriz(matrizTablero:TMatriz);
      procedure setPoints(posFila:Word; posColumna:Word);

      function isValid(posFila:Word; posColumna:Word):Boolean;
      function moverIzquierda():Boolean;
      function moverDerecha():Boolean;
      function moverAbajo():Boolean;
      function moverArriba():Boolean;

  end;

implementation

{ TJugador }

constructor TJugador.create;
begin
  Self.posRow := 0;
  Self.posCol := 0;
  Self.removed:= False;
  Self.name:= 'Jugador';
end;

function TJugador.getPosRow: Word;
begin
  Result:= Self.posRow;
end;

function TJugador.getPosCol: Word;
begin
  Result:= Self.posCol;
end;

procedure TJugador.setMatriz(matrizTablero: TMatriz);
begin
  Self.matriz := matrizTablero;
end;

procedure TJugador.setPoints(posFila: Word; posColumna: Word);
begin
  Self.posRow := posFila;
  Self.posCol := posColumna;
end;

function TJugador.isValid(posFila:Word; posColumna:Word): Boolean;
var value:Word;
begin
  value:= matriz.getValue(posFila, posColumna);
  if (value = GHOST) then
    removed:= True;
  Result := (value = PASILLO) or (value = POINTS);
end;

function TJugador.moverIzquierda(): Boolean;
var state: Boolean;
begin
  state:= isValid(posRow, posCol-1);
  if (state) then begin
     matriz.setValue(posRow, posCol, PASILLO);
     matriz.setValue(posRow, posCol-1, PACMAN);
     setPoints(posRow, posCol-1);
  end;
  Result:= state;
end;

function TJugador.moverDerecha(): Boolean;
var state: Boolean;
begin
  state:= isValid(posRow, posCol+1);
  if (state) then begin
     matriz.setValue(posRow, posCol, PASILLO);
     matriz.setValue(posRow, posCol+1, PACMAN);
     setPoints(posRow, posCol+1);
  end;
  Result:= state;
end;

function TJugador.moverAbajo(): Boolean;
var state: Boolean;
begin
  state:= isValid( posRow+1, posCol);
  if (state) then begin
     matriz.setValue(posRow, posCol, PASILLO);
     matriz.setValue(posRow+1, posCol, PACMAN);
     setPoints(posRow+1, posCol);
  end;
  Result:= state;
end;

function TJugador.moverArriba(): Boolean;
var state: Boolean;
begin
  state:= isValid( posRow-1, posCol);
  if (state) then begin
     matriz.setValue(posRow, posCol, PASILLO);
     matriz.setValue(posRow-1, posCol, PACMAN);
     setPoints(posRow-1, posCol);
  end;
  Result:= state;
end;

end.

