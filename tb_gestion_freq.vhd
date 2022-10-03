----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 16:16:17
-- Design Name: 
-- Module Name: tb_gestion_freq - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_gestion_freq is
--  Port ( );
end tb_gestion_freq;

architecture Behavioral of tb_gestion_freq is

 component gestion_freq is
        Port ( clock : in STD_LOGIC;
         RAZ : in STD_LOGIC;
         CE_affichage : out STD_LOGIC;
         CE_perception : out STD_LOGIC);
    end component;

  signal s_clock : std_logic;
    signal s_RAZ  : std_logic;
    signal s_CE_affichage   : std_logic;
    signal s_CE_perception   : std_logic;
    constant period : time := 10 ns;
    signal count : std_logic_vector(15 downto 0) := x"0000";
    signal count2 : std_logic_vector(15 downto 0) := x"0000";

begin

clock_process: process
    begin
        s_clock <= '1';
        wait for period/2;
        s_clock <= '0';
        wait for period/2;
    end process ;

    -- instanciation du component �  tester
    uut : gestion_freq port map( clock => s_clock,
                 RAZ => s_RAZ,
                 CE_affichage => s_CE_affichage,
                 CE_perception => s_CE_perception);

    -- génération des stimuli logiques
    
    s_RAZ <= '1', '0' after 100 ns;
    
--    process(s_clock)
--    begin 
    
--    if(rising_edge(s_clock)) then
--    if(s_CE_perception = '1') then
     
--    count <= count + x"0001";
    
--    end if;
    
--    if(s_CE_affichage = '1') then
     
--    count2 <= count2 + x"0001";
    
--    end if;
    
--  end if;
    
    
--    end process;
    
    


end Behavioral;
