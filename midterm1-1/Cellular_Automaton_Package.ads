generic
--  First create the `Cellular_Automaton_Package` generic package with the parameters:
--  * `Cell` discrete type to represent cells.
    type Cell is (<>);
--  * `Rule(Cell) -> Cell` function which transforms a cell into a new one.
    --  with function Rule(C : Cell) return Cell;
    with function Rule(C : Cell; N : Natural) return Cell;
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
    procedure Run(C : in out Cellular_Automaton; Steps : Natural);
--  * `Iterate(Cellular_Automaton)` applies the rules to the previous state of the automaton and then updates 
--  the state of the parameter automaton with the new values, call this cell trajectory. Make sure to use the state of the previous track!
    procedure Iterate(C : in out Cellular_Automaton);
--  * `Put(Cellular_Automaton)` prints the trajectory of the automaton. (It is advisable to write a dividing line as well, and a space between elements.)
    procedure Put(C : Cellular_Automaton);

--  We will need to initialize the fields, let's implement this in the following way: 
--  define 2 public types: `Coordinate' type and `Coordinate_Array` in the generic package `Cellular_Automaton_Package`.
--  Implement the public `Coordinate' type, which is a three-field record. 
--  Its fields are the positive integers `X`, `Y`, and a `Value` field, which indicates what value should take on this coordinate.
    type Coordinate is record
        X : Positive;
        Y : Positive;
        Value : Cell;
    end record;
--  The `Coordinate_Array` array type is an array of `Coordinate` type values, with indefinite positive indexing.
    type Coordinate_Array is array (Positive range <>) of Coordinate;
--  Implement the `Init` procedure (additionally to previous mark 3), 
--  which expects an outgoing `Cellular_Automaton` and an incoming `Coordinate_Array` parameters, 
--  iterates through the latter and assigns the `Value` value to each coordinate.
    procedure Init ( InCA : in Coordinate_Array; OutCA : out Cellular_Automaton );

private
    type C_Matrix is array (Positive range <>, Positive range <>) of Cell;

    type Cellular_Automaton(Height : Positive; Width : Positive) is record
        Board : C_Matrix(Positive range 1..Height, Positive range 1..Width) := (others => (others => Cell'First));
    end record;

end Cellular_Automaton_Package;