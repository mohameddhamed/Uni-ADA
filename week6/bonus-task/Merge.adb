procedure Merge(T: in out Arr; Left, Mid, Right: Integer) is
        Temp: Arr(Left .. Right);  
        I, J, K: Integer := Left;
    begin
        
        I := Left;        
        J := Mid + 1;     
        K := Left;        

        
        while I <= Mid and J <= Right loop
            if T(I) <= T(J) then
                Temp(K) := T(I);
                I := I + 1;
            else
                Temp(K) := T(J);
                J := J + 1;
            end if;
            K := K + 1;
        end loop;

        
        while I <= Mid loop
            Temp(K) := T(I);
            I := I + 1;
            K := K + 1;
        end loop;

        
        while J <= Right loop
            Temp(K) := T(J);
            J := J + 1;
            K := K + 1;
        end loop;

        
        for L in Left .. Right loop
            T(L) := Temp(L);
        end loop;
    end Merge;