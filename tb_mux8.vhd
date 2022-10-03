----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2022 12:30:12
-- Design Name: 
-- Module Name: tb_mux8 - Behavioral
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

entity tb_mux8 is
end;

architecture bench of tb_mux8 is

  component mux8
      Port ( commande : in STD_LOGIC_VECTOR (2 downto 0);
           E0 : in STD_LOGIC_VECTOR (6 downto 0);
           E1 : in STD_LOGIC_VECTOR (6 downto 0);
           E2 : in STD_LOGIC_VECTOR (6 downto 0);
           E3 : in STD_LOGIC_VECTOR (6 downto 0);
           E4 : in STD_LOGIC_VECTOR (6 downto 0);
           E5 : in STD_LOGIC_VECTOR (6 downto 0);
           E6 : in STD_LOGIC_VECTOR (6 downto 0);
           E7 : in STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal commande: STD_LOGIC_VECTOR (2 downto 0);
--  signal E0: STD_LOGIC_VECTOR (6 downto 0);
--  signal E1: STD_LOGIC_VECTOR (6 downto 0);
--  signal E2: STD_LOGIC_VECTOR (6 downto 0);
--  signal E3: STD_LOGIC_VECTOR (6 downto 0);
--  signal E4: STD_LOGIC_VECTOR (6 downto 0);
--  signal E5: STD_LOGIC_VECTOR (6 downto 0);
--  signal E6: STD_LOGIC_VECTOR (6 downto 0);
--  signal E7: STD_LOGIC_VECTOR (6 downto 0);
  signal DP: STD_LOGIC;
  signal S: STD_LOGIC_VECTOR (6 downto 0);
  
   component Trans
      Port ( FORWARD : in STD_LOGIC;
           PLAY_PAUSE : in STD_LOGIC;
           RESTART : in STD_LOGIC;
           NB_MUS : in STD_LOGIC_VECTOR (9 downto 0);
           NB_VOL : in STD_LOGIC_VECTOR (3 downto 0);
           s_cent : out STD_LOGIC_VECTOR (6 downto 0);
           s_dizaine : out STD_LOGIC_VECTOR (6 downto 0);
           s_unit : out STD_LOGIC_VECTOR (6 downto 0);
           s_vol : out STD_LOGIC_VECTOR (6 downto 0);
           sortie1 : out STD_LOGIC_VECTOR (6 downto 0);
           sortie2 : out STD_LOGIC_VECTOR (6 downto 0);
           sortie3 : out STD_LOGIC_VECTOR (6 downto 0);
           sortie4 : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal FORWARD: STD_LOGIC;
  signal PLAY_PAUSE: STD_LOGIC;
  signal RESTART: STD_LOGIC;
  signal NB_MUS: STD_LOGIC_VECTOR (9 downto 0);
  signal NB_VOL: STD_LOGIC_VECTOR (3 downto 0);
  signal s_cent: STD_LOGIC_VECTOR (6 downto 0);
  signal s_dizaine: STD_LOGIC_VECTOR (6 downto 0);
  signal s_unit: STD_LOGIC_VECTOR (6 downto 0);
  signal s_vol: STD_LOGIC_VECTOR (6 downto 0);
  signal sortie1: STD_LOGIC_VECTOR (6 downto 0);
  signal sortie2: STD_LOGIC_VECTOR (6 downto 0);
  signal sortie3: STD_LOGIC_VECTOR (6 downto 0);
  signal sortie4: STD_LOGIC_VECTOR (6 downto 0);
  
  component gestion_freq is
        Port ( clock : in STD_LOGIC;
         RAZ : in STD_LOGIC;
         CE_affichage : out STD_LOGIC;
         CE_perception : out STD_LOGIC);
    end component;
  
    
    signal s_CE_affichage   : std_logic;
    signal s_CE_perception   : std_logic;

  component mod8
      Port ( CE : in STD_LOGIC;
             clock : in STD_LOGIC;
             raz : in STD_LOGIC;
             AN : out STD_LOGIC_VECTOR (7 downto 0);
             sortie : out STD_LOGIC_VECTOR (2 downto 0));
  end component;

  signal clock: STD_LOGIC;
  signal raz: STD_LOGIC;
  signal AN: STD_LOGIC_VECTOR (7 downto 0);
  signal sortie: STD_LOGIC_VECTOR (2 downto 0);

  constant clock_period: time := 10 ns;

begin

  uut : gestion_freq port map( clock => clock,
                 RAZ => raz,
                 CE_affichage => s_CE_affichage,
                 CE_perception => s_CE_perception);

  uut2: mod8 port map ( CE     => s_CE_perception,
                       clock  => clock,
                       raz    => raz,
                       AN     => AN,
                       sortie => sortie );

  uut3: Trans port map ( FORWARD    => FORWARD,
                        PLAY_PAUSE => PLAY_PAUSE,
                        RESTART    => RESTART,
                        NB_MUS     => NB_MUS,
                        NB_VOL     => NB_VOL,
                        s_cent     => s_cent,
                        s_dizaine  => s_dizaine,
                        s_unit     => s_unit,
                        s_vol      => s_vol,
                        sortie1    => sortie1,
                        sortie2    => sortie2,
                        sortie3    => sortie3,
                        sortie4    => sortie4 );

  uut4: mux8 port map ( commande => sortie,
                       E0       => s_cent,
                       E1       => s_dizaine,
                       E2       => s_unit,
                       E3       => s_vol,
                       E4       => sortie1,
                       E5       => sortie2,
                       E6       => sortie3,
                       E7       => sortie4,
                       DP       => DP,
                       S        => S );


raz <= '1', '0' after 135 ns;

  PLAY_PAUSE <=  '1', '0' after 800000000 ns ;
  FORWARD <= '1', '0' after 200000000 ns;
  RESTART <= '0', '1' after 500000000 ns, '0' after 800000000 ns;
  
  
  
  NB_VOL <= "0001" after 200000000 ns;
  
  NB_MUS <= "0110000011" after 100000000 ns;

   
 
clock_process: process
    begin
        clock <= '1';
        wait for clock_period/2;
        clock <= '0';
        wait for clock_period/2;
    end process ;
  


end;
