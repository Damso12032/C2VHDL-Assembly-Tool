----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2023 12:17:56
-- Design Name: 
-- Module Name: test_ALU - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_ALU is
--  Port ( );
end test_ALU;

architecture Behavioral of test_ALU is
COMPONENT ALU is 
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
       B : in STD_LOGIC_VECTOR (7 downto 0);
       Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
       Flags : out STD_LOGIC_VECTOR (3 downto 0);
       --Flags(3)= N 
       --Flags(2)= O
       --Flags(1)= Z 
       --Flags(0)= C
       S : inout STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;
signal A:STD_LOGIC_VECTOR (7 downto 0):=X"FF";
signal B:STD_LOGIC_VECTOR (7 downto 0):=X"02";
signal S:STD_LOGIC_VECTOR (7 downto 0);
signal Ctrl_Alu:STD_LOGIC_VECTOR (1 downto 0):="11";
signal Flags:STD_LOGIC_VECTOR (3 downto 0);
begin
aluu:ALU PORT MAP(A,B,Ctrl_Alu,Flags,S);
A<=X"FF" after 5 ns,X"04" after 10 ns,X"05" after 15 ns;
B<=X"02" after 5 ns,X"0F" after 10 ns,X"0F" after 15 ns;
Ctrl_Alu<="10" after 5 ns,"11" after 10 ns,"10" after 15 ns;


end Behavioral;
