library ieee;
use ieee.numeric_bit.rising_edge;

entity compl2 is
    port(
        A : in  bit_vector(3 downto 0);
        B : out bit_vector(3 downto 0)
    );
    end entity compl2;

architecture acompl2 of compl2 is

    component fa_4bit
    port (
      A,B  : in  bit_vector(3 downto 0);
      CIN  : in  bit;
      SUM  : out bit_vector(3 downto 0);
      COUT : out bit
    );
    end component;

        signal i_a: bit_vector(3 downto 0);
        signal s_sum: bit_vector(3 downto 0);

    begin
        i_a <= not A;
        coml2: fa_4bit port map (
            A   =>  i_a,
            B   =>  "0001",
            CIN =>  '0',
            SUM =>  s_sum,
            COUT=>  open 
            );

        with A(3) select
            B   <= A when '0',
                   s_sum when '1',
                   "0000" when others;

    end architecture acompl2;