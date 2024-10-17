package body Studentp is
    function GetName(S : Student) return String is
    begin
    return To_String(S.Name);
    end GetName;
    function GetAge(S : Student) return Positive is
    begin
        return S.Age;
    end GetAge;
    function GetPlaceOfBirth(S : Student) return String is
    begin
        return To_String(S.PlaceOfBirth);
    end GetPlaceOfBirth;

    function "<=" (S1, S2: Student) return Boolean is
    begin
        return S1.Age < S2.Age;
    end "<=";

    procedure SetAge(S: in out Student; E: Positive) is
    begin
        S.Age := E;
    end SetAge;

    procedure SetName(S : in out Student; E: String) is
    begin
        S.Name := To_Unbounded_String(E);
    end SetName;

    procedure SetAll(S : in out Student; Name: String; Age : Positive; PlaceOfBirth : String) is
    begin
        S.Age := Age;
        S.Name := To_Unbounded_String(Name);
        S.PlaceOfBirth := To_Unbounded_String(PlaceOfBirth);
    end SetAll;
end Studentp;