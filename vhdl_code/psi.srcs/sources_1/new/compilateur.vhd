----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 13:09:19
-- Design Name: 
-- Module Name: memoire_instruction - Behavioral
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
use ieee.std_logic_textio.all;
use std.textio.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instruction is
    Port ( fl : in STD_LOGIC;
           result : out STD_LOGIC);
end memoire_instruction;

architecture Behavioral of memoire_instruction is
    file input_file : text;
begin
    process
        begin 
            file_open(input_file, "input.txt", read_mode);
            while not endfile(input_file) loop
            
            end loop;
        end process;

end Behavioral;
