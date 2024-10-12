with Ada.Text_IO, Matrix_Pack;
use Ada.Text_IO, Matrix_Pack;

procedure Exercise20 is
   
   
   --M:Matrix := ((11, 12, 13),(21, 22, 23));
   --M:Matrix := ((11, 12),(21, 22),(31, 32),(41, 42));
   M: Matrix := ((11,22,33,44,55), (1,8,3,8,8), (10,10,20,30,1));
   
   RowStart: Index := M'First(1);
   RowEnd: Index := M'Last(1);
   ColStart: Index := M'First(2);
   ColEnd: Index := M'Last(2);
   
begin
   
   while RowStart <= RowEnd and ColStart <= ColEnd loop
      for I in ColStart..ColEnd loop
         Put(Elem'Image(M(RowStart, I)) & " ");
      end loop;
      RowStart := RowStart + 1;
      
      for I in RowStart..RowEnd loop
         Put(Elem'Image(M(I, ColEnd)) & " ");
      end loop;
      ColEnd := ColEnd - 1;
      
      if RowStart <= RowEnd then
         for I in reverse ColStart..ColEnd loop
            Put(Elem'Image(M(RowEnd, I)) & " ");
         end loop;
         RowEnd := RowEnd - 1;
      end if;
      
      if ColStart <= ColEnd then
         for I in reverse RowStart..RowEnd loop
            Put(Elem'Image(M(I, ColStart)) & " ");
         end loop;
         ColStart := ColStart + 1;
      end if;
   end loop;
   
   
end Exercise20;
