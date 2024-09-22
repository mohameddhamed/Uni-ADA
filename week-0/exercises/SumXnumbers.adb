with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
procedure SumXNumbers is
    N : Integer;
    Sum : Integer := 0;
begin
    Get(N);
    for I in 1..N loop
        Sum := Sum + I;
    end loop;
    Put(Sum);
end SumXNumbers;