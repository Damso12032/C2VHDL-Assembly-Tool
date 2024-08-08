----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 11:47:41
-- Design Name: 
-- Module Name: test_MI - Behavioral
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

entity test_MI is
--  Port ( );
end test_MI;

architecture Behavioral of test_MI is
component MI IS
    Port ( IP : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           EN : in STD_LOGIC; 
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal IP: STD_LOGIC_VECTOR (7 downto 0);
signal DOUT: STD_LOGIC_VECTOR (31 downto 0);
signal CLK : STD_LOGIC:= '0';
signal EN : STD_LOGIC:= '1';

begin
    memory_i: MI PORT MAP(IP, CLK, EN, DOUT);
    
    IP<= X"00";
    CLK<= not CLK after 5 ns;

end Behavioral;
