with Ada.Text_IO, QueueP, Ada.Command_Line;
use Ada.Text_IO, QueueP;

procedure Exercise22 is
   
   E: Integer;
   Q: Queue(Ada.Command_Line.Argument_Count);
   
begin
   
   for I in 1..Ada.Command_Line.Argument_Count loop
      E := Integer'Value(Ada.Command_Line.Argument(I));
      Enqueue(Q, E);
      Put_Line(Integer'Image(E));
   end loop;
   
   Put_Line("Enqueue complete");
   
   while not Is_Empty(Q) loop
      Dequeue(Q, E);
      Put_Line(Integer'Image(E));
   end loop;   
   
end Exercise22;
