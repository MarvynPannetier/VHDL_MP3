----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 14:30:08
-- Design Name: 
-- Module Name: tb_compteur - Behavioral
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

entity tb_Compteur is
end;

architecture bench of tb_Compteur is

  component Compteur
      Port ( raz : in STD_LOGIC;
             clock : in STD_LOGIC;
             CE44100 : in STD_LOGIC;
             output : out STD_LOGIC_VECTOR (15 downto 0));
  end component;

  signal raz: STD_LOGIC;
  signal clock: STD_LOGIC;
  signal CE44100: STD_LOGIC;
  signal output: STD_LOGIC_VECTOR (15 downto 0);

  constant clock_period: time := 10 ns;
  constant clock_period2: time := 22675 ns;
  signal stop_the_clock: boolean;

begin

  uut: Compteur port map ( raz     => raz,
                           clock   => clock,
                           CE44100 => CE44100,
                           output  => output );


raz <= '1', '0' after 30 ns;

 clocking2: process
  begin
    while not stop_the_clock loop
      CE44100 <= '1', '0' after clock_period;
      wait for clock_period2;
    end loop;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '1', '0' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
