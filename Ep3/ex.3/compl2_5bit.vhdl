library ieee;
use ieee.numeric_bit.rising_edge;

entity compl2_5bit is
    port(
        A : in  bit_vector(4 downto 0);
        B : out bit_vector(4 downto 0)
    );
    end entity compl2_5bit;

architecture acompl2_5bit of compl2_5bit is

    component fa_5bit is
        port (
          A,B  : in  bit_vector(4 downto 0);
          CIN  : in  bit;
          SUM  : out bit_vector(4 downto 0);
          COUT : out bit
          );
      end component;

        signal i_a: bit_vector(4 downto 0);
        signal s_sum: bit_vector(4 downto 0);

    begin
        i_a <= not A;
        coml2: fa_5bit port map (
            A   =>  i_a,
            B   =>  "00001",
            CIN =>  '0',
            SUM =>  s_sum,
            COUT=>  open 
            );

        with A(4) select
            B   <= A when '0',
                   s_sum when '1',
                   "00000" when others;

    end architecture acompl2_5bit;