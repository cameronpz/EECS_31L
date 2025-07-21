----------------------------------------------------------------------
-- EECS31L Assignment 2
-- FSM Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cameron
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Lab2b_FSM is
    Port ( Input : in  STD_LOGIC_VECTOR(2 DOWNTO 0);
           Clk : in  STD_LOGIC;
           Permit : out  STD_LOGIC;
           ReturnChange : out  STD_LOGIC);
end Lab2b_FSM;

architecture Behavioral of Lab2b_FSM is
-- DO NOT modify any signals, ports, or entities above this line
-- Recommendation: Create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- Figure out the appropriate sensitivity list of both the processes.
-- Use CASE statements and IF/ELSE/ELSIF statements to describe your processes.
-- add your code signal

    TYPE Statetype is 
        (S_Idle, S_5, S_10, S_15, S_20, S_Extra, S_C, S_W5, S_W10, S_W15, S_WF, S_WC);
        ---Ex. S_5 reads "State $5"; S_C reads "State Cancel"; S_W5 reads "State Wait $5";
        ---S_WF reads "State Wait Final"; S_Extra reads "State with Extra Money"
    SIGNAL Currstate, Nextstate: Statetype;

BEGIN
    StateReg: PROCESS (Clk)
    BEGIN
        IF (Clk = '1' AND Clk'EVENT) then
            Currstate <= Nextstate;    ---current state gets set to next state at every rising edge
        END IF;
    END PROCESS StateReg;
   CombLogic: PROCESS (Currstate, Input)
   BEGIN 
        CASE Currstate is 
        ---Situations when we don't have conditions (blue arrows in FSM):
            WHEN S_20 => 
                Permit <= '1';
                ReturnChange <= '0';
                Nextstate <= S_WF;
            WHEN S_Extra => 
                Permit <= '1';
                ReturnChange <= '1';
                Nextstate <= S_WF;
            WHEN S_C => 
                Permit <= '0';
                ReturnChange <= '1';
                Nextstate <= S_WC;
       ---All Main States:
            WHEN S_Idle => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_Idle;
                ELSIF (Input = "111") THEN 
                    Nextstate <= S_Idle;
                ELSIF (Input = "001") THEN 
                    Nextstate <= S_W5;
                ELSIF (Input = "010") THEN 
                    Nextstate <= S_W10;
                ELSIF (Input = "100") THEN 
                    Nextstate <= S_20;
                END IF;
            WHEN S_5 => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_5;
                ELSIF (Input = "111") THEN 
                    Nextstate <= S_C;
                ELSIF (Input = "001") THEN 
                    Nextstate <= S_W10;
                ELSIF (Input = "010") THEN 
                    Nextstate <= S_W15;
                ELSIF (Input = "100") THEN 
                    Nextstate <= S_Extra;
                END IF;   
            WHEN S_10 =>      
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_10;
                ELSIF (Input = "111") THEN 
                    Nextstate <= S_C;
                ELSIF (Input = "001") THEN 
                    Nextstate <= S_W15;
                ELSIF (Input = "010") THEN 
                    Nextstate <= S_20;
                ELSIF (Input = "100") THEN 
                    Nextstate <= S_Extra;
                END IF;
            WHEN S_15 =>   
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_15;
                ELSIF (Input = "111") THEN 
                    Nextstate <= S_C;
                ELSIF (Input = "001") THEN 
                    Nextstate <= S_20;
                ELSIF (Input = "010") THEN 
                    Nextstate <= S_Extra;
                ELSIF (Input = "100") THEN 
                    Nextstate <= S_Extra;
                END IF;
             ---Wait States: 
             WHEN S_W5 => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_5;
                ElSE 
                    Nextstate <= S_W5;
                END IF;
             WHEN S_W10 => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_10;
                ElSE 
                    Nextstate <= S_W10;
                END IF;
             WHEN S_W15 => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_15;
                ElSE 
                    Nextstate <= S_W15;
                END IF;
             WHEN S_WF => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_Idle;
                ElSE 
                    Nextstate <= S_WF;
                END IF;
             WHEN S_WC => 
                Permit <= '0';
                ReturnChange <= '0';
                IF (Input = "000") THEN 
                    Nextstate <= S_Idle;
                ElSE 
                    Nextstate <= S_WC;
                END IF;
          END CASE;
        END PROCESS;
      END Behavioral;