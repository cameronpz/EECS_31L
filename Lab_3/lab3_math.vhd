-- Starting Example for EECS 31L - S'22
-- may contain issues

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL; -- to support multiplication

entity myMathThing  is
    Port ( 	Input1	:	in STD_LOGIC_VECTOR (15 downto 0);
			Input2	:	in STD_LOGIC_VECTOR (15 downto 0);
			Result : out  STD_LOGIC_VECTOR (15 downto 0)
			);
end myMathThing;

architecture Behavioral of myMathThing  is

   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL testArray : regArray_type :=  (X"0000", X"0001", X"0002", X"0003", X"0010", X"0011", X"0012", X"0000");     
   
begin

	PROCESS (Input1, Input2)
		variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
	BEGIN
		temp := Input1 * Input2 ;
		Result <= temp(15 downto 0) AFTER 12 NS; 
	END PROCESS;

end Behavioral;