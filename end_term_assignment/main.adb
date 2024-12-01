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
         when Num_Connected_Aircrafts = 0 => accept Recall;
            Landing_Strip.Final_Approach;
            Print.P("*****E2D-AWACS on Final Approach for Landing*****"); 
            delay 5.0; 
            Landing_Strip.Move_To_Parking_Spot; 
            Print.P("*****E2D-AWACS moving to parking spot*****");
            delay 3.0;
      or
         accept Connect;
         Num_Connected_Aircrafts := Num_Connected_Aircrafts + 1;
         Print.P("*****Aircraft connected to E2D-AWACS: number of aircraft connected " & Num_Connected_Aircrafts'Image & " *****");
      or 
         accept Disconnect;
         Num_Connected_Aircrafts := Num_Connected_Aircrafts - 1;
         Print.P("*****Aircraft disconnected to E2D-AWACS: number of aircraft connected " & Num_Connected_Aircrafts'Image & " *****");

      end select;
   end E2DAWACS; 

   task type Aircraft is
   end Aircraft;

begin
   null;
end Main;
