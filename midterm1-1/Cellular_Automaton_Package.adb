with Ada.Text_IO, Adjacent_Count;
use Ada.Text_IO;

package body Cellular_Automaton_Package is

    function Is_Alive(C: Cell) return Boolean is
    begin
        return C = Cell'Last;
    end Is_Alive;
    function Alive_Adjacents is new Adjacent_Count(Cell, Positive, C_Matrix, Is_Alive);
--  * `Run(Cellular_Automaton, Natural)` executes the number of steps specified by the second parameter on the parameter  automaton. 
--  After each step, it draws the automaton and then waits for half a second (`delay 0.5;`).
    procedure Run(C : in out Cellular_Automaton; Steps : Natural) is 
    begin
        for I in 1..Steps loop
           Put_Line("Step Number: " & I'Image);
           Iterate (C);
           Put(C);
           delay 0.5;
        end loop;
    end Run;
--  * `Iterate(Cellular_Automaton)` applies the rules to the previous state of the automaton and then updates 
--  the state of the parameter automaton with the new values, call this cell trajectory. Make sure to use the state of the previous track!
    procedure Iterate(C : in out Cellular_Automaton) is
        Prev : C_Matrix := C.Board;
        Neighbors_Count : Natural;
    begin
        for I in C.Board'Range(1) loop
            for J in C.Board'Range(2) loop
                Neighbors_Count := Alive_Adjacents(Prev, I, J);
                C.Board(I, J) := Rule(Prev(I, J), Neighbors_Count);
            end loop;
        end loop;
    end Iterate;

--  * `Put(Cellular_Automaton)` prints the trajectory of the automaton. (It is advisable to write a dividing line as well, and a space between elements.)
    procedure Put(C : Cellular_Automaton) is
    begin
        for I in C.Board'Range(1) loop
            for J in C.Board'Range(2) loop
                Put(C.Board(I, J)'Image & " | ");
            end loop;
            --  New_Line; Put_Line("--+---+---|"); 
            New_Line; Put_Line("--+---+---+---+---+---+---+---+---+---|"); 
        end loop;
    end Put;
--  Implement the `Init` procedure (additionally to previous mark 3), 
--  which expects an outgoing `Cellular_Automaton` and an incoming `Coordinate_Array` parameters, 
--  iterates through the latter and assigns the `Value` value to each coordinate.
    procedure Init ( InCA : in Coordinate_Array; OutCA : out Cellular_Automaton ) is
    begin
        for I in InCA'Range loop
            OutCA.Board(InCA(I).X, InCA(I).Y) := InCA(I).Value;
        end loop;
    end Init;
end Cellular_Automaton_Package;