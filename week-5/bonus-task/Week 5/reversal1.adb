procedure Reversal1(A: in out T) is
   I: Index := A'First;
   J: Index := A'Last;
begin
   while I < J loop
      Swap(A(I), A(J));
      I := Index'Succ(I);
      J := Index'Pred(J);
   end loop;
end Reversal1;
