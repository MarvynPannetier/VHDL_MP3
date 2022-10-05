----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2022 14:29:31
-- Design Name: 
-- Module Name: RAM - Behavioral
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    GENERIC(
        RAM_ADDR_BITS : INTEGER := 18
    );
    Port ( clock : in STD_LOGIC;
         raz : in STD_LOGIC;
         compteur : in STD_LOGIC;
         addr : in STD_LOGIC_VECTOR (RAM_ADDR_BITS-1 downto 0);
         value : in STD_LOGIC_VECTOR (15 downto 0);
         enable : in STD_LOGIC;
         output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
end RAM;

architecture Behavioral of RAM is

    subtype val is std_logic_vector(15 downto 0);
    TYPE ram_type IS ARRAY(0 to 2**RAM_ADDR_BITS-1) of val;
    signal memory : ram_type := (others => (others => '0'));

    ATTRIBUTE RAM_STYLE : string;
    ATTRIBUTE RAM_STYLE of memory: signal is "BLOCK";

begin

    PROCESS (CLOCK)

        -- variable count_w : integer :=0;

    BEGIN
        IF (CLOCK'event AND CLOCK = '1') THEN
            if (raz = '1') then
                output <= x"0000";
            else

                if enable = '0' then
                    output <= STD_LOGIC_VECTOR( memory(to_integer(UNSIGNED(compteur))));
                else
                --addre et value gérés par blocs uart ?
                    memory(to_integer(unsigned(addr))) <= value;
                end if;
                
            end if;
        END IF;
    END PROCESS;
    
    --QUESTION 
    -- signaux de l'énoncé?
    -- comment fonctionne addr venant des blocs déjà développés
    -- vérifier si ma logique du bloc RAM est juste
    -- voir comment mettre la borne dans le bloc compteur 
    -- taille vecteur des données 16bits contre 11 avant, valeurs max vont être tronquées si travaille à une fréquence de 44100Hz normal ? 


end Behavioral;






