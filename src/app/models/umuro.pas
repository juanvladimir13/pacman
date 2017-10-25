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
unit umuro;

{$mode objfpc}{$H+}

interface
uses umatriz, uutils, sysutils, math;
type

  { TMuro }

  TMuro = class
    length: Word;
    posRow : Word;
    posCol: Word;
    matriz : TMatriz;

    name: String;
    private
      celdas : TArrayByte;
    public

      constructor create(matrizTablero:TMatriz);
      procedure init(longitud:Word; rowBegin:Word; colBegin:Word);

      function isValid():Boolean;
      procedure avanzar();
      procedure construir();
      function toString:String;

      function getCeldas:TArrayByte;

  end;

implementation

{ TMuro }

constructor TMuro.create(matrizTablero:TMatriz);
begin
  Self.length := 0;
  Self.posRow:= 0;
  Self.posCol:= 0;
  Self.name:= 'Muro';
  Self.matriz := matrizTablero;
end;

procedure TMuro.init(longitud: Word; rowBegin: Word; colBegin: Word);
begin
  Self.length:= longitud;
  Self.posRow:= rowBegin;
  Self.posCol:= colBegin;
end;

function TMuro.isValid(): Boolean;
var state:Boolean;
begin
  state:= False;
  if (((posRow > 0) and (posRow < matriz.getNroFilas())) and
      ((posCol > 0) and (posCol < matriz.getNroColumnas()))) then
    state:= matriz.getValue( posRow, posCol) = POINTS;
  Result:= state;
end;

procedure TMuro.avanzar;
var opcion: Word;
begin
  opcion:= RandomRange(0, 8);
  case opcion of
    0:// izquierda
      posCol := posCol - 1;
    1: // diagonal inferior izquierda
      begin
        posRow := posRow + 1;
        posCol := posCol - 1;
      end;
    2:// abajo
      posRow := posRow +1;
    3: // diagonal inferior derecha
      begin
        posRow := posRow + 1;
        posCol := posCol + 1;
      end;
    4:// derecha
      posCol := posCol + 1;
    5: // diagonal superior derecha
      begin
        posRow := posRow -1;
        posCol := posCol + 1;
      end;
    6:// arriba
      posRow := posRow - 1;
    7: // diagonal superior izquierda
      begin
        posRow := posRow -1;
        posCol := posCol -1;
      end;
  end;
end;

procedure TMuro.construir;
var sw :Boolean; index:Word;
begin
  sw := True;
  index:= 0;
  while ( sw and (index < length)) do begin
    sw := isValid();
    if (sw)then begin
      matriz.setValue(posRow, posCol, MURO);
      index:= index + 1;
      if ( (posRow > 0) and (posCol > 0) and
           (posRow < matriz.getNroFilas()-1) and
           (posCol < matriz.getNroColumnas()-1)) then
        avanzar()
    end;
  end;
end;

function TMuro.toString: String;
var rowIndex, colIndex:Word;
    s : String;
begin
  s := '';
  for rowIndex := 0 to matriz.getNroFilas()-1 do begin
    for colIndex := 0 to matriz.getNroColumnas()-1 do begin
      s := s + ' ' + IntToStr(celdas[rowIndex, colIndex]);
    end;
    s:= s + #13;
  end;
  Result:= s;
end;

function TMuro.getCeldas: TArrayByte;
begin
  Result:= celdas;
end;

end.

