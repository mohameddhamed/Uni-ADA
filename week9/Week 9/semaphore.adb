with Ada.Text_IO;
use Ada.Text_IO;

procedure Semaphore is
   
   task type Print is
      entry Init(S: in String := "");
   end Print;
   
   A, B: Print;
   
   task Semaf is
      entry Seize;
      entry Release;
   end Semaf;
   
   task body Semaf is
   begin
      loop
         accept Seize;
         accept Release;
      end loop;
   end Semaf;
   
   task body Print is
      type PStr is access String;
      Name: PStr;
   begin
      accept Init (S : in String := "") do
         Name := new String(1..S'Length);
         Name.all := S;
         delay 1.0;
      end Init;
      
      for I in 1..20 loop
         Semaf.Seize;
         Put_Line(Name.all & Positive'Image(I));
         Semaf.Release;
      end loop;
   end Print;
   
   task Wait;
   
   task body Wait is
   begin
      loop
         Semaf.Seize;
         delay 1.0;
         Semaf.Release;
      end loop;
   end Wait;   
   
begin
   A.Init("John");
   B.Init("Mary");
end Semaphore;
