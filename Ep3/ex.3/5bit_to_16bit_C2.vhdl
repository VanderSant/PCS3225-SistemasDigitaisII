
--c2 = complemnto de 2
entity bit5_to_bit16_C2 is
    port(
    A: in bit_vector(4 downto 0);
    B: out bit_vector(15 downto 0)
    );
end entity bit5_to_bit16_C2;

architecture bit5_to_bit16_C2_arch of bit5_to_bit16_C2 is
    signal s_a: bit_vector(4 downto 0);
    begin
        s_a <= A;
        B(15) <= '0'; 
        B(14) <= '0'; B(13) <= '0'; B(12) <= '0'; B(11) <= '0'; B(10) <= '0';
        B(9) <= '0';  B(8) <= '0';  B(7) <= '0';  B(6) <= '0';  B(5) <= '0';
        B(4) <= s_a(4); B(3) <= s_a(3); B(2) <= s_a(2); B(1) <= s_a(1); B(0) <= s_a(0); 

        
    end architecture bit5_to_bit16_C2_arch;