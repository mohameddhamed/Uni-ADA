with Ada.Text_IO;
use Ada.Text_IO;

procedure Shoes is

--     task Sand;
   task Sand is 
      entry Put_Right_Foot_On_Sand;
      entry Put_Left_Foot_On_Sand; 
   end Sand;

   task Right_Shoe is
      entry Can_Step(What : in Boolean);
   end Right_Shoe;

   task Left_Shoe is
      entry Can_Step(What : in Boolean);
   end Left_Shoe;

   task body Sand is 
   begin
      --  Right_Shoe.Can_Step;

      loop
         select
            accept Put_Right_Foot_On_Sand do
                  Put_Line("Right Foot is stepping on the Sand.");
                  Right_Shoe.Can_Step(False);
                  Left_Shoe.Can_Step(True);
            end Put_Right_Foot_On_Sand;
            or
            accept Put_Left_Foot_On_Sand do 
                  Put_Line("Left Foot is stepping on the Sand.");
                  Left_Shoe.Can_Step(False);
                  Right_Shoe.Can_Step(True);
            end Put_Left_Foot_On_Sand;
         end select;
      end loop;

   end Sand;

   
   task body Left_Shoe is
   begin
      loop
        select
            accept Can_Step(What : in Boolean) do
               if What = True then
                  Sand.Put_Left_Foot_On_Sand;
               end if;
               --  Put_Line("Left Foot Stepping on Sand");
            end Can_Step;
            or 
               delay 3.0;   
        end select;
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("Closed?");
   end Left_Shoe;

   
   task body Right_Shoe is
   begin
      loop
        select
            accept Can_Step(What : in Boolean) do
               if What = True then 
                  Sand.Put_Right_Foot_On_Sand;
               end if;
               --  Put_Line("Right Foot Stepping on Sand");
            end Can_Step;
            or 
               delay 3.0;   
        end select;
      end loop;
   exception
      when Tasking_Error =>
         Put_Line("Closed?");
   end Right_Shoe;

   
begin
   Right_Shoe.Can_Step(True);
   --  Left_Shoe.Can_Step;
      delay 10.0; -- Simulate runtime for the tasks

end Shoes;