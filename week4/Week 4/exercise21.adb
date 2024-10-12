with Ada.Text_IO, Ada.Integer_Text_IO, SetQ;
use Ada.Text_IO, Ada.Integer_Text_IO, SetQ;

procedure Exercise21 is
   
   R1: Rational := 4/8;
   R2: Rational := 5/7;
   R3: Rational;
   
begin
   
   R3 := R1 / R2;
   Put_Line(Integer'Image(Numerator(R3)) & "/" & Integer'Image(Denominator(R3)));
   
   R3 := R1 / 5;
   Put_Line(Integer'Image(Numerator(R3)) & "/" & Integer'Image(Denominator(R3)));
   
   R3 := R1 + R2;
   Put_Line(Integer'Image(Numerator(R3)) & "/" & Integer'Image(Denominator(R3)));
   
   R3 := R1 * R2;
   Put_Line(Integer'Image(Numerator(R3)) & "/" & Integer'Image(Denominator(R3)));
   
end Exercise21;
