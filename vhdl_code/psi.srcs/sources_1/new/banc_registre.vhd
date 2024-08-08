----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 13:28:46
-- Design Name: 
-- Module Name: banc_registre - Behavioral
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

entity banc_registre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC_VECTOR (3 downto 0);
           WR : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end banc_registre;

architecture Behavioral of banc_registre is
subtype INDEX is INTEGER range 0 to 15;
type VECTEUR is array (INDEX) of STD_LOGIC_VECTOR(7 downto 0);
signal myArray : VECTEUR:=(others=>X"00");
begin

    process
    begin
        
        wait on CLK;
        if CLK'event and CLK='1' then
            if RST='0' then 
                myArray<= (OTHERS => X"00");
--            else 
--                if WR='1' then
--                    myArray(to_integer(unsigned(W)))<= DATA;
--                end if;
            end if;
        end if;
        if CLK'event and CLK='0' then
            QA <= myArray(to_integer(unsigned(A)));
            QB <= myArray(to_integer(unsigned(B)));
            if WR='1' then
                myArray(to_integer(unsigned(W)))<= DATA;
            end if;
         end if;
    end process;

            
end Behavioral;