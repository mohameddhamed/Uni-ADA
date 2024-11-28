with Ada.Text_IO;
use Ada.Text_IO;

procedure Lamps is

   type Color is (Red, Yellow, Green);

   protected Lamp is
      entry Pass;
      procedure Change;
      function Is_Color return Color;
   private
      Light: Color := Red;
   end Lamp;

   protected body Lamp is
   	entry Pass when Light = Green is 
      begin 
         Put_Line("[Lamp]: Cars can pass!");
      end;
      procedure Change is
      begin
         if Light = Green then
            Light := Red;
         else
            Light := Color'Succ(Light);
         end if; 
         Put_Line(Color'Image(Light));
      end Change;
      function Is_Color return Color is
      begin
         return Light;
      end Is_Color;
   end Lamp;

   task Scheduler;

   task body Scheduler is
   begin
      for I in 1..3 loop
        Lamp.Change;
        delay 2.0;
        Lamp.Change;
        delay 1.5;
        Lamp.Change;
        delay 0.5; 
      end loop;
   end Scheduler;

   type String_Access is access String;
   type Duration_Access is access Duration;

   task type Car(Plate : String_Access; TValue : Duration_Access);

   task body Car is
   begin
      loop
         select
            Lamp.Pass;
            Put_Line("[License Plate]: " & Plate.all & " => I crossed!");
            delay TValue.all;
         or 
            delay 0.2;   
         end select;
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("No more steps?");
   end Car;

   type Car_Access is access Car;
   type Car_Array is array (1..3) of Car_Access;

   Car_Arr : Car_Array := (
      new Car(new String'("1"), new Duration'(1.0)), 
      new Car(new String'("2"), new Duration'(1.2)), 
      new Car(new String'("3"), new Duration'(1.4))
   );
   




begin
null;
   
end Lamps;