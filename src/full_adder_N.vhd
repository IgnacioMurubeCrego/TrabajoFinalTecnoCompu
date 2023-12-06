library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity full_adder_N is
Generic ( N : integer := 4
);
Port (  A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(N-1 downto 0);
        Cout : out std_logic
);
end full_adder_N;

architecture Behavioral of full_adder_N is

component full_adder1 is
Port (  A : in std_logic;
        B : in std_logic;
        Cin : in std_logic;
        S : out std_logic;
        Cout : out std_logic
);
end component;

signal Cout_s : std_logic_vector(N-1 downto 0);
signal A_s, B_s, S_s : std_logic_vector(N-1 downto 0);
signal Cin_s : std_logic;


begin

A_s <= A;
B_s <= B;
Cin_s <= Cin;

B_0 : full_adder1 port map(A => A_s(0), B => B_s(0), Cin => Cin, S => S_s(0), Cout => Cout_s(0));

B_ALL : for ii in 1 to N-1 generate
    B1 : full_adder1 port map(A => A_s(ii), B => B_s(ii), Cin => Cout_s(ii-1), S => S_s(ii), Cout => Cout_s(ii));
end generate;

S <= S_s;
Cout <= Cout_s(N-1);

end Behavioral;
