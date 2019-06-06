program BinTree_v2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
type
  PntBinTree = ^bintree;
  BinTree = record
    num: Integer;
    BF: ShortInt;
    counter: Byte;
    GNext, Lnext, Prev: PntBinTree;
  end;

procedure BalanceFactor(pnt: PntBinTree);
begin

end;

function find_in_bin_tree(pnt: pntbintree; inf: integer; ins: Boolean = false
  {false = find; true = insert}):
  //find or insert number
pntbintree;
begin
  while true do //find place for inser or find num
  begin
    if inf = pnt^.num then ///////////point num equal num
    begin
      result := pnt;
      exit;
    end;
    if inf < pnt^.num then ///////////// point num > num
    begin
      if pnt^.lnext = nil then
      begin
        if ins then
        begin
          New(pnt^.lnext); //add point if we insert num
          pnt^.Lnext^.Prev := pnt;
        end;
        Result := pnt^.lnext;
        exit;
      end;
      pnt := pnt^.lnext;
      continue;
    end
    else
    begin ////////// num > point num
      if pnt^.gnext = nil then
      begin
        if ins then
        begin
          New(pnt^.gnext); //add point if we insert num
          pnt^.Gnext^.Prev := pnt;
        end;
        Result := pnt^.gnext;
        exit;
      end;
      pnt := pnt^.gnext;
      continue;
    end;
  end;
end;

procedure write_bin_tree(pnt: PntBinTree);
begin
  if pnt^.Lnext <> nil then
    write_bin_tree(pnt^.Lnext);
  write(pnt^.num, '(', pnt^.bf, ') ');
  if pnt^.gnext <> nil then
    write_bin_tree(pnt^.gnext);
end;

procedure insert_num(head: PntBinTree; num: Integer);
  procedure BF_ADD(p: PntBinTree);
  var
    num: Integer;

  begin
    num := p^.num;
    repeat //paste here prohibit if you copy it
      p := p^.Prev;
      if num > p^.num then
        inc(p^.BF)
      else
        Dec(p^.bf);
    until (p^.BF = 0) or (p^.Prev = nil);
  end;
var
  outp: PntBinTree;
begin
  outp := find_in_bin_tree(head, num, true);
  outp^.num := num;
  inc(outp^.counter);
  if outp^.counter = 1 then
  begin
    outp^.BF := 0;
    BF_ADD(outp);
  end;
end;
var
  n, i, nol: Cardinal;
  k: Byte;
  inp: Integer;
  head: PntBinTree;
  outpul: pntbintree;

begin
  repeat
    Write('Input amount of numbers n: ');
    Readln(n);
  until n > 0;
  writeln('Input numbers: ');
  Readln(inp);
  New(head);
  head^.num := inp;
  head^.counter := 1;
  head^.Prev := nil;
  for i := 2 to n do
  begin
    Readln(inp);
    insert_num(head, inp);
  end;

  write_bin_tree(head);
  Readln;
end.

