with Ada.Text_IO, mapg;
use Ada.Text_IO;

procedure mapg_demo is
    type Elem is new Float;
    function triple (X : Elem) return Elem is
    begin
        return Elem (3) * X;
    end triple;
    function mymap is new mapg (Elem, triple);
begin
    Put_Line (Elem'Image (mymap (2.0)));

end mapg_demo;
