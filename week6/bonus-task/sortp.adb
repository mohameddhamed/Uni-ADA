with StudentP, Merge, sorter;
use StudentP;

package body SortP is
    procedure For_Each (A : in Arr) is
    begin
       for I in A'Range loop
            Process_Element(A(I));
        end loop; 
    end For_Each;

    procedure Merge_Sort(T: in out Arr) is
        procedure MergeFct is new Merge(Elem, Arr);

        procedure SortFct is new Sorter(Elem, Arr, MergeFct); 
    begin
        SortFct(T, T'First, T'Last);
    end Merge_Sort;


end SortP;