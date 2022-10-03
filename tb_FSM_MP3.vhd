----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 11:20:38
-- Design Name: 
-- Module Name: tb_FSM_MP3 - Behavioral
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

entity tb_FSM_MP3 is
    --  Port ( );
end tb_FSM_MP3;

architecture Behavioral of tb_FSM_MP3 is

    component FSM_MP3
        PORT (
            clock : in STD_LOGIC;
            reset : in STD_LOGIC;
            B_UP : in STD_LOGIC;
            B_DOWN : in STD_LOGIC;
            B_CENTER : in STD_LOGIC;
            B_LEFT : in STD_LOGIC;
            B_RIGHT : in STD_LOGIC;
            PLAY_PAUSE : out STD_LOGIC;
            RESTART : out STD_LOGIC;
            FORWARD : out STD_LOGIC;
            VOLUME_UP : out STD_LOGIC;
            VOLUME_DOWN : out STD_LOGIC
        );
    end component;
    
    signal CLOCK: STD_LOGIC;
    signal RESET: STD_LOGIC;
    signal B_UP: STD_LOGIC;
    signal B_DOWN: STD_LOGIC;
    signal B_CENTER: STD_LOGIC;
    signal B_LEFT: STD_LOGIC;
    signal B_RIGHT: STD_LOGIC;
    signal PLAY_PAUSE: STD_LOGIC;
    signal RESTART: STD_LOGIC;
    signal FORWARD: STD_LOGIC;
    signal VOLUME_UP: STD_LOGIC ;
    signal VOLUME_DOWN: STD_LOGIC ;
    
    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;
begin
    uut: FSM_MP3 port map ( RESET => RESET,
                 CLOCK => CLOCK,
                 B_UP => B_UP,
                 B_DOWN => B_DOWN,
                 B_CENTER => B_CENTER,
                 B_LEFT => B_LEFT,
                 B_RIGHT => B_RIGHT,
                 PLAY_PAUSE => PLAY_PAUSE,
                 RESTART => RESTART,
                 FORWARD => FORWARD,
                 VOLUME_UP => VOLUME_UP,
                 VOLUME_DOWN => VOLUME_DOWN );
                 
    clocking: process
    begin
        while not stop_the_clock loop
            CLOCK <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
    end process;

    stimulus: process
    begin
        -- Put initialisation code here
        RESET <= '1'; wait for CLOCK_period * 2;
        RESET <= '0'; wait for CLOCK_period * 2;
        -- ON PASSE DANS L'ETAT PLAY FWD
        B_CENTER <= '1'; wait for CLOCK_period;
        B_CENTER <= '0'; wait for CLOCK_period * 9;
        -- ON PASSE DANS L'ETAT PAUSE
        B_CENTER <= '1'; wait for CLOCK_period;
        B_CENTER <= '0'; wait for CLOCK_period * 9;
        -- ON PASSE DANS L'ETAT PLAY FWD
        B_RIGHT <= '1'; wait for CLOCK_period;
        B_RIGHT <= '0'; wait for CLOCK_period * 9;
        -- ON PASSE DANS L'ETAT PAUSE
        B_CENTER <= '1'; wait for CLOCK_period;
        B_CENTER <= '0'; wait for CLOCK_period * 9;
        stop_the_clock <= true;
        wait;
    end process;

end Behavioral;
