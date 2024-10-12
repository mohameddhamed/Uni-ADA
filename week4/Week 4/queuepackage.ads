package QueuePackage is
    type Index is new Integer;
    type Elem is new Integer;
    type MyQueue (Max : Index) is private;
    procedure Enqueue (Q : in out MyQueue; E : Elem);
    procedure Dequeue (Q : in out MyQueue; E : out Elem);
    function Is_Empty (Q : in out MyQueue) return Boolean;

private
    type QArray is array (Index range <>) of Elem;
    type MyQueue (Max : Index) is record
        setter, getter : Index := 1;
        elements       : QArray (1 .. Max);
        size           : Index := 0;
    end record;
end QueuePackage;
