----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.05.2023 17:40:32
-- Design Name: 
-- Module Name: LI_DI - Behavioral
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

entity LI_DI is
    Port ( CLK_LI_DI:in STD_LOGIC;
           LI_A : in STD_LOGIC_VECTOR (7 downto 0);
           LI_Op : in STD_LOGIC_VECTOR (7 downto 0);
           Li_B : in STD_LOGIC_VECTOR (7 downto 0);
           LI_C : in STD_LOGIC_VECTOR (7 downto 0);
           EN:in STD_LOGIC;
           DI_A : out STD_LOGIC_VECTOR (7 downto 0);
           DI_Op : out STD_LOGIC_VECTOR (7 downto 0);
           DI_B : out STD_LOGIC_VECTOR (7 downto 0);
           DI_C : out STD_LOGIC_VECTOR (7 downto 0));
end LI_DI;

architecture Behavioral of LI_DI is
begin
    process
    begin
    wait until CLK_LI_DI'event and CLK_LI_DI='1';
    if (EN='1') then
        --dans le cas où il y'a un alea, on fait sortir un nope
        DI_A<=X"00";
        DI_Op<=X"00";
        DI_B<=X"00";
        DI_C<=X"00";

     else    
        DI_A<=LI_A;
        DI_Op<=LI_Op;
        DI_B<=LI_B;
        DI_C<=LI_C;
    end if;
    end process;
end Behavioral;
