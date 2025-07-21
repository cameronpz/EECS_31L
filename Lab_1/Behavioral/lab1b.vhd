----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - S22
-- LFDetector Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cameron
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY LFDetector_behav IS
--define ports coming into the box
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_behav;

ARCHITECTURE Behavior OF LFDetector_behav IS
--no internal components since this is just behavorial
-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- put your code in a PROCESS
-- use AND/OR/NOT keywords for behavioral function
BEGIN 

    PROCESS (Fuel3, Fuel2, Fuel1, Fuel0)
BEGIN 
    FuelWarningLight <= NOT(Fuel3) AND NOT(Fuel2) ;
    END PROCESS;
END Behavior;