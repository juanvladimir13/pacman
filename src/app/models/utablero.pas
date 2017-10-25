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
unit utablero;

{$mode objfpc}{$H+}

interface

uses
  umatriz, umuro, uutils, ujugador, Dialogs, sysutils, math;
type
  { TTablero }

  TTablero = class
    nroMuros : Word;
    name: String;
    private
      matriz : TMatriz;
      jugador: TJugador;
    public
      constructor create();
      function getMatriz():TMatriz;

      procedure init(nroFilas:Word; nroColumnas:Word);

      procedure addMuro(longitud:Word; rowBegin:Word; colBegin:Word);
      procedure construirMuros();

      procedure addGhost();

      procedure addJugador(jugadorazo: TJugador);
      procedure setJugador();

      function toString:String;
  end;

implementation

{ TTablero }

constructor TTablero.create;
begin
  Self.nroMuros:= 0;
  Self.name:= 'Tablero';
  Self.matriz:= TMatriz.create();
  Self.jugador:= nil;
end;

function TTablero.getMatriz: TMatriz;
begin
  Result:= Self.matriz;
end;

procedure TTablero.init(nroFilas: Word; nroColumnas: Word);
begin
  matriz.init(nroFilas, nroColumnas);
  matriz.reset(POINTS);
  Self.nroMuros:= round((nroFilas + nroColumnas)/3)+1;
end;

procedure TTablero.addMuro(longitud:Word; rowBegin:Word; colBegin:Word);
var muro:TMuro;
begin
  muro := TMuro.create(matriz);
  muro.init(longitud,rowBegin,colBegin);
  muro.construir();
end;

procedure TTablero.construirMuros;
var index, size, longitud,
  rowBegin, colBegin,
  nroRows, nroCols: Word;
begin
  nroRows:= matriz.getNroFilas();
  nroCols:= matriz.getNroColumnas();

  size := round((nroRows + nroCols)/2)-1;
  for index:= 0 to nroMuros-1 do begin
    longitud:= RandomRange( round(size/2),size);
    rowBegin:= RandomRange( 1 , nroRows-1);
    colBegin:= RandomRange( 1 , nroCols-1);

    addMuro(longitud, rowBegin, colBegin);
  end;
end;

procedure TTablero.addGhost;
var index, row, col, nro:Byte;
begin
  nro := round((matriz.getNroFilas() + matriz.getNroColumnas())/3);
  for index := 0 to nro do begin
     row := RandomRange(0, matriz.getNroFilas());
     col := RandomRange(0, matriz.getNroColumnas());
     if (matriz.getValue(row,col) = POINTS) then
        matriz.setValue(row,col, GHOST);
  end;
end;

procedure TTablero.addJugador(jugadorazo: TJugador);
begin
  Self.jugador:= jugadorazo;
  Self.jugador.removed:= False;
  Self.jugador.setMatriz(matriz);
end;

procedure TTablero.setJugador;
var indexRow,indexCol:Word;
  sw :Boolean;
begin
  sw := False;
  indexRow:= RandomRange(round(matriz.getNroFilas()/2), matriz.getNroFilas()-1);
  indexCol:= RandomRange(round(matriz.getNroColumnas()/2), matriz.getNroColumnas()-1);

  while ( not sw and (indexRow < matriz.getNroFilas())) do begin
    while (not sw and (indexCol < matriz.getNroColumnas())) do begin
      if ( matriz.getValue(indexRow, indexCol) = POINTS) then begin
         matriz.setValue(indexRow, indexCol, PACMAN);
         jugador.setPoints(indexRow, indexCol);
         ShowMessage(IntToStr(indexRow) + ' ' + IntToStr(indexCol));
         sw := True;
      end;
      indexCol:= indexCol + 1;
    end;
      indexRow:= indexRow + 1;
  end;
end;

function TTablero.toString: String;
begin
  Result:= matriz.toString;
end;

end.

