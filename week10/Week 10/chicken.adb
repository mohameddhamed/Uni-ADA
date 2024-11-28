with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

procedure Chicken is
   
   package Rand_Bool is new Ada.Numerics.Discrete_Random(Boolean);
   
   protected Gen_Rand_Bool is
      procedure Init;
      function Generate return Boolean;
   private
      G: Rand_Bool.Generator;
   end Gen_Rand_Bool;
   
   protected body Gen_Rand_Bool is
      procedure Init is
      begin
         Rand_Bool.Reset(G);
      end Init;
      
      function Generate return Boolean is
      begin
         return Rand_Bool.Random(G);
      end Generate;
   end Gen_Rand_Bool;
   
   Gone: exception;
   Fly: exception;
   
   task Chicken is
      entry Feed;
      entry Play;
   end Chicken;
   
   task body Chicken is
      SeedInStomach: Integer := 4;
      SeedDelay: Duration := 1.0;
      TimeNotPlayed: Float := 5.0;
      Now: Time := Clock;
   begin
      loop
         Put_Line("Problem");
         Now := Clock;
         if SeedInStomach <= 0 then
            raise Gone;
         elsif SeedInStomach >= 30 then
            raise Fly;
         elsif TimeNotPlayed <= 0.0 then
            raise Gone;
         else
            select
               accept Feed  do
                  SeedInStomach := SeedInStomach + 3;
                  Put_Line("Chicken: I am getting fed: " & Integer'Image(SeedInStomach));
               end Feed;
            or
               accept Play  do
                  TimeNotPlayed := 5.0;
                  SeedInStomach := SeedInStomach - 1;
                  Put_Line("Chicken: Child is playing with me: " & Integer'Image(SeedInStomach));
               end Play;
            or 
               delay SeedDelay;
               SeedInStomach := SeedInStomach - 1;
               Put_Line("Chicken: losing a seed: " & Integer'Image(SeedInStomach));
            end select;
         end if;
         TimeNotPlayed := TimeNotPlayed - Float(Clock - Now);
         Put_Line(Float'Image(TimeNotPlayed));
      end loop;
   exception
      when Fly => Put_Line("Chicken flew away");
      when Gone => Put_Line("Chicken died");
   end Chicken;
      
  
   task Child;
   
   task body Child is
      B: Boolean;
   begin
      Gen_Rand_Bool.Init;
      loop
         delay 1.5;
         B := Gen_Rand_Bool.Generate;
         if B then
            Chicken.Feed;
         else
            Chicken.Play;
         end if;
      end loop;
   exception
      when Tasking_Error => Put_Line("Child is sad");
   end Child;
                
begin
   null;
end Chicken;
