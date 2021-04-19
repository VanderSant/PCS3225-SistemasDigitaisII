library ieee;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity calc is
    port(
        clock:       in  bit;
        reset:       in  bit;
        instruction: in  bit_vector(15 downto 0);
        overflow:    out bit;
        q1:          out bit_vector(15 downto 0)
    );
    end entity calc;

    architecture calc_arch of calc is

          component regfile is 
           generic(
             regn: natural := 32;
             wordSize: natural :=16
             );
            port(
              clock: in bit;
              reset: in bit;
              regWrite: in bit;
              rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn))))-1 downto 0);
              d: in bit_vector(wordSize-1 downto 0);

              qq1, qq2, qwr:  out bit_vector(wordSize-1 downto 0)
               );
          end component regfile;

          component fa_16bit is
            port (
              A,B  : in  bit_vector(15 downto 0);
              CIN  : in  bit;
              SUM  : out bit_vector(15 downto 0);
              COUT : out bit
              );
          end component;

          component mux16_2to1 is
            port (
              SEL : in bit;    
              A :   in bit_vector  (15 downto 0);
              B :   in bit_vector  (15 downto 0);
              Y :   out bit_vector (15 downto 0)
              );
          end component mux16_2to1;

          component bit5_to_bit16_C2 is
            port(
            A: in bit_vector(4 downto 0);
            B: out bit_vector(15 downto 0)
            );
          end component bit5_to_bit16_C2;

          component compl2_5bit is
            port(
                A : in  bit_vector(4 downto 0);
                B : out bit_vector(4 downto 0)
            );
          end component compl2_5bit;

          component compl2_16bit is
            port(
                A : in  bit_vector(15 downto 0);
                B : out bit_vector(15 downto 0)
            );
          end component compl2_16bit;

          component transbor is
            port(
                A: in bit;
                B: in bit;
                C: in bit;
                D: out bit
        
            );
            end component transbor;

          signal s_rw, s_rr1,s_rr2,s_c21: bit_vector(4 downto 0);
          signal s_qq1, s_qq2, s_mux1, s_mux2 : bit_vector(15 downto 0); 
          signal s_5to16,s_c22, s_d: bit_vector(15 downto 0);
          signal s_selmux1: bit;

          begin
            s_rw(0) <= instruction(0); s_rw(1) <= instruction(1);
            s_rw(2) <= instruction(2); s_rw(3) <= instruction(3);s_rw(4) <= instruction(4);

            s_rr1(0) <= instruction(5); s_rr1(1) <= instruction(6);
            s_rr1(2) <= instruction(7); s_rr1(3) <= instruction(8); s_rr1(4) <= instruction(9);

            s_rr2(0) <= instruction(10); s_rr2(1) <= instruction(11); 
            s_rr2(2) <= instruction(12); s_rr2(3) <= instruction(13); s_rr2(4) <= instruction(14);

            s_selmux1 <= s_rr2(4);
            q1 <= s_qq1;
            
            REGFILE1: regfile port map(
                clock => clock,   
                reset => reset,
                regWrite => '1',
                rr1 => s_rr1, 
                rr2 => s_rr2,
                wr  => s_rw,
                d   => s_d,
                qq1  => s_qq1,
                qq2  => s_qq2,
                qwr  => open
                
            );

            COMPL2_1: compl2_5bit port map(
                A => s_rr2,
                B => s_c21
            );

            TO5BIT16BIT: bit5_to_bit16_C2 port map(
                A =>s_c21,
                B =>s_5to16
            );
            COMPL2_2: compl2_16bit port map(
                A =>s_5to16,
                B =>s_c22
            );

            MUX1: mux16_2to1 port map(
                SEL => s_selmux1,   
                A   => s_5to16,
                B   => s_c22,
                Y   => s_mux1
                
            );

            MUX2: mux16_2to1 port map(
                SEL => instruction(15),   
                A   => s_mux1,
                B   => s_qq2,
                Y   => s_mux2
                
            );

            SUM: fa_16bit port map(
                A    => s_qq1,
                B    => s_mux2,
                CIN  => '0',
                SUM  => s_d,
                COUT => open
            );

            TRANBOR: transbor port map(
                A =>s_qq1(15),
                B =>s_mux2(15),
                C =>s_d(15),
                D => overflow
            );



        end architecture calc_arch;