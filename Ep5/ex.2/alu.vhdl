library ieee;
use ieee.numeric_bit.all;

entity alu is
    generic(
        size : natural :=64
    );
    port(
        A, B : in bit_vector(size-1 downto 0); -- inputs
        F    : out bit_vector(size-1 downto 0); -- outputs
        S    : in bit_vector(3 downto 0); -- op selection
        Z    : out bit; -- zero flag
        Ov   : out bit; -- overflow flag
        Co   : out bit -- carry out
    );
    end entity alu;

    architecture alu_arch of alu is
        component alu1bit is
            port(
                a, b, less, cin             : in bit;
                result, cout, set, overflow : out bit;
                ainvert, binvert            : in bit;
                operation                   : in bit_vector(1 downto 0)
            );
            end component alu1bit;

            signal s_cout, s_F, s_zero :bit_vector(size-1 downto 0);
            signal s_cin : bit;

            signal s_set  :bit;
            begin
                s_zero <= (others=>'0');
                Co <= s_cout(size-1);

                ULACO: for i in size-1 downto 0 generate

                ULAmiolo: if (i > 0 and i < size-1) generate
                ULAS: alu1bit port map(A(i),B(i),'0',s_cout(i-1),s_F(i),s_cout(i),open,open,S(3),S(2),S(1 downto 0));
                end generate;

                ULA0: if i=0 generate
                ULAS: alu1bit port map(A(i),B(i),s_set,S(2),s_F(i),s_cout(i),open,open,S(3),S(2),S(1 downto 0));
                end generate;

                ULAfim: if i=size-1 generate
                ULAS: alu1bit port map(A(i),B(i),'0',s_cout(i-1),s_F(i),s_cout(i),s_set,Ov,S(3),S(2),S(1 downto 0));
                end generate;

                end generate ULACO;
                F <= s_F;

                Z <= '1' when s_F = s_zero else '0';

        end architecture alu_arch;