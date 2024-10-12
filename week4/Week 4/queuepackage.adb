package body QueuePackage is
    procedure Enqueue (Q : in out MyQueue; E : Elem) is
    begin
        Q.size                := Q.size + 1;
        Q.elements (Q.setter) := E;
        Q.setter              := (Q.setter mod Q.Max) + 1;
    end Enqueue;
    procedure Dequeue (Q : in out MyQueue; E : out Elem) is
    begin
        Q.size   := Q.size - 1;
        E        := Q.elements (Q.getter);
        Q.getter := (Q.getter mod Q.Max) + 1;
    end Dequeue;
    function Is_Empty (Q : in out MyQueue) return Boolean is
    begin
        return Q.size = 0;
    end Is_Empty;
end QueuePackage;
