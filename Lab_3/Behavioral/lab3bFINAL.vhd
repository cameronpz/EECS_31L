----------------------------------------------------------------------
-- EECS31L Assignment 3 - S'22
-- Locator Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cameron
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


entity Locator_beh  is
    Port ( Clk : in  STD_LOGIC;
		   Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_beh;

architecture Behavioral of Locator_beh  is

   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type :=  (X"0000", X"000B", X"0023", X"0007", X"000A", X"0000", X"0000", X"0000");     

-- do not modify any code above this line
-- additional variables/signals can be declared if needed below
-- add your code starting here
TYPE Statetype IS (S_Start, S_Math, S_End); 
SIGNAL Curr_State, Next_State: Statetype; 

begin
    StateReg: PROCESS (Clk)
    BEGIN
        IF (Clk = '1' AND Clk'EVENT) then
            If (Rst = '1') then 
            Curr_State <= S_Start;
            else 
            Curr_State <= Next_State; 
            END IF;
        END IF; 
    END PROCESS StateReg;
    
    
    CombLogic: PROCESS (Start, Rst, Curr_State)
    variable Cat_L0: std_logic_vector(31 downto 0);
    variable Cat_L1: std_logic_vector(15 downto 0);
    variable Cat_L2: std_logic_vector(31 downto 0);
    variable Cat_L3: std_logic_vector(15 downto 0);
    begin
    CASE Next_State is 
         WHEN S_Start =>
              Done <= '0';
              Loc <= X"0000";
              IF (Start = '0') then
              Next_State <= S_Start; 
              ELSIF (Start = '1' AND Rst = '0')  then
              Next_State <= S_Math; 
              END IF;
         WHEN S_Math => 
              Cat_L0 := regArray(2) * regArray(2);
              Cat_L1:= Cat_L0(15 downto 0);
              Cat_L2 := Cat_L1* regArray(1);
              Cat_L3:= Cat_L2(15 downto 0);
              Cat_L3:= '0' & Cat_L3(15 downto 1);
              Cat_L0 := regArray(3) * regArray(2);
              Cat_L1 := Cat_L0(15 downto 0);
              Cat_L3 := Cat_L3 + Cat_L1 + regArray(4);
              Done <= '0';
              Loc <= X"0000"; 
              Next_State <= S_End; 
         WHEN S_End => 
              Done <= '1';
              Loc <= Cat_L3;     
              Next_State <= S_Start; 
         END CASE;  
     END PROCESS; 
                     
end Behavioral;

