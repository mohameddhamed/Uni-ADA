with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Studentp is
    type Student is private;
    function GetName(S : Student) return String;
    function GetAge(S : Student) return Positive;
    function GetPlaceOfBirth(S : Student) return String;
    procedure SetAge(S: in out Student; E: Positive);
    procedure SetName(S : in out Student; E: String);
    procedure SetAll(S : in out Student; Name: String; Age : Positive; PlaceOfBirth : String);

    function "<=" (S1, S2: Student) return Boolean;
private
    type Student is record
        Name : Unbounded_String := To_Unbounded_String("");
        Age : Positive := 1;
        PlaceOfBirth: Unbounded_String  := To_Unbounded_String("");
    end record;
end Studentp;