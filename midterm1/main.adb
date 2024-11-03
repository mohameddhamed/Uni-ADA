with Ada.Text_IO, Election_P;
use Ada.Text_IO;

--  * In a demo program instantiate the package with these types:

--  ** type Candidates is (Rasul, Bill, Jill, Will, Nill);

--  ** type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);

--  * For each mark illustrate and test extensively the operations of the specific mark (keep also the previous marks' tests).

procedure Main is
    type Candidates is (Rasul, Bill, Jill, Will, Nill); 
    type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);
    package My_Election is new Election_P(Candidates, Regions);
    use My_Election;
    E : Election(5);
    First : Candidates;

--  * In the demo

--  ** Create a function my_action which takes an integer 
--  and returns it subtracted by 10. If votes go below 0, assign 0 to it.
    function my_action(V : Integer) return Integer is
        I : Integer := V - 10; 
    begin
        if I < 0 then
            return 0;
        end if;
        return I;
    end my_action;
--  ** Instantiate my_ForEach using my_action function and 
--  test it extensively on the Elections.
    procedure my_ForEach is new For_Each(my_action);
begin
    Put_Line("Hello World");

    Initialize_Regional_Votes (E);
    Print (E, True);
    Print (E, False);
    Finalize_Votes (E);
    Print_Detailed (E);
    First := Find_First_Place(E);
    Put_Line("First Place: "& First'Image);
    Put_Line("Last Place: "& Find_Last_Place(E)'Image);
    Put_Line("Third Place: "& Find_N_th_Place(E, 3)'Image);
    Put_Line("Percentage of Rasul: " & Calculate_Percentage_Of_Candidate (E, Rasul)'Image);
    Put_Line("Regional Percentage of Nill in Gyor: " & Calculate_Regional_Percentage_Of_Candidate (E, Gyor, Nill)'Image);
    my_ForEach(E, Gyor);
    Put_Line("Gyor's votes should decrease by 10 * Number of Candidates (5)");
    Print (E, True);
    Print (E, False);

    Put_Line("Before Finalization");
    Print_Detailed(E);
    Put_Line("After Finalization");
    Finalize_Votes (E);
    Print_Detailed(E);
    
end Main;