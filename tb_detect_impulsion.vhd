----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 14:03:40
-- Design Name: 
-- Module Name: tb_detect_impulsion - Behavioral
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

entity tb_detect_impulsion is
    --  Port ( );
end tb_detect_impulsion;

architecture Behavioral of tb_detect_impulsion is

    component detect_impulsion is
        Port ( clock : in STD_LOGIC;
             input : in STD_LOGIC;
             output : out STD_LOGIC);
    end component;



    signal s_clock : std_logic;
    signal s_input  : std_logic;
    signal s_output   : std_logic;
    constant period : time := 100 ns;

begin

    clock_process: process
    begin
        s_clock <= '1';
        wait for period/2;
        s_clock <= '0';
        wait for period/2;
    end process ;

    -- instanciation du component �  tester
    uut : detect_impulsion port map( clock => s_clock,
                 input => s_input,
                 output => s_output);

    -- génération des stimuli logiques
    
    s_input <= '0', '1' after 210 ns, '0' after 1000 ns;
    

end Behavioral;






