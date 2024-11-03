with Ada.Numerics.Discrete_Random, Ada.Integer_Text_IO, Ada.Text_IO;

use Ada.Integer_Text_IO, Ada.Text_IO;

package body Election_P is

    subtype NewInt is Integer range 0..50;
    package Random_int is new Ada.Numerics.Discrete_Random (NewInt);
    G : Random_int.Generator;
    
--  * Implement `Initialize_Regional_Votes` operation which fills `Regional_Votes` matrix with random integers between 0 and 50. Random generating example can be found below.
    procedure Initialize_Regional_Votes(E : in out Election) is
    begin
        Random_int.Reset(G);

        for I in E.Regional_Votes'Range(1) loop
            for J in E.Regional_Votes'Range(2) loop
                E.Regional_Votes(I, J) := Random_int.Random(G);
            end loop;
        end loop;
    end Initialize_Regional_Votes;

--  * Implement `Finalize_Votes` operation which fills `Final_Votes` array based on calculations from each region according to candidates. 
--  For example: Rasul got 10 votes from each region, and if we have 5 regions then total should be 50.
    procedure Finalize_Votes (E : in out Election) is
    begin
        for C in E.Regional_Votes'Range(2) loop
            E.Final_Votes(C) := Final_Vote_Of_Candidate (E, C);
        end loop;
    end Finalize_Votes;

--  * Implement `Final_Vote_Of_Candidate` operation which will return the given candidateâ€™s total votes.
    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer is
        Final_Vote : Integer := 0;
    begin
        for Region in E.Regional_Votes'Range(1) loop
            Final_Vote := Final_Vote + Regional_Vote_Of_Candidate(E, Region, C);
        end loop;
        return Final_Vote;
    end Final_Vote_Of_Candidate;

--  * Implement `Regional_Vote_Of_Candidate` operation which will return regional votesâ€™ number based on the given region and candidate parameters.
    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer is
    begin
        return E.Regional_Votes(R, C);
    end Regional_Vote_Of_Candidate;

--  * Implement `Find_First_Place` operation which will return the candidate who has the most total votes.

    function Find_First_Place (E : Election) return Candidates is
    begin
        return Find_N_th_Place (E, 1);
    end Find_First_Place;

--  * Implement `Find_Last_Place` operation which will return the candidate who has the least total votes.

    function Find_Last_Place (E : Election) return Candidates is
    begin
        return Find_N_th_Place (E, E.Count);
    end Find_Last_Place;

--  * Implement `Find_N_th_Place` operation which will return candidate who has the nth most total votes.

    function Find_N_th_Place (E : Election; N : Integer) return Candidates is
        Candidate : Candidates;
        Final_Votes_Array : Int_Arr(1..E.Count);
    begin
        Candidate := E.Final_Votes'First;

        for I in 1..E.Count - 1 loop 
            Final_Votes_Array(I) := Final_Vote_Of_Candidate(E, Candidate);
            Candidate := Candidates'Succ(Candidate);
        end loop;
        Final_Votes_Array(E.Count) := Final_Vote_Of_Candidate(E, Candidate);

        Bubble_Sort (Final_Votes_Array);

        for C in E.Final_Votes'Range loop
            if Final_Vote_Of_Candidate(E, C) = Final_Votes_Array(N) then 
                return C;
            end if;
        end loop;
        return Candidate;
    end Find_N_th_Place;

--  * Implement `compare_Candidates` will return true if C1's total votes will be greater than C2's total votes, false otherwise

    function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean is
    begin
        return Final_Vote_Of_Candidate (E, C1) > Final_Vote_Of_Candidate (E, C2);
    end compare_Candidates;


    procedure Bubble_Sort(A : in out Int_Arr) is 
        Finished : Boolean;
    begin
        loop
            Finished := True;
            for I in A'First..Integer'Pred(A'Last) loop
                if A(I) < A(Integer'Succ(I)) then
                    Swap(A(I), A(Integer'Succ(I)));
                    Finished := False;
                end if; 
            end loop;
            if Finished then
                exit;
            end if;
        end loop;
    end Bubble_Sort;

    procedure Swap(C1, C2 : in out Integer) is
        Temp : Integer := C1;
    begin
        C1 := C2;
        C2 := Temp;
    end Swap;

--  * Implement `Calculate_Percentage_Of_Candidate` operation which will return float percentage for a candidate total votes over all votes around election.

    function Calculate_Percentage_Of_Candidate (E : Election; C : Candidates) return Float is
    begin
        return 100.0 * (Float(Final_Vote_Of_Candidate(E, C)) / Float(Total_Votes(E)));

    end Calculate_Percentage_Of_Candidate;

--  * Implement `Calculate_Regional_Percentage_Of_Candidate` operation which will return float percentage for a candidate of a specific region.

    function Calculate_Regional_Percentage_Of_Candidate (E : Election; R : Regions; C : Candidates) return Float is
    begin
        return 100.0 * (Float(Regional_Vote_Of_Candidate (E, R, C)) / Float(Total_Region_Votes(E, R)));
    end Calculate_Regional_Percentage_Of_Candidate;

    function Total_Region_Votes(E: Election; R : Regions) return Integer is
        R_Vote : Integer := 0;
    begin
        for Candidate in E.Regional_Votes'Range(2) loop
            R_Vote := R_Vote + Regional_Vote_Of_Candidate (E, R, Candidate);
        end loop;
        return R_Vote;
    end Total_Region_Votes;

    function Total_Votes(E: Election) return Integer is
        R_Vote : Integer := 0;
    begin
        for Region in E.Regional_Votes'Range(1) loop
            R_Vote := R_Vote + Total_Region_Votes(E, Region);
        end loop;
        return R_Vote;
    end Total_Votes;
--  * Implement `Print` operation which will print regional votes if B is true, otherwise print total votes.

    procedure Print (E : Election; B : Boolean := True) is 
        R_Votes : Integer;
    begin
        if B then
            for R in E.Regional_Votes'Range(1) loop
                R_Votes := Total_Region_Votes (E, R);
                Put_Line("Region: " & R'Image & " has: " & R_Votes'Image);
            end loop;
        else
            R_Votes := Total_Votes(E);
            Put_Line("Total Votes are: " & R_Votes'Image);
        end if;
    end Print;

    procedure Print_Detailed (A: Final_Vote_Arr) is 
    begin
        for Candidate in A'Range loop
            Put_Line(Candidate'Image & " has: " & A(Candidate)'Image);
        end loop;
    end Print_Detailed;

    procedure Print_Detailed (E : Election) is 
    begin
        Print_Detailed (E.Final_Votes);
    end Print_Detailed;

    --  function Get_Candidates(E: Election; R : Regions) return Candidate_Arr is
    --      C_Arr : Candidate_Arr := 
    --  begin
    --      for Region in E'Range(1) loop
    --          for Candidate in E'Range(2) loop
    --              if Region = R then 

    --              end if;
    --          end loop;
    --      end loop;
    --  end Get_Candidates;

    procedure For_Each(E : in out Election; R : in Regions) is
    --     Candidates_in_Region : Candidate_Arr := Get_Candidates(E, R);
       C_Vote : Integer;
    begin
        for C in E.Regional_Votes'Range(2) loop
            C_Vote := Process_Element (E.Regional_Votes(R, C));
            E.Regional_Votes(R, C) := C_Vote;
        end loop;

    end For_Each;

end Election_P;
