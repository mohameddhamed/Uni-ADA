with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
procedure factorial is 

    N : Integer;

    function Fact(N : Integer) return Integer is 
        F : Integer := 1;
    begin
        for I in 1..N loop
            F := F * I;
        end loop;
        return F;
    end Fact;

begin
    Get(N);
    Put(Fact(N));
end factorial;