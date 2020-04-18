LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY one_hot_machine IS
	PORT(w, clock, reset : IN STD_LOGIC;
	     y : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0);
		  z : OUT STD_LOGIC);
END one_hot_machine;
		  
ARCHITECTURE Structural OF one_hot_machine IS

COMPONENT flip_flop IS
	PORT (D, Clock, Resetn : IN STD_LOGIC;
			Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL input_FF : STD_LOGIC_VECTOR(8 DOWNTO 0);

BEGIN

 input_FF(0) <= reset; -- A
 input_FF(1) <= (y(0) AND NOT(w)) OR (NOT(w) AND (y(5) OR y(6) OR y(7) OR y(8))); --OR (NOT(w) AND z(5)) OR (NOT(w) AND z(6)) OR (NOT  B
 input_FF(2) <= (y(1) AND NOT(w)); --C
 input_FF(3) <= (y(2) AND NOT(w)); --D
 input_FF(4) <= (y(3) AND NOT(w)) OR (NOT(w) AND y(4)); --E
 input_FF(5) <= (y(0) AND (w)) OR ((w) AND (y(1) OR y(2) OR y(3) OR y(4))); --F
 input_FF(6) <= (y(5) AND (w)); --G
 input_FF(7) <= (y(6) AND (w)); --H
 input_FF(8) <= (y(7) AND (w)) OR ((w) AND y(8)); --I
 
 z <= y(4) OR y(8);

 FF0 : flip_flop PORT MAP (D => input_FF(0) , Clock => clock , Resetn => '1' , Q => y(0));

Generate_FF:

  FOR i IN 1 TO 8 GENERATE
  
  FF : flip_flop PORT MAP (D => input_FF(i) , Clock => clock , Resetn => reset , Q => y(i));
  
END GENERATE Generate_FF;

END Structural;
