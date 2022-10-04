----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 11:34:05
-- Design Name: 
-- Module Name: tb_PWM_mod - Behavioral
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

entity tb_PWM_mod is
end;

architecture bench of tb_PWM_mod is

  component PWM_mod
      Port ( idata : in STD_LOGIC_VECTOR (10 downto 0);
           CE_44100HZ : in STD_LOGIC;
           clock : in STD_LOGIC;
           raz : in STD_LOGIC;
           odata : out STD_LOGIC);
  end component;

  signal idata: STD_LOGIC_VECTOR (10 downto 0);
  signal CE_44100HZ: STD_LOGIC;
  signal clock: STD_LOGIC;
  signal raz: STD_LOGIC;
  signal odata: STD_LOGIC;

  constant clock_period: time := 10 ns;
  constant clock_period2: time := 22675 ns;
  signal stop_the_clock: boolean;

begin

  uut: PWM_mod port map ( idata      => idata,
                          CE_44100HZ => CE_44100HZ,
                          clock      => clock,
                          raz        => raz,
                          odata      => odata );

    raz <= '1', '0' after 20 ns;
   -- CE_44100HZ <='0', '1' after 95 ns, '0' after 100 ns,'1' after 22770 ns,'0' after 22775 ns, '1' after 45445 ns, '0' after 45450 ns;
    
    idata <= "00000000001";

 clocking2: process
  begin
    while not stop_the_clock loop
      CE_44100HZ <= '1', '0' after clock_period / 2;
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
