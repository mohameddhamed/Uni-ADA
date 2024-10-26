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
   function Find_First_Place(E: Election) return Candidates is
   begin
      return Find_Nth_Place(E, 1);
   end Find_First_Place;
   
   
   function Find_Last_Place(E: Election) return Candidates is
   begin
      return Find_Nth_Place(E, E.Count);
   end Find_Last_Place;
   
   
   function Find_Nth_Place(E: Election; N: Integer) return Candidates is
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
            end loop;
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
   end Find_Nth_Place;
   
      
   function Compare_Candidates(E: Election; C1: Candidates; C2: Candidates) return Boolean is
      Cand1: Integer;
      Cand2: Integer;
   begin
      Cand1 := E.Final_Votes(C1);
      Cand2 := E.Final_Votes(C2);
      return Cand1 > Cand2;
   end Compare_Candidates;
   
   
   --Grade 4
   function Calculate_Percentage_Of_Candidate(E: Election; C: Candidates) return Float is
      Percent: Float;
      Total: Integer := 0;
      C_Val: Integer := E.Final_Votes(C);
   begin
      for I in E.Final_Votes'Range loop
         Total := Total + E.Final_Votes(I);
      end loop;
      Percent := Float(C_Val) / Float(Total);
      return Percent * 100.0;
   end Calculate_Percentage_Of_Candidate;
   
      
   function Calculate_Regional_Percentage_Of_Candidate(E: Election; R: Regions; C: Candidates) return Float is
      Percent: Float;
      Total: Integer := 0;
      C_Val: Integer := E.Regional_Votes(R, C);
   begin
      for I in E.Regional_Votes'Range(2) loop
         Total := Total + E.Regional_Votes(R, I);
      end loop;
      Percent := Float(C_Val) / Float(Total);
      return Percent * 100.0;
   end Calculate_Regional_Percentage_Of_Candidate;
   
      
   procedure Print(E: Election; B: Boolean := True) is
      V: Integer;
   begin
      if B then
         Put_Line("Regional Vote Results:");
         for I in E.Regional_Votes'Range(1) loop
            Put_Line("Region: " & I'Image);
            
            for J in E.Regional_Votes'Range(2) loop
               V:= E.Regional_Votes(I, J);
               Put("Candidate: " & J'Image & " - " & V'Image & ",");
            end loop;
            New_Line;
         end loop;
      else
         Put_Line("Final Vote Results:");
         for I in E.Final_Votes'Range loop
            V := E.Final_Votes(I);
            Put_Line("Candidate: " & I'Image & " - " & V'Image);
         end loop;
      end if;
   end Print;
   
   --Grade 5
   procedure For_Each ( E : in out Election; R : Regions ) is
      S: Integer;
   begin
      for I in E.Regional_Votes'Range(2) loop
         S := Action(E.Regional_Votes(R, I));
         E.Regional_Votes(R, I) := S;
      end loop;
   end For_Each;

end Election_Package;
