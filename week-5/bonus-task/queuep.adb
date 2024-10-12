package body QueueP is

   procedure Enqueue(Q: in out Queue; E: in Integer) is
   begin
      Q.Data(Q.Last) := E;
      Q.Last := (Q.Last mod Q.Max) + 1;
      Q.Size := Q.Size + 1;
   end Enqueue;
   
      
   procedure Dequeue(Q: in out Queue; E: out Integer) is
   begin
      E := Get_First(Q);
      Q.First := (Q.First mod Q.Max) + 1;
      Q.Size := Q.Size - 1;
   end Dequeue;
   
   
   function Get_First(Q: Queue) return Integer is
   begin
      return Q.Data(Q.First);
   end Get_First;
   
   
   function Is_Full(Q: Queue) return Boolean is
   begin
      return Size(Q) = Q.Max;
   end Is_Full;
   
   
   function Is_Empty(Q: Queue) return Boolean is
   begin
      return Size(Q) = 0 ;
   end Is_Empty;
   
   
   function Size(Q: Queue) return Natural is
   begin
      return Q.Size;
   end Size;

end QueueP;
