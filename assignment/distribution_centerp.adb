with Ada.Text_IO, ParcelP;
use Ada.Text_IO, ParcelP;
package body Distribution_CenterP is

    function Is_Full(Dc : Distribution_Center) return Boolean is 
    begin
        return Dc.Package_List_Pointer >= Dc.Max;
    end Is_Full;

    
    function Add_Parcel(Dc : in out Distribution_Center ; Parcel: Elem) return Boolean is
    begin
        if Is_Full(Dc) then 
            return False;
        end if;
        Dc.Package_List(Dc.Package_List_Pointer) := Parcel;
        Dc.Package_List_Pointer := Index'Succ(Dc.Package_List_Pointer);
        Dc.Total_Package_Number := Dc.Total_Package_Number + 1;
        return True;
    end Add_Parcel;

    --  Operation which receives and array of parcels and adds it to the Distribution Center. If no more
    --  parcels can be added, the user should be informed.
    function Add_Parcel_Array(Dc : in out Distribution_Center ; Parcel_Array : Arr) return Boolean is
    begin
        Put_Line("Starting to add Parcels from Parcel array...");
        for I in Parcel_Array'Range loop
            if Add_Parcel(Dc, Parcel_Array(I)) = False then
               Put_Line("Can't add any more Parcels."); 
               Put_Line("Stopped adding Parcels at Parcel array index: " & I'Image);
               return False;
            end if;
        end loop;
        Put_Line("Added all Parcels from Parcel array successfully");
        return True;
    end Add_Parcel_Array;

    --  Operation which tells the user whether the Distribution Center has mad a Profit or Loss. Profit / Loss = Revenue – Total Costs.
    procedure IsProfitable(Dc : Distribution_Center) is
    begin
        if Dc.Revenue > Dc.Total_Costs then
            Put_Line("This Distribution Center is profitable.");
        else
            Put_Line("This Distribution Center is not profitable.");
        end if;
    end IsProfitable;

    --  Procedure which prints all data of the Distribution Center in JSON format (Create a string which looks like JSON).
    procedure print(Dc : Distribution_Center) is
        JSON_String : String := 
            "{" & ASCII.LF &
            "  'Name': '" & To_String(Dc.Name) & "'," & ASCII.LF &
            "  'Revenue': " & Dc.Revenue'Image & "," & ASCII.LF &
            "  'Total_Costs': " & Dc.Total_Costs'Image & "," & ASCII.LF &
            "  'Total_Package_Number': " & Dc.Total_Package_Number'Image & ASCII.LF &
            "}";
    begin
        Put_Line(JSON_String);
    end;
        
    --  Procedure which creates a new Distribution Center with the name of the Distribution Center received as a parameter.
    procedure Create_Distribution_Center(Dc: out Distribution_Center; Dc_Name : Unbounded_String) is
    begin
        Dc.Name := Dc_Name;
        New_Line; Put_Line("Distribution Center " & To_String(Dc_Name) & " has been created successfully!"); New_Line;
    end Create_Distribution_Center;

    --  For each recorded parcel:
    --   The revenue (Storage Cost of Parcel + (Storage Cost of Parcel * 0.1 * Value of Category of Parcel)) must be added to the Distribution Center Revenue.
    --   The Storage cost of parcel must be added to the Distribution Center Total costs.
    --   Remove the Parcel from the stored Parcels in the Distribution Center array.
    --   The condition for processing the parcel is if the receiver and sender match the input receiver and sender.
    function Process_Element(Dc: in out Distribution_Center; P: in out Parcel; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) return Boolean is
        Revenue : Float;
    begin
        -- if Parcel should be processed 
        if Check_Condition(P, In_Receiver, In_Sender) then
            Revenue := Get_Storage_Cost(P) + (Get_Storage_Cost(P) * 0.1 * Float(Parcel_Category'Enum_Rep(Get_Category(P))));                 
            Dc.Revenue := Dc.Revenue + Dollars(Revenue); 
            Dc.Total_Costs := Dc.Total_Costs + Dollars(Get_Storage_Cost (P)); 
            -- Parcel has been processed
            Put_Line("Parcel Satisfies condition -> Parcel Removed from Distribution List"); New_Line; 
            return True;
        end if;

        -- Parcel wasn't processed
        return False;
    end Process_Element;

    procedure For_Each(Dc : in out Distribution_Center; In_Receiver: Unbounded_String; In_Sender: Unbounded_String) is
        Pointer : Index := Index'First;
        Original_Pointer : Index := Dc.Package_List_Pointer;
        Packages : Arr := Dc.Package_List;
    begin
        New_Line; Put_Line("Starting Processing Parcels which have a Receiver " & To_String(In_Receiver) & " and a Sender " & To_String(In_Sender)); New_Line;
        Empty_Out_Dc_Package_List(Dc);

        while Pointer < Original_Pointer loop

            -- if the parcel has not been processed
            if Process_Element2(Dc, Packages(Pointer), In_Receiver, In_Sender) = False then

                -- remove the parcels which have been processed
                -- i.e. only add the parcels which haven't been processed
                if Add_Parcel(Dc, Packages(Pointer)) = False then
                    Put_Line("Can't add anymore parcels within the For_Each");
                    exit;
                else
                    Put_Line("Parcel has been Added sucessfully");New_Line;
                end if;

            end if;
            Pointer := Index'Succ(Pointer);
        end loop;

        New_Line; Put_Line("Done Processing Parcels which have a Receiver " & To_String(In_Receiver) & " and a Sender " & To_String(In_Sender)); New_Line;

    end For_Each;

    procedure For_Each2(Dc : in Distribution_Center) is 
        Pointer : Index := Index'First;
        Where : Index := Dc.Package_List_Pointer - Index'First;
    begin
        New_Line; Put_Line("Starting to Apply Print operation to all Parcels within Distribution Center!"); New_Line;
        while Pointer < Dc.Package_List_Pointer loop
            PrintParcel (Dc.Package_List(Pointer));
            Pointer := Index'Succ(Pointer);
        end loop;

        New_Line; Put_Line("Done Applying Print operation to all Parcels within Distribution Center!"); New_Line;
    end For_Each2;

    procedure Empty_Out_Dc_Package_List(Dc: in out Distribution_Center) is 
        List : Arr(Index'First..Dc.Max);
        List_Pointer : Index := Index'First;
    begin
        Dc.Package_List := List;
        Dc.Package_List_Pointer := List_Pointer;
        Dc.Total_Package_Number := 0;
    end Empty_Out_Dc_Package_List;
    
end Distribution_CenterP;