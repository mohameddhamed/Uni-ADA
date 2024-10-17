generic
    type Element_T is private;
    with function mapping_function (X : Element_T) return Element_T;
function mapg (X : Element_T) return Element_T;
