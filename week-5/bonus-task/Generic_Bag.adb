package body Generic_Bag is

    -- Insert a single element into the bag
    procedure Insert_One (B : in out Bag; E : in Elem) is
    begin
        QueueP.Enqueue (B.Queue, E);
    end Insert_One;

    -- Insert multiple copies of an element into the bag
    procedure Insert_Multiple (B : in out Bag; E : in Elem; Count : in Natural)
    is
    begin
        for I in 1 .. Count loop
            QueueP.Enqueue (B.Queue, E);
        end loop;
    end Insert_Multiple;

    -- Extract a single element from the bag, if possible
    procedure Extract_One (B : in out Bag; E : out Elem; Success : out Boolean)
    is
    begin
        if not QueueP.Is_Empty (B.Queue) then
            QueueP.Dequeue (B.Queue, E);
            Success := True;
        else
            Success := False;
        end if;
    end Extract_One;

    -- Extract multiple instances of an element, returning the actual count extracted
    procedure Extract_Multiple
       (B            : in out Bag; E : out Elem; Count : in Natural;
        Actual_Count :    out Natural)
    is
        Local_Elem : Elem;
        Success    : Boolean;
    begin
        Actual_Count := 0;
        for I in 1 .. Count loop
            Extract_One (B, Local_Elem, Success);
            if Success then
                E            := Local_Elem;
                Actual_Count := Actual_Count + 1;
            else
                exit;
            end if;
        end loop;
    end Extract_Multiple;

    -- Check if the bag is empty
    function Is_Empty (B : Bag) return Boolean is
    begin
        return QueueP.Is_Empty (B.Queue);
    end Is_Empty;

    -- Return the number of elements in the bag
    function Size (B : Bag) return Natural is
    begin
        return QueueP.Size (B.Queue);
    end Size;

end Generic_Bag;
