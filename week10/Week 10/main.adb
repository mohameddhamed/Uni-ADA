with Ada.Text_IO;
use Ada.Text_IO;

procedure Main is

   task type Person is
      entry Init(S: in String := "");
   end Person;

   protected type Print is
      entry P(S: in String := "");
      procedure P2(S: in String := "");
   private
      Count: Natural := 0;
   end Print;


   protected body Print is
      entry P(S: in String := "") when True is
      begin
         Count := Count + 1;
         Put_Line(S & Integer'Image(Count));
      end P;

      --alternative
      procedure P2(S: in String := "") is
      begin
         Count := Count + 1;
         Put_Line(S & Integer'Image(Count));
      end P2;
   end Print;

   task Print2 is
      entry P(S: in String := "");
   end Print2;

   task body Print2 is
      Count: Natural := 0;
   begin
      loop
         accept P (S : in String := "") do
            Count := Count + 1;
            Put_Line(S & Integer'Image(Count));
         end P;
      end loop;
   end Print2;


   task body Person is
      type PStr is access String;
      Name: PStr;
   begin
      accept Init (S : in String := "") do
         Name := new String'(S);
      end Init;

      for I in Positive'Range loop
         Print.P(Name.all & Integer'Image(I) & ": ");
      end loop;
   end Person;

   A, B: Person;


begin
   A.Init("Mary");
   B.Init("John");
end Main;
