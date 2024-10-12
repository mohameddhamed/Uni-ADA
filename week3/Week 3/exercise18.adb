with Ada.Text_IO, Matrix_Pack;
use Ada.Text_IO, Matrix_Pack;

procedure Exercise18 is
   M: Matrix := ((1,2), (1,2), (3,2));
   N: Matrix := ((3,5), (3,5), (6,4));
   Sum: Matrix(M'Range(1), M'Range(2));
   
   A: Matrix := ((1,2), (1,2), (3,4));
   B: Matrix := ((1,0,3), (0,1,4));
   Prod1: Matrix(A'Range(1), B'Range(2));
   
   E: Elem := 8;
   Prod2: Matrix(A'Range(1), A'Range(2));
   
   M1: Matrix := ((1,2,3), (4,5,6), (7,8,9));

   --M: Matrix := ((11,22,33,44,55), (1,8,3,8,8), (10,10,20,30,1));
   
begin
   
   Sum := M + N;
   Print_Matrix(Sum);
   New_Line;
   
   Add(M, N);
   Print_Matrix(M);
   
   Prod1 := A * B;
   Print_Matrix(Prod1);
   New_Line;
   
   Prod2 := E * A;
   Print_Matrix(Prod2);
   New_Line;
   
   Multiply(E, A);
   Print_Matrix(A);
   New_Line;
   
   --Exercise 18
   Put_Line(Elem'Image(Diagonal(M1)));
   
   
end Exercise18;
