with Ada.Text_IO;
use Ada.Text_IO;

procedure Exercise17 is
   
   type Index is new Integer;
   type Elem is new Integer;
   type Arr is array(Index range <>) of Elem;
   
   
   procedure Swap(A, B: in out Elem) is
      Tmp: Elem := A;
   begin
      A := B;
      B := Tmp;
   end Swap;
   
   procedure Own_Bubble_Sort(A: in out Arr) is
   begin
      for I in A'Range loop
         for J in A'First..Index'Pred(A'Last) loop
            if A(J) > A(I) then
               Swap(A(J), A(I));
            end if;
         end loop;
      end loop;
   end Own_Bubble_Sort;
   
   
   A: Arr := (3,6,1,5,3);
   
begin
   
   for I in A'Range loop
      Put(Elem'Image(A(I)));
      Put(" ");
   end loop;
   New_Line;
   
   Own_Bubble_Sort(A);
   
   for I in A'Range loop
      Put(Elem'Image(A(I)));
      Put(" ");
   end loop;
   New_Line;
   
end Exercise17;
