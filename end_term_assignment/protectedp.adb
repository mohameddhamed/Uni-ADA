with Ada.Text_IO;
with Ada.Numerics.Float_Random;
use Ada.Text_IO;

package body ProtectedP is

   protected body Gen_Rand_Num is
      procedure Init is
      begin
         Rand_Integer.Reset(G);
      end Init;

      function Generate return Integer is
      begin
         return Rand_Integer.Random(G);
      end Generate;
   end Gen_Rand_Num;

   protected body Gen_Rand_Aircraft is
      procedure Init is
      begin
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
         Ada.Numerics.Float_Random.Reset(G);
      end Init;

      function Generate return Duration is
      begin
         return Duration(Ada.Numerics.Float_Random.Random(G));
      end Generate;
   end Rand_Intercept_Time;

   protected body Print is
      procedure Print(S: in String := "") is
      begin
         Put_Line(S);
      end Print;
   end Print;

   protected body Catapult is
      procedure Init(S: in String := "") is
      begin
         Name := new String'(S);
         Put_Line("*****" & Name.all & ": initialized *****");
      end Init;

      entry Move_To_Position when Jet_Blast_Ramp_Raised = False is
      begin
         Jet_Blast_Ramp_Raised := True;
         Put_Line("*****" & Name.all & ": Jet Blast Ramp raised *****");
      end;

      entry Launch when Safe_Distance_From_Carrier = True and Jet_Blast_Ramp_Raised is
      begin
         Safe_Distance_From_Carrier := False;
         Jet_Blast_Ramp_Raised := False;
         Put_Line("*****" & Name.all & ": Jet taking off *****");
         Put_Line("*****" & Name.all & ": Jet Blast Ramp lowered *****");
      end;

      entry Clear_From_Carrier when Safe_Distance_From_Carrier = False is
      begin
         Safe_Distance_From_Carrier := True;
      end;
   end Catapult;

   protected body Landing_Strip is
      entry Final_Approach when Aircraft_In_Landing_Sequence = False is
      begin
         Aircraft_In_Landing_Sequence := True;
      end;

      entry Move_To_Parking_Spot when Aircraft_In_Landing_Sequence is
      begin
         null;
      end;
   end Landing_Strip;

begin
   null;
end ProtectedP;
