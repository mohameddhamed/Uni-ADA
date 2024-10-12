with Ada.Text_IO, QueueP;
use Ada.Text_IO, QueueP;

package body Bagp is

    procedure insert_one (B : in out Bag; E : Elem) is
    begin
        Enqueue (B.Content, E);
    end insert_one;

    procedure insert_multiple (B : in out Bag; E : Elem; N : Positive) is
    begin
        for I in 1 .. N loop
            Enqueue (B.Content, E);
        end loop;
    end insert_multiple;

    function extract_one (B : in out Bag) return Elem is
        E : Elem;
    begin
        Dequeue (B.Content, E);
        return E;
    end extract_one;

    function extract_multiple (B : in out Bag; N : Positive) return Arr is
        res : Arr (Index (1) .. Index (N));
        E   : Elem;
    begin
        for I in res'Range loop
            if not IsEmpty (B) then
                Dequeue (B.Content, E);
                res (I) := E;
            end if;
        end loop;
        return res;
    end extract_multiple;

    procedure print (B : in out Bag) is
        E : Elem;
    begin
        for I in 1 .. Size (B.Content) loop
            Dequeue (B.Content, E);
            Put_Line (Elem'Image (E));
        end loop;
    end print;

    function IsEmpty (B : Bag) return Boolean is
    begin
        return Is_Empty (B.Content);
    end IsEmpty;

end Bagp;
