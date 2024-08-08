----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 11:15:29
-- Design Name: 
-- Module Name: MD - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MD is
    Port ( ADD : in STD_LOGIC_VECTOR (7 downto 0);
           DIN : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end MD;

architecture Behavioral of MD is
subtype INDEX is INTEGER range 0 to 7;
type VECTEUR is array (INDEX) of STD_LOGIC_VECTOR(7 downto 0);
signal myArray : VECTEUR := (others=>X"00");
begin

process
    begin
        wait on CLK; 
        if CLK'event and CLK='1' and RST='0' then 
            myArray<= (OTHERS => X"00");
        end if;
        
        if CLK'event and CLK='0' then
            if RW='1' then
                DOUT <= myArray(to_integer(unsigned(ADD)));
            else
                myArray(to_integer(unsigned(ADD))) <= DIN;
            end if;
        end if;
    end process;
    
end Behavioral;
