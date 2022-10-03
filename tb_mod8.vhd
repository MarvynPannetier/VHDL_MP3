library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_mod8 is
end;

architecture bench of tb_mod8 is

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

 
  
    -- Put initialisation code here
    raz <= '1', '0' after 135 ns;
    

    



clock_process: process
    begin
        clock <= '1';
        wait for clock_period/2;
        clock <= '0';
        wait for clock_period/2;
    end process ;

end;
  