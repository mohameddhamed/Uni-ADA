with Ada.Text_IO, Matrix_Pack, Ada.Float_Text_IO;
use Ada.Text_IO, Matrix_Pack, Ada.Float_Text_IO;
procedure Main is
    Value : Float;
    M     : Matrix :=
       ((0.0, 0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0));

begin
    for I in M'Range (1) loop
        for J in M'Range (2) loop
            if J - M'First (2) < 3 then
                Put ("Give the value at position I = " &
                    Index'Image (I - M'First (1)) & " and J = " &
                    Index'Image (J - M'First (2)) & " : ");
                Get (Value);
                M (I, J) := Elem (Value);
            end if;
        end loop;
    end loop;
    PrintMatrix (M);

    Put_Line ("Please input solution :");
    for I in M'Range (1) loop
        Put ("Give the value at position I = " &
            Index'Image (I - M'First (1)) & " : ");
        Get (Value);
        M (I, M'First (2) + 3) := Elem (Value);
    end loop;
    PrintMatrix (M);

    Gaussian_Elimination (M);
    Put_Line ("After Gaussian Elimination :");

    PrintMatrix (M);

end Main;

-- Sample:
--  Give the value at position I =  0 and J =  0 : 2
--  Give the value at position I =  0 and J =  1 : 3
--  Give the value at position I =  0 and J =  2 : 1
--  Give the value at position I =  1 and J =  0 : 4
--  Give the value at position I =  1 and J =  1 : 1
--  Give the value at position I =  1 and J =  2 : 2
--  Give the value at position I =  2 and J =  0 : 3
--  Give the value at position I =  2 and J =  1 : 2
--  Give the value at position I =  2 and J =  2 : 3
--  2.0 3.0 1.0 0.0
--  4.0 1.0 2.0 0.0
--  3.0 2.0 3.0 0.0
--  Please input solution :
--  Give the value at position I =  0 : 1
--  Give the value at position I =  1 : 2
--  Give the value at position I =  2 : 3
--  2.0 3.0 1.0 1.0
--  4.0 1.0 2.0 2.0
--  3.0 2.0 3.0 3.0
--  After Gaussian Elimination :
--  1.0 1.5 0.5 0.5
--  0.0 1.0 -0.0 -0.0
--  0.0 0.0 1.5 1.5
