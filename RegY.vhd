library ieee;
use ieee.std_logic_1164.all;

entity regy is
  
   port (ck, Clr_r, ld_r, Y : in  std_logic;
                       ex1 : out std_logic);
         
end regy;

architecture logica of regy is

begin
   process(Ck, Clr_r, ld_r)
   begin
      if    (ld_r = '0')            then ex1 <= '1';
      elsif (Clr_r = '0')            then ex1 <= '0';
      elsif (ck'event and ck ='1') then ex1 <= Y;    
      end if;   
   end process;   
end logica;
