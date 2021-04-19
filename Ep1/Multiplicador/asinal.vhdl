library ieee;
use ieee.numeric_bit.rising_edge;

entity asinal is
    port(
        Ar: in  bit_vector(7 downto 0);
        Br: in bit;
        Qr: out bit_vector(7 downto 0)
    );
end entity asinal;

architecture aasinal of asinal is
    component fa_8bit
    port (
      A,B  : in  bit_vector(7 downto 0);
      CIN  : in  bit;
      SUM  : out bit_vector(7 downto 0);
      COUT : out bit
    );
    end component;

        signal i_a: bit_vector(7 downto 0);
        signal s_sum: bit_vector(7 downto 0);

    begin
        i_a <= not Ar;
        coml2: fa_8bit port map (
            A   =>  i_a,
            B   =>  "00000001",
            CIN =>  '0',
            SUM =>  s_sum,
            COUT=>  open 
            );

        with  Br select
            Qr  <= Ar when '0',
                   s_sum when '1',
                   "00000000" when others;
        

end architecture aasinal;



--sinal(0) <= A(0);
  --      sinal(1) <= A(1);
    --    sinal(2) <= A(2);
      --  sinal(3) <= A(3);
        --sinal(4) <= A(4);
       -- sinal(5) <= A(5);
       -- sinal(6) <= A(6);
       -- sinal(7) <= B;
       -- Q <= sinal;