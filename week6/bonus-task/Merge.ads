generic
    type Elem is private;
    type Arr is array (Integer range <>) of Elem;
    with function "<=" ( A, B: Elem ) return Boolean is <>;

procedure Merge(T: in out Arr; Left, Mid, Right: Integer);