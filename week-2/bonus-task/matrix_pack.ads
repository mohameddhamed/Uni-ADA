package Matrix_Pack is
    type Index is new Integer;
    type Elem is new Float;
    type Matrix is array (Index range <>, Index range <>) of Elem;

    procedure PrintMatrix (M : in Matrix);
    function "*" (E : Elem; M : Matrix) return Matrix;
    procedure Gaussian_Elimination (M : in out Matrix);
    procedure PrintElem (E : Elem);
end Matrix_Pack;
