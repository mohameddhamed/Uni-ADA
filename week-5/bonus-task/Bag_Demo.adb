with Generic_Bag, Ada.Command_Line, Ada.Integer_Text_IO, QueueP;
-- Declare the main demo procedure
procedure Bag_Demo is

    -- Instantiate the Queue package with Integer as the element type and Natural as the index type
    package Integer_Queue is new QueueP (Index => Natural, Elem => Integer);

    -- Instantiate the Bag package using the above Queue
    package Integer_Bag is new Generic_Bag
       (Index => Natural, Elem => Integer, QueueP => Integer_Queue);
    use Integer_Bag;

    -- Create a Bag object with the size equal to the number of command line arguments
    My_Bag : Bag :=
       (Queue => Integer_Queue.Queue (Ada.Command_Line.Argument_Count));

    -- Declare variables for processing
    N       : Integer;
    Success : Boolean;

begin
    -- Insert each command-line argument into the bag
    for I in 1 .. Ada.Command_Line.Argument_Count loop
        N := Integer'Value (Ada.Command_Line.Argument (I));
        Insert_One (My_Bag, N);
    end loop;

    -- Extract and display elements until the bag is empty
    while not Is_Empty (My_Bag) loop
        Extract_One (My_Bag, N, Success);
        if Success then
            Ada.Integer_Text_IO.Put_Line ("Extracted: " & Integer'Image (N));
        end if;
    end loop;

    -- Check if the bag is empty
    if Is_Empty (My_Bag) then
        Ada.Integer_Text_IO.Put_Line ("The bag is now empty.");
    else
        Ada.Integer_Text_IO.Put_Line ("There are still elements in the bag.");
    end if;

end Bag_Demo;
