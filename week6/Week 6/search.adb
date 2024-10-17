procedure Search (A : Arr; B : out Boolean; I1 : out Index; I2 : out Index) is
   C : Integer := 0;
begin
   B := False;
-- 1 2 2 3 5 6
   for I in A'Range loop
      I1 := I;
      for J in I .. A'Last loop
         if A (I) = A (J) then
            C  := C + 1;
            I2 := J;
         end if;
      end loop;
      if C >= 2 then
         B := True;
         return;
      end if;
      C := 0;
   end loop;
end Search;
