with ProtectedP, Ada.Text_IO, Ada.Exceptions;
use ProtectedP, Ada.Text_IO;

procedure Main is

   Termination : exception;
   task E2DAWACS is
      entry Launch(c: in out P_Catapult);
      entry Recall;
      entry Connect;
      entry Disconnect;
   end;

   task body E2DAWACS is
      Num_Connected_Aircrafts, Iter_Num : Integer;
   begin
      Num_Connected_Aircrafts := 0;
      Iter_Num := Gen_Rand_Num.Generate;
      --  for I in 1..Iter_Num loop
      loop
         select
            accept Launch(c: in out P_Catapult) do
               c.Move_To_Position;
               Print.P("*****E2D-AWACS preparing to take off from catapult*****"); 
               delay 2.0;
               c.Launch;
               Print.P("*****E2D-AWACS taking off from catapult*****"); 
               delay 4.0; 
               c.Clear_From_Carrier;
               Print.P("*****E2D-AWACS clear from carrier*****");
            end Launch;
         or
            when Num_Connected_Aircrafts = 0 => accept Recall do
               Landing_Strip.Final_Approach;
               Print.P("*****E2D-AWACS on Final Approach for Landing*****"); 
               delay 5.0; 
               Landing_Strip.Move_To_Parking_Spot; 
               Print.P("*****E2D-AWACS moving to parking spot*****");
               delay 3.0;
            end Recall;
         or
            accept Connect do
               Num_Connected_Aircrafts := Num_Connected_Aircrafts + 1;
               Print.P("*****Aircraft connected to E2D-AWACS: number of aircraft connected " & Num_Connected_Aircrafts'Image & " *****");
            exception
            when others =>
               Print.P("Exception occered at E2DAWACS Connect " & Num_Connected_Aircrafts'Image); 
            end Connect;
         or 
            accept Disconnect do
               Num_Connected_Aircrafts := Num_Connected_Aircrafts - 1;
               Print.P("*****Aircraft disconnected to E2D-AWACS: number of aircraft connected " & Num_Connected_Aircrafts'Image & " *****");
            end Disconnect;
         or 
            terminate;
         end select;
      end loop;
   exception
      when Tasking_Error =>
         Print.P("Exception occered at E2DAWACS"); 
   end E2DAWACS; 

   task type Aircraft is
      entry Init(aType : TAircraft; aNum : Integer; aCatapult : P_Catapult);
      entry Start_Sortie;
      entry Intercept;
   end Aircraft;

   task body Aircraft is
      aircraftHasTakenOff : Boolean := False;
      terminated: Boolean := False;
      RandDur : Duration;
      Iter_Num : Integer;
      airType : TAircraft; 
      airNum : Integer; 
      airCatapult : P_Catapult;
   begin
      accept Init(aType : TAircraft; aNum : Integer; aCatapult : P_Catapult) do
         airType := aType;
         airNum := aNum;
         airCatapult := aCatapult;
         Print.P(airType'Image & "-" & airNum'Image & ": is ready to start."); 
      end Init;
      Iter_Num := Gen_Rand_Num.Generate;

      for I in 1..Iter_Num loop
         select
            accept Start_Sortie;
            declare begin

               declare begin
               airCatapult.Move_To_Position;
               Print.P(airType'Image & "-" & airNum'Image & ": Preparing to Take-off from Catapult."); 
               delay 1.0;
               exception
               when others =>
                  Print.P("Exception occered at air Move to position"); 
               end;

               declare begin
               airCatapult.Launch;
               Print.P(airType'Image & "-" & airNum'Image & ": Taking Off from Catapult."); 
               delay 3.0;
               exception
               when others =>
                  Print.P("Exception occered at air Launch"); 
               end;

               declare begin
               airCatapult.Clear_From_Carrier;
               Print.P(airType'Image & "-" & airNum'Image & ": Clear from the Carrier."); 
               declare begin
                  E2DAWACS.Connect;
               exception
               when others =>
                  Print.P("Exception occered at air Connect"); 
               end;
               aircraftHasTakenOff := True;
               exception
               when others =>
                  Print.P("Exception occered at air Clear"); 
               end;
            exception
            when others =>
               Print.P("Exception occered at Start Sortie"); 
            end;
         or 
            accept Intercept;
            
            declare begin
            RandDur := Rand_Intercept_Time.Generate;
            Print.P(airType'Image & "-" & airNum'Image & ": Intercepting an Unidentified Aircraft."); 
            delay RandDur;
            Print.P(airType'Image & "-" & airNum'Image & ": Completed Intercept in – " & RandDur'Image); 
            exception
            when others =>
               Print.P("Exception occered at Intercept"); 
            end;
         or
            delay 40.0;
            if aircraftHasTakenOff then
               E2DAWACS.Disconnect;
               Landing_Strip.Final_Approach;
               Print.P(airType'Image & "-" & airNum'Image & ": on Final Approach for Landing."); 
               delay 3.0;
               Landing_Strip.Move_To_Parking_Spot;
               Print.P(airType'Image & "-" & airNum'Image & "Moving to Parking Spot."); 
               delay 2.0;
               terminated := True;
               raise Termination;
            end if;
            
         end select;
         if terminated = True then
            exit;
         end if;
      end loop;
   exception
      when Tasking_Error =>
         Print.P("Exception occered at " & airType'Image & "-" & airNum'Image); 
      when Termination => 
         Print.P("Aircraft thread terminated");
   end Aircraft;

   Left_Catapult, Right_Catapult : P_Catapult;

   task Flight_Operations is
      entry Init(R_Catapult : P_Catapult; L_Catapult : P_Catapult);
   end Flight_Operations;

   type P_Aircraft is access Aircraft;
   type P_Aircraft_Arr  is array(Positive range <>) of P_Aircraft;
   Jet_Aircraft : P_Aircraft_Arr(1..50);
   task body Flight_Operations is
      airType : TAircraft;
      Rand_Index : Integer;
   begin
      Print.P("[Flight_Operations] Before Init");
      accept Init (R_Catapult : P_Catapult; L_Catapult : P_Catapult) do
         Print.P("[Flight_Operations] Init");
         declare begin
         for I in Jet_Aircraft'Range loop
            Jet_Aircraft(I) := new Aircraft;
            airType := Gen_Rand_Aircraft.Generate;
            if I mod 2 = 0 then
               Jet_Aircraft(I).Init(airType, I, Left_Catapult);
            else
               Jet_Aircraft(I).Init(airType, I, Right_Catapult);
            end if;
         end loop;
         exception
         when others =>
            Print.P("Exception occered at first loop"); 
         end;

         declare begin
         E2DAWACS.Launch (Left_Catapult);
         exception
         when others =>
            Print.P("Exception occered at Launch loop"); 
         end;
         
         declare begin
         for I in Jet_Aircraft'Range loop
            Jet_Aircraft(I).Start_Sortie;
         end loop;
         Print.P ("***** All Aircraft starting sorties *****");
         exception
         when others =>
            Print.P("Exception occered at Second loop"); 
         end;

         declare begin
         for I in 1 .. 8 loop
            Rand_Index := 1 + Gen_Rand_Num.Generate mod 50;
            Jet_Aircraft(Rand_Index).Intercept;
         end loop;
         exception
         when others =>
            Print.P("Exception occered at Third loop"); 
         end;

         declare begin
         E2DAWACS.Recall;
         exception
         when others =>
            Print.P("Exception occered at Recall"); 
         end;
         
      end Init;
   --  exception
   --     when Tasking_Error =>
   --        Print.P("Exception occered at Flight Operations"); 
exception
   when E : others =>
      declare
         use Ada.Exceptions;
         Exception_Text : constant String := Exception_Message(E); -- Pass E directly here
      begin
         Print.P("Exception occered at Flight Operations"); 
         Put_Line("Exception occurred:");
         Put_Line("Message: " & Exception_Text);
      end;
   end Flight_Operations;


begin
   Left_Catapult := new Catapult;
   Right_Catapult := new Catapult;

   Gen_Rand_Aircraft.Init;
   Rand_Intercept_Time.Init;
   Gen_Rand_Num.Init;
   Left_Catapult.Init("Left Catapult");
   Right_Catapult.Init("Right Catapult");
   Flight_Operations.Init(Left_Catapult, Right_Catapult);
exception
   when E : others =>
      declare
         use Ada.Exceptions;
         Exception_Text : constant String := Exception_Message(E); -- Pass E directly here
      begin
         Put_Line("Exception occurred:");
         Put_Line("Message: " & Exception_Text);
      end;
end Main;
