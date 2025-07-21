-- Starting Example for EECS 31L - S'22
-- may contain issues

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL; -- for write, writelin
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY lab3_math_tb IS
END lab3_math_tb;
 
ARCHITECTURE behavior OF lab3_math_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myMathThing
    Port ( 	Input1	:	in STD_LOGIC_VECTOR (15 downto 0);
			Input2	:	in STD_LOGIC_VECTOR (15 downto 0);
			Result : out  STD_LOGIC_VECTOR (15 downto 0)
			);
    END COMPONENT;
    

   --Inputs
   signal Input1, Input2 : std_logic_vector (15 downto 0);

     --Outputs
   signal Result : std_logic_vector(15 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: myMathThing PORT MAP (
          Input1 => Input1,
          Input2 => Input2,
          Result => Result
        );

   -- Stimulus process
   stim_proc: process
    variable stringbuff : LINE;
   begin        
        WRITE (stringbuff, string'("Simulation starts at "));
        WRITE (stringbuff, now);
        WRITELINE (output, stringbuff);

        Input1 <= X"0000"; Input2 <= X"0000";
        WAIT FOR 20 NS;
        Input1 <= X"0001"; Input2 <= X"0001";
        WAIT FOR 20 NS;
        Input1 <= X"0002"; Input2 <= X"0002";
        WAIT FOR 20 NS;
        
		-- remove line below & add your own waits, asserts, etc.
		WAIT FOR 200 NS; -- arbitrary wait time

        WRITE (stringbuff, string'("Simulation Ends at "));
        WRITE (stringbuff, now);
        WRITELINE (output, stringbuff);

        wait; -- will wait forever
   end process;

END;
