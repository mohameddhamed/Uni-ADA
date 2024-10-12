with Ada.Text_IO, Matrix_Pack;
use Ada.Text_IO, Matrix_Pack;

procedure Exercise19 is
   
   M: Matrix := ((11,22,33,44,55), (1,8,3,8,8), (10,10,20,30,1));
   
   function Min_In_Column(M: Matrix; Col_Ind: Index) return Elem is
      Min_Val: Elem := M(M'First(1), Col_Ind);
   begin
      for Row in M'Range(1) loop
         if M(Row, Col_Ind) < Min_Val then
            Min_Val := M(Row, Col_Ind);
         end if;
      end loop;
      return Min_Val;
   end Min_In_Column;
   
   
   function Max_In_Row(M: Matrix; Row_Ind: Index) return Elem is
      Max_Val: Elem := M(Row_Ind, M'First(2));
   begin
      for Col in M'Range(2) loop
         if M(Row_Ind, Col) > Max_Val then
            Max_Val := M(Row_Ind, Col);
         end if;
      end loop;
      return Max_Val;
   end Max_In_Row;
   
   
   procedure Local_Max(M: in Matrix) is
   begin
      for Row in M'Range(1) loop
         for Col in M'Range(2) loop
            if M(Row, Col) = Min_In_Column(M, Col) and M(Row, Col) = Max_In_Row(M, Row) then
               Put_Line("Local max element: " & Elem'Image(M(Row, Col)) & " at Row: " &
                          Index'Image(Row) & " and Col: " & Index'Image(Col));
            end if;
         end loop;
      end loop;
   end Local_Max;
   
begin
   
   Local_Max(M);
   
end Exercise19;
