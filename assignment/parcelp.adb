with Ada.Text_IO, Ada.Strings.Unbounded;
use Ada.Text_IO, Ada.Strings.Unbounded;

package body ParcelP is 
--  Getters for all 5 attributes.
    function Get_Sender_Name(P: Parcel) return Unbounded_String is  
    begin 
        return P.Sender_Name;
    end Get_Sender_Name;

    function Get_Receiver_Name(P: Parcel) return Unbounded_String is
    begin
        return P.Receiver_Name;
    end Get_Receiver_Name;
    function Get_Weight(P: Parcel) return Float is  
    begin
        return P.Weight;
    end Get_Weight;
    function Get_Category(P: Parcel) return Parcel_Category is 
    begin
        return P.Category;
    end Get_Category;
    function Get_Storage_Cost(P: Parcel) return Float is  
    begin
        return P.Storage_Cost;
    end Get_Storage_Cost;

--  Getter for the value of the Category of the Parcel
    function Get_Category_Value(P: Parcel) return Integer is 
    begin
        return Parcel_Category'Enum_Rep(P.Category);
    end Get_Category_Value;

--  Procedure to print all data of the flight in JSON format (Create a string which looks like JSON).
    procedure print(P: Parcel) is
        Category_Value : Integer := Get_Category_Value(P);
        JSON_String : String := 
            "{" & ASCII.LF &
            "  'Sender_Name': '" & To_String(P.Sender_Name) & "'," & ASCII.LF &
            "  'Receiver_Name': '" & To_String(P.Receiver_Name) & "'," & ASCII.LF &
            "  'Weight': " & P.Weight'Image & "," & ASCII.LF &
            "  'Category': " & P.Category'Image & "," & ASCII.LF &
            "  'Category_Value': " & Category_Value'Image & "," & ASCII.LF &
            "  'Storage_Cost': " & P.Storage_Cost'Image & ASCII.LF &
            "}";
    begin
        Put_Line(JSON_String);
    end print;

--  Procedure to modify the storage cost – should take a float value as input and modify the
--  storage cost by a percentage – if 0.8 is entered – new storage cost should be 80% of old storage cost.
    procedure Set_Storage_Cost(P: in out Parcel; Sc : Float) is 
    begin
        P.Storage_Cost := P.Storage_Cost * Sc;
    end Set_Storage_Cost;

--  Procedure to create a new Parcel.
    procedure Create_Parcel(P: out Parcel; 
        Sender_Name: Unbounded_String;
        Receiver_Name : Unbounded_String; 
        Weight : Float; 
        Category_Value : Integer 
    ) is
    begin
        P.Sender_Name:= Sender_Name;
        P.Receiver_Name := Receiver_Name;
        P.Weight := Weight;
        P.Category := Parcel_Category'Enum_Val(Category_Value);
--  Formula for calculating Storage cost of a flight:
--  500.0 + (Parcel Weight * Value of the Category of the Parcel)
        P.Storage_Cost := 500.0 + (Weight * Float(Category_Value));
    end Create_Parcel;
end ParcelP;