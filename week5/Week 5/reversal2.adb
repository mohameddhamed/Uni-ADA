procedure Reversal2 (arr_in : in out Arr) is 
    I : Index := arr_in'First;
    J : Index := arr_in'Last;
begin
    while I < J loop
        Swap(arr_in(I), arr_in(J));
      I := Index'Succ(I);
      J := Index'Pred(J);
    end loop;
end Reversal2;
