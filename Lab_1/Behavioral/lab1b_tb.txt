------------------------------------------------------------------------
-- Company: EECS 31L - S22
-- Engineer: Cameron Peterson-Zopf
--
-- Design Name:   LFDetector_behav
-- Module Name:   lab1b_tb.vhd
-- Project Name:  Lab1_LFDetector
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFDetector_behav
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY lab1b_tb_vhd IS
--test bench has no ports so we don't have anything here
END lab1b_tb_vhd;

ARCHITECTURE behavior OF lab1b_tb_vhd IS 
	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT LFDetector_behav IS 
	PORT(
		Fuel3 : IN std_logic;
		Fuel2 : IN std_logic;
		Fuel1 : IN std_logic;
		Fuel0 : IN std_logic;          
		FuelWarningLight : OUT std_logic
		);
	END COMPONENT;
	--Inputs; all are in binary and initialize to 0
	SIGNAL Fuel3 :  std_logic := '0';
	SIGNAL Fuel2 :  std_logic := '0';
	SIGNAL Fuel1 :  std_logic := '0';
	SIGNAL Fuel0 :  std_logic := '0';

	--Outputs
	SIGNAL FuelWarningLight :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	--direct mapping
	uut: LFDetector_behav PORT MAP(
		Fuel3 => Fuel3,
		Fuel2 => Fuel2,
		Fuel1 => Fuel1,
		Fuel0 => Fuel0,
		FuelWarningLight => FuelWarningLight
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;
        -- testing value "0000", expecting FuelWarningLight = 1
		Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='0'; --FWL = 1
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='1'; --FWL = 1
		wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='0'; --FWL = 1
        wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='1'; -- FWL = 1
        wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='0'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='1'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '1'; Fuel0 <='0'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '1'; Fuel0 <='1'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='0'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='1'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='0'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='1'; -- FWL = 0 
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='0'; -- FWL = 0
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='1'; -- FWL = 0
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '1'; Fuel1 <= '1'; Fuel0 <='0'; -- FWL = 0
        wait for 10 ns;
        Fuel3 <= '1'; Fuel2 <= '1'; Fuel1 <= '1'; Fuel0 <='1'; -- FWL = 0
		wait; -- will wait forever
	END PROCESS;

END;
