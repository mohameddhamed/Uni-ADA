with QueueP; use QueueP;

package Bagp is
    type Index is new Integer;
    subtype Elem is Integer;
    type Arr is array (Index range <>) of Elem;
    type Bag is limited private;
    procedure insert_one (B : in out Bag; E : Elem);
    procedure insert_multiple (B : in out Bag; E : Elem; N : Positive);
    function extract_one (B : in out Bag) return Elem;
    function extract_multiple (B : in out Bag; N : Positive) return Arr;
    procedure print (B : in out Bag);
    function IsEmpty (B : Bag) return Boolean;

private
    type Bag is record
        Content : Queue (100);
    end record;
end Bagp;
