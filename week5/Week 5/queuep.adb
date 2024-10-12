package body QueueP is

   procedure Enqueue(Q: in out Queue; E: in Elem) is
   begin
      Q.Data(Q.Last) := E;
      Q.Last := Index'Succ(Q.Last mod Q.Max);
      Q.Size := Q.Size + 1;
   end Enqueue;
   
   
   procedure Dequeue(Q: in out Queue; E: out Elem) is
   begin
      E := Get_First(Q);
      Q.First := Index'Succ(Q.First mod Q.Max);
      Q.Size := Q.Size - 1;
   end Dequeue;
   
   
   function Get_First(Q: Queue) return Elem is
   begin
      return Q.Data(Q.First);
   end Get_First;
   
   
   function Is_Empty(Q: Queue) return Boolean is
   begin
      return Size(Q) = 0;
   end Is_Empty;
   
   
   function Is_Full(Q: Queue) return Boolean is
   begin
      return Size(Q) = Q.Max;
   end Is_Full;
   
   
   function Size(Q: Queue) return Natural is
   begin
      return Q.Size;
   end Size;
   
   procedure For_Each(Q: in Queue) is
   begin
      for I in Q.First..Q.Last loop
         Process_Element(Q.Data(I));
      end loop;
   end For_Each;
   

end QueueP;
