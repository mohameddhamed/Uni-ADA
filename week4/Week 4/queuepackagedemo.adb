with Ada.Text_IO, QueuePackage, Ada.Command_Line;
use Ada.Text_IO, QueuePackage;

procedure QueuePackageDemo is
    E : Elem;
    Q : MyQueue (Index (Ada.Command_Line.Argument_Count));

begin
    for I in 1 .. Ada.Command_Line.Argument_Count loop
        E := Elem'Value (Ada.Command_Line.Argument (I));
        Enqueue (Q, E);
        Put_Line (Elem'Image (E));
    end loop;

    Put_Line ("Enqueue complete");

    while not Is_Empty (Q) loop
        Dequeue (Q, E);
        Put_Line (Elem'Image (E));
    end loop;

end QueuePackageDemo;
