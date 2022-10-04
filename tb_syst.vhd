----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 15:52:43
-- Design Name: 
-- Module Name: tb_syst - Behavioral
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

entity tb_syst is
end;

architecture bench of tb_syst is

    component timebase
        Port ( clock : in STD_LOGIC;
             raz : in STD_LOGIC;
             output : out STD_LOGIC);
    end component;

    signal clock: STD_LOGIC;
    signal raz: STD_LOGIC;
   -- signal output: STD_LOGIC;

    component Compteur
        Port ( raz : in STD_LOGIC;
             clock : in STD_LOGIC;
             CE44100 : in STD_LOGIC;
             output : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

    signal CE44100: STD_LOGIC;
    signal s_output: STD_LOGIC_VECTOR (15 downto 0);

    component wav_rom
        PORT (
            CLOCK          : IN  STD_LOGIC;
            ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
        );
    end component;


   -- signal ADDR_R: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal DATA_OUT: STD_LOGIC_VECTOR(10 DOWNTO 0) ;



    component PWM_mod
        Port ( idata : in STD_LOGIC_VECTOR (10 downto 0);
             CE_44100HZ : in STD_LOGIC;
             clock : in STD_LOGIC;
             raz : in STD_LOGIC;
             odata : out STD_LOGIC);
    end component;

   -- signal idata: STD_LOGIC_VECTOR (10 downto 0);
   -- signal CE_44100HZ: STD_LOGIC;
    signal odata: STD_LOGIC;

    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;

begin

    uut1: timebase port map ( clock  => clock,
                 raz    => raz,
                 output => CE44100 );

    uut2: Compteur port map ( raz     => raz,
                 clock   => clock,
                 CE44100 => CE44100,
                 output  => s_output );
                 
    uut3: wav_rom port map ( CLOCK    => CLOCK,
                          ADDR_R   => s_output,
                          DATA_OUT => DATA_OUT );

    uut4: PWM_mod port map ( idata      => DATA_OUT,
                 CE_44100HZ => CE44100,
                 clock      => clock,
                 raz        => raz,
                 odata      => odata );

    raz <= '1', '0' after 20 ns;

   
    clocking: process
    begin
        while not stop_the_clock loop
            clock <= '1', '0' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

end;
