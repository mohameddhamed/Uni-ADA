generic
    type Elem is private;
    type Arr is array (Integer range <>) of Elem;
    with procedure Merge(T: in out Arr; Left, Mid, Right: Integer);
procedure Sorter(T: in out Arr; Left, Right: Integer);