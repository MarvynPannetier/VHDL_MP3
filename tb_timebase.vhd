----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 15:29:06
-- Design Name: 
-- Module Name: tb_timebase - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_timebase is
end;

architecture bench of tb_timebase is

  component timebase
      Port ( clock : in STD_LOGIC;
           raz : in STD_LOGIC;
           output : out STD_LOGIC);
  end component;

  signal clock: STD_LOGIC;
  signal raz: STD_LOGIC;
  signal output: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: timebase port map ( clock  => clock,
                           raz    => raz,
                           output => output );

 raz <= '1', '0' after 20 ns;
 

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
