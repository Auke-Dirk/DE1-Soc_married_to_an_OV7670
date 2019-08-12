library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_div is
port(
  i_clk         : in  std_logic;
  i_rst         : in  std_logic;
  o_clk_div2    : out std_logic;
  o_clk_div4    : out std_logic;
  o_clk_div8    : out std_logic;
  o_clk_div16   : out std_logic);
end clock_div;

architecture rtl of clock_div is

signal clk_divider        : unsigned(3 downto 0);

begin


p_clk_divider: process(i_rst,i_clk)
begin
  if(i_rst='1') then
    clk_divider   <= (others=>'0');
  elsif(rising_edge(i_clk)) then
    clk_divider   <= clk_divider + 1;
  end if;
end process p_clk_divider;

o_clk_div2    <= clk_divider(0);
o_clk_div4    <= clk_divider(1);
o_clk_div8    <= clk_divider(2);
o_clk_div16   <= clk_divider(3);

end rtl;