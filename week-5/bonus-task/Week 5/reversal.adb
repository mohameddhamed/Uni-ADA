procedure Reversal(A: in out T) is
   I: Index := A'First;
   J: Index := A'Last;
   Tmp: Elem;
begin
   while I < J loop
      Tmp := A(I);
      A(I) := A(J);
      A(J) := Tmp;
      I := Index'Succ(I);
      J := Index'Pred(J);
   end loop;
end Reversal;
