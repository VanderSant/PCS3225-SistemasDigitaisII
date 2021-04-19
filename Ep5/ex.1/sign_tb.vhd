library ieee;
use std.textio.all;
use ieee.numeric_bit.all;


entity sign_tb is
end entity;

architecture sign_tb_arch of sign_tb is
    signal i_in: bit_vector (31 downto 0);
    signal o_out: bit_vector (63 downto 0);

    component signExtend is
        port(
            i: in bit_vector (31 downto 0);
            o: out bit_vector (63 downto 0)
        );
    end component;

    

    begin
        sign: signExtend 
        port map (
            i=>i_in, 
            o=>o_out);
        stim: process is

            file tb_in_file: text open read_mode is "sign_tb.dat";
            variable tb_line_in: line;
            variable space_in: character;
            variable linha: integer;

            variable idat: bit_vector (31 downto 0);
            variable odat: bit_vector (63 downto 0);
            
    
            begin
                -- o testbench le o arquivo dat linha por linha, coluna por coluna. 
                -- na primeira coluna ta o i na segunda o o
                -- para todos os comandos ele faz 2 testes em um ele usa como address 1 e no outro -1
                -- eh testado primeiro o LDUR, depois o STUR, CBZ e B
                -- ex: se der erro na linha 6, foi no CBZ com o caso com address -1
                -- n esuece de por o arquivo dat na mesma pasta do tb :)
                
                linha:=0;
                while (not endfile (tb_in_file)) loop
                    readline(tb_in_file, tb_line_in);
                    linha:=linha+1;
                    read(tb_line_in,idat);
                    read(tb_line_in, space_in);

                    read(tb_line_in, odat);

                    i_in<=idat;
                    wait for 10 ns;

                    assert (o_out=odat) report "erro na linha"& integer'image (linha) &" do arquivo" severity note;

                end loop;

            assert False report "fim" severity note;
            wait;
        end process;
end architecture sign_tb_arch;