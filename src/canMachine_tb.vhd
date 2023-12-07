----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2023 10:03:02
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity canMachine_tb is
end canMachine_tb;

architecture testbench of canMachine_tb is
    signal clk, rst: std_logic := '0';
    signal coin_in: std_logic_vector(2 downto 0) := "000";
    signal lata: std_logic;
    signal coin_out: std_logic_vector(2 downto 0);
begin


    uut: entity work.canMachine
        port map (
            coin_in => coin_in,
            clk => clk,
            rst => rst,
            lata => lata,
            coin_out => coin_out
        );

-- Clock process
    process
    begin
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
    end process;
    
-- Test Coin_in para estimulos de entrada

    process
        begin
        
            -- Caso 1
                Coin_in <= "001";
                wait for 10 ns;
                Coin_in <= "000";
                wait for 10 ns;
                Coin_in <= "001";
                wait for 10 ns;
                
            -- Rst caso 1
                rst <= '1';
                assert (lata = '1' and coin_out = "000")
                    report "Error Test 1" severity error;
                Coin_in <= "000";
                Coin_out <= "000";
                wait for 10ns;
                rst <= '0';
                wait for 10 ns;
              
      ---------- Caso 2
                Coin_in <= "001";
                wait for 10 ns;
                Coin_in <= "000";
                wait for 10 ns;
                Coin_in <= "010";
                wait for 10 ns;
                
            -- Rst caso 2
                rst <= '1';
                assert (lata = '1' and coin_out = "001")
                    report "Error Test 2" severity error;
                Coin_in <= "000";
                wait for 10 ns;
                rst <= '0';
                wait for 10 ns;
                
    ---------- Caso 3
                Coin_in <= "001";
                wait for 10 ns;
                Coin_in <= "000";
                wait for 10 ns;
                Coin_in <= "101";
                wait for 10 ns;
                
            -- Rst caso 3
                rst <= '1';
                assert (lata = '1' and coin_out = "100")
                    report "Error Test 3" severity error;
                Coin_in <= "000";
                wait for 10 ns;
                rst <= '0';
                wait for 10 ns;
                
    ---------- Caso 4
                Coin_in <= "010";
                wait for 10 ns;
                
            -- Rst caso 4
                rst <= '1';
                assert (lata = '1' and coin_out = "000")
                    report "Error Test 4" severity error;
                Coin_in <= "000";
                wait for 10 ns;
                rst <= '0';
                wait for 10 ns;
                
    ---------- Caso 5
                Coin_in <= "101";
                wait for 10 ns;

                
            -- Rst caso 5
                rst <= '1';
                assert (lata = '1' and coin_out = "011")
                    report "Error Test 5" severity error;
                Coin_in <= "000";
                wait for 10 ns;
                rst <= '0';
                wait for 10 ns;
            
            
            
      end process;


end testbench;

