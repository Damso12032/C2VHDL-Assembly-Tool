----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2023 13:30:29
-- Design Name: 
-- Module Name: compteur_8bits - Behavioral
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
use IEEE.std_logic_arith.all ;
use IEEE.std_logic_unsigned.all ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity compteur_8bits is
    Port ( CK : in STD_LOGIC;
           RST : in STD_LOGIC;
           SENS : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end compteur_8bits;

architecture Behavioral of compteur_8bits is
    SIGNAL aux:STD_LOGIC_VECTOR (7 downto 0):=X"00";
    
begin
Dout<=aux;
    process
    variable cpt:INTEGER:=0;
    begin
    WAIT until CK'event;
        if(CK='1') then 
            if RST='1' then aux<=x"00";cpt:=0;
            else
                if EN='0' then 
                    cpt:=0;
                    if (LOAD='0') then
                        
                        if(sens='1') then 
                            aux<=aux + 1;
                           
                        else
                            aux<=aux-1;
                            
                        end if;
                    end if;
                end if;
            end if;
         else
              if EN='1' then
              --dans le cas où il y'a un aléa
                if cpt=0 then
                  aux<=aux-1;
                  cpt:=cpt+1;
                else
                  aux<=aux;
                  cpt:=cpt+1;
                end if;
              elsif EN='0' and cpt>=1 then
              --dans le cas où on a assez attendu et qu'il n'a plus d'alea
                  aux<=aux+1;
              elsif EN='0' and LOAD='1' then
                aux<=Din;
              end if;
          end if;
    end process;
end Behavioral;