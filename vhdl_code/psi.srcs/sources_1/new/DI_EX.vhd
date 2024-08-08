----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.05.2023 17:59:46
-- Design Name: 
-- Module Name: EX_MEM - Behavioral
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

entity EX_MEM is
    Port ( CLK_DI_EX: in STD_LOGIC;
           EX_A : in STD_LOGIC_VECTOR (7 downto 0);
           EX_Op : in STD_LOGIC_VECTOR (7 downto 0);
           EX_B : in STD_LOGIC_VECTOR (7 downto 0);
           MEM_A : out STD_LOGIC_VECTOR (7 downto 0);
           MEM_Op : out STD_LOGIC_VECTOR (7 downto 0);
           MEM_B : out STD_LOGIC_VECTOR (7 downto 0));
end EX_MEM;

architecture Behavioral of EX_MEM is
begin
    process
    begin
    wait until CLK_DI_EX'event and CLK_DI_EX='1';
    --wait on CLK_DI_EX;
    MEM_A<=EX_A;
    MEM_Op<=EX_Op;
    MEM_B<=EX_B;
    end process;


end Behavioral;
