generic

--  * `Item` a definite any type (equality check is possible).
    type Item is private;
--  * `Index` discrete type.
    type Index is (<>);
--  * `Matrix` a 2-dimensional array with indefinite `Index` and `Item` elements.
    type Matrix is array (Index range <>, Index range <>) of Item;
--  * `Predicate(Item) -> Boolean` a logical function on `Item`.
    with function Predicate(I : Item) return Boolean;

--  The function parameters are a Matrix used for computation, `X` and `Y` indexes and returning a natural value.

function Adjacent_Count(M : Matrix; X, Y: Index) return Natural; 

--  function Count_Neighbours(M : Matrix; Row, Col : Index) return Natural;