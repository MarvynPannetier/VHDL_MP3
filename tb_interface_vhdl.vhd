----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2022 16:34:33
-- Design Name: 
-- Module Name: tb_interface_vhdl - Behavioral
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

entity Interface_VHDL_tb is
end;

architecture bench of Interface_VHDL_tb is


    signal sortie_c : std_logic := '0';
    signal sortie_h : std_logic := '0';
    signal sortie_d : std_logic := '0';
    signal sortie_l : std_logic := '0';
    signal sortie_r : std_logic := '0';

    signal  s_PLAY_PAUSE : std_logic := '0';
    signal  s_RESTART : std_logic := '0';
    signal  s_FORWARD : std_logic := '0';
    signal  s_VOLUME_UP : std_logic := '0';
    signal  s_VOLUME_DOWN : std_logic:= '0';

    signal s_CE_affichage   : std_logic := '0';
    signal s_CE_perception   : std_logic := '0';

    signal sortie_cpt1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal sortie_cpt2 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";

    signal s_cent: STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    signal s_dizaine: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal s_unit: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal s_vol: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie1: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie2: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie3: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie4: STD_LOGIC_VECTOR (6 downto 0):= "0000000";

    signal s_commande: STD_LOGIC_VECTOR (2 downto 0);

  
    signal S: STD_LOGIC_VECTOR (6 downto 0);


  component Interface_VHDL
      Port (     CLK100MHZ : in STD_LOGIC;
           RAZ : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           Sept_Segments : out STD_LOGIC_VECTOR (6 downto 0);
--           CA : out STD_LOGIC;
--           CB : out STD_LOGIC;
--           CC : out STD_LOGIC;
--           CD : out STD_LOGIC;
--           CE : out STD_LOGIC;
--           CF : out STD_LOGIC;
--           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal CLK100MHZ: STD_LOGIC;
  signal RAZ: STD_LOGIC;
  signal BTNU: STD_LOGIC := '0';
  signal BTND: STD_LOGIC := '0';
  signal BTNL: STD_LOGIC := '0';
  signal BTNR: STD_LOGIC := '0';
  signal BTNC: STD_LOGIC := '0';
  signal Sept_Segments : STD_LOGIC_VECTOR (6 downto 0);
--  signal CA: STD_LOGIC;
--  signal CB: STD_LOGIC;
--  signal CC: STD_LOGIC;
--  signal CD: STD_LOGIC;
--  signal CE: STD_LOGIC;
--  signal CF: STD_LOGIC;
--  signal CG: STD_LOGIC;
  signal DP: STD_LOGIC;
  signal AN: STD_LOGIC_VECTOR (7 downto 0);
  constant clock_period: time := 10 ns;

begin

  uut: Interface_VHDL port map ( CLK100MHZ => CLK100MHZ,
                                 RAZ       => RAZ,
                                 BTNU      => BTNU,
                                 BTND      => BTND,
                                 BTNL      => BTNL,
                                 BTNR      => BTNR,
                                 BTNC      => BTNC,
                                 Sept_Segments => Sept_Segments,
                                 DP        => DP,
                                 AN        => AN );
                                 
bouton_center : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNC,
            output => sortie_c);

    bouton_high : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNU,
            output => sortie_h);

    bouton_down : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTND,
            output => sortie_d);

    bouton_right : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNR,
            output => sortie_r);

    bouton_left : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNL,
            output => sortie_l);

    FSM : entity work.FSM_MP3 port map(
            clock => CLK100MHZ,
            reset => RAZ,
            B_UP => sortie_h,
            B_DOWN => sortie_d,
            B_CENTER => sortie_c,
            B_LEFT => sortie_l,
            B_RIGHT =>  sortie_r,
            PLAY_PAUSE => s_PLAY_PAUSE,
            RESTART => s_RESTART,
            FORWARD =>  s_FORWARD,
            VOLUME_UP =>  s_VOLUME_UP,
            VOLUME_DOWN => s_VOLUME_DOWN   );

    gest_freq : entity work.gestion_freq port map(
            clock => CLK100MHZ,
            RAZ => RAZ,
            CE_affichage => s_CE_affichage,
            CE_perception => s_CE_perception);

    cpt_1_9 : entity work.cpt_1_9 port map(
            raz => RAZ,
            incr =>  s_VOLUME_UP,
            decr =>  s_VOLUME_DOWN,
            clock => CLK100MHZ,
            sortie =>  sortie_cpt1);

    cpt_1_999 : entity work.cpt_1_999 port map(
            CE     => s_CE_affichage,
            clock  => CLK100MHZ,
            init   => s_RESTART,
            raz    => RAZ,
            play   => s_PLAY_PAUSE,
            sens   => s_FORWARD,
            sortie => sortie_cpt2 );

    trans : entity work.Trans port map(
            FORWARD    => s_FORWARD,
            PLAY_PAUSE => s_PLAY_PAUSE,
            RESTART    => s_RESTART,
            NB_MUS     => sortie_cpt2,
            NB_VOL     => sortie_cpt1,
            s_cent     => s_cent,
            s_dizaine  => s_dizaine,
            s_unit     => s_unit,
            s_vol      => s_vol,
            sortie1    => sortie1,
            sortie2    => sortie2,
            sortie3    => sortie3,
            sortie4    => sortie4 );

    mod8 : entity work.mod8 port map(
            CE     => s_CE_perception,
            clock  => CLK100MHZ,
            raz    => RAZ,
            AN_s     => AN,
            sortie => s_commande );

    mux8 : entity work.mux8 port map(
            commande => s_commande,
            E0       => s_cent,
            E1       => s_dizaine,
            E2       => s_unit,
            E3       => s_vol,
            E4       => sortie1,
            E5       => sortie2,
            E6       => sortie3,
            E7       => sortie4,
            DP       => DP,
            S => Sept_Segments);
                                 
                                 
  clock_process: process
    begin
        CLK100MHZ <= '1';
        wait for clock_period/2;
        CLK100MHZ <= '0';
        wait for clock_period/2;
    end process ;                               
                                 
BTNC <= '1' after  500 ns, '0' after 515 ns, '1' after 500 ms, '0' after 505 ms, '1' after 900 ms, '0' after 905 ms; 
 
--BTNU <= '1' after 50 ms, '0' after 70 ms, '1' after 110ms, '0' after 120ms,'1' after 160ms, '0' after 190ms;
BTND <= '1' after 20ms, '0' after 21 ms;

end;
