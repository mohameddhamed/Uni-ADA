with Ada.Text_IO, Ada.Strings.Unbounded, ParcelP, Distribution_CenterP;
use Ada.Text_IO, Ada.Strings.Unbounded, ParcelP;

procedure Main is

    type Index is new Integer;
    type Parcel_Array is array (Index range <>) of Parcel;

    Parcels : Parcel_Array(1..5);

    package My_Distribution_Center is new Distribution_CenterP(Index, Parcel, Parcel_Array);
    use My_Distribution_Center;

    Dc : Distribution_Center(Index'First + 10);

    function My_Check_Condition(P: in Parcel; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) return Boolean is
        truth : Boolean;
    begin
        truth := Get_Receiver_Name(P) = In_Receiver and Get_Sender_Name(P) = In_Sender;
        if truth then
            Put_Line(
                To_String(Get_Receiver_Name(P)) & " = " & To_String(In_Receiver)
                & " and "
                & To_String(Get_Sender_Name(P)) & " = " & To_String(In_Sender)
                & ": Condition Satisfied!"
            );
        else 
            Put_Line(
                To_String(Get_Receiver_Name(P)) & " != " & To_String(In_Receiver)
                & " or "
                & To_String(Get_Sender_Name(P)) & " != " & To_String(In_Sender)
                & ": Condition Unsatisfied!"
            );
        end if;
        return truth;
    end My_Check_Condition;

    function My_Process_Element is new Process_Element(My_Check_Condition);

    procedure My_For_Each is new For_Each(My_Process_Element);

    procedure My_Print_All is new For_Each2(ParcelP.print);

begin
    -- Creating Distribution Center
    Create_Distribution_Center(Dc, To_Unbounded_String("My Distribution Center"));

    -- Creating Parcels
    Create_Parcel(Parcels(1), To_Unbounded_String("Ali"), To_Unbounded_String("Mohamed"), 50.0, 1);  
    Create_Parcel(Parcels(2), To_Unbounded_String("Ahmed"), To_Unbounded_String("Mahmoud"), 25.0, 2);  
    Create_Parcel(Parcels(3), To_Unbounded_String("Amir"), To_Unbounded_String("Mahdi"), 30.0, 3);  
    Create_Parcel(Parcels(4), To_Unbounded_String("Ammar"), To_Unbounded_String("Majdi"), 5.0, 4);  
    Create_Parcel(Parcels(5), To_Unbounded_String("Ala"), To_Unbounded_String("Majid"), 500.0, 5);  

    
    -- Showing the print operation for a single parcel
    New_Line; Put_Line("Starting to print all the parcels..."); New_Line;
    for I in Parcels'Range loop
        print(Parcels(I));
    end loop;
    New_Line; Put_Line("Done printing all the parcels!"); New_Line;

    -- Adding an array of Parcels to the Distribution Center
    if Add_Parcel_Array(Dc, Parcels) then
        print(Dc);
    end if;

    Put_Line("Distribution Center at the Start");
    My_Print_All (Dc);

    -- Applying a generic operation on parcels that match the input sender and receiver
    My_For_Each(Dc, To_Unbounded_String("Mohamed"), To_Unbounded_String("Ali"));
    Put_Line("Distribution Center after applying the first For_Each");
    My_Print_All (Dc);

    -- Applying a generic operation on parcels that match the input sender and receiver
    My_For_Each(Dc, To_Unbounded_String("Majid"), To_Unbounded_String("Ala"));
    Put_Line("Distribution Center after applying the second For_Each");
    My_Print_All (Dc);

    print(Dc);
    -- Checking profitabilty
    IsProfitable (Dc);

    -- setting the storage cost for the parcel that has Sender => Mahdi and Receiver => Amir
    New_Line; Put_Line("Parcel before setting Cost : "); New_Line;
    print(Parcels(3));
    Set_Storage_Cost (Parcels(3), 9.9);
    New_Line; Put_Line("Parcel after setting Cost : "); New_Line;
    print(Parcels(3));

    -- Distribution Center gets the parcel array added to it with one entry's storage cost modified!
    if Add_Parcel_Array(Dc, Parcels) then
        print(Dc);
    end if;

    -- Applying the generic operation the parcel that had its storage cost modified within the Distribution Package List
    My_For_Each(Dc, To_Unbounded_String("Mahdi"), To_Unbounded_String("Amir"));
    Put_Line("Distribution Center after applying the third For_Each");
    My_Print_All (Dc);

    print(Dc);
    -- Checking profitabilty
    IsProfitable (Dc);

    -- Adding too many parcels
    if Add_Parcel_Array(Dc, Parcels) then
        print(Dc);
    end if;

    My_Print_All (Dc);

end Main;

