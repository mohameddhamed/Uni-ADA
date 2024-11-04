with Ada.Text_IO;
use Ada.Text_IO;

package body Cellular_Automaton_Package is
--  * `Run(Cellular_Automaton, Natural)` executes the number of steps specified by the second parameter on the parameter  automaton. 
--  After each step, it draws the automaton and then waits for half a second (`delay 0.5;`).
    procedure Run(C : Cellular_Automaton; Steps : Natural) is 
    begin
        Put_Line("Hello World");
    end Run;
--  * `Iterate(Cellular_Automaton)` applies the rules to the previous state of the automaton and then updates 
--  the state of the parameter automaton with the new values, call this cell trajectory. Make sure to use the state of the previous track!
    procedure Iterate(C : Cellular_Automaton) is
    begin
        Put_Line("Hello World");
    end Iterate;

--  * `Put(Cellular_Automaton)` prints the trajectory of the automaton. (It is advisable to write a dividing line as well, and a space between elements.)
    procedure Put(C : Cellular_Automaton) is
    begin
        Put_Line("Hello World");
    end Put;
end Cellular_Automaton_Package;