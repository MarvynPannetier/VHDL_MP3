----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2022 15:24:13
-- Design Name: 
-- Module Name: tb_Trans - Behavioral
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

entity tb_Trans is
end;

architecture bench of tb_Trans is

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

begin

  uut: Trans port map ( FORWARD    => FORWARD,
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

  
  PLAY_PAUSE <=  '1', '0' after 800000000 ns ;
  FORWARD <= '1', '0' after 200000000 ns;
  RESTART <= '0', '1' after 500000000 ns, '0' after 800000000 ns;
  
  
  
  NB_VOL <= "0001" after 200000000 ns;
  
  NB_MUS <= "0001101111" after 100000000 ns;


end;
