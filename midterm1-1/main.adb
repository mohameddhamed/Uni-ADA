with Ada.Text_IO, Adjacent_Count;
use Ada.Text_IO;

procedure Main is
    
    type Int_Arr is array (Integer range 1..5) of Integer;
    type Int_Matrix is array (Integer range <>, Integer range <>) of Integer;

    function Is_Even(I: Integer) return Boolean is
    begin
        if I mod 2 = 0 then
            return True;
        end if;
        return False;
    end Is_Even;
--  In demo instantiate the function as `Even_Adjacents`, 
--  which counts how many even neighbours are. Use the following snippet for a matrix M of indexes ( 1 .. 5, 1 .. 5 ):
    function Even_Adjacents is new Adjacent_Count(Integer, Integer, Int_Matrix, Is_Even);
    A : Int_Arr := (1, 2, 3, 4, 5);
    M : Int_Matrix(A'Range, A'Range);
begin
    
    for I in M'range(1) loop
        for J in M'range(2) loop
            M(I, J) := Integer(I * J);
            Ada.Text_IO.Put(Integer'Image(M(I,J)));
        end loop;
        Ada.Text_IO.New_Line;
    end loop;

    Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 1, 1) )); --3
    Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 3, 3) )); --8
    Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 4, 5) )); --3
    Ada.Text_IO.Put( Integer'Image( Even_Adjacents(M, 5, 5) )); --3

end Main;