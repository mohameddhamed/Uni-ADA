with Ada.Text_IO;
use Ada.Text_IO;

procedure Pub is
   
   type Drinks is (Beer, Wine, Brandy);
   
   task Barman is
      entry Order(What: in Drinks);
   end Barman;
   
   task body Barman is
   begin
      for I in 1..20 loop
         accept Order (What : in Drinks) do
            Put_Line("The ordered drink: " & Drinks'Image(What));
            case What is
               when Beer => delay 1.0;
               when Wine => delay 0.2;
               when Brandy => delay 0.3;
            end case;
         end Order;
      end loop;
   end Barman;
   
   task type Customer;
   
   task body Customer is
      Beer_Drinking: Duration := 1.0;
   begin
      Barman.Order(Brandy);
      Put_Line("Customer orders brandy.");
      delay 0.1;
      Barman.Order(Wine);
      Put_Line("Customer orders wine.");
      delay 0.3;
      loop
         Barman.Order(Beer);
         Put_Line("Customer orders beer.");
         delay Beer_Drinking;
         Beer_Drinking := 2 * Beer_Drinking;
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("Closed?");
   end Customer;
   
   type Customer_Access is access Customer;
   C: Customer_Access;

begin
   for I in 1..5 loop
      delay 3.0;
      Put_Line("Customer is here");
      C := new Customer;
   end loop;
end Pub;
