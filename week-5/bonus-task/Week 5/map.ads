generic
   type A is private;
   type B is private;
   type Index is (<>);
   type A_Array is array(Index range <>) of A;
   type B_Array is array(Index range <>) of B;
   with function Op(X: A) return B;
function Map(X: A_Array) return B_Array;
