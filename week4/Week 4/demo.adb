with Setq, Ada.Integer_Text_IO, Ada.Text_IO;
use Setq, Ada.Integer_Text_IO, Ada.Text_IO;

procedure demo is

    R  : Rational := 1 / 8;
    R2 : Rational := 2 / 4;
    -- X: Rational := 3/4/5;

begin

    R := R * R2;
    Put (Numerator (R));
    Put_Line ("/");
    Put (Denominator (R));

end demo;
