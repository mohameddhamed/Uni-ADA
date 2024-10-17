with Ada.Text_IO, Search;
use Ada.Text_IO;

procedure Exercise27 is
   
   type Arr is array(Integer range <>) of Integer;
   
   procedure Own_Search is new Search(Integer, Integer, Arr);
   
   A1: Arr(1..6) := (1,2,2,3,4,5);
   A2: Arr(1..5) := (1,2,3,4,5);
   
   procedure Print(A: in Arr) is
      B: Boolean;
      I1: Integer;
      I2: Integer;
   begin
      Own_Search(A, B, I1, I2);
      if B then
         Put_Line("Array contains element that occurs more than 2 times");
         Put_Line("Index 1: " & Integer'Image(I1) & " Index 2: " & Integer'Image(I2));
      else
         Put_Line("Array does not contain an element that occurs more than twice");
      end if;
   end Print;
   
   
begin
   
   Print(A1);
   Print(A2);
   
end Exercise27;
