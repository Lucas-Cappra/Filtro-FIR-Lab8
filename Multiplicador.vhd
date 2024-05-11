library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplicador is
    Port (
        a : in STD_LOGIC_VECTOR(3 downto 0);    -- Operando A (4 bits)
        b : in STD_LOGIC_VECTOR(3 downto 0);    -- Operando B (4 bits)
        cout : out STD_LOGIC;                    -- Carry de sa?da
        mul : out STD_LOGIC_VECTOR(7 downto 0)   -- Resultado da multi (4 bits)
    );
end Multiplicador ;

architecture Behavioral of Multiplicador  is
 signal c : STD_LOGIC_VECTOR(17 downto 0);    -- Vetor de carry interno
 signal add : STD_LOGIC_VECTOR(12 downto 0);   -- Resultado da soma (4 bits)
begin

	mul(0) <= a(0) and b(0);

	add(0) <= (a(0) and b(1)) xor (a(1) and b(0));
	c(0) <= ((a(0) and b(1)) and (a(1) and b(0)));
	mul(1) <= add(0);

	add(1) <= ((a(0) and b(2)) xor (a(1) and b(1)) xor c(0));
	c(1) <= ((a(0) and b(2)) and (a(1) and b(1))) or ((a(0) and b(2)) and c(0)) or ((a(1) and b(1)) and c(0)); --isso vai pra add(3)
	add(2) <= add(1) xor (a(2) and b(0));
	c(2) <= add(1) and (a(2) and b(0)); --isso vai pra add(4)
	mul(2) <= add(2);

	add(3) <= (a(0) and b(3)) xor (a(1) and b(2)) xor c(1);
	c(3) <= ((a(0) and b(3)) and (a(1) and b(2))) or ((a(0) and b(3)) and c(1)) or ((a(1) and b(2)) and c(1)); --isso vai pra add(6) e c(6)
	add(4) <= add(3) xor (a(2) and b(1)) xor c(2);
	c(4) <= (add(3) and (a(2) and b(1))) or (add(3) and c(2)) or ((a(2) and b(1)) and c(2)); --isso vai pra add(6) e c(6)
	add(5) <=add(4) xor (a(3) and b(0));
	c(5) <= add(4) and (a(3) and b(0)); --isso vai pra add(7) e c(7)
	mul(3) <= add(5);

	add(6) <= c(3) xor (a(1) and b(3)) xor c(4);
	c(6) <= (c(3) and (a(1) and b(3))) or (c(3) and c(4)) or ((a(1) and b(3)) and c(4)); --isso vai pra add(9) e c(9)
	add(7) <= add(6) xor (a(2) and b(2)) xor c(5);
	c(7) <= (add(6) and (a(2) and b(2))) or (add(6) and c(5)) or ((a(2) and b(2)) and c(5)); --isso vai pra add(9) e c(9)
	add(8) <=add(7) xor (a(3) and b(1));
	c(8) <= add(7) and (a(3) and b(1)); --isso vai pra add(10) e c(10)
	mul(4) <= add(8);
	
	add(9) <= c(6) xor (a(2) and b(3)) xor c(7);
	c(9) <= (c(6) and (a(2) and b(3))) or (c(6) and c(7)) or ((a(2) and b(3)) and c(7)); --isso vai pra add(11) e c(11)
	add(10) <= add(9) xor (a(3) and b(2)) xor c(8);
	c(10) <= (add(9) and (a(3) and b(2))) or (add(9) and c(8)) or ((a(3) and b(2)) and c(8)); --isso vai pra add(11) e c(11)
	mul(5) <= add(10); 
	
	add(11) <= c(9) xor (a(3) and b(3)) xor c(10);
	c(11) <= (c(9) and (a(3) and b(3))) or (c(9) and c(10)) or ((a(3) and b(3)) and c(10)); --isso vai pra mul(7)
	mul(6) <= add(11);

	mul(7) <= c(11);
	cout<= add(11);
	
	
end Behavioral;
