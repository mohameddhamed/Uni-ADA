with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Numerics.Float_Random;
use Ada.Text_IO;

package body ProtectedP is

   protected body Gen_Rand_Num is
      procedure Init is
      begin
         Print.P("[Gen_Rand_Num] Init");
         Rand_Integer.Reset(G);
      end Init;

      function Generate return Integer is
      begin
         return Integer(Rand_Integer.Random(G));
      end Generate;
   end Gen_Rand_Num;

   protected body Gen_Rand_Aircraft is
      procedure Init is
      begin
         Print.P("[Gen_Rand_Aircraft] Init");
         Rand_TAircraft.Reset(G);
      end Init;

      function Generate return TAircraft is
      begin
         return Rand_TAircraft.Random(G);
      end Generate;
   end Gen_Rand_Aircraft;

   protected body Rand_Intercept_Time is
      procedure Init is
      begin
         Print.P("[Rand_Intercept_Time] Init");
         Ada.Numerics.Float_Random.Reset(G);
      end Init;

      function Generate return Duration is
         Random_Value : Float := Ada.Numerics.Float_Random.Random(G);
      begin
         return Duration(Random_Value * 5.0 + 10.0);
      end Generate;
   end Rand_Intercept_Time;

   protected body Print is
      procedure P(S: in String := "") is
      begin
         Put_Line(S);
      end P;
   end Print;

   protected body Catapult is
      procedure Init(S: in String := "") is
      begin
         Name := new String'(S);
         Print.P("*****" & Name.all & ": initialized *****");
      
      exception
      when others =>
         Print.P("Exception occered at Catapult Init"); 
      end Init;

      entry Move_To_Position when Jet_Blast_Ramp_Raised = False is
      begin
         Jet_Blast_Ramp_Raised := True;
         Print.P("*****" & Name.all & ": Jet Blast Ramp raised *****");
      exception
      when others =>
         Print.P("Exception occered at Catapult Move to position"); 
      end;

      entry Launch when Safe_Distance_From_Carrier = True and Jet_Blast_Ramp_Raised is
      begin
         Safe_Distance_From_Carrier := False;
         Jet_Blast_Ramp_Raised := False;
         Print.P("*****" & Name.all & ": Jet taking off *****");
         Print.P("*****" & Name.all & ": Jet Blast Ramp lowered *****");
      end;

      entry Clear_From_Carrier when Safe_Distance_From_Carrier = False is
      begin
         Print.P("*****" & Name.all & ": Clearing from Carrier*****");
         Safe_Distance_From_Carrier := True;
      exception
      when others =>
         Print.P("Exception occered at Catapult Clear From Carrier"); 
      end;
   end Catapult;

   protected body Landing_Strip is
      entry Final_Approach when Aircraft_In_Landing_Sequence = False is
      begin
         Aircraft_In_Landing_Sequence := True;
      end;

      entry Move_To_Parking_Spot when Aircraft_In_Landing_Sequence is
      begin
         Aircraft_In_Landing_Sequence := False;
      end;
   end Landing_Strip;

begin
   null;
end ProtectedP;
