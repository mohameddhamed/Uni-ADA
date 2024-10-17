function map2 (A : ArrIn) return ArrOut is
    Res : ArrOut (A'Range);
begin
    for I in Res'Range loop
        Res (I) := map_to (A (I));
    end loop;
    return Res;
end map2;
