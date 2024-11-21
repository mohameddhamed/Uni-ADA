with Ada.Text_IO;
use Ada.Text_IO;

procedure AB is
   
   task A;
   task B;
   
   task body A is
   begin
      for I in Positive'Range loop
         Put_Line("A: " & Positive'Image(I));
      end loop;
   end A;

   
   task body B is
   begin
      for I in Positive'Range loop
         Put_Line("B: " & Positive'Image(I));
      end loop;
   end B;
   
   
begin
   null;
end AB;
