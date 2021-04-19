library ieee;
use ieee.numeric_bit.ALL;

entity ram is
generic(
 addressSize : natural := 4;
 wordSize : natural := 8
  );
port (
        ck, wr : in  bit;
        addr   : in  bit_vector(addressSize-1 downto 0);
        data_i : in  bit_vector(wordSize-1 downto 0);
        data_o : out bit_vector(wordSize-1 downto 0)
      );
end entity ram ;

architecture ram_arch of ram is
    constant profun : natural := 2**addressSize;
    type memo_type is array (0 to profun-1) of bit_vector(wordSize-1 downto 0);
    signal memo : memo_type;
  begin
    DUT: process(ck)
    begin
      if (ck='1' and ck'event) then
        if (wr='1') then
          memo(to_integer(unsigned(addr))) <= data_i;
        end if;
      end if;
    end process;
       data_o <= memo(to_integer(unsigned(addr)));
  end ram_arch;