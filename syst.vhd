----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2022 10:57:49
-- Design Name: 
-- Module Name: syst - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity syst is
    Port ( clock : in STD_LOGIC;
         raz : in STD_LOGIC;
         PWM_EN : out STD_LOGIC;
         out_PWM : out STD_LOGIC);
end syst;

architecture Behavioral of syst is

signal out_timebase : std_logic ;
signal out_compteur : STD_LOGIC_VECTOR (15 downto 0);
signal out_ROM: STD_LOGIC_VECTOR(10 DOWNTO 0) ;
signal odata: STD_LOGIC;

begin

    TimeCE : entity work.timebase port map (
            clock  => clock,
            raz    => raz,
            output => out_timebase );

    compt: entity work.Compteur port map (
            raz     => raz,
            clock   => clock,
            CE44100 => out_timebase,
            output  => out_compteur );

    ROM: entity work.wav_rom port map(
            CLOCK    => CLOCK,
            ADDR_R   => out_compteur,
            DATA_OUT => out_ROM );

    PWM_audio : entity work.PWM_mod port map (
            idata      => out_ROM,
            CE_44100HZ => out_timebase,
            clock      => clock,
            raz        => raz,
            odata      => out_PWM,
            EN => PWM_EN );


end Behavioral;
