----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 11:24:39
-- Design Name: 
-- Module Name: test_MD - Behavioral
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

entity test_MD is
--  Port ( );
end test_MD;

architecture Behavioral of test_MD is
component MD IS
    Port ( ADD : in STD_LOGIC_VECTOR (7 downto 0);
           DIN : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;
signal ADD, DIN, DOUT: STD_LOGIC_VECTOR (7 downto 0);
signal RW, RST:STD_LOGIC:= '1';
signal CLK : STD_LOGIC:= '0';
begin
    memory_d: MD PORT MAP(ADD, DIN, RW, RST, CLK, DOUT);
    
    ADD<= X"00";
    DIN<= X"01";
    CLK<= not CLK after 5 ns;
    RST<='0' after 3 ns,'1' after 6 ns;
    RW<='0' after 100 ns;

end Behavioral;
