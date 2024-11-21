with Ada.Text_IO;
use Ada.Text_IO;

procedure Names is
   
   task type Print is
      entry Init(S: in String := "");
   end Print;
   
   A, B: Print;
   
   task body Print is
      type PStr is access String;
      Name: PStr;
   begin
      accept Init (S : in String := "") do
         Name := new String(1..S'Length);
         Name.all := S;
         delay 1.0;
      end Init;
      
      for I in Positive'Range loop
         Put_Line(Name.all & Positive'Image(I));
      end loop;
   end Print;
     
begin
   A.Init("John");
   B.Init("Mary");
end Names;
