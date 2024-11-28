with Ada.Text_IO;
use Ada.Text_IO;

procedure Exercise34 is
   
   type Color is (Red, Yellow, Green);
   
   protected Lamp is
      procedure Change;
      function Is_Color return Color;
   private
      Light: Color := Red;
   end Lamp;
   
   protected body Lamp is
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
           
   
      
   
begin
   null;
end Exercise34;
