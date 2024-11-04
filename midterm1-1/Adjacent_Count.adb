with Ada.Text_IO;
use Ada.Text_IO;
--   It counts for the value of given indexes the number of neighbours 
--  that satisfy the Predicate (be careful counting at borders not to index outside the limits).

function Adjacent_Count(M : Matrix; X, Y: Index) return Natural is 
    Count : Natural := 0;
    Up_Neighbour : Boolean := True;
    Down_Neighbour : Boolean := True;
    Left_Neighbour : Boolean := True;
    Right_Neighbour : Boolean := True;
    Top_Right : Boolean;
    Top_Left : Boolean;
    Bottom_Right : Boolean;
    Bottom_Left: Boolean;
begin
    if X = M'First(1) then
        Up_Neighbour := False;
    end if;
    if Y = M'First(2) then
        Left_Neighbour := False;
    end if;
    if X = M'Last(1) then
        Down_Neighbour := False;
    end if;
    if Y = M'Last(2) then
        Right_Neighbour := False;
    end if;

    -- Vertical and Horizontal
    if Up_Neighbour then
        if Predicate(M(Index'Pred(X), Y)) then 
            Count := Count + 1;
        end if;
    end if;

    if Left_Neighbour then
        if Predicate(M(X, Index'Pred(Y))) then 
            Count := Count + 1;
        end if;
    end if;
    if Down_Neighbour then
        if Predicate(M(Index'Succ(X), Y)) then 
            Count := Count + 1;
        end if;
    end if;
    if Right_Neighbour then
        if Predicate(M(X, Index'Succ(Y))) then 
            Count := Count + 1;
        end if;
    end if;

    -- Diagonal
    Top_Right := Up_Neighbour and Right_Neighbour;
    Top_Left := Up_Neighbour and Left_Neighbour;
    Bottom_Right := Down_Neighbour and Right_Neighbour;
    Bottom_Left := Down_Neighbour and Left_Neighbour;

    if Top_Right then
        if Predicate(M(Index'Pred(X), Index'Succ(Y))) then 
            Count := Count + 1;
        end if;
    end if;

    if Top_Left then
        if Predicate(M(Index'Pred(X), Index'Pred(Y))) then 
            Count := Count + 1;
        end if;
    end if;
    if Bottom_Right then
        if Predicate(M(Index'Succ(X), Index'Succ(Y))) then 
            Count := Count + 1;
        end if;
    end if;
    if Bottom_Left then
        if Predicate(M(Index'Succ(X), Index'Pred(Y))) then 
            Count := Count + 1;
        end if;
    end if;
    --  Put_Line(Count'Image);
    return Count;

end Adjacent_Count;
