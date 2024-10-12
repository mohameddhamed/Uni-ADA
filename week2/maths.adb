package body Maths is
    function Sum_Digits(N: Positive) return Positive is
        X: Positive := N;
        Sum: Integer := 0;
    begin
        while X >= 10 loop
            Sum := Sum + (X mod 10);
            X := X / 10;
        end loop;
        return Sum;
    end Sum_Digits;
end Maths;