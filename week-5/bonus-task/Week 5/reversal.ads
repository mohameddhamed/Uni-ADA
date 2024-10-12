generic
   type Elem is private;
   type Index is (<>);
   type T is array(Index range <>) of Elem;
procedure Reversal(A: in out T);
