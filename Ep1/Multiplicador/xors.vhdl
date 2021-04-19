library ieee;
use ieee.numeric_bit.rising_edge;

entity xors is
    port(
        A : in bit_vector(3 downto 0);
        B : in bit_vector(3 downto 0);
        C : out bit
    );
    end entity xors;

architecture axors of xors is
    begin

        C <= '0' when A="0000" or B= "0000" else A(3) xor B(3) ;
        
    end architecture axors;