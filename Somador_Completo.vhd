LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SomadorCompleto IS
	PORT(
		A_SC, B_SC, CI_SC: IN STD_LOGIC;
		S_SC, CO_SC: OUT STD_LOGIC
	);
END SomadorCompleto;

ARCHITECTURE soma OF SomadorCompleto IS

BEGIN

S_SC <= A_SC XOR B_SC XOR CI_SC;
CO_SC <= (A_SC AND B_SC) OR (A_SC AND CI_SC) OR (B_SC AND CI_SC);

END soma;