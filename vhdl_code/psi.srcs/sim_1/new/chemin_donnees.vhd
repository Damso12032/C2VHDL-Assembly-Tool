----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2023 12:02:16
-- Design Name: 
-- Module Name: chemin_donnees - Behavioral
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

entity chemin_donnees is
--  Port ( );
end chemin_donnees;

architecture Behavioral of chemin_donnees is
component MD IS
    Port ( ADD : in STD_LOGIC_VECTOR (7 downto 0);
           DIN : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MI IS
    Port ( IP : in STD_LOGIC_VECTOR (7 downto 0);
           CLK: in STD_LOGIC;
           EN : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

Component ALU is 
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0);
           Flags : out STD_LOGIC_VECTOR (3 downto 0);
           S : inout STD_LOGIC_VECTOR (7 downto 0));
end component;

Component banc_registre is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       W : in STD_LOGIC_VECTOR (3 downto 0);
       WR : in STD_LOGIC;
       DATA : in STD_LOGIC_VECTOR (7 downto 0);
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       QA : out STD_LOGIC_VECTOR (7 downto 0);
       QB : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

Component ALEA is
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
END COMPONENT;

COMPONENT EX_MEM is
    Port ( CLK_DI_EX: in STD_LOGIC;
           EX_A : in STD_LOGIC_VECTOR (7 downto 0);
           EX_Op : in STD_LOGIC_VECTOR (7 downto 0);
           EX_B : in STD_LOGIC_VECTOR (7 downto 0);
           MEM_A : out STD_LOGIC_VECTOR (7 downto 0);
           MEM_Op : out STD_LOGIC_VECTOR (7 downto 0);
           MEM_B : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;
COMPONENT LI_DI is
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
end COMPONENT;

COMPONENT compteur_8bits is
    Port ( CK : in STD_LOGIC;
       RST : in STD_LOGIC;
       SENS : in STD_LOGIC;
       LOAD : in STD_LOGIC;
       EN : in STD_LOGIC;
       Din : in STD_LOGIC_VECTOR (7 downto 0);
       Dout : out STD_LOGIC_VECTOR (7 downto 0));
end component;


-- mémoire d'instructions
signal IP: STD_LOGIC_VECTOR (7 downto 0);
signal DOUT: STD_LOGIC_VECTOR (31 downto 0);
signal CLK : STD_LOGIC:= '0';
signal EN_MI: STD_LOGIC:= '1';



-- banc de registres
Signal A,B,W:STD_LOGIC_VECTOR (3 downto 0);
Signal DATA, QA, QB: STD_LOGIC_VECTOR (7 downto 0);
Signal RST: STD_LOGIC := '1';
Signal WR: STD_LOGIC := '0';

-- ALU
Signal A_alu, B_alu, S: STD_LOGIC_VECTOR (7 downto 0);
Signal Ctrl_Alu: STD_LOGIC_VECTOR (1 downto 0);
signal Flags : STD_LOGIC_VECTOR (3 downto 0);

-- mémoire données
signal ADD, DIN, DOUT_md: STD_LOGIC_VECTOR (7 downto 0);
signal RW, RST_md:STD_LOGIC:= '1';

-- alea
signal OP_LI_DI,OP_DI_EX,OP_EX_Mem,OP_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
signal A_DI_EX, A_EX_Mem,A_Mem_RE : STD_LOGIC_VECTOR (7 downto 0);
signal B_LI_DI,C_LI_DI : STD_LOGIC_VECTOR (7 downto 0);
signal OUT_alea :STD_LOGIC;
---LI_DI--
signal LI_A,LI_B,LI_C,LI_OP,DI_A,DI_B,DI_C,DI_OP:STD_LOGIC_VECTOR (7 downto 0);
signal en_li_di: STD_LOGIC:='0';


---DI_EX---
signal DI2_A,DI2_B,DI2_C,DI2_OP:STD_LOGIC_VECTOR (7 downto 0);
signal EX_A,EX_B,EX_C,EX_OP:STD_LOGIC_VECTOR (7 downto 0);
signal en_di_ex:STD_LOGIC:='0';
---EX_MEM---
signal EX2_A,EX2_B,EX2_C,EX2_OP:STD_LOGIC_VECTOR (7 downto 0);
signal MEM_A,MEM_B,MEM_OP:STD_LOGIC_VECTOR (7 downto 0);
---MEM_RE---
signal MEM2_A,MEM2_B,MEM2_OP:STD_LOGIC_VECTOR (7 downto 0);
signal RE_A,RE_B,RE_OP:STD_LOGIC_VECTOR (7 downto 0);

---compteur---
signal RST_compteur,LOAD:STD_LOGIC:='0';
signal SENS:STD_LOGIC:='1';
signal EN:STD_LOGIC:='0';
signal Din_compteur,Dout_compteur:STD_LOGIC_VECTOR (7 downto 0);



begin
    compteur:compteur_8bits PORT MAP(CLK,RST_compteur,SENS,LOAD,EN,Din_compteur,Dout_compteur);
    memory_i: MI PORT MAP(IP, CLK, EN_MI, DOUT);
    br:banc_registre PORT MAP (A,B,W,WR,DATA,RST,CLK,QA,QB);
    ual:ALU PORT MAP (A_alu,B_alu,Ctrl_Alu,Flags,S);
    memory_d: MD PORT MAP(ADD, DIN, RW, RST_md, CLK, DOUT_md);
    aleaa: ALEA PORT MAP(OP_LI_DI,OP_DI_EX,OP_EX_Mem,OP_Mem_RE,A_DI_EX ,A_EX_Mem,A_MEM_RE,B_LI_DI,C_LI_DI,OUT_alea);
    lidi: LI_DI PORT MAP(CLK, LI_A,LI_OP,LI_B,LI_C,en_li_di,DI_A,DI_OP,DI_B,DI_C);
    diex: LI_DI PORT MAP(CLK,DI2_A,DI2_OP,DI2_B,DI2_C,en_di_ex,EX_A,EX_OP,EX_B,EX_C);
    exmem:EX_MEM PORT MAP(CLK,EX2_A,EX2_OP,EX2_B,MEM_A,MEM_OP,MEM_B);
    memre:EX_MEM PORT MAP(CLK,MEM2_A,MEM2_OP,MEM2_B,RE_A,RE_OP,RE_B);
    
    CLK<= not CLK after 5 ns;
    
    
    ---------compteur----------
    EN<=NOT OUT_ALEA;
    --on ne modifie la valeur de IP que quand on a un JMP(0D) et un JUMPF(0E) avec condition fausse
    LOAD<='1' when LI_OP=X"0D" or (EX_OP=X"0E" and EX_A=X"00") else '0';
    --On change IP à LI_A quand il y'a un jump et à EX_B+1 quand il y'a JUMPF
    --car on a déja chargé EX_B dans IP(voir ligne 200)
    Din_compteur<=LI_A when LI_OP=X"0D" else
         (EX_B+1) when EX_OP=X"0E" and EX_A=X"00" ;
    --------memoire d'instruction------
    IP<=DI2_B when (DI2_OP=X"0E" and DI2_A=X"00") else Dout_compteur;
    ------------ alea ---------------
    OP_LI_DI<=LI_OP;
    OP_DI_EX <= DI2_OP;
    OP_EX_Mem <= EX2_OP;
    OP_Mem_RE<=MEM2_OP;
    A_DI_EX <= DI2_A;
    A_EX_Mem <=EX2_A;
    A_Mem_RE<=MEM2_A;
    --on lit au registre A dans le cas d'un JUMPF(0E)
    B_LI_DI <=LI_A when LI_OP=X"0E" else  LI_B;
    C_LI_DI <=LI_C;
    
    
    ------------ pipeline 1 -----------
    en_li_di<=not OUT_ALEA;
    --on change les li quand on a un JUMPF devant que la condition à verifier est false
    --ON ajoute ainsi dérriere ce JUMPF un JUMP
    LI_OP <= X"0D" when DI2_OP=X"0E" and DI2_A=X"00" else DOUT (31 downto 24) ; 
    LI_A<= DI2_B when DI2_OP=X"0E" and DI2_A=X"00" else DOUT (23 downto 16)  ;
    LI_B <=DOUT (15 downto 8) ;
    LI_C<=DOUT (7 downto 0) ;
    
    
    --------------- BR ------------
    --Quand on un JUMPF(0E) on lit la valeur du registre DI_A sinon
    --on lit tout le temps le B 
    A<=DI_A(3 downto 0) when DI_OP=X"0E" else  DI_B(3 downto 0);
    B <= DI_C (3 downto 0);
    --On n'écrit pas dans les régistres quand on a un NOPE, un STORE, un JMP et un JMPF
    WR <='0' when RE_OP=X"00" or RE_OP=X"08" or RE_OP=X"0D" or RE_OP=X"0E" else '1';
    W<=RE_A(3 downto 0);
    DATA<=RE_B;
    
     ------------ pipeline 2 -----------
    --on récupére la valeur du registre DI_A quand on a un JUMPF sinon
    --on propage toujours la sortie A du 1er pipeline(DI_A)
    DI2_A<=QA when DI_OP=X"0E" else DI_A;
    DI2_OP<=DI_OP;
    --On ne lit pas dans les registres quand on a un AFC,LOAD,NOPE, JMP
    --On lit quand il y'a un JUMPF mais on stocke le resultat dans DI2_A
    DI2_B <= DI_B when DI_OP=X"06" or  DI_OP=X"07" or  DI_OP=X"00" or DI_OP=X"0D" or DI_OP=X"0E" else 
                                QA; 
    DI2_C<=QB;
    
    --------------------ALU -------
    --On prend EX_C comme A_alu et EX_B comme B_ALU dans le cas où on a SUP ou SUPE afin de faire C-B
    --Ainsi, on va les traiter de la méme maniére que INF et INFE
    A_alu <= EX_C when EX_OP=X"0A" or EX_OP=X"1A" else
         EX_B;
    B_alu <=EX_B when EX_OP=X"0A" or EX_OP=X"1A" else
         EX_C;
    --On realise les calculs correspondants lorsqu'on a une opération arithméthique
    --Sinon on fait une soustraction dans le cas où on a les opérateurs de comparaison(INF,INFE,SUP,SUPE,EQU,NEQU)
    Ctrl_Alu <= EX_OP (1 downto 0) when EX_OP=X"01" or EX_OP=X"02" or EX_OP=X"03" else
                "11";
    
    
     ------------ pipeline 3 -----------
    EX2_A<=EX_A;
    EX2_OP<=EX_OP;
    --On prend le résultat de l'ALU que quand il y'a une opération arithmétique(ADD,SOU,MUL,DIV)
    --On prend dans EX2_B le flag zéro(flags(1)) lorsqu'il y'a l'opération EQU(0B) 
    --On prend dans EX2_B le non du flag zéro(non flags(1)) lorsqu'il y'a NEQU(2B)
    --On prend dans EX2_B le flag négatif(flags(3)) lorsqu'il y'a INF et SUP(09 et 0A)
    --On prend dans EX2_B le flag négatif+le flag zéro(flags(3) & flags(1)) lorsqu'il y'a INFE et SUPE(19 et 1A)
    --Et dans les autres cas on ne tient pas compte des résultats de l'ALU
    EX2_B <= S  when EX_OP=X"01" OR EX_OP=X"02" OR EX_OP=X"03" OR EX_OP=X"04" 
                else "0000000"& Flags(1) when EX_OP=X"0B"
                else "0000000"& (NOT Flags(1)) when EX_OP=X"2B"
                else "0000000"& Flags(3) when EX_OP=X"09" or EX_OP=X"0A"
                else "000000"&Flags(3)&Flags(1) when EX_OP=X"19" or EX_OP=X"1A"
                else EX_B;
                    
                    
    --------------------- MD ------
    --Si on a un LOAD(07) on part lire dans la mémoire la valeur qui est à l'adresse MEM_B
    --Si on a un store(08), on doit écrire dans la mémoire à l'adresse MEM_A
    --Sinon on met par défaut 00 en entrée de la mémoire de donnée
    ADD <= MEM_A when MEM_OP=X"08" else
           MEM_B when MEM_OP=X"07" else
           X"00";
    DIN<=MEM_B;
    --On n'écrit dans la mémoire de données que quand il y'a un store
    RW<='0' when MEM_OP=X"08" else '1';
    
     ------------ pipeline 4 -----------
    MEM2_A<=MEM_A;
    MEM2_OP<=MEM_OP;
    --On ne récupére la valeur lit dans la mémoire,de données que quand il y'a un LOAD
    MEM2_B <= DOUT_md when MEM_OP=X"07" else
              MEM_B;
    

end Behavioral;
