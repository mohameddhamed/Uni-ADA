with Ada.Text_IO;
use Ada.Text_IO;

procedure Pub2 is
   
   type Drinks is (Beer, Wine, Brandy);
   
   task Barman is
      entry Order(What: in Drinks);
   end Barman;
   
   task Door is
      entry Go_In;
      entry Go_Out;
   end Door;
   
   task type Customer;
   Customers: array(1..5) of Customer;
   
   task type Student is
      entry Name(S: in String := "");
   end Student;
   
   Students: array(1..3) of Student;
   
   type PStudent is access Student;
   Stud: PStudent;
   

   task body Barman is
      Make_Time: constant array (Drinks) of Duration := (1.0, 0.1, 0.2);
      Closing_Time: constant Duration := 5.0;
   begin
      loop
         select
            accept Order(What : in Drinks) do
               Put_Line(Drinks'Image(What) & " was ordered.");
               delay Make_Time(What);
            end Order;
         or 
            delay Closing_Time;
            exit;
         end select;
      end loop;
   end Barman;

   task body Door is
      Inside: Natural := 0;
   begin
      loop
         select
            accept Go_Out;
            Inside := Inside - 1;
         or
            when Inside < 5 => accept Go_In;
               Inside := Inside + 1;
         or
            terminate;
         end select;
      end loop;
   end Door;
   
   
   task body Customer is
      Drink_Time: constant array(Drinks) of Duration := (2.0, 1.0, 0.2);
      Factor: Positive := 1;
   begin
      loop
         select
            Door.Go_In;
            Barman.Order(Brandy);
            delay Drink_Time(Brandy);
            Barman.Order(Wine);
            delay Drink_Time(Wine);
            loop
               Barman.Order(Beer);
               delay Drink_Time(Beer) * Factor;
               Factor := Factor + 1;
            end loop;
         else
            Put_Line("Coming back later");
            delay 5.0;
         end select;
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("Closed?");
         Door.Go_Out;
   end Customer;
   
   task body Student is
      type PString is access String;
      N: PString;
   begin
      accept Name (S : in String := "") do
         N := new String'(S);
      end Name;
      
      select
         Door.Go_In;
         Barman.Order(Wine);
         Put_Line(N.all & " drinking wine");
         delay 3.0;
         Door.Go_Out;
      or
         delay 1.0;
         Put_Line(N.all & " going home");
      end select;
   end Student;

begin
   
   for I in Students'Range loop
      Students(I).Name("Student " & Integer'Image(I));
   end loop;
   
   delay 2.0;
   Stud := new Student;
   Stud.Name("Mary");
   delay 2.0;
   Stud := new Student;
   Stud.Name("John");
   
end Pub2;
