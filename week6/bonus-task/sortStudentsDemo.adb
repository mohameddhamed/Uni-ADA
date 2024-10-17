with Ada.Text_IO, StudentP, SortP;
use Ada.Text_IO, StudentP;

procedure SortStudentsDemo is

   type Elem is new Student;
   type Arr is array(Integer range <>) of Elem;

   package My_Sort is new SortP(Elem, Arr); 
   use My_Sort;

    procedure Print_Student(Student: Elem) is 
    begin
        Put_Line(" ( " & GetName(Student) & " : " & Positive'Image(GetAge(Student)) & " ) ");
    end Print_Student;


    procedure Print_Students is new My_Sort.For_Each(Print_Student);
    procedure Sort_Students is new My_Sort.Merge_Sort;

    Students : Arr(1..6);

begin
    SetAge(Students(4), 7);
    SetName(Students(4), "Drake2");
    SetAge(Students(5), 60);
    SetName(Students(5), "Drake3");
    SetAge(Students(3), 10);
    SetName(Students(3), "Drake");
    SetAge(Students(2), 12);
    SetName(Students(2), "Josh");
    SetAge(Students(1), 13);
    SetName(Students(1), "Derek");

    SetAll(Students(6), "Dave", 50, "Wherever");

    Print_Students (Students);
    Put_Line("---------------");
    Sort_Students(Students);

    Print_Students (Students);

    
end SortStudentsDemo;