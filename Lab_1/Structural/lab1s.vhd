----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 (Structural) - S22
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Cameron
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY NAND2 IS
   PORT (x: IN std_logic;
         y: IN std_logic;
         F: OUT std_logic);
END NAND2;  

ARCHITECTURE behav OF NAND2 IS
BEGIN
   PROCESS(x, y)
   BEGIN
      F <= NOT (x AND y) AFTER 1.4 ns; 
   END PROCESS;
END behav;
---we need this part so we can define the behavior of the gate we are going to use. 
---The only time we don't need to do this is when we are using the AND, OR or NOT since those are built in. 
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY LFDetector_structural IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_structural;

ARCHITECTURE Structural OF LFDetector_structural IS
-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- you should be declaring and connecting components in this code
-- you should not use a PROCESS for lab 1s
-- use the appropriate library component(s) specified in the lab handout
-- add the appropriate internal signals & wire your design below

    COMPONENT NAND2 is
        PORT (x, y: IN std_logic;
              F: OUT std_logic); 
    END COMPONENT; 
----------------------------------------------------------
    SIGNAL w1, w2, w3: std_logic; 
----------------------------------------------------------
BEGIN 
    NAND2_1: NAND2 PORT MAP (Fuel3, Fuel3, w1);
    NAND2_2: NAND2 PORT MAP (Fuel2, Fuel2, w2);
    NAND2_3: NAND2 PORT MAP (w2, w1, w3); ---it does not matter whether I have w1 or w2 first
    NAND2_4: NAND2 PORT MAP (w3, w3, FuelWarningLight); 
END Structural;

