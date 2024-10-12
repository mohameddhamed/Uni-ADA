with Ada.Text_IO, Bagp, Ada.Command_Line;
use Ada.Text_IO, Bagp;

procedure Bag_demo is

    N       : Positive := 3;
    E       : Elem;
    B       : Bag;
    numbers : Arr (1 .. Index (N));

begin

    for I in 1 .. Ada.Command_Line.Argument_Count loop
        E := Elem'Value (Ada.Command_Line.Argument (I));
        insert_one (B, E);
        Put_Line (Elem'Image (E));
    end loop;

    Put_Line ("Inserting complete");

    while not IsEmpty (B) loop
        E := extract_one (B);
        Put_Line (Elem'Image (E));
    end loop;

    insert_multiple (B, 11, 5);
    numbers := extract_multiple (B, N);

    --  while not IsEmpty (B) loop
    --      E := extract_one (B);
    --      Put_Line (Elem'Image (E));
    --  end loop;

    for I in numbers'Range loop
        Put_Line (Elem'Image (numbers (I)));
    end loop;

    Put_Line ("Extraction Complete");
    print (B);

end Bag_demo;
