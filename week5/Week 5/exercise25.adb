with Ada.Text_IO, Reversal2;
use Ada.Text_IO;

procedure Exercise25 is

   type Arr is array (Integer range <>) of Integer;
   type Elem is new Integer;

   procedure Swap(A : in out Integer; B : in out Integer) is 
      Temp : Integer := A;
   begin
      A := B;
      B := Temp;
   end;

   procedure My_Reversal is new Reversal2 (Integer, Integer, Arr, Swap);

   A1 : Arr := (1, 2, 3, 4, 5);

   procedure Print (A : in Arr) is
   begin
      for I in A'Range loop
         Put_Line (Integer'Image (A (I)));
      end loop;
   end Print;

begin

   My_Reversal (A1);
   Print (A1);

end Exercise25;
