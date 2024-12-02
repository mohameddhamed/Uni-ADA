with ProtectedP;
use ProtectedP;

procedure Main is

   task E2DAWACS is
      entry Launch(c: in out P_Catapult);
      entry Recall;
      entry Connect;
      entry Disconnect;
   end;

   task body E2DAWACS is
      Num_Connected_Aircrafts : Integer := 0;
   begin
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
         end Connect;
      or 
         accept Disconnect do
            Num_Connected_Aircrafts := Num_Connected_Aircrafts - 1;
            Print.P("*****Aircraft disconnected to E2D-AWACS: number of aircraft connected " & Num_Connected_Aircrafts'Image & " *****");
         end Disconnect;

      end select;
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

            airCatapult.Move_To_Position;
            Print.P(airType'Image & "-" & airNum'Image & ": Preparing to Take-off from Catapult."); 
            delay 1.0;

            airCatapult.Launch;
            Print.P(airType'Image & "-" & airNum'Image & ": Taking Off from Catapult."); 
            delay 3.0;

            airCatapult.Clear_From_Carrier;
            Print.P(airType'Image & "-" & airNum'Image & ": Clear from the Carrier."); 
            E2DAWACS.Connect;
            aircraftHasTakenOff := True;
         or 
            accept Intercept;
            
            RandDur := Rand_Intercept_Time.Generate;
            Print.P(airType'Image & "-" & airNum'Image & ": Intercepting an Unidentified Aircraft."); 
            delay RandDur;
            Print.P(airType'Image & "-" & airNum'Image & ": Completed Intercept in – " & RandDur'Image); 
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
            end if;
            
         end select;
         if terminated = True then
            exit;
         end if;
      end loop;
   exception
      when Tasking_Error =>
         Print.P("Exception occered at " & airType'Image & "-" & airNum'Image); 
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
      accept Init (R_Catapult : P_Catapult; L_Catapult : P_Catapult) do
         for I in Jet_Aircraft'Range loop
            Jet_Aircraft(I) := new Aircraft;
            airType := Gen_Rand_Aircraft.Generate;
            if I mod 2 = 0 then
               Jet_Aircraft(I).Init(airType, I, Left_Catapult);
            else
               Jet_Aircraft(I).Init(airType, I, Right_Catapult);
            end if;
         end loop;

         E2DAWACS.Launch (Left_Catapult);
         for I in Jet_Aircraft'Range loop
            Jet_Aircraft(I).Start_Sortie;
         end loop;
         Print.P ("***** All Aircraft starting sorties *****");

         for I in 1 .. 8 loop
            Rand_Index := 1 + Gen_Rand_Num.Generate mod 50;
            Jet_Aircraft(Rand_Index).Intercept;
         end loop;

         E2DAWACS.Recall;
      end Init;
   exception
      when Tasking_Error =>
         Print.P("Exception occered at Flight Operations"); 
   end Flight_Operations;


begin
   Gen_Rand_Aircraft.Init;
   Rand_Intercept_Time.Init;
   Gen_Rand_Num.Init;
   Left_Catapult.Init("Left Catapult");
   Right_Catapult.Init("Right Catapult");
   Flight_Operations.Init(Left_Catapult, Right_Catapult);
end Main;
