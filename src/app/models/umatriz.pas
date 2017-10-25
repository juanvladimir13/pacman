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

unit umatriz;

{$mode objfpc}{$H+}

interface

uses
 uutils, sysutils;
type
  { TMatriz }

  TMatriz = class
    nroRow : Word;
    nroCol : Word;
    name : String;
  private
    celdas : TArrayByte;
    procedure setNroFilas(nroFilas:Word);
    procedure setNroColumnas(nroColumnas:Word);
  public
    constructor create();
    function getNroFilas():Word;
    function getNroColumnas():Word;

    procedure init(nroFilas:Word; nroColumnas:Word);
    procedure reset(value:Word);
    function setValue(posRow:Word; posCol:Word; value:Word):Boolean;
    function getValue(posRow:Word; posCol:Word):Word;

    function toString:String;
  end;

implementation

{ TMatriz }

constructor TMatriz.create;
begin
  Self.nroRow:= 0;
  Self.nroCol:= 0;
  Self.name:= 'Matriz';
end;

procedure TMatriz.setNroFilas(nroFilas: Word);
begin
    Self.nroRow:= nroFilas;
end;

procedure TMatriz.setNroColumnas(nroColumnas: Word);
begin
    Self.nroCol:= nroColumnas;
end;

function TMatriz.getNroFilas: Word;
begin
  Result:= Self.nroRow;
end;

function TMatriz.getNroColumnas: Word;
begin
  Result:= Self.nroCol;
end;

procedure TMatriz.init(nroFilas: Word; nroColumnas: Word);
begin
  setNroFilas(nroFilas);
  setNroColumnas(nroColumnas);
end;

procedure TMatriz.reset(value:Word);
var row,col:Word;
begin
  for row := 0 to getNroFilas()-1 do begin
    for col := 0 to getNroColumnas()-1 do begin
      celdas[row, col ]:= value;
    end;
  end;
end;

function TMatriz.setValue(posRow: Word; posCol: Word; value:Word): Boolean;
var state:Boolean;
begin
  state:= False;
  if (((posRow >=0) and (posRow < getNroFilas())) and
       ((posCol>= 0) and (posCol < getNroColumnas()))) then begin
     celdas[posRow, posCol] := value;
     state := True;
  end;
  Result:= state;
end;

function TMatriz.getValue(posRow: Word; posCol: Word): Word;
var data: Word;
begin
  data:= 255;
  if (((posRow >=0) and (posRow < getNroFilas())) and
       ((posCol>= 0) and (posCol < getNroColumnas()))) then begin
     data:= celdas[posRow][posCol];
  end;
  Result:= data;
end;


function TMatriz.toString: String;
var rowIndex, colIndex:Word;
    s : String;
begin
  s := '';
  for rowIndex := 0 to getNroFilas()-1 do begin
    for colIndex := 0 to getNroColumnas()-1 do begin
      s := s + ' ' + IntToStr(celdas[rowIndex, colIndex]);
    end;
    s:= s + #13;
  end;
  Result:= s;
end;
end.

