with Ada.Text_IO, Maths, Ada.Integer_Text_IO;
use Ada.Text_IO, Maths, Ada.Integer_Text_IO;
procedure Main is
    N : Positive := 123;
    --  X : Integer; 
    Div9 : Boolean;
begin
    --  Put_Line (Positive'Image(SumNum(N)));
    --  Get(N);
    --  Div9 := DivideByNine(N);
    --  if Div9 then
    --      Put_Line ("Divisible by 9");
    --  else
    --      Put_Line ("Not divisible by 9");
    --  end if;
    --  Get(N);
    --  if IsPerfect(N) then
    --      Put_Line ("Is Perfect");
    --  else
    --      Put_Line ("Is not Perfect");
    --  end if;
    --  Get(N);
    --  PerfectsInterval(N);
    --  Put_Line(Float'Image(Sinus(30.0)));
    Get (N);
    Put_Line(Integer'Image(FactRec(N)));
end Main;