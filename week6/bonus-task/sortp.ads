generic
    type Elem is private;
    type Arr is array (Integer range <>) of Elem;
package SortP is

    generic
        with procedure Process_Element(E: in Elem);
    procedure For_Each(A : in Arr);

    generic
        with function "<=" ( A, B: Elem ) return Boolean is <>;
    procedure Merge_Sort(T: in out Arr);

end SortP;