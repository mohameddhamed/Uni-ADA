with Ada.Text_IO, Reversal;
use Ada.Text_IO;

procedure Exercise25 is
   
   type Arr is array(Integer range <>) of Integer;
   
   procedure My_Reversal is new Reversal(Integer, Integer, Arr);
   
   A1: Arr := (1,2,3,4,5);
   
   procedure Print(A: in Arr) is
   begin
      for I in A'Range loop
         Put_Line(Integer'Image(A(I)));
      end loop;
   end Print;
   
begin
   
   My_Reversal(A1);
   Print(A1);
   
end Exercise25;
