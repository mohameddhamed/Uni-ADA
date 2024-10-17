generic 
    type Index is (<>);
    type Elem is private;
    type Arr is array(Index range <>) of Elem;

    with function "=" (A : Index; B : Positive) return Boolean is <>;
    with function "Mod" (A : Index; B : Positive) return Index is <>;
    --  with function My_Compare(S: Elem; I: Index) return Boolean;
package QueueP2 is

   type Queue(Max: Index) is limited private;
   
   procedure Enqueue(Q: in out Queue; E: in Elem);
   procedure Dequeue(Q: in out Queue; E: out Elem);
   
   function Get_First(Q: Queue) return Elem;
   function Is_Full(Q: Queue) return Boolean;
   function Is_Empty(Q: Queue) return Boolean;
   function Size(Q: Queue) return Natural;
    
    generic 
        with procedure Process_Element(E : Elem);
    procedure ForEach(Q : Queue);
   
private
   
   type Queue(Max: Index) is record
      Data: Arr(Index'First..Max);
      First, Last: Index := Index'First;
      Size: Natural := 0;
   end record;
   

end QueueP2;
