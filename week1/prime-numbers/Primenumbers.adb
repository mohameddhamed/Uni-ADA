-- takes a number N as input 
-- and prints all prime numbers between 1 qnd N
with Ada.Integer_Text_IO; 
use Ada.Integer_Text_IO;

procedure PrimeNumbers is
  
  N: Integer;
  
  function IsPrime(N: Integer) return Boolean is 
  begin
    
    if N <= 1 then
      return False;
    end if;
    
    for I in 2..(N/2) loop
    
      if N mod I = 0 then
        return False;
      end if;
    
    end loop;
    
    return True;
    
  end IsPrime;

begin
  Get(N);
  
  for I in 2..N loop
    if IsPrime(I) then
      Put(I);
    end if;
  end loop;
	
end PrimeNumbers;