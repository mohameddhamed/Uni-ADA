with Election_Package, Ada.Text_IO;
use Ada.Text_IO;

procedure Main is

   type Candidates is (Rasul, Bill, Jill, Will, Nill);
   type Regions is (Budapest, Pecs, Gyor, Debrecen, Szeged);

   package My_Election is new Election_Package(Candidates, Regions);
   use My_Election;

   A: Election(5);
   B: Election(5);

   F: Float;
begin




end Main;
