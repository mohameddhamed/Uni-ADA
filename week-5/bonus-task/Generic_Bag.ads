generic
    type Index is (<>);  -- Generic index type
    type Elem is private;  -- Generic element type
    with package QueueP is new QueueP
       (Index => Index, Elem => Elem);  -- Instantiate the Queue package

package Generic_Bag is

    type Bag is limited private;  -- The Bag type is defined as limited private

    -- Procedures and functions for Bag operations
    procedure Insert_One (B : in out Bag; E : in Elem);
    procedure Insert_Multiple
       (B : in out Bag; E : in Elem; Count : in Natural);
    procedure Extract_One
       (B : in out Bag; E : out Elem; Success : out Boolean);
    procedure Extract_Multiple
       (B            : in out Bag; E : out Elem; Count : in Natural;
        Actual_Count :    out Natural);

    function Is_Empty (B : Bag) return Boolean;
    function Size (B : Bag) return Natural;

private
    type Bag is record
        Queue : QueueP.Queue
           (Index'
               Last);  -- Use the Queue package as the internal data structure
    end record;

end Generic_Bag;
