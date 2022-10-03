----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 13:48:31
-- Design Name: 
-- Module Name: tb_cpt_1_9 - Behavioral
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

entity tb_cpt_1_9 is
    --  Port ( );
end tb_cpt_1_9;

architecture Behavioral of tb_cpt_1_9 is

    component cpt_1_9 is
        Port ( raz : in STD_LOGIC;
             incr : in STD_LOGIC;
             decr : in STD_LOGIC;
             clock : in STD_LOGIC;
             sortie : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal s_raz :  STD_LOGIC;
    signal  s_incr : STD_LOGIC;
    signal  s_decr :  STD_LOGIC;
    signal    s_clock :  STD_LOGIC;
    signal     s_sortie :  STD_LOGIC_VECTOR (3 downto 0);
    constant period : time := 10 ns;

begin

    clock_process: process
    begin
        s_clock <= '1';
        wait for period/2;
        s_clock <= '0';
        wait for period/2;
    end process ;


    uut : cpt_1_9 port map (
            raz => s_raz,
            incr => s_incr,
            decr => s_decr,
            clock => s_clock,
            sortie => s_sortie);
            
s_raz <= '1', '0' after 105 ns; 
s_incr <= '0', '1' after 85 ns, '0' after 302 ns;
s_decr <= '0', '1' after 302 ns;
 

end Behavioral;
