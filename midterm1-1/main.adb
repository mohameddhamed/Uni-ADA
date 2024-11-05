with Ada.Text_IO, Adjacent_Count, Cellular_Automaton_Package;
use Ada.Text_IO;

procedure Main is
    
    type Int_Arr is array (Integer range 1..5) of Integer;
    type Int_Matrix is array (Integer range <>, Integer range <>) of Integer;
    --  type Char_Arr is array (Integer range <>) of Character;
    type Simple_Cell is (O, I);

    --  function Is_Even(I: Integer) return Boolean is
    --  begin
    --      if I mod 2 = 0 then
    --          return True;
    --      end if;
    --      return False;
    --  end Is_Even;

    --  function ToggleCell(C : Simple_Cell) return Simple_Cell is
    --  begin
    --      if C = O then
    --          return I;
    --      end if;
    --      return O;
    --  end ToggleCell;

--  Modify the `Rule` rule so that it expects a `Natural` in addition to the `Cell` parameter, 
--  this will be the result of the above function. Make sure to pass the state of the old matrix to the function!
--  Modify the rule of the main program according to the following logic:
    function ToggleCell(C: Simple_Cell; Alive_Neighbors : Natural) return Simple_Cell is
    begin
        if C = Simple_Cell'Last then
--  * If a cell was alive, then if it had two or three living neighbours, it would remain alive, otherwise it would be dead.
            if Alive_Neighbors = 2 or Alive_Neighbors = 3 then
                return C;
            end if;
            return Simple_Cell'First; -- Dead
        else -- C is Dead
--  * If a cell was dead, then if it had exactly three living neighbours, it should be alive from now on, otherwise it should remain dead.
            if Alive_Neighbors = 3 then
                return Simple_Cell'Last; -- Alive
            end if;
        end if;
        return C;
        
    end ToggleCell;


--  In demo instantiate the function as `Even_Adjacents`, 
--  which counts how many even neighbours are. Use the following snippet for a matrix M of indexes ( 1 .. 5, 1 .. 5 ):
    --  function Even_Adjacents is new Adjacent_Count(Integer, Integer, Int_Matrix, Is_Even);
    --  A : Int_Arr := (1, 2, 3, 4, 5);
    --  M : Int_Matrix(A'Range, A'Range);


    --  package My_Cellular is new Cellular_Automaton_Package(Simple_Cell, ToggleCell);
    --  use My_Cellular;

    --  My_Automaton : Cellular_Automaton(3, 3);

    --  C1 : Coordinate := (X => 1, Y => 1, Value => Simple_Cell'Last);
    --  C2 : Coordinate := (X => 2, Y => 3, Value => Simple_Cell'Last);
    --  InCA : Coordinate_Array (1 .. 2) := (C1, C2);
    --  CA : Cellular_Automaton(3, 3);

    package Automaton is new Cellular_Automaton_Package(Simple_Cell, ToggleCell);
    Config : Automaton.Coordinate_Array := ( (3, 1, I), (3, 2, I), (3, 3, I), (2, 3, I), (1, 2, I));
    CA : Automaton.Cellular_Automaton(10,10);

begin
    
    --  for I in M'range(1) loop
    --      for J in M'range(2) loop
    --          M(I, J) := Integer(I * J);
    --          Ada.Text_IO.Put(Integer'Image(M(I,J)));
    --      end loop;
    --      Ada.Text_IO.New_Line;
    --  end loop;

    --  Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 1, 1) )); --3
    --  Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 3, 3) )); --8
    --  Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 4, 5) )); --3
    --  Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 5, 5) )); --3

    --  Put (My_Automaton);
    --  Run(My_Automaton, 3);

    --  Init(InCA, CA);  Run(CA, 5);
    Automaton.Init(Config, CA); Automaton.Put(CA); Ada.Text_IO.New_Line; Automaton.Run(CA, 3);
end Main;