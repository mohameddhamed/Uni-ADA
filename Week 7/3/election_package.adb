with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package body Election_Package is

   --Grade 2
   procedure Initialize_Regional_Votes(E: in out Election) is
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
            
            
   procedure Finalize_Votes(E: in out Election) is
      S: Integer := 0;
   begin
      for I in E.Final_Votes'Range loop
         S := 0;
         for J in E.Regional_Votes'Range(1) loop
            for K in E.Regional_Votes'Range(2) loop
               if I = K then
                  S := S + E.Regional_Votes(J, K);
               end if;
            end loop;
         end loop;
         E.Final_Votes(I) := S;
      end loop;
   end Finalize_Votes;
      
      
   function Final_Vote_Of_Candidate(E: Election; C: Candidates) return Integer is
   begin
      return E.Final_Votes(C);
   end Final_Vote_Of_Candidate;
   
      
   function Regional_Vote_Of_Candidates(E: Election; R: Regions; C: Candidates) return Integer is
   begin
      return E.Regional_Votes(R, C);
   end Regional_Vote_Of_Candidates;
   
   
   --Grade 3
   function Find_First_Place (E : Election) return Candidates is
   begin
      return Find_N_Th_Place(E, 1);
   end Find_N_Th_Place;
   
      
   function Find_Last_Place (E : Election) return Candidates is
   begin
      return Find_N_Th_Place(E, E.Count);
   end Find_Last_Place;
   
      
   function Find_N_th_Place (E : Election; N : Integer) return Candidates is
      type T_Array is array(Integer range <>) of Integer;
      T1: T_Array(1..E.Count);
      Pointer: Integer := 0;
      Nth: Integer;
      
      procedure Bubble_Sort(A: in out T_Array) is
         Finished: Boolean;
         Temp: Integer;
      begin
         loop
            Finished := True;
            for J in A'First..Integer'Pred(A'Last) loop
               if A(Integer'Succ(J)) > A(J) then
                  Finished := False;
                  Temp := A(Integer'Succ(J));
                  A(Integer'Succ(J)) := A(J);
                  A(J) := Temp;
               end if;
            end loop
            exit when Finished;
         end loop;
      end Bubble_Sort;
      
   begin
      for I in E.Final_Votes'Range loop
         Pointer := Pointer + 1;
         T1(Pointer) := E.Final_Votes(I);
      end loop;
      
      Bubble_Sort(T1);
      Nth := T1(N);
      for I in E.Final_Votes'Range loop
         if E.Final_Votes(I) = Nth then
            return I;
         end if;
      end loop;
      return Candidates'First;
   end Find_N_Th_Place;
      
      
   function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean is
      Cand1: Integer := E.Final_Votes(C1);
      Cand2: Integer := E.Final_Votes(C2);
   begin
      return Cand1 > Cand2;
   end Compare_Candidates;
   

end Election_Package;
