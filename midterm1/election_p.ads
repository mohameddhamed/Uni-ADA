generic

--  discrete type `Candidates` (type will be enum representing several candidates of election)
    type Candidates is (<>);

--  discrete type `Regions` (type will be enum representing several areas of country for example like Budapest, Debrecen so on)
    type Regions is (<>);
    
package Election_P is
--  Implement `Election` limited private type with a discriminant `Count` of type Integer which will represent number of `Candidates`. The record has two private typed fields:
--  * `Regional_Votes` -> matrix type with `Regions` and `Candidates` indexes and Integer elements. This will represent the votes for each candidate from different regions.

--  * `Final_Votes` -> array of Integer with index of `Candidates`. This will represent final votes result based on regional votes. Initially all of the final votes are 0.
    type Election(Count : Integer) is limited private;
--  * Implement `Initialize_Regional_Votes` operation which fills `Regional_Votes` matrix with random integers between 0 and 50. Random generating example can be found below.
    procedure Initialize_Regional_Votes(E : in out Election);

--  * Implement `Finalize_Votes` operation which fills `Final_Votes` array based on calculations from each region according to candidates. For example: Rasul got 10 votes from each region, and if we have 5 regions then total should be 50.
    procedure Finalize_Votes (E : in out Election);

--  * Implement `Final_Vote_Of_Candidate` operation which will return the given candidateâ€™s total votes.
    function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer;

--  * Implement `Regional_Vote_Of_Candidate` operation which will return regional votesâ€™ number based on the given region and candidate parameters.
    function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer;

--  * Implement `Find_First_Place` operation which will return the candidate who has the most total votes.

    function Find_First_Place (E : Election) return Candidates;

--  * Implement `Find_Last_Place` operation which will return the candidate who has the least total votes.

    function Find_Last_Place (E : Election) return Candidates;

--  * Implement `Find_N_th_Place` operation which will return candidate who has the nth most total votes.

    function Find_N_th_Place (E : Election; N : Integer) return Candidates;

--  * Implement `compare_Candidates` will return true if C1's total votes will be greater than C2's total votes, false otherwise

    function compare_Candidates (E : Election; C1 : Candidates; C2 : Candidates) return Boolean;

--  For Grade 4:

--  * Implement `Calculate_Percentage_Of_Candidate` operation which will return float percentage for a candidate total votes over all votes around election.

    function Calculate_Percentage_Of_Candidate (E : Election; C : Candidates) return Float;

--  * Implement `Calculate_Regional_Percentage_Of_Candidate` operation which will return float percentage for a candidate of a specific region.

    function Calculate_Regional_Percentage_Of_Candidate (E : Election; R : Regions; C : Candidates) return Float;

--  * Implement `Print` operation which will print regional votes if B is true, otherwise print total votes.

    procedure Print (E : Election; B : Boolean := True);

    procedure Print_Detailed (E : Election);
    --  For Grade 5:

--  Add the following operations to the previous marks:

--  * Create a generic procedure `ForEach` inside the package 
--  with a region parameter, which performs an Action function parameter 
--  on the Region parameter and every candidate of the `Regional_Votes`. 
--  For example, if the Region is Budapest and the action 
--  is decreasing votes by 10 (this is the actual Action in the main program), 
--  then for all the votes of each candidate in the region Budapest, 
--  it should be decreased by 10.

    generic
        with function Process_Element(I : Integer) return Integer;
    procedure For_Each(E : in out Election; R : in Regions);

--  * In the demo

--  ** Create a function my_action which takes an integer and returns it subtracted by 10. If votes go below 0, assign 0 to it.

--  ** Instantiate my_ForEach using my_action function and test it extensively on the Elections.

private

    type Regional_Votes_Arr is array (Regions, Candidates) of Integer;
    type Final_Vote_Arr is array (Candidates) of Integer;
    type Int_Arr is array (Integer range <>) of Integer;
    type Candidate_Arr is array (Integer range <>) of Candidates;

    procedure Bubble_Sort(A : in out Int_Arr); 
    function Total_Region_Votes(E: Election; R : Regions) return Integer;
    function Total_Votes(E: Election) return Integer;
    --  procedure Swap(A : in out Final_Vote_Arr; I, J : Candidates);
    procedure Swap(C1, C2 : in out Integer);
    procedure Print_Detailed (A: Final_Vote_Arr);

    type Election(Count : Integer) is record
        -- change range <> to range 1..Count for Candidates
        Regional_Votes : Regional_Votes_Arr;
        Final_Votes : Final_Vote_Arr := (others => 0);
    end record;
end Election_P;