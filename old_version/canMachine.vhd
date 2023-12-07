----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2023 17:56:07
-- Design Name: 
-- Module Name: canMachine - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity canMachine is
Port ( coin_in : in std_logic_vector(2 downto 0);
       clk, rst : in std_logic;
       lata : out std_logic;
       coin_out : out std_logic_vector(2 downto 0)
        );
end canMachine;

architecture Behavioral of canMachine is

signal precio_lata : std_logic_vector(2 downto 0) := "010";
signal counter : std_logic_vector(2 downto 0);
signal en_resta : std_logic := '0';
signal suma_resta : std_logic_vector(2 downto 0) := "000";
type SM_state is (E0,E1,E2,E3,E4,E5);
signal CS, NS : SM_state;
 
component full_add_sub_Nbits is
Generic( N : integer := 3
        );
Port ( clk : in std_logic;
       A,B : in std_logic_vector(N-1 downto 0);
       add_sub : in std_logic;
       S : out std_logic_vector(N-1 downto 0)
    );
end component;

begin

SUMADOR_RESTADOR : full_add_sub_Nbits
generic map ( N => 3 )
port map (
          clk => clk,
          A => counter,
          B => suma_resta,
          add_sub => en_resta,
          S => counter
          );

-- Bucle Transición de Estados Maquina de Moore :
process(clk,rst,coin_in)
begin
    if rising_edge(clk) then
    
        case CS is 
        
        -- Estado 0 :
            when E0 =>
                if rst = '1' then
                    NS <= E0;
                elsif (coin_in = "001") then
                    NS <= E1;
                elsif (coin_in = "010") then
                    NS <= E2;
                elsif (coin_in = "101") then
                    NS <= E5;
                else 
                    NS <= CS;
                end if;
                
            -- Estado 1 :
            when E1 =>
                if rst = '1' then
                    NS <= E0;
                elsif (coin_in = "001") then
                    NS <= E2;
                elsif (coin_in = "010") then
                    NS <= E3;
                elsif (coin_in = "101") then
                    NS <= E4;
                else
                    NS <= CS;
                end if;
                
            -- Estado 2 :
            when E2 =>
                NS <= E0;
                
            -- Estado 3 :
            when E3 =>
                NS <= E0;
                
            -- Estado 4 :
            when E4 =>
                NS <= E0;
                
            -- Estado 5 :
            when E5 =>
                NS <= E0;
            
        end case;
    end if;
end process;

-- Casos por Estado :
process(CS,coin_in,counter)
begin
    case CS is
        when E0 =>
            suma_resta <= coin_in;
            en_resta <= '0';
            lata <= '0';
            counter <= "000";
        when E1 =>
            suma_resta <= coin_in;
            en_resta <= '0';
            lata <= '0';
        when others =>
            suma_resta <= precio_lata;
            en_resta <= '1';
            lata <= '1';
    end case;
    coin_out <= counter;
end process;

end Behavioral;
