library ieee;
use ieee.numeric_bit.rising_edge;

entity compl2_16bit is
    port(
        A : in  bit_vector(15 downto 0);
        B : out bit_vector(15 downto 0)
    );
    end entity compl2_16bit;

architecture acompl2_16bit of compl2_16bit is

    component fa_16bit is
        port (
          A,B  : in  bit_vector(15 downto 0);
          CIN  : in  bit;
          SUM  : out bit_vector(15 downto 0);
          COUT : out bit
          );
      end component;

        signal i_a: bit_vector(15 downto 0);
        signal s_sum: bit_vector(15 downto 0);

    begin
        i_a <= not A;
        coml2: fa_16bit port map (
            A   =>  i_a,
            B   =>  "0000000000000001",
            CIN =>  '0',
            SUM =>  s_sum,
            COUT=>  open 
            );

            B   <= s_sum ;

    end architecture acompl2_16bit;