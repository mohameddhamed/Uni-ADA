generic
    type ElemIn is private;
    type ElemOut is private;
    type Index is (<>);
    type ArrIn is array (Index range <>) of ElemIn;
    type ArrOut is array (Index range <>) of ElemOut;
    with function map_to (X : ElemIn) return ElemOut;
function map2 (A : ArrIn) return ArrOut;
