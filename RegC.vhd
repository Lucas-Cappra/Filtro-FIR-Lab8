library ieee;
use ieee.std_logic_1164.all;

entity regc is
   port (ck, Clr_r, set, c012 : in  std_logic;
                       ex1 : out std_logic);
end regc;

architecture logica of regc is

begin
   process(Ck, Clr_r, set)
   begin
      if    (set = '0')            then ex1 <= '1';
      elsif (Clr_r = '0')            then ex1 <= '0';
      elsif (ck'event and ck ='1') then ex1 <= c012;    
      end if;   
   end process;   
end logica;
