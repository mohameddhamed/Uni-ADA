with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure MaxTwo is
    A : Integer;
    B : Integer;
begin
    Get(A);
    Get(B);
    if A < B then
        Put(A);
        return;
    end if;
    Put(B); 
end MaxTwo;