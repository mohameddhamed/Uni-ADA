with Ada.Text_IO;
use Ada.Text_IO;

package body Matrix_Pack is

   --0,0 0,1 0,2     0,0 0,1 0,2
   --1,0 1,1 1,2     1,0 1,1 1,2
   --2,0 2,1 2,2     2,0 2,1 2,2
   --
   --0,0 + 0-0+0,0-0+0  -> 0,0 + 0,0
   --1,0 + 1-0+0,0-0+0  -> 1,0 + 1,0
   --2,0 + 2-0+0,0-0+0  -> 2,0 + 2,0
   
   --1,1 1,2 1,3     7,7 7,8 7,9
   --2,1 2,2 2,3     8,7 8,8 8,9
   --3,1 3,2 3,3     9,7 9,8 9,9
   --
   --1,1 + 1-1+7,1-1+7
   --2,1 + 2-1+7,1-1+7
   --3,1 + 3-1+7,1-1+7
   --
   --3,1 + 7,7
   --3,1 + 8,7
   --3,1 + 9,7
   
   
   procedure Add(A: in out Matrix; B: in Matrix) is
   --A := A + B
   begin
      for I in A'Range(1) loop
         for J in A'Range(2) loop
            A(I, J) := A(I,J) + B(I - A'First(1) + B'First(1), J - A'First(2) + B'First(2));
         end loop;
      end loop;
   end Add;
      
      
   function "+"(A, B: Matrix) return Matrix is
      C: Matrix(A'Range(1), A'Range(2));
   begin
      for I in A'Range(1) loop
         for J in A'Range(2) loop
            C(I, J) := A(I,J) + B(I - A'First(1) + B'First(1), J - A'First(2) + B'First(2));
         end loop;
      end loop;
      return C;
   end "+";
   
   function "*"(A, B: Matrix) return Matrix is
      C: Matrix(A'Range(1), B'Range(2)) := (others => (others => 0));
   begin
      for I in C'Range(1) loop
         for J in C'Range(2) loop
            for K in A'Range(2) loop
               C(I,J) := C(I, J) + A(I, K-B'First(1) + A'First(2)) * B(K-A'First(2) + B'First(1), J);
            end loop;
         end loop;
      end loop;
      return C;
   end "*";
   
   function "*"(E: Elem; M: Matrix) return Matrix is
      C: Matrix(M'Range(1), M'Range(2));
   begin
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            C(I, J) := E * M(I, J);
         end loop;
      end loop;
      return C;
   end "*";
   
   procedure Multiply(E: in Elem; M: in out Matrix) is
   begin
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            M(I, J) := E * M(I, J);
         end loop;
      end loop;
   end Multiply;
   
   function Diagonal(A: Matrix) return Elem is
      S: Elem := 0;
   begin
      for I in A'Range(1) loop
         S := S + A(I, I - A'First(1) + A'First(2));
      end loop;
      return S;
   end Diagonal;
   
   procedure Print_Matrix(M: in Matrix) is
   begin
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            Put(Elem'Image(M(I, J)) & " ");
         end loop;
         New_Line;
      end loop;
   end Print_Matrix;

end Matrix_Pack;
