with Ada.Text_IO;
use Ada.Text_IO;

procedure Shoes is

--     task Sand;
   task Sand is 
      entry Put_Right_Foot_On_Sand;
      entry Put_Left_Foot_On_Sand; 
   end Sand;

   task Right_Shoe;

   task Left_Shoe;

   task body Sand is 
   begin

      for I in 1..10 loop
         select
            accept Put_Left_Foot_On_Sand do
               Put_Line("Iteration " & I'Image);
               Put_Line("Left Foot is stepping on the Sand.");
               accept Put_Right_Foot_On_Sand do 
                     Put_Line("Right Foot is stepping on the Sand.");
               end Put_Right_Foot_On_Sand;
            end Put_Left_Foot_On_Sand;
            or
               delay 5.0;
         end select;
      end loop;

   end Sand;
   task body Left_Shoe is
   begin
      loop
         Sand.Put_Left_Foot_On_Sand;
         delay 0.5;   
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("No more steps?");
   end Left_Shoe;

   
   task body Right_Shoe is
   begin
      loop
         Sand.Put_Right_Foot_On_Sand;
         delay 1.2;   
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("No more steps?");
   end Right_Shoe;

   
begin
   null;

end Shoes;