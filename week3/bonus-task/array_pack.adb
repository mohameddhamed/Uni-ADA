with Ada.Text_IO, Matrix_Pack;
use Ada.Text_IO, Matrix_Pack;
package body Array_Pack is
    procedure PrintArr (A : in Arr) is
    begin
        for I in A'Range loop
            Put_Line (Elem'Image (A (I)));
        end loop;
    end PrintArr;
end Array_Pack;
