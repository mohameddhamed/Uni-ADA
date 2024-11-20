with Ada.Text_IO;
use Ada.Text_IO;

procedure Shoes2 is

    task type Sand is 
        entry Right_Foot;
        entry Left_Foot; 
    end Sand;

    task body Sand is 
    begin

    loop
        select
            accept Right_Foot do
                Put_Line("Right Foot is stepping on the Sand.");
            end Right_Foot;
            or
            accept Left_Foot do 
                Put_Line("Left Foot is stepping on the Sand.");
            end Left_Foot;
        end select;
    end loop;

    end Sand;
    x, y : Sand;--x,ytwotasks
begin
    for I in 1..10 loop
        x.Right_Foot;
        x.Left_Foot;
    end loop;
end Shoes2;