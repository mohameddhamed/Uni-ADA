package QueueP is

   type Queue(Max: Positive) is limited private;
   
   procedure Enqueue(Q: in out Queue; E: in Integer);
   procedure Dequeue(Q: in out Queue; E: out Integer);
   
   function Get_First(Q: Queue) return Integer;
   function Is_Full(Q: Queue) return Boolean;
   function Is_Empty(Q: Queue) return Boolean;
   function Size(Q: Queue) return Natural;
   
   
private
   
   type Arr is array(Integer range <>) of Integer;
   
   type Queue(Max: Positive) is record
      Data: Arr(1..Max);
      First, Last: Positive := 1;
      Size: Natural := 0;
   end record;
   

end QueueP;
