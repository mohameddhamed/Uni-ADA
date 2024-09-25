with Matrix_Pack; use Matrix_Pack;

package Array_Pack is
    type Arr is array (Index range <>) of Elem;
    procedure PrintArr (A : in Arr);
end Array_Pack;
