procedure Sorter(T: in out Arr; Left, Right: Integer) is
        Mid: Integer;
    begin
        if Left < Right then
            Mid := (Left + Right) / 2;
            Sorter(T, Left, Mid);
            Sorter(T, Mid + 1, Right);

            Merge(T, Left, Mid, Right);
        end if;
    end Sorter;