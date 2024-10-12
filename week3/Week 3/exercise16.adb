with Ada.Text_IO;
use Ada.Text_IO;

procedure Exercise16 is
   
   type Index is new Integer;
   type Elem is new Integer;
   type Arr is array(Index range <>) of Elem;
   
   function Sum_Arr(T: Arr) return Elem is
      S: Elem := 0;
   begin
      for I in T'Range loop
         S := S + T(I);
      end loop;
      return S;
   end Sum_Arr;
   
   function Sum_Arr_Rec(T: Arr; N: Index) return Elem is
      Sum: Elem := 0;
   begin
      if N <= T'Last then
         Sum := T(N) + Sum_Arr_Rec(T, N + 1);
      end if;
      return Sum;
   end Sum_Arr_Rec;
   
   T: Arr := (3,6,1,5,3);
   
begin
   Put_Line(Elem'Image(Sum_Arr(T)));
   Put_Line(Elem'Image(Sum_Arr_Rec(T, T'First)));
   
end Exercise16;
