library ieee;
use ieee.std_logic_1164.all;

entity RxC is
  
   port (entrada1, entrada2 : in std_logic_vector(3 downto 0);
        Ck,  clr_r, ld_r, ld_c : in  std_logic;  
        ex2 : out STD_LOGIC_VECTOR(7 downto 0);
        ex1 : out std_logic_vector(3 downto 0)
        
        );
end RxC;

architecture logica of RxC is
    
------------------- Componente 1 -------------------------
COMPONENT regC IS
   port (set, Ck, c012, Clr_r  : in  std_logic;
         ex1: out std_logic
         );
         --ck, clr, set, d -> Ck, Clr_r, ld_out, c012;
         --q, ~q -> ex1, ex2;
         
         
	END COMPONENT;	
------------------- Componente 2 -------------------------

COMPONENT regY IS
	port (ld_r, Ck, Y, Clr_r  : in  std_logic;
         ex1: out std_logic);
         --ck, clr, set, d -> Ck, Clr_r, ld_out, c012;
         --q, ~q -> ex1, ex2;
         
	END COMPONENT;
------------------- Componente 3 -------------------------
	
COMPONENT multiplicador IS
	port (
        a : in STD_LOGIC_VECTOR(3 downto 0);    -- Operando A (4 bits)
        b : in STD_LOGIC_VECTOR(3 downto 0);    -- Operando B (4 bits)
        cout : out STD_LOGIC;                    -- Carry de sa?da
        mul : out STD_LOGIC_VECTOR(7 downto 0)   -- Resultado da multi (8 bits)
    );
         
	END COMPONENT;	  
	
	------------------ Sinais -----------------------------
  
  -- Sinais para portmap RegYC
    SIGNAL set : STD_LOGIC := '0';
    SIGNAL exit1RegC, exit1RegY : STD_LOGIC_VECTOR(3 downto 0):=(others => '0');
 
  -- Sinais para portmap Multiplicador
    SIGNAL coutt: STD_LOGIC := '0';
    SIGNAL mull : STD_LOGIC_VECTOR(7 downto 0):=(others => '0'); 
          
begin
  
  regcc0: regC PORT MAP(ld_c, ck, entrada2(0), clr_r, exit1RegC(0));
  regcc1: regC PORT MAP(ld_c, ck, entrada2(1), clr_r, exit1RegC(1));
  regcc2: regC PORT MAP(ld_c, ck, entrada2(2), clr_r, exit1RegC(2));
  regcc3: regC PORT MAP(ld_c, ck, entrada2(3), clr_r, exit1RegC(3));

  regyy0: regY PORT MAP(ld_r, ck, entrada1(0), clr_r, exit1RegY(0));
  regyy1: regY PORT MAP(ld_r, ck, entrada1(1), clr_r, exit1RegY(1));
  regyy2: regY PORT MAP(ld_r, ck, entrada1(2), clr_r, exit1RegY(2));
  regyy3: regY PORT MAP(ld_r, ck, entrada1(3), clr_r, exit1RegY(3));
    
  multii: multiplicador PORT MAP(exit1RegY, exit1RegC, coutt, mull);
    
  ex1 <= exit1RegY;
  ex2 <= mull;
    
end logica;