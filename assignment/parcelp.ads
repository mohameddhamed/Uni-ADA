with Ada.Strings.Unbounded; 
use Ada.Strings.Unbounded;

package ParcelP is 

    type Parcel_Category is (Phones, Laptops, Computers, Printers, Appliances);
    for Parcel_Category use (1,2,3,4,5);

    type Parcel is private; 

    -- Getters for all 5 attributes.
    function Get_Sender_Name(P: Parcel) return Unbounded_String; 
    function Get_Receiver_Name(P: Parcel) return Unbounded_String; 
    function Get_Weight(P: Parcel) return Float; 
    function Get_Category(P: Parcel) return Parcel_Category; 
    function Get_Storage_Cost(P: Parcel) return Float; 

    -- Getter for the value of the Category of the Parcel
    function Get_Category_Value(P: Parcel) return Integer; 

    -- Procedure to print all data of the flight in JSON format (Create a string which looks like JSON).
    procedure print(P: Parcel);

    --  Procedure to modify the storage cost – should take a float value as input and modify the
    --  storage cost by a percentage – if 0.8 is entered – new storage cost should be 80% of old
    --  storage cost.
    procedure Set_Storage_Cost(P: in out Parcel; Sc : Float);

    --  Procedure to create a new Parcel.
    procedure Create_Parcel(P: out Parcel; 
        Sender_Name: Unbounded_String;
        Receiver_Name : Unbounded_String; 
        Weight : Float; 
        Category_Value : Integer 
    );
private
    type Parcel is record
        Sender_Name : Unbounded_String; 
        Receiver_Name : Unbounded_String; 
        Weight : Float; 
        Category : Parcel_Category; 
        Storage_Cost : Float; 
    end record;
end ParcelP;