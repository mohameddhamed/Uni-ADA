with Ada.Text_IO, Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
use Ada.Text_IO;

package ProtectedP is
   type TAircraft is (F35C, FA18D, FA18E);
   package Rand_Integer is new Ada.Numerics.Discrete_Random(Integer);
   package Rand_TAircraft is new Ada.Numerics.Discrete_Random(TAircraft);
   
   protected Gen_Rand_Num is
      procedure Init;
      function Generate return Integer;
   private
      G : Rand_Integer.Generator;
   end Gen_Rand_Num;

   protected Gen_Rand_Aircraft is
      procedure Init;
      function Generate return TAircraft;
   private
      G : Rand_TAircraft.Generator;
   end Gen_Rand_Aircraft;

   protected Rand_Intercept_Time is
      procedure Init;
      function Generate return Duration;
   private
      G : Ada.Numerics.Float_Random.Generator;
   end Rand_Intercept_Time;

   protected Print is
      procedure P(S: in String := "");
   end Print;

   type PStr is access String;
   protected type Catapult is
      procedure Init(S: in String := "");
      entry Move_To_Position; 
      entry Launch; 
      entry Clear_From_Carrier; 
   private
      Safe_Distance_From_Carrier: Boolean := True;
      Jet_Blast_Ramp_Raised: Boolean := False;
      Name : PStr;
   end Catapult;


   protected Landing_Strip is
      entry Final_Approach;
      entry Move_To_Parking_Spot;
   private
      Aircraft_In_Landing_Sequence: Boolean := False;
   end Landing_Strip;
   type P_Catapult is access Catapult;

end ProtectedP;
