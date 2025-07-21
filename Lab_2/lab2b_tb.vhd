--------------------------------------------------------------------------------
-- Company:       EECS 31L
-- Engineer:      Cameron Peterson-Zopf  
-- 
-- VHDL Test Bench Created by ISE for module: Lab2b_FSM
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
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY lab2b_tb IS
END lab2b_tb;
 
ARCHITECTURE behavior OF lab2b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Lab2b_FSM
    PORT(
         Input : IN  std_logic_vector(2 downto 0);
         Clk : IN  std_logic;
         Permit : OUT  std_logic;
         ReturnChange : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(2 downto 0) := (others => '0');
   signal Clk : std_logic := '0';

 	--Outputs
   signal Permit : std_logic;
   signal ReturnChange : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Lab2b_FSM PORT MAP (
          Input => Input,
          Clk => Clk,
          Permit => Permit,
          ReturnChange => ReturnChange
        );

   -- Clock process definitions
   Clk_process: process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for some number of ns.
      wait for 40 ns;	
      -- waiting for next clock edge, then adding a little bit of time
      -- to help avoid any potential setup/hold time errors
      -- you can remove these next 2 lines and/or modify them as you wish
      WAIT UNTIL clk = '1' AND clk'EVENT;
      WAIT for 2 ns;
      -- insert stimulus here 
      -- TEST CASE 0 BEGIN (provided) --
	  -- insert $10 ($10 total)
		Input <= "010";
		Wait for 20 NS ;
	    Input <= "000";
		Wait for 20 NS ;
	  -- insert $5 ($15 total)
	    Input <= "001";
		Wait for 20 NS ;
	    Input <= "000";
		Wait for 20 NS ;
	  -- insert $5 ($20 total, expecting P=1, R=0)
	    Input <= "001";
		Wait for 10 NS ; ---since we wait for one clk cyle here instead of 20 ns per rubric
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 0" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 0" SEVERITY WARNING;
	  -- Check to make sure we got P = 1 and R = 0 once we hit $20
	    Wait for 10 NS ; ---wait for another 10 ns so total is 20 ns since bill is entered
		Input <= "000";
		Wait for 20 NS ;
      -- END TEST CASE 0; 
	
	-- TEST CASE 1 BEGIN --
	  -- insert Nothing ($0 total)
		Input <= "000";
		Wait for 20 NS ; 
		ASSERT Permit = '0' REPORT "p = 0 fail with test case 1" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 1" SEVERITY WARNING;
	  -- Check to make sure we got P = 0 and R = 0 (that we successful stay in Idle State) 
      -- END TEST CASE 1;
      
    -- TEST CASE 2 BEGIN --
	  -- insert Cancel Right Away ($0 total)
		Input <= "111";
		Wait for 20 NS ; 
		ASSERT Permit = '0' REPORT "p = 0 fail with test case 2" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 2" SEVERITY WARNING;
	  -- Check to make sure we got P = 0 and R = 0 (that we successful stay in Idle State)
      -- END TEST CASE 2;
      
	 -- TEST CASE 3 BEGIN --
	  -- insert $5 ($5 total)
		Input <= "001";
		Wait for 20 NS ;
	    Input <= "000";
		Wait for 20 NS ;
	  -- insert $20 ($25 total)
	    Input <= "100";
		Wait for 10 NS ; ---since we wait for one clk cyle here instead of 20 ns per rubric
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 3" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 1 fail with test case 3" SEVERITY WARNING;
	  -- Check to make sure we got P = 1 and R = 1 once we hit $25
	    Wait for 10 NS ; ---wait for another 10 ns so total is 20 ns since bill is entered
		Input <= "000";
		Wait for 20 NS ;
      -- END TEST CASE 3;	
		
	-- TEST CASE 4 BEGIN --
	  -- insert $5 ($5 total)
		Input <= "001";
		Wait for 20 NS ;
	    Input <= "000";
		Wait for 20 NS ;
	  -- insert $10 ($15 total)
	    Input <= "010";
		Wait for 20 NS;
		Input <= "000";
		Wait for 20 NS;
	--insert $10 ($25 total)
		Input <= "010";
		Wait for 10 NS ; ---since we wait for one clk cyle here instead of 20 ns per rubric
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 4" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 1 fail with test case 4" SEVERITY WARNING;
	  -- Check to make sure we got P = 1 and R = 1 once we hit $25
	    Wait for 10 NS ; ---wait for another 10 ns so total is 20 ns since bill is entered
		Input <= "000";
		Wait for 20 NS ;
      -- END TEST CASE 4;
      
     -- TEST CASE 5 BEGIN --
	  -- insert $5 ($5 total)
		Input <= "001";
		Wait for 20 NS ;
	    Input <= "100"; ---invalid...let's see if it stays at current state (and doesn't prove a permit)
		Wait for 20 NS ;
		Input <= "000";
		Wait for 20 NS; 
	  -- Cancel
	    Input <= "111";
		Wait for 10 NS ; ---since we wait for one clk cyle here instead of 20 ns per rubric
		ASSERT Permit = '0' REPORT "p = 0 fail with test case 5" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 1 fail with test case 5" SEVERITY WARNING;
	  -- Check to make sure we recieved money back but no permit
	    Wait for 10 NS ; ---wait for another 10 ns so total is 20 ns since bill is entered
		Input <= "000";
		Wait for 20 NS ;
      -- END TEST CASE 5;
      
      Wait;
   end process;
         
END;
