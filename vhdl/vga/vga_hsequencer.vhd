library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.Numeric_Std.all;

------------------------------------------------------------
-- author Auke-Dirk Pietersma
--
-- VGA Horizontal Sequencer
--
-- vga_hsequencer is a simple sequencer for the horizontal
-- states of a vga controller.
-- The states in order, with their duration
--
--  back porch   48
--  active       640
--  front porch  16
--  retrace      96
--  -----------------
--  total        800
------------------------------------------------------------

entity vga_hsequencer is
port(
  clk      : in  std_logic;  --< clock, 25/25.175 MHz
  reset    : in  std_logic;  --< reset
  bp_out   : out std_logic;  --> back porch
  act_out  : out std_logic;  --> active
  fp_out   : out std_logic;  --> front porch
  ret_out  : out std_logic   --> retrace
);      
end vga_hsequencer;

-- 
architecture archi of vga_hsequencer is  

constant BP  : integer := 48;  
constant ACT : integer := 640; 
constant FP  : integer := 16; 
constant RET : integer := 96;
constant SD  : integer := BP + ACT + FP + RET; -- the Signal Duration
        
-- we need to count up 800 2^10  
signal cntr: std_logic_vector(9 downto 0) :=  std_logic_vector(to_unsigned(SD - 1,10));

begin
process (clk, reset) 
begin   
 
  --if (reset = '1') then   
  --  cntr <= std_logic_vector(to_unsigned(SD - 1,cntr'length));
  if (rising_edge(clk)) then   	 
	if (cntr = SD -1) then  -- cntr [0,799]
		cntr <= "0000000000";
	else
		cntr <= cntr + 1;  -- increment
	end if;
  end if;
end process; 

-- The (output) state signals
--bp_out  <= '1' when cntr /= "0000000001" else '0';
bp_out  <= '1' when cntr < BP   else '0';
act_out <= '1' when cntr >= BP and cntr < (BP + ACT) else '0';
fp_out  <= '1' when cntr >= (BP + ACT) and cntr < (BP + ACT + FP) else '0';
ret_out <= '1' when cntr >= (BP + ACT + FP) else '0';		  

end archi;
