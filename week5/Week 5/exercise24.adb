with Ada.Text_IO, Map;
use Ada.Text_IO;

procedure Exercise24 is
   
   type Arr1 is array(Integer range <>) of Integer;
   type Arr2 is array(Integer range <>) of Float;
   
   function Half(X: Integer) return Float is
   begin
      return Float(X) / 2.0;
   end Half;
   
   function My_Map is new Map(Integer, Float, Integer, Arr1, Arr2, Half);
   
   A: Arr1(1..5) := (1,2,3,4,5);
   B: Arr2(A'Range);
   
   
begin
   
   B := My_Map(A);
   
   for I in B'Range loop
      Put_Line(Float'Image(B(I)));
   end loop;
   
   
end Exercise24;
