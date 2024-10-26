generic
   type Candidates is (<>);
   type Regions is (<>);
package Election_Package is
   
   type Election(Count: Integer) is limited private;
   
   --Grade 2
   procedure Initialize_Regional_Votes (E : in out Election);
   procedure Finalize_Votes (E : in out Election);
   function Final_Vote_Of_Candidate(E : Election; C : Candidates) return Integer;
   function Regional_Vote_Of_Candidate(E : Election; R : Regions; C : Candidates) return Integer;
   
private
   
   type Regional_Vote_Arr is array(Regions, Candidates) of Integer;
   type Vote_Arr is array(Candidates) of Integer;
   
   type Election(Count: Integer) is record
      Regional_Votes: Regional_Vote_Arr;
      Final_Votes: Vote_Arr := (others => 0);
   end record;
   
end Election_Package;
