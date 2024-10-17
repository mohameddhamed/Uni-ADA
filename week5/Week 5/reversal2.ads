generic
    type Elem is limited private;
    type Index is (<>);
    type Arr is array (Index range <>) of Elem;
    with procedure Swap (A : in out Elem; B : in out Elem);
procedure Reversal2 (arr_in : in out Arr);
