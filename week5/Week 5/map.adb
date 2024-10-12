function Map(X: A_Array) return B_Array is
   Y: B_Array(X'Range);
begin
   for I in X'Range loop
      Y(I) := Op(X(I));
   end loop;
   return Y;
end Map;
