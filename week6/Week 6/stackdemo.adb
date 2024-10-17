with Ada.Text_IO, StackP;
use Ada.Text_IO;

procedure StackDemo is
   
   type Index is new Integer;
   type Elem is new Integer;
   type Arr is array(Index range <>) of Elem;
   
   function My_Compare(N: Natural; I: Index) return Boolean is
   begin
      if N = Integer(I) then
         return True;
      else
         return False;
      end if;
   end My_Compare;
   
   
   package My_Stack is new StackP(Index, Elem, Arr, My_Compare);
   use My_Stack;
   
   procedure Print_Int(E: Elem) is
   begin
      Put_Line(Elem'Image(E));
   end Print_Int;
   
   procedure Print_Stack is new My_Stack.For_Each(Print_Int);
   
   S: Stack(Index'First + 5);
   
begin
   
   Push(S, 3);
   Push(S, 4);
   Push(S, 5);
   Push(S, 6);
   Push(S, 7);
   Push(S, 8);
   Print_Stack(S);
   Push(S, 9);
   
end StackDemo;
