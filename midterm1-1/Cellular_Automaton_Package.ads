generic
--  First create the `Cellular_Automaton_Package` generic package with the parameters:
--  * `Cell` discrete type to represent cells.
    type Cell is (<>);
--  * `Rule(Cell) -> Cell` function which transforms a cell into a new one.
    with function Rule(C : Cell) return Cell;
package Cellular_Automaton_Package is
--  The package has the `Cellular_Automaton` private record type, `Height` and `Width` positive discriminants. 
--  The record has one field `Board`, which should be implemented using a `Height` times `Width` matrix 
--  (the matrix type should be private, it is indexed by positives and it has `Cell` elements). 
--  The initial value of each field of the matrix of field `Board` should be the first value of the `Cell` type.
    type Cellular_Automaton(Height : Positive; Width : Positive) is private;
    --  type C_Matrix is private;
--  The generic package includes the following procedures:
--  * `Run(Cellular_Automaton, Natural)` executes the number of steps specified by the second parameter on the parameter  automaton. 
--  After each step, it draws the automaton and then waits for half a second (`delay 0.5;`).
    procedure Run(C : Cellular_Automaton; Steps : Natural);
--  * `Iterate(Cellular_Automaton)` applies the rules to the previous state of the automaton and then updates 
--  the state of the parameter automaton with the new values, call this cell trajectory. Make sure to use the state of the previous track!
    procedure Iterate(C : Cellular_Automaton);
--  * `Put(Cellular_Automaton)` prints the trajectory of the automaton. (It is advisable to write a dividing line as well, and a space between elements.)
    procedure Put(C : Cellular_Automaton);


private
    type C_Matrix is array (Positive range <>, Positive range <>) of Cell;

    type Cellular_Automaton(Height : Positive; Width : Positive) is record
        Board : C_Matrix(Positive range 1..Height, Positive range 1..Width);
    end record;

end Cellular_Automaton_Package;