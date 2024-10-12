with Ada.Text_IO, Ada.Strings.Unbounded;
use Ada.Text_IO, Ada.Strings.Unbounded;

procedure Main is

   S1: String(1..11) := "Hello World";
   S2: Unbounded_String := To_Unbounded_String("Hello World");

   type Parcel_Category is (Phones, Laptops, Computers, Printers, Appliances);
   for Parcel_Category use (1,2,3,4,5);

begin

   Put_Line(S1);
   Put_Line(To_String(S2));

   S1(1..10) := "New String";
   S2 := To_Unbounded_String("Hello");

   Put_Line(S1);
   Put_Line(To_String(S2));

   Put_Line(Parcel_Category'Image(Phones));
   Put_Line(Parcel_Category'Image(Parcel_Category'Enum_Val(3)));
   Put_Line(Integer'Image(Parcel_Category'Enum_Rep(Laptops)));

end Main;
