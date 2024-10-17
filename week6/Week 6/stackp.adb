with Ada.Text_IO;
use Ada.Text_IO;

package body StackP is

   procedure Push(S: in out Stack; E: in Elem) is
   begin
      if Is_Full(S) then
         Put_Line("Stack is full");
         return;
      end if;
      S.Data(S.Pointer) := E;
      --1 2 3 4 5
      S.Pointer := Index'Succ(S.Pointer);
      S.Size := S.Size + 1;
   end Push;
   
      
   procedure Pop(S: in out Stack; E: out Elem) is
   begin
      if Is_Empty(S) then
         Put_Line("Stack is empty");
         return;
      end if;
      S.Pointer := Index'Pred(S.Pointer);
      E := S.Data(S.Pointer);
      S.Size := S.Size - 1;
   end Pop;
   
      
   function Top(S: Stack) return Elem is
   begin
      return S.Data(Index'Pred(S.Pointer));
   end Top;
   
      
   function Is_Empty(S: Stack) return Boolean is
   begin
      return S.Size = 0;
   end Is_Empty;
   
      
   function Is_Full(S: Stack) return Boolean is
   begin
      return S.Size = S.Max;
   end Is_Full;
   
   
   function Size(S: Stack) return Natural is
   begin
      return S.Size;
   end Size;
   
      
   procedure For_Each(S: in Stack) is
   begin
      for I in S.Data'Range loop
         Process_Element(S.Data(I));
      end loop;
   end For_Each;

end StackP;
