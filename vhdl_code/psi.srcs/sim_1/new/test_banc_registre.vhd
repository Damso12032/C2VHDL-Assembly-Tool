----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 14:38:37
-- Design Name: 
-- Module Name: test_banc_registre - Behavioral
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

entity test_banc_registre is

end test_banc_registre;
architecture Behavioral of test_banc_registre is
Component banc_registre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       W : in STD_LOGIC_VECTOR (3 downto 0);
       WR : in STD_LOGIC;
       DATA : in STD_LOGIC_VECTOR (7 downto 0);
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       QA : out STD_LOGIC_VECTOR (7 downto 0);
       QB : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;
Signal A,B,W:STD_LOGIC_VECTOR (3 downto 0);
Signal DATA, QA, QB: STD_LOGIC_VECTOR (7 downto 0);
signal CLK : std_logic := '0';
Signal RST, WR: STD_LOGIC := '1';

begin
    br:banc_registre PORT MAP (A,B,W,WR,DATA,RST,CLK,QA,QB);
    
    A<="0000";
    B<="0001";
    CLK<= not CLK after 5 ns;
    RST<='0' after 3 ns,'1' after 6 ns;
    WR<='1' after 6 ns, '0' after 100 ns;
    W<="0010";
    DATA<=X"10";

end Behavioral;
