LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FIR IS
	PORT(
		y, c012 : in STD_LOGIC_VECTOR(3 downto 0);
		clk, ld_r, clr_r, ld_out: IN STD_LOGIC;
		F : out STD_LOGIC_VECTOR(9 downto 0)
	);
	

END FIR;

ARCHITECTURE bloco OF FIR IS
   
------------------- Componente 1 -------------------------
COMPONENT RxC IS
   port (entrada1, entrada2 : in std_logic_vector(3 downto 0);
        Ck,  clr_r, ld_r, ld_c : in  std_logic;  
        ex2 : out STD_LOGIC_VECTOR(7 downto 0);
        ex1 : out std_logic_vector(3 downto 0) 
        );         
END COMPONENT;	

------------------- Componente 2 -------------------------
COMPONENT SomadorCompleto IS
   PORT(
		A_SC, B_SC, CI_SC: IN STD_LOGIC;
		S_SC, CO_SC: OUT STD_LOGIC
	);
END COMPONENT;	

------------------- Componente 3 -------------------------
COMPONENT ffd IS
      port (ck, clr, set, d : in  std_logic;
                       q : out std_logic);
        
END COMPONENT;	

  SIGNAL ld_c : STD_LOGIC := '0'; 
  
  SIGNAL exrec1 : std_logic_vector(3 downto 0); 
  SIGNAL exrec2 : std_logic_vector(7 downto 0);
  
  SIGNAL exrec3 : std_logic_vector(3 downto 0); 
  SIGNAL exrec4 : std_logic_vector(7 downto 0);
  
  SIGNAL exrec5 : std_logic_vector(3 downto 0); 
  SIGNAL exrec6 : std_logic_vector(7 downto 0);

  SIGNAL soma1  : std_logic_vector(3 downto 0); 
  SIGNAL soma2  : std_logic_vector(3 downto 0); 

  SIGNAL q      : std_logic_vector(7 downto 0);
  
  SIGNAL sete   : STD_LOGIC := '0';

BEGIN

  rec1: RxC PORT MAP(y, c012, clk, clr_r, ld_r, ld_c, exrec2, exrec1);  
  
  rec2: RxC PORT MAP(exrec1, c012, clk, clr_r, ld_r, ld_c, exrec4, exrec3);
    
  somador11: SomadorCompleto PORT MAP(exrec2(0), exrec3(0), '0', soma1(0));    
  somador12: SomadorCompleto PORT MAP(exrec2(1), exrec3(1), '0', soma1(1));  
  somador13: SomadorCompleto PORT MAP(exrec2(2), exrec3(2), '0', soma1(2));  
  somador14: SomadorCompleto PORT MAP(exrec2(3), exrec3(3), '0', soma1(3));
	
  rec3: RxC PORT MAP(exrec3, c012, clk, clr_r, ld_r, ld_c, exrec6, exrec5);  
    
  somador21: SomadorCompleto PORT MAP(soma1(0), exrec6(0), '0', soma2(0));  
  somador22: SomadorCompleto PORT MAP(soma1(1), exrec6(1), '0', soma2(1));  
  somador23: SomadorCompleto PORT MAP(soma1(2), exrec6(2), '0', soma2(2));  
  somador24: SomadorCompleto PORT MAP(soma1(3), exrec6(3), '0', soma2(3));

  Reg1: ffd PORT MAP(clk, clr_r, sete, ld_out, q(0)); 
  Reg2: ffd PORT MAP(clk, clr_r, sete, ld_out, q(1));
  Reg3: ffd PORT MAP(clk, clr_r, sete, ld_out, q(2));
  Reg4: ffd PORT MAP(clk, clr_r, sete, ld_out, q(3));
    
END bloco;


