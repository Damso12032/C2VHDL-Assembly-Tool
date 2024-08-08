----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 11:45:32
-- Design Name: 
-- Module Name: MI - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MI is
    Port ( IP : in STD_LOGIC_VECTOR (7 downto 0);
           CLK: in STD_LOGIC;
           EN : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end MI;

architecture Behavioral of MI is
subtype INDEX is INTEGER range 0 to 31;
type VECTEUR is array (INDEX) of STD_LOGIC_VECTOR(31 downto 0);
signal myArray : VECTEUR;
signal compteur: STD_LOGIC_VECTOR (7 downto 0);
begin
--myArray<=(X"06020900",X"06011000",X"05000100",X"06030500", others=>X"00000000");--test alea de donnée
--myArray<=(X"0B010102",X"06030900",X"0E010400",X"06030500", others=>X"00000000");
--myArray<=(X"06010002",X"0E010300",X"06020900",X"06030800",X"06040700", others=>X"00000000");--test alea de branchement
--myArray<=(X"06030200", X"06040300", X"01030304", X"08020300", X"06040500", X"08030400", X"07040300", X"08020400", X"06040000", X"08010400",others=>X"00000000");--inst_code1
myArray<=(x"06030200", x"06040300", x"01030304", x"08020300", x"06040500", x"08030400", x"07040200", x"06050300", x"0B040405", x"0E040d00", x"06050800", x"08030500", x"0D0f0000", x"06050a00", x"08020500", x"06050500", x"08010500",others=>X"00000000");
process
    
    begin
        wait until CLK'event and CLK='1';
            if(to_integer(unsigned(IP))=myArray'length) then
            --dans le cas où on n'a plus d'instruction à lire, on sort des nope
                DOUT<=X"00000000";
            else
                DOUT <= myArray(to_integer(unsigned(IP)));
            end if;
    end process;
end Behavioral;
