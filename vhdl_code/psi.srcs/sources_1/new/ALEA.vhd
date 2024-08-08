----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2023 09:53:02
-- Design Name: 
-- Module Name: ALEA - Behavioral
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

entity ALEA is
    Port ( OP_LI_DI : in STD_LOGIC_VECTOR (7 downto 0);
           OP_DI_EX : in STD_LOGIC_VECTOR (7 downto 0);
           OP_EX_Mem : in STD_LOGIC_VECTOR (7 downto 0);
           OP_Mem_RE:in STD_LOGIC_VECTOR (7 downto 0);
           A_DI_EX : in STD_LOGIC_VECTOR (7 downto 0);
           A_EX_Mem : in STD_LOGIC_VECTOR (7 downto 0);
           A_Mem_RE : in STD_LOGIC_VECTOR (7 downto 0);
           B_LI_DI : in STD_LOGIC_VECTOR (7 downto 0);
           C_LI_DI : in STD_LOGIC_VECTOR (7 downto 0);
           OUT_alea : out STD_LOGIC);
end ALEA;

architecture Behavioral of ALEA is
begin
    process(OP_LI_DI,OP_DI_EX,OP_EX_Mem,OP_Mem_RE,A_DI_EX,A_EX_Mem,A_Mem_RE,B_LI_DI,C_LI_DI)
    begin
        if(OP_DI_EX=X"00" and OP_Mem_RE=X"00" and OP_DI_EX=X"00") then
            OUT_alea <= '1';
        elsif ((OP_LI_DI<=X"05" and OP_LI_DI/=X"00") OR OP_LI_DI=X"08" OR (OP_LI_DI>=X"09" and OP_LI_DI/=X"0D"))
            AND ((OP_DI_EX<=X"07" and OP_DI_EX>X"00") or (OP_DI_EX>=X"09" and OP_DI_EX/=X"0C" and OP_DI_EX/=X"0D" and OP_DI_EX/=X"0E")) 
            AND (B_LI_DI=A_DI_EX OR C_LI_DI=A_DI_EX) then 
            
            OUT_alea <= '0';
        elsif ((OP_LI_DI<=X"05" and OP_LI_DI/=X"00") OR OP_LI_DI=X"08" OR (OP_LI_DI>=X"09" and OP_LI_DI/=X"0D" ))
               AND ((OP_EX_Mem<=X"07" and OP_EX_Mem>X"00") or (OP_EX_Mem>=X"09" and OP_EX_Mem/=X"0C" and OP_EX_Mem/=X"0D" and OP_EX_Mem/=X"0E"))  
               AND (B_LI_DI=A_EX_Mem OR C_LI_DI=A_EX_Mem) then
            OUT_alea <= '0';
        elsif ((OP_LI_DI<=X"05" and OP_LI_DI/=X"00") OR OP_LI_DI=X"08" OR (OP_LI_DI>=X"09" and OP_LI_DI/=X"0D" ))
            AND ((OP_Mem_RE<=X"07" and OP_Mem_RE>X"00") or (OP_Mem_RE>=X"09" and OP_Mem_RE/=X"0C" and OP_Mem_RE/=X"0D" and OP_Mem_RE/=X"0E"))  
            AND (B_LI_DI=A_Mem_RE OR C_LI_DI=A_Mem_RE) then
            OUT_alea <= '0';
        else
            OUT_alea<='1';
        end if;
    end process;

end Behavioral;
