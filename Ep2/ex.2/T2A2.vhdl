library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom_arquivo is
port (
addr : in bit_vector (3 downto 0 ) ;
data : out bit_vector (7 downto 0 )
) ;
end rom_arquivo ;

architecture rom_arquivo_arch of rom_arquivo is
    constant data_file_name : string  := "conteudo_rom_ativ_02_carga.dat";
    constant depth : natural := 2**4;
    type mem_type is array (0 to depth-1) of bit_vector(7 downto 0);
    --! Initial values filling function
    impure function init_mem(file_name : in string) return mem_type is
    file     f       : text open read_mode is file_name;
    variable l       : line;
    variable tmp_bv  : bit_vector(7 downto 0);
    variable tmp_mem : mem_type;

    begin
        for i in mem_type'range loop
          readline(f, l);
          read(l, tmp_bv);
          tmp_mem(i) := tmp_bv;
        end loop;
        return tmp_mem;
     end;
     constant mem : mem_type := init_mem(data_file_name);

     begin
       data <= mem(to_integer(unsigned(addr)));

    end architecture rom_arquivo_arch;