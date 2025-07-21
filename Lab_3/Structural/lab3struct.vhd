----------------------------------------------------------------------
-- EECS31L Assignment 3
-- Locator Structural Model
----------------------------------------------------------------------
-- Student First Name : Cameron 
-- Student Last Name : Peterson-Zopf
-- Student ID : 57999719
----------------------------------------------------------------------

---------- Components library ----------

---------- 8x16 Register File ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile IS
   PORT (R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
         R_en, W_en: IN std_logic;
         Reg_Data1 : OUT std_logic_vector(15 DOWNTO 0); 
			Reg_Data2 : OUT std_logic_vector(15 DOWNTO 0); 
         W_Data: IN std_logic_vector(15 DOWNTO 0); 
         Clk, Rst: IN std_logic);
END RegFile;

ARCHITECTURE Beh OF RegFile IS 
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type;
BEGIN
   WriteProcess: PROCESS(Clk)    
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            regArray(0) <= X"0000" AFTER 6.0 NS;
            regArray(1) <= X"000B" AFTER 6.0 NS;
            regArray(2) <= X"0023" AFTER 6.0 NS;
            regArray(3) <= X"0007" AFTER 6.0 NS;
            regArray(4) <= X"000A" AFTER 6.0 NS;
            regArray(5) <= X"0000" AFTER 6.0 NS;
            regArray(6) <= X"0000" AFTER 6.0 NS;
            regArray(7) <= X"0000" AFTER 6.0 NS;
         ELSE
            IF (W_en = '1') THEN
                regArray(conv_integer(W_Addr)) <= W_Data AFTER 6.0 NS;
                END IF;
        END IF;
     END IF;
   END PROCESS;
            
   ReadProcess1: PROCESS(R_en, R_Addr1, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr1 IS
            WHEN "000" =>
                Reg_Data1 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data1 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data1 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data1 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data1 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data1 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data1 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data1 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
	
	ReadProcess2: PROCESS(R_en, R_Addr2, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr2 IS
            WHEN "000" =>
                Reg_Data2 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data2 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data2 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data2 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data2 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data2 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data2 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data2 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
END Beh;


---------- 16-Bit ALU ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY ALU IS
    PORT (Sel: IN std_logic;
            A: IN std_logic_vector(15 DOWNTO 0);
            B: IN std_logic_vector(15 DOWNTO 0);
            ALU_Out: OUT std_logic_vector (15 DOWNTO 0) );
END ALU;

ARCHITECTURE Beh OF ALU IS

BEGIN
    PROCESS (A, B, Sel)
         variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
        IF (Sel = '0') THEN
            ALU_Out <= A + B AFTER 12 NS;                
        ELSIF (Sel = '1') THEN
            temp := A * B ;
			ALU_Out <= temp(15 downto 0) AFTER 12 NS; 
        END IF;
    END PROCESS;
END Beh;


---------- 16-bit Shifter ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shifter IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         sel: IN std_logic );
END Shifter;

ARCHITECTURE Beh OF Shifter IS 
BEGIN
   PROCESS (I,sel) 
   BEGIN
         IF (sel = '1') THEN 
            Q <= I(14 downto 0) & '0' AFTER 4.0 NS;
         ELSE
            Q <= '0' & I(15 downto 1) AFTER 4.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 2-to-1 Selector ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Selector IS
   PORT (sel: IN std_logic;
         x,y: IN std_logic_vector(15 DOWNTO 0);
         f: OUT std_logic_vector(15 DOWNTO 0));
END Selector;

ARCHITECTURE Beh OF Selector IS 
BEGIN
   PROCESS (x,y,sel)
   BEGIN
         IF (sel = '0') THEN
            f <= x AFTER 3.0 NS;
         ELSE
            f <= y AFTER 3.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 16-bit Register ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         Ld: IN std_logic; 
         Clk, Rst: IN std_logic );
END Reg;

ARCHITECTURE Beh OF Reg IS 
BEGIN
   PROCESS (Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            Q <= X"0000" AFTER 4.0 NS;
         ELSIF (Ld = '1') THEN
            Q <= I AFTER 4.0 NS;
         END IF;   
      END IF;
   END PROCESS; 
END Beh;

---------- 16-bit Three-state Buffer ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeStateBuff IS
    PORT (Control_Input: IN std_logic;
          Data_Input: IN std_logic_vector(15 DOWNTO 0);
          Output: OUT std_logic_vector(15 DOWNTO 0) );
END ThreeStateBuff;

ARCHITECTURE Beh OF ThreeStateBuff IS
BEGIN
    PROCESS (Control_Input, Data_Input)
    BEGIN
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER 2 NS;
        ELSE
            Output <= (OTHERS=>'Z') AFTER 2 NS;
        END IF;
    END PROCESS;
END Beh;

---------- Controller ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Controller IS
    PORT(R_en: OUT std_logic;
         W_en: OUT std_logic;
         R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
		 R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
         W_Addr: OUT std_logic_vector(2 DOWNTO 0);
         Shifter_Sel: OUT std_logic;
         Selector_Sel: OUT std_logic;
         ALU_sel : OUT std_logic;
         OutReg_Ld: OUT std_logic;
         Oe: OUT std_logic;
         Done: OUT std_logic;
         Start, Clk, Rst: IN std_logic); 
END Controller;


ARCHITECTURE Beh OF Controller IS

-------------------------------------------------------
-- Hint:
-- Controller shall consist of a CombLogic process 
-- containing case-statement and a StateReg process.
SUBTYPE Statetype IS std_logic_vector (3 downto 0);
SIGNAL CurrentState, NextState: Statetype; 
begin 
    StateReg: PROCESS (Clk)
    begin 
        IF (Clk'Event and Clk = '1') THEN 
            IF (Rst = '1') THEN 
                CurrentState <= "0000" after 4 ns; 
            ELSE 
                CurrentState <= NextState after 4 ns; 
            END IF;
        END IF; 
     END PROCESS; 
     
     CombLogic: PROCESS (Start, CurrentState)
     begin 
     CASE CurrentState IS 
        --S_Start
        WHEN "0000" => 
            IF (Start = '0') THEN 
                NextState <= "0000" after 11 ns;
                ---R_en <= 'X' after 11 ns; 
                W_en <= '0' after 11 ns; 
                ---R_Addr1 <= "XXX" after 11 ns; 
                ---R_Addr2 <= "XXX" after 11 ns; 
                ---W_Addr <= "XXX" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                ---Selector_Sel <= 'X' after 11 ns; 
                ---ALU_sel <= 'X' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns; 
            ELSE --Start = 1
                NextState <= "0001" after 11 ns;
               --- R_en <= 'X' after 11 ns; 
                W_en <= '0' after 11 ns; 
                ---R_Addr1 <= "XXX" after 11 ns; 
                ---R_Addr2 <= "XXX" after 11 ns; 
                ---W_Addr <= "XXX" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                --Selector_Sel <= 'X' after 11 ns; 
                --ALU_sel <= 'X' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns; 
            END IF; 
        ---S_Math1
        WHEN "0001" => 
                NextState <= "0010" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                R_Addr1 <= "010" after 11 ns; 
                R_Addr2 <= "010" after 11 ns; 
                W_Addr <= "101" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                Selector_Sel <= '1' after 11 ns; 
                ALU_sel <= '1' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;         
        ---S_Math2
        WHEN "0010" => 
                NextState <= "0011" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                R_Addr1 <= "101" after 11 ns; 
                R_Addr2 <= "001" after 11 ns; 
                W_Addr <= "101" after 11 ns; 
                --Shifter_Sel <= 'X' after 11 ns; 
                Selector_Sel <= '1' after 11 ns; 
                ALU_sel <= '1' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;         
        ---S_Math3
        WHEN "0011" => 
                NextState <= "0100" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                ---R_Addr1 <= "XXX" after 11 ns; 
                R_Addr2 <= "101" after 11 ns; 
                W_Addr <= "101" after 11 ns; 
                Shifter_Sel <= '0' after 11 ns; 
                Selector_Sel <= '0' after 11 ns; 
                ---ALU_sel <= 'X' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;
         ---S_Math4
        WHEN "0100" => 
                NextState <= "0101" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                R_Addr1 <= "010" after 11 ns; 
                R_Addr2 <= "011" after 11 ns; 
                W_Addr <= "110" after 11 ns; 
                --Shifter_Sel <= 'X' after 11 ns; 
                Selector_Sel <= '1' after 11 ns; 
                ALU_sel <= '1' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;   
           ---S_Math5
         WHEN "0101" => 
                NextState <= "0110" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                R_Addr1 <= "110" after 11 ns; 
                R_Addr2 <= "100" after 11 ns; 
                W_Addr <= "111" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                Selector_Sel <= '1' after 11 ns; 
                ALU_sel <= '0' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;   
           ---S_Math6
        WHEN "0110" => 
                NextState <= "0111" after 11 ns;
                R_en <= '1' after 11 ns; 
                W_en <= '1' after 11 ns; 
                R_Addr1 <= "101" after 11 ns; 
                R_Addr2 <= "111" after 11 ns; 
                W_Addr <= "111" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                Selector_Sel <= '1' after 11 ns; 
                ALU_sel <= '0' after 11 ns;
                OutReg_Ld <= '1' after 11 ns; 
                Oe <= '0' after 11 ns;
                Done <= '0' after 11 ns;   
        ---S_Math7
        WHEN "0111" => 
                NextState <= "0000" after 11 ns;
                ---R_en <= 'X' after 11 ns; 
                W_en <= '0' after 11 ns; 
                ---R_Addr1 <= "XXX" after 11 ns; 
                --R_Addr2 <= "XXX" after 11 ns; 
                --W_Addr <= "XXX" after 11 ns; 
                ---Shifter_Sel <= 'X' after 11 ns; 
                ---Selector_Sel <= 'X' after 11 ns; 
                ---ALU_sel <= 'X' after 11 ns;
                OutReg_Ld <= '0' after 11 ns; 
                Oe <= '1' after 11 ns;
                Done <= '1' after 11 ns;
        WHEN Others => 
        --do nothing 
        END CASE;     
        END PROCESS; 

END Beh;
---------- Locator (with clock cycle =  37 NS )----------
--         INDICATE YOUR CLOCK CYCLE TIME ABOVE      ----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Locator_struct is
    Port ( Clk : in  STD_LOGIC;
		   Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_struct;

architecture Struct of Locator_struct is
    
    COMPONENT RegFile IS
        PORT (  R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
                R_en, W_en: IN std_logic;
                Reg_Data1: OUT std_logic_vector(15 DOWNTO 0); 
				Reg_Data2: OUT std_logic_vector(15 DOWNTO 0);
                W_Data: IN std_logic_vector(15 DOWNTO 0); 
                Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ALU IS
        PORT (Sel: IN std_logic;
                A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                ALU_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
    END COMPONENT;

    COMPONENT Shifter IS
         PORT (I: IN std_logic_vector(15 DOWNTO 0);
               Q: OUT std_logic_vector(15 DOWNTO 0);
               sel: IN std_logic );
    END COMPONENT;

    COMPONENT Selector IS
        PORT (sel: IN std_logic;
              x,y: IN std_logic_vector(15 DOWNTO 0);
              f: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
   
    COMPONENT Reg IS
        PORT (I: IN std_logic_vector(15 DOWNTO 0);
              Q: OUT std_logic_vector(15 DOWNTO 0);
              Ld: IN std_logic; 
              Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ThreeStateBuff IS
        PORT (Control_Input: IN std_logic;
              Data_Input: IN std_logic_vector(15 DOWNTO 0);
              Output: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
    
    COMPONENT Controller IS
       PORT(R_en: OUT std_logic;
            W_en: OUT std_logic;
            R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
			R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
            W_Addr: OUT std_logic_vector(2 DOWNTO 0);
            Shifter_sel: OUT std_logic;
            Selector_sel: OUT std_logic;
            ALU_sel : OUT std_logic;
            OutReg_Ld: OUT std_logic;
            Oe: OUT std_logic;
            Done: OUT std_logic;
            Start, Clk, Rst: IN std_logic); 
     END COMPONENT;

-- do not modify any code above this line
-- add signals needed below. hint: name them something you can keep track of while debugging/testing
-- add your code starting here
 SUBTYPE Statetype IS std_logic_vector (3 downto 0);
 SIGNAL CurrentState, NextState: Statetype; 
 SIGNAL R_Addr1_s, R_Addr2_s, W_Addr_s: std_logic_vector (2 downto 0); 
 SIGNAL R_en_s, W_en_s: std_logic;
 SIGNAL Reg_Data_1_s,Reg_Data_2_s: std_logic_vector (15 downto 0);
 SIGNAL ALU_sel_s, shifter_sel_s, sel_s, outreg_ld_s, Oe_s, done_s: std_logic; 
 SIGNAL Shiftertosel_s, ALUtosel_s: std_logic_vector (15 downto 0); 
 SIGNAL Output_selector_s, output_outreg_s: std_logic_vector (15 downto 0);

BEGIN 
 -----Controller Port Map-----
 Controller_1: controller PORT MAP (R_en => R_en_s, W_en => W_en_s, R_Addr1 => R_Addr1_s, R_Addr2 => R_Addr2_s, W_Addr => W_Addr_s, Shifter_sel => shifter_sel_s, Selector_sel => sel_s, ALU_sel => ALU_sel_s, Outreg_ld => Outreg_ld_s,Oe => Oe_s, Done => Done, Start => Start, Clk => Clk, Rst => Rst);       
 -----Data path Port Map-----        
 RegFile_1: RegFile PORT MAP (R_Addr1 => R_Addr1_s, R_Addr2 => R_Addr2_s, W_Addr => W_Addr_s, R_en => R_en_s, W_en => W_en_s, Reg_Data1 => Reg_Data_1_s, Reg_Data2 => Reg_Data_2_s, W_Data => Output_selector_s, Clk => Clk, Rst => Rst); 
 ALU_1: ALU PORT MAP (Sel => ALU_sel_s, A => Reg_Data_2_s, B => Reg_Data_1_s, ALU_Out => ALUtosel_s);
 Shifter_1: Shifter PORT MAP (I => Reg_Data_2_s, Q => Shiftertosel_s, sel => shifter_sel_s); 
 Selector_1: Selector PORT MAP (sel => sel_s, x => shiftertosel_s, y => ALUtosel_s, f => Output_selector_s);
 OutReg_1: Reg PORT MAP (I => Output_selector_s, Q => output_outreg_s, Ld => outreg_ld_s, Clk => Clk, Rst => Rst); 
 ThreeStateBuff_1: ThreeStateBuff Port Map (Control_Input => Oe_s, Data_Input => output_outreg_s, Output => Loc); 

end Struct;     

