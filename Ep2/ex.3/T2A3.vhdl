library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom_arquivo_generica is
  generic (
    addressSize : natural := 4;
    wordSize    : natural := 8;
    datFileName : string  := "rom.dat"
   );
   port(
    addr : in  bit_vector(addressSize-1 downto 0);
    data : out bit_vector(wordSize-1 downto 0)
  );
end rom_arquivo_generica;

architecture rom_arquivo_generica_arch of rom_arquivo_generica is
    constant profun : natural := 2**addressSize;
    type mem_type is array (0 to profun-1) of bit_vector(wordSize-1 downto 0);
    --! Initial values filling function
    impure function init_mem(file_name : in string) return mem_type is
      file     fi       : text open read_mode is file_name;
      variable li       : line;
      variable tmp_bv  : bit_vector(wordSize-1 downto 0);
      variable tmp_mem : mem_type;
    begin
      for i in mem_type'range loop
        readline(fi, li);
        read(li, tmp_bv);
        tmp_mem(i) := tmp_bv;
      end loop;
      return tmp_mem;
    end;
    --! Memory matrix
    constant mem : mem_type := init_mem(datFileName);
  begin
    data <= mem(to_integer(unsigned(addr)));

  end architecture rom_arquivo_generica_arch;
