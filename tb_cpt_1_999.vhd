library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_cpt_1_999 is
end;

architecture Behavioral of tb_cpt_1_999 is

component gestion_freq is
        Port ( clock : in STD_LOGIC;
         RAZ : in STD_LOGIC;
         CE_affichage : out STD_LOGIC;
         CE_perception : out STD_LOGIC);
    end component;
  
    
    signal s_CE_affichage   : std_logic;
    signal s_CE_perception   : std_logic;


  component cpt_1_999
      Port ( CE : in STD_LOGIC;
           clock : in STD_LOGIC;
           init : in STD_LOGIC;
           raz : in STD_LOGIC;
           play : in STD_LOGIC;
           sens : in STD_LOGIC;
           sortie : out STD_LOGIC_VECTOR (9 downto 0));
  end component;

  
  signal clock: STD_LOGIC;
  signal init: STD_LOGIC;
  signal raz: STD_LOGIC;
  signal play: STD_LOGIC;
  signal sens: STD_LOGIC;
  signal sortie: STD_LOGIC_VECTOR (9 downto 0);

  constant clock_period: time := 10 ns;
 -- signal stop_the_clock: boolean;

begin

   uut : gestion_freq port map( clock => clock,
                 RAZ => raz,
                 CE_affichage => s_CE_affichage,
                 CE_perception => s_CE_perception);

  uut2 : cpt_1_999 port map ( CE     => s_CE_affichage,
                            clock  => clock,
                            init   => init,
                            raz    => raz,
                            play   => play,
                            sens   => sens,
                            sortie => sortie );

 
  
    -- Put initialisation code here
    raz <= '1', '0' after 485 us;
    
    play <= '0', '1' after 1200 us; 
    
    sens <= '1', '0' after 700 ms;
    
    init <= '0', '1' after 532 ms, '0' after 560 ms;

    -- Put test bench stimulus code here



clock_process: process
    begin
        clock <= '1';
        wait for clock_period/2;
        clock <= '0';
        wait for clock_period/2;
    end process ;
--  clocking: process
--  begin
--    while not stop_the_clock loop
--      clock <= '0', '1' after clock_period / 2;
--      wait for clock_period;
--    end loop;
--    wait;
--  end process;

end Behavioral;