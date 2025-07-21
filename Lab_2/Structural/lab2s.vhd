----------------------------------------------------------------------
-- EECS31L Assignment 2
-- FSM Structural Model
----------------------------------------------------------------------
-- Student First Name : Cameron
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Lab2s_FSM IS
     Port (Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
END Lab2s_FSM;

ARCHITECTURE Structural OF Lab2s_FSM IS

-- DO NOT modify any signals, ports, or entities above this line
-- Required - there are multiple ways to complete this FSM; however, you will be restricted to the following as a best practice:
-- Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- For the combinatorial process, use Boolean equations consisting of AND, OR, and NOT gates while expressing the delay in terms of the provided information from the lab handout for all signals. 
-- For the state register process, use IF statements. Remember to use the calculated delay from the lab handout.
-- Figure out the appropriate sensitivity list of both the processes.
-- add your code here
 SUBTYPE Statetype is std_logic_vector (3 downto 0);
 SIGNAL Curr_St, Next_State: Statetype := "0000";

begin 
CombLogic: Process (Curr_St, Input)
    begin 
    Permit <= (NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(1));
    ReturnChange <= ((NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(1)) AND Curr_St(0)) OR ((NOT Curr_St(3))AND Curr_St(2) AND Curr_St(1) AND (NOT Curr_St(0)));
    Next_State(3) <= ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND (NOT Curr_St(0)) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(1))) OR ((NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(0))) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Input(2) AND Input(1) AND Input(0)) after 5.6 ns;
    Next_State(2) <= ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(0) AND Input(2) AND Input(1) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND Input(2) AND Input(1) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND (NOT Curr_St(0)) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND Input(1) AND Input(0)) after 5.6 ns; 
    Next_State(1) <= ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND (NOT Curr_St(0)) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Curr_St(0) AND Input(2) AND Input(1) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND (NOT Input(2)) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(2)) AND Curr_St(1) AND Input(2) AND Input(1) AND Input(0)) OR ((NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(1))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND (NOT Curr_St(0))) OR
                     (Curr_St(3) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND (NOT Input(2)) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND Input(1) AND Input(0)) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Curr_St(1) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Curr_St(1) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Curr_St(1) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) after 5.6 ns; 
    Next_State(0) <= ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(0)) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Curr_St(0) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND (NOT Curr_St(2)) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(3)) AND Curr_St(2) AND Curr_St(1)) OR (Curr_St(3) AND (NOT Curr_St(2)) AND (NOT Curr_St(1)) AND Curr_St(0)) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND (NOT Input(1)) AND Input(0)) OR 
                     ((NOT Curr_St(2)) AND Curr_St(1) AND Curr_St(0) AND (NOT Input(2)) AND Input(1) AND (NOT Input(0))) OR 
                     ((NOT Curr_St(2)) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND (NOT Input(1)) AND (NOT Input(0))) OR 
                     (Curr_St(3) AND (NOT Curr_St(2)) AND Curr_St(1) AND Curr_St(0) AND Input(2) AND Input(1) AND Input(0)) after 5.6 ns;
    end process CombLogic;

StateRegister: Process (Clk)
    begin 
     If (Clk = '1' AND Clk'EVENT) then ---current state gets set to next state at every rising edge
            Curr_St <= Next_State after 4 ns; ---account for delay
        END IF;
    end process StateRegister;

END Structural;