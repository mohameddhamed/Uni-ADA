with Ada.Strings.Unbounded, ParcelP;
use Ada.Strings.Unbounded, ParcelP;

generic 
    type Index is (<>);
    type Elem is private;
    type Arr is array (Index range <>) of Elem;
    with function "-"(I1: Index; I : Index) return Index is <>;
package Distribution_CenterP is 

    type Distribution_Center(Max : Index) is limited private;

    --  Operation which receives and array of parcels and adds it to the Distribution Center. If no more
    --  parcels can be added, the user should be informed.
    function Add_Parcel_Array(Dc : in out Distribution_Center ; Parcel_Array : Arr) return Boolean;

    --  Operation which tells the user whether the Distribution Center has mad a Profit or Loss. Profit /
    --  Loss = Revenue – Total Costs.
    procedure IsProfitable(Dc : Distribution_Center);

    --  Procedure which prints all data of the Distribution Center in JSON format (Create a string
    --  which looks like JSON).
    procedure print(Dc : Distribution_Center); 

    --  Procedure which creates a new Parcel with the name of the Distribution Center received as a
    --  parameter.
    procedure Create_Distribution_Center(Dc: out Distribution_Center; Dc_Name : Unbounded_String);

    --  A generic operation which processes a parcel and takes a generic function or procedure that
    --  determines the condition required to process the parcel
    generic
        with function Check_Condition(P: in Parcel; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) return Boolean;
    function Process_Element(Dc: in out Distribution_Center; P: in out Parcel; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) return Boolean;

    generic
        with function Process_Element2(Dc: in out Distribution_Center; Parcel: in out Elem; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) return Boolean;
    procedure For_Each(Dc : in out Distribution_Center; In_Receiver: Unbounded_String; In_Sender: Unbounded_String);

    generic
        with procedure PrintParcel(Parcel: in Elem);
    procedure For_Each2(Dc : in Distribution_Center);

private 

    function Is_Full(Dc : Distribution_Center) return Boolean;
    procedure Empty_Out_Dc_Package_List(Dc: in out Distribution_Center);

    type Dollars is new Float range 0.0..Float'Last;
    type Distribution_Center(Max : Index) is record 
        --  Name
        Name : Unbounded_String;

        --  List of Packages where both the Index and Elem are generic.
        Package_List : Arr(Index'First..Max);
        Package_List_Pointer : Index := Index'First;

        --  Revenue of type Dollars -> initialized to 0.0;
        Revenue : Dollars := 0.0;

        --  Total Costs of type Dollars -> initialized to 0.0;
        Total_Costs : Dollars := 0.0;

        --  Total Number of Packages processed of type Natural -> initialized to 0;
        Total_Package_Number : Natural := 0;
    end record;
end Distribution_CenterP;