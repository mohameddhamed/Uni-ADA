generic
   type Index is (<>);
   type Elem is private;
   type Arr is array(Index range <>) of Elem;
   with function "="(S: Natural; I: Index) return Boolean is <>;
   with function "mod"(I1, I2: Index) return Index is <>;
package QueueP is

   type Queue(Max: Index) is limited private;
   
   procedure Enqueue(Q: in out Queue; E: in Elem);
   procedure Dequeue(Q: in out Queue; E: out Elem);
   
   function Get_First(Q: Queue) return Elem;
   
   function Is_Empty(Q: Queue) return Boolean;
   function Is_Full(Q: Queue) return Boolean;
   function Size(Q: Queue) return Natural;
   
   generic
      with procedure Process_Element(Item: in Elem);
   procedure For_Each(Q: in Queue);
   
private
   
   type Queue(Max: Index) is record
      Data: Arr(Index'First..Max);
      First, Last: Index := Index'First;
      Size: Natural := 0;
   end record;
   

end QueueP;
