----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 13:02:55
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
           Flags : out STD_LOGIC_VECTOR (3 downto 0);
           --Flags(3)= N 
           --Flags(2)= O
           --Flags(1)= Z 
           --Flags(0)= C
           S : inout STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal aux: STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    signal aux_mul: STD_LOGIC_VECTOR (15 downto 0) :=  X"0000";
    signal negatif:STD_LOGIC:='0';
begin

    S<= aux(7 downto 0) when Ctrl_Alu/="10" else aux_mul(7 downto 0);
    
    process(A,B,aux, aux_mul, Ctrl_Alu)
        variable A_extend: STD_LOGIC_VECTOR (8 downto 0);
        variable B_extend: STD_LOGIC_VECTOR (8 downto 0);
        
    begin
    A_extend := '0' & A;
    B_extend := '0' & B;
    
    if Ctrl_Alu="01" then 
        aux<= A_extend + B_extend; 
    elsif Ctrl_Alu="11" then
        if(A_extend>B_extend) then
            aux<=A_extend - B_extend;
        else
            aux<=B_extend-A_extend;
            negatif<='1';
        end if;
    elsif Ctrl_Alu="10" then 
        aux_mul<=A * B ;
    else
        --aux<= std_logic_vector(to_unsigned(to_integer(unsigned(A) / unsigned(B)),8));
        --aux_mul<=std_logic_vector(to_unsigned(to_integer(unsigned(A))/to_integer(unsigned(B)),16));
    end if; 
    
     end process;
     --Flags(3)= N 
     --Flags(2)= O
     --Flags(1)= Z 
     --Flags(0)= C
     Flags(0) <= '1' when Ctrl_Alu/="10" and aux(aux'high)='1' else '0';
     Flags(1) <= '1' when S=X"00" else '0';  
     Flags(2) <= '1' when  (Ctrl_Alu="01" and aux(aux'high)='1') or (Ctrl_Alu="10" and aux_mul(15 downto 8)/=X"00") else '0';
     Flags(3) <= negatif;
     

     
end Behavioral;
