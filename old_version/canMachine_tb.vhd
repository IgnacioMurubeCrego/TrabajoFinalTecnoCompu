----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2023 16:37:55
-- Design Name: 
-- Module Name: canMachine_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity canMachine_tb is
end canMachine_tb;

architecture Behavioral of canMachine_tb is

component canMachine is
Port ( clk, rst : in std_logic;
       coin_in : in std_logic_vector(2 downto 0); 
       lata : out std_logic; 
       coin_out : out std_logic_vector(2 downto 0)
      );
end component;

signal clk, rst : std_logic := '0';
signal coin_in : std_logic_vector(2 downto 0); 
signal lata : std_logic; 
signal coin_out : std_logic_vector(2 downto 0);
signal half_clk_period : time := 5 ns;

begin

UUT : canMachine
port map(
        clk => clk,
        rst => rst,
        coin_in => coin_in,
        lata => lata,
        coin_out => coin_out
        );

-- Ciclos de reloj
process
begin 
    clk <= '0';
    wait for half_clk_period;
    clk <= '1';
    wait for half_clk_period;
end process;

-- Casos de Estimulo : 
process
begin
-- Caso 1
                coin_in <= "001";
                wait for 10 ns;
                coin_in <= "000";
                wait for 10 ns;
                coin_in <= "001";
                wait for 10 ns;
                coin_in <= "000";
                wait for 10 ns;

-- Caso Rst 1
                coin_in <= "001";
                wait for 10 ns;
                rst <= '1';
                assert (lata = '0' and coin_out = "001")
                    report "Error Test 1" severity error;
                coin_in <= "000";
                wait for 10 ns;
                rst <= '0';
                wait for 10 ns;

      ---------- Caso 2
                coin_in <= "001";
                wait for 10 ns;
                coin_in <= "000";
                wait for 10 ns;
                coin_in <= "010";
                wait for 10 ns;
                assert (lata = '1' and coin_out = "001")
                    report "Error Test 2" severity error;
                coin_in <= "000";
                wait for 10 ns;

    ---------- Caso 3
                coin_in <= "001";
                wait for 10 ns;
                coin_in <= "000";
                wait for 10 ns;
                coin_in <= "101";
                wait for 10 ns;

                assert (lata = '1' and coin_out = "100")
                    report "Error Test 3" severity error;
                coin_in <= "000";
                wait for 10 ns;

    ---------- Caso 4
                coin_in <= "010";
                wait for 10 ns;                
                assert (lata = '1' and coin_out = "000")
                    report "Error Test 4" severity error;
                coin_in <= "000";
                wait for 10 ns;


    ---------- Caso 5
                coin_in <= "101";
                wait for 10 ns;
                assert (lata = '1' and coin_out = "011")
                    report "Error Test 5" severity error;
                coin_in <= "000";
                wait for 10 ns;

end process;


end Behavioral;
