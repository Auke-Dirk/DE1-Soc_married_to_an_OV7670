library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

------------------------------------------------------------
-- author Auke-Dirk Pietersma
--
-- VGA Vertical Sequencer
--
-- vga_vsequencer is a simple sequencer for the horizontal
-- states of a vga controller.
-- The states in order, with their duration
--
--	back porch   33
--  active       480
--  front porch  10
--	retrace      2
--  -----------------
--  total        525
------------------------------------------------------------

entity vga_vsequencer is
port(
  clk      : in  std_logic;  --< clock, 25/25.175 MHz
  reset    : in  std_logic;  --< reset
  bp_out   : out std_logic;  --> back porch
  act_out  : out std_logic;  --> active
  fp_out   : out std_logic;  --> front porch
  ret_out  : out std_logic   --> retrace
);      
end vga_vsequencer;

architecture archi of vga_vsequencer is  

constant BP  : integer := 33;  
constant ACT : integer := 480; 
constant FP  : integer := 10; 
constant RET : integer := 2; 
        
signal cntr: std_logic_vector(9 downto 0);	-- we need to count up 525 2^10  

begin
process (clk, reset) 
begin   
  if (reset = '1') then   
    cntr <= "0000000000";         
  elsif (rising_edge(clk)) then
    
	 cntr <= cntr + 1;  -- increment
	 	 
	 if (cntr = 800) then  -- cntr [0,799]
	   cntr <= "0000000000";
    end if;
	
  end if;     
end process; 

bp_out  <= '1' when tmp < BP   else '0';
act_out <= '1' when tmp >= BP and tmp < (BP + ACT) else '0';
fp_out  <= '1' when tmp >= (BP + ACT) and tmp < (BP + ACT + FP) else '0';
ret_out <= '1' when tmp >= (BP + ACT + FP) else '0';		  

end archi;
