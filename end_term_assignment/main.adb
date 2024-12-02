with ProtectedP;
use ProtectedP;

procedure Main is

   task E2DAWACS is
      entry Launch(c: in out Catapult);
      entry Recall;
      entry Connect;
      entry Disconnect;
   end;

   task body E2DAWACS is
      Num_Connected_Aircrafts : Integer := 0;
   begin
      select
         accept Launch(c: in out Catapult) do
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
   end Aircraft;

   type P_Aircraft is access Aircraft;
   type P_Aircraft_Arr  is array(Positive range <>) of P_Aircraft;
   Jet_Aircraft : P_Aircraft_Arr(1..50);


begin
   null;
end Main;
