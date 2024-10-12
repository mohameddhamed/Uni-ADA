with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;

package body Matrix_Pack is
    procedure PrintMatrix (M : in Matrix) is
    begin
        for I in M'Range (1) loop
            for J in M'Range (2) loop
                PrintElem (M (I, J));
                Put (' ');
            end loop;
            New_Line;
        end loop;
    end PrintMatrix;
    procedure Gaussian_Elimination (M : in out Matrix) is

        Pivot      : Elem;
        Multiplier : Elem;

        RowStart : Index := M'First (1);
        RowEnd   : Index := M'Last (1);
        ColEnd   : Index := M'Last (2);
    begin

        for I in RowStart .. Index'Pred (RowEnd) loop

            Pivot := M (I, I);

            for J in I .. ColEnd loop
                M (I, J) := M (I, J) / Pivot;
            end loop;

            for K in Index'Succ (I) .. Index'Pred (ColEnd) loop
                Multiplier := M (K, I);
                for J in I .. ColEnd loop
                    M (K, J) := M (K, J) - Multiplier * M (I, J);
                end loop;
            end loop;

        end loop;

    end Gaussian_Elimination;

    function "*" (E : Elem; M : Matrix) return Matrix is
        C : Matrix (M'Range (1), M'Range (2));
    begin
        for I in M'Range (1) loop
            for J in M'Range (2) loop
                C (I, J) := E * M (I, J);
            end loop;
        end loop;
        return C;
    end "*";

    procedure PrintElem (E : Elem) is
    begin
        Put (Float (E), Fore => 1, Aft => 1, Exp => 0);
    end PrintElem;

end Matrix_Pack;
