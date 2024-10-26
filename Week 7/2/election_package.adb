with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package body Election_Package is
   
   --Grade 2
   procedure Initialize_Regional_Votes (E : in out Election) is
      type NewInt is new Integer range 0..50;
      package Rand_Votes is new Ada.Numerics.Discrete_Random(NewInt);
      G: Rand_Votes.Generator;
      Random_Vote: NewInt;
   begin
      Rand_Votes.Reset(G);
      
      for I in E.Regional_Votes'Range(1) loop
         for J in E.Regional_Votes'Range(2) loop
            Random_Vote := Rand_Votes.Random(G);
            E.Regional_Votes(I, J) := Integer(Random_Vote);
         end loop;
      end loop;
   end Initialize_Regional_Votes;
   
      
   procedure Finalize_Votes (E : in out Election) is
      S: Integer := 0;
   begin
      for I in E.Final_Votes'Range loop
         S:= 0;
         for J in E.Regional_Votes'Range(1) loop
            S := S + E.Regional_Votes(J,I);
         end loop;
         E.Final_Votes(I) := S;
      end loop;
   end Finalize_Votes;
   
      
   function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer is
   begin
      return E.Final_Votes(C);
   end Final_Vote_Of_Candidate;
   
   
   function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer is
   begin
      return E.Regional_Votes(R, C);
   end Regional_Vote_Of_Candidate;
      

end Election_Package;
