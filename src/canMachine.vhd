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

type SM_state is (E0,E1,E2,E3,E4,E5);
signal CS, NS : SM_state;

begin

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
process(CS,coin_in)
begin
    case CS is
        when E0 => 
            coin_out <= "000";
        when E1 => 
            coin_out <= "000";
        when E2 => 
            coin_out <= "000";
            lata <= '1';
        when E3 => 
            coin_out <= "001";
            lata <= '1';
        when E4 => 
            coin_out <= "100";
            lata <= '1';
        when E5 => 
            coin_out <= "011";
            lata <= '1';
    end case;
end process;

end Behavioral;
