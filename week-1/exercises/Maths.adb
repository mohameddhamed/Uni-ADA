with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;

package body Maths is
    function SumNum(N : Positive) return Integer is  
        X : Positive := N;
        Sum : Integer := 0;
    begin
        while (X >= 10) loop
            Sum := Sum + (X mod 10);
            X := X / 10;
        end loop;
        Sum := Sum + (X mod 10);
        return Sum;
    end SumNum;

    function DivideByNine(N : Positive) return Boolean is
        Sum : Positive;
    begin
        Sum := SumNum (N);
        if Sum mod 9 = 0 then
            return True;
        end if;
        return False;
    end DivideByNine;

    function IsPerfect(N : Positive) return Boolean is
        Sum : Integer := 0;
    begin
        for I in 1..N-1 loop
            if N mod I = 0 then
                Sum := Sum + I;
            end if;
        end loop;
        return N = Sum;

    end IsPerfect;

    procedure PerfectsInterval(N : Positive) is
    begin
        Put("The perfect numbers up to ");
        Put(N);
        Put_Line ("");
        for I in 1..N loop
            if IsPerfect (I) then
                Put(I);
                Put(", ");
            end if;
        end loop;
    end PerfectsInterval;

    function Sinus(X : Float) return Float is
    begin
        return Sin(X); 
    end Sinus;

    function FactRec(N : Positive) return Positive is
    begin
        if N = 1 then
            return 1;
        end if;
        return N * FactRec(N - 1);

    end FactRec;

end Maths;