entity decoder is
    port(
        ent: in bit_vector(4 downto 0);
        sai: out bit_vector(31 downto 0)

        );
end entity decoder;

architecture decoder_arch of decoder is
    begin
        with ent select
          sai <= "00000000000000000000000000000001" when "00000",
                 "00000000000000000000000000000010" when "00001",
                 "00000000000000000000000000000100" when "00010",
                 "00000000000000000000000000001000" when "00011",
                 "00000000000000000000000000010000" when "00100",
                 "00000000000000000000000000100000" when "00101",
                 "00000000000000000000000001000000" when "00110",
                 "00000000000000000000000010000000" when "00111",
                 "00000000000000000000000100000000" when "01000",
                 "00000000000000000000001000000000" when "01001",
                 "00000000000000000000010000000000" when "01010",
                 "00000000000000000000100000000000" when "01011",
                 "00000000000000000001000000000000" when "01100",
                 "00000000000000000010000000000000" when "01101",
                 "00000000000000000100000000000000" when "01110",
                 "00000000000000001000000000000000" when "01111",
                 "00000000000000010000000000000000" when "10000",
                 "00000000000000100000000000000000" when "10001",
                 "00000000000001000000000000000000" when "10010",
                 "00000000000010000000000000000000" when "10011",
                 "00000000000100000000000000000000" when "10100",
                 "00000000001000000000000000000000" when "10101",
                 "00000000010000000000000000000000" when "10110",
                 "00000000100000000000000000000000" when "10111",
                 "00000001000000000000000000000000" when "11000",
                 "00000010000000000000000000000000" when "11001",
                 "00000100000000000000000000000000" when "11010",
                 "00001000000000000000000000000000" when "11011",
                 "00010000000000000000000000000000" when "11100",
                 "00100000000000000000000000000000" when "11101",
                 "01000000000000000000000000000000" when "11110",
                 "10000000000000000000000000000000" when "11111",
                 "00000000000000000000000000000000" when others;
    
    
                 end architecture decoder_arch;

                 entity mux is
                    port (
                      rr    :   in bit_vector  (4 downto 0);    
                      reg0  :   in bit_vector  (63 downto 0);
                      reg1  :   in bit_vector  (63 downto 0);
                      reg2  :   in bit_vector  (63 downto 0);
                      reg3  :   in bit_vector  (63 downto 0);
                      reg4  :   in bit_vector  (63 downto 0);
                      reg5  :   in bit_vector  (63 downto 0);
                      reg6  :   in bit_vector  (63 downto 0);
                      reg7  :   in bit_vector  (63 downto 0);
                      reg8  :   in bit_vector  (63 downto 0);
                      reg9  :   in bit_vector  (63 downto 0);
                      reg10 :   in bit_vector  (63 downto 0);
                      reg11 :   in bit_vector  (63 downto 0);
                      reg12 :   in bit_vector  (63 downto 0);
                      reg13 :   in bit_vector  (63 downto 0);
                      reg14 :   in bit_vector  (63 downto 0);
                      reg15 :   in bit_vector  (63 downto 0);
                      reg16 :   in bit_vector  (63 downto 0);
                      reg17 :   in bit_vector  (63 downto 0);
                      reg18 :   in bit_vector  (63 downto 0);
                      reg19 :   in bit_vector  (63 downto 0);
                      reg20 :   in bit_vector  (63 downto 0);
                      reg21 :   in bit_vector  (63 downto 0);
                      reg22 :   in bit_vector  (63 downto 0);
                      reg23 :   in bit_vector  (63 downto 0);
                      reg24 :   in bit_vector  (63 downto 0);
                      reg25 :   in bit_vector  (63 downto 0);
                      reg26 :   in bit_vector  (63 downto 0);
                      reg27 :   in bit_vector  (63 downto 0);
                      reg28 :   in bit_vector  (63 downto 0);
                      reg29 :   in bit_vector  (63 downto 0);
                      reg30 :   in bit_vector  (63 downto 0);
                      reg31 :   in bit_vector  (63 downto 0);
                
                      q :   out bit_vector (63 downto 0)
                
                      );
                  end entity mux;
                  
                  architecture with_select of mux is
                  begin
                    with rr select
                      q <= reg0  when "00000",
                           reg1  when "00001",
                           reg2  when "00010",
                           reg3  when "00011",
                           reg4  when "00100",
                           reg5  when "00101",
                           reg6  when "00110",
                           reg7  when "00111",
                           reg8  when "01000",
                           reg9  when "01001",
                           reg10 when "01010",
                           reg11 when "01011",
                           reg12 when "01100",
                           reg13 when "01101",
                           reg14 when "01110",
                           reg15 when "01111",
                           reg16 when "10000",
                           reg17 when "10001",
                           reg18 when "10010",
                           reg19 when "10011",
                           reg20 when "10100",
                           reg21 when "10101",
                           reg22 when "10110",
                           reg23 when "10111",
                           reg24 when "11000",
                           reg25 when "11001",
                           reg26 when "11010",
                           reg27 when "11011",
                           reg28 when "11100",
                           reg29 when "11101",
                           reg30 when "11110",
                           reg31 when "11111",
                           (others=>'0') when others;
                  end architecture with_select;

                  entity reg is
                    generic (
                      wordSize    : natural := 64
                     );
                     port(
                      clock: in  bit ; -- ! entrada de clock
                      reset: in  bit ; -- ! clear assincrono
                      load : in  bit;  -- ! write enable (carga paralela)
                      d    : in  bit_vector(wordSize-1 downto 0);
                      q    : out bit_vector(wordSize-1 downto 0)
                    );
                  end reg;
                  
                  architecture reg_arch of reg is
                  
                    begin
                      ffdr: process(clock,reset)
                  
                      begin
                          if (reset='1') then
                          q<=(others=>'0');
                  
                          elsif (clock'event and clock='1') then
                              if load = '1' then
                                  q <=d;
                                  end if;
                              end if;
                          end process;
                          
                      end architecture reg_arch;

                      library ieee;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity regfile is 
     generic(
       regn: natural := 32;
       wordSize: natural :=64
     );
     port(
       clock: in bit;
       reset: in bit;
       regWrite: in bit;
       rr1, rr2, wr: in bit_vector(natural(ceil(log2(real(regn))))-1 downto 0);
       d: in bit_vector(wordSize-1 downto 0);

       q1, q2:  out bit_vector(wordSize-1 downto 0)
     );
     end entity regfile;




architecture regfile_arch of regfile is

  component reg is
    generic (
      wordSize    : natural := 64
     );
     port(
      clock: in  bit ; -- ! entrada de clock
      reset: in  bit ; -- ! clear assincrono
      load : in  bit;  -- ! write enable (carga paralela)
      d    : in  bit_vector(wordSize-1 downto 0);
      q    : out bit_vector(wordSize-1 downto 0)
    );
  end component reg;

  component mux is
    port (
      rr    :   in bit_vector  (4 downto 0);    
      reg0  :   in bit_vector  (63 downto 0);
      reg1  :   in bit_vector  (63 downto 0);
      reg2  :   in bit_vector  (63 downto 0);
      reg3  :   in bit_vector  (63 downto 0);
      reg4  :   in bit_vector  (63 downto 0);
      reg5  :   in bit_vector  (63 downto 0);
      reg6  :   in bit_vector  (63 downto 0);
      reg7  :   in bit_vector  (63 downto 0);
      reg8  :   in bit_vector  (63 downto 0);
      reg9  :   in bit_vector  (63 downto 0);
      reg10 :   in bit_vector  (63 downto 0);
      reg11 :   in bit_vector  (63 downto 0);
      reg12 :   in bit_vector  (63 downto 0);
      reg13 :   in bit_vector  (63 downto 0);
      reg14 :   in bit_vector  (63 downto 0);
      reg15 :   in bit_vector  (63 downto 0);
      reg16 :   in bit_vector  (63 downto 0);
      reg17 :   in bit_vector  (63 downto 0);
      reg18 :   in bit_vector  (63 downto 0);
      reg19 :   in bit_vector  (63 downto 0);
      reg20 :   in bit_vector  (63 downto 0);
      reg21 :   in bit_vector  (63 downto 0);
      reg22 :   in bit_vector  (63 downto 0);
      reg23 :   in bit_vector  (63 downto 0);
      reg24 :   in bit_vector  (63 downto 0);
      reg25 :   in bit_vector  (63 downto 0);
      reg26 :   in bit_vector  (63 downto 0);
      reg27 :   in bit_vector  (63 downto 0);
      reg28 :   in bit_vector  (63 downto 0);
      reg29 :   in bit_vector  (63 downto 0);
      reg30 :   in bit_vector  (63 downto 0);
      reg31 :   in bit_vector  (63 downto 0);

      q :   out bit_vector (63 downto 0)

      );
  end component mux;

  component decoder is
    port(
        ent: in bit_vector(4 downto 0);
        sai: out bit_vector(31 downto 0)

        );
   end component decoder;

   signal s_decoder, sel: bit_vector(regn-1 downto 0);
   signal s_reg0,s_reg4,s_reg8, s_reg12,s_reg16,s_reg20,s_reg24,s_reg28: bit_vector(wordSize-1 downto 0);
   signal s_reg1,s_reg5,s_reg9, s_reg13,s_reg17,s_reg21,s_reg25,s_reg29: bit_vector(wordSize-1 downto 0);
   signal s_reg2,s_reg6,s_reg10,s_reg14,s_reg18,s_reg22,s_reg26,s_reg30: bit_vector(wordSize-1 downto 0);
   signal s_reg3,s_reg7,s_reg11,s_reg15,s_reg19,s_reg23,s_reg27        : bit_vector(wordSize-1 downto 0);
   begin
    sel(0) <= s_decoder(0) and regWrite; sel(11) <= s_decoder(11) and regWrite; sel(21) <= s_decoder(21) and regWrite;
    sel(1) <= s_decoder(1) and regWrite; sel(12) <= s_decoder(12) and regWrite; sel(22) <= s_decoder(22) and regWrite;
    sel(2) <= s_decoder(2) and regWrite; sel(13) <= s_decoder(13) and regWrite; sel(23) <= s_decoder(23) and regWrite;
    sel(3) <= s_decoder(3) and regWrite; sel(14) <= s_decoder(14) and regWrite; sel(24) <= s_decoder(24) and regWrite;
    sel(4) <= s_decoder(4) and regWrite; sel(15) <= s_decoder(15) and regWrite; sel(25) <= s_decoder(25) and regWrite;
    sel(5) <= s_decoder(5) and regWrite; sel(16) <= s_decoder(16) and regWrite; sel(26) <= s_decoder(26) and regWrite;
    sel(6) <= s_decoder(6) and regWrite; sel(17) <= s_decoder(17) and regWrite; sel(27) <= s_decoder(27) and regWrite;
    sel(7) <= s_decoder(7) and regWrite; sel(18) <= s_decoder(18) and regWrite; sel(28) <= s_decoder(28) and regWrite;
    sel(8) <= s_decoder(8) and regWrite; sel(19) <= s_decoder(19) and regWrite; sel(29) <= s_decoder(29) and regWrite;
    sel(9) <= s_decoder(9) and regWrite; sel(20) <= s_decoder(20) and regWrite; sel(30) <= s_decoder(30) and regWrite;
    sel(10)<= s_decoder(10) and regWrite;                                       sel(31) <= s_decoder(31) and regWrite;

    DECODEREAD: decoder port map(
        ent => wr, 
        sai => s_decoder
    );

    MUXQ1: mux port map(
      rr    => rr1,    
      reg0  =>s_reg0,
      reg1  =>s_reg1,
      reg2  =>s_reg2,
      reg3  =>s_reg3,
      reg4  =>s_reg4,
      reg5  =>s_reg5,
      reg6  =>s_reg6,
      reg7  =>s_reg7,
      reg8  =>s_reg8,
      reg9  =>s_reg9,
      reg10 =>s_reg10,
      reg11 =>s_reg11,
      reg12 =>s_reg12,
      reg13 =>s_reg13,
      reg14 =>s_reg14,
      reg15 =>s_reg15,
      reg16 =>s_reg16,
      reg17 =>s_reg17,
      reg18 =>s_reg18,
      reg19 =>s_reg19,
      reg20 =>s_reg20,
      reg21 =>s_reg21,
      reg22 =>s_reg22,
      reg23 =>s_reg23,
      reg24 =>s_reg24,
      reg25 =>s_reg25,
      reg26 =>s_reg26,
      reg27 =>s_reg27,
      reg28 =>s_reg28,
      reg29 =>s_reg29,
      reg30 =>s_reg30,
      reg31 => "0000000000000000000000000000000000000000000000000000000000000000",
      q => q1
    );

    MUXQ2: mux port map(
      rr    => rr2,    
      reg0  =>s_reg0,
      reg1  =>s_reg1,
      reg2  =>s_reg2,
      reg3  =>s_reg3,
      reg4  =>s_reg4,
      reg5  =>s_reg5,
      reg6  =>s_reg6,
      reg7  =>s_reg7,
      reg8  =>s_reg8,
      reg9  =>s_reg9,
      reg10 =>s_reg10,
      reg11 =>s_reg11,
      reg12 =>s_reg12,
      reg13 =>s_reg13,
      reg14 =>s_reg14,
      reg15 =>s_reg15,
      reg16 =>s_reg16,
      reg17 =>s_reg17,
      reg18 =>s_reg18,
      reg19 =>s_reg19,
      reg20 =>s_reg20,
      reg21 =>s_reg21,
      reg22 =>s_reg22,
      reg23 =>s_reg23,
      reg24 =>s_reg24,
      reg25 =>s_reg25,
      reg26 =>s_reg26,
      reg27 =>s_reg27,
      reg28 =>s_reg28,
      reg29 =>s_reg29,
      reg30 =>s_reg30,
      reg31 => "0000000000000000000000000000000000000000000000000000000000000000",
      q => q2
    );


    REGIS0: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(0),
      d     => d,
      q     => s_reg0
    );

    REGIS1: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(1),
      d    => d,
      q    => s_reg1
    );

    REGIS2: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(2),
      d    => d,
      q    => s_reg2
    );

    REGIS3: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(3),
      d    => d,
      q    => s_reg3
    );

    REGIS4: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(4),
      d    => d,
      q    => s_reg4
    );

    REGIS5: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(5),
      d    => d,
      q    => s_reg5
    );

    REGIS6: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(6),
      d    => d,
      q    => s_reg6
    );

    REGIS7: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(7),
      d    => d,
      q    => s_reg7
    );

    REGIS8: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(8),
      d    => d,
      q    => s_reg8
    );

    REGIS9: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(9),
      d    => d,
      q    => s_reg9
    );


    REGIS10: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(10),
      d    => d,
      q    => s_reg10
    );

    REGIS11: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(11),
      d    => d,
      q    => s_reg11
    );

    REGIS12: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(12),
      d    => d,
      q    => s_reg12
    );

    REGIS13: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(13),
      d    => d,
      q    => s_reg13
    );

    REGIS14: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(14),
      d    => d,
      q    => s_reg14
    );

    REGIS15: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(15),
      d    => d,
      q    => s_reg15
    );

    REGIS16: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(16),
      d    => d,
      q    => s_reg16
    );

    REGIS17: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(17),
      d    => d,
      q    => s_reg17
    );

    REGIS18: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(18),
      d    => d,
      q    => s_reg18
    );

    REGIS19: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(19),
      d    => d,
      q    => s_reg19
    );

    REGIS20: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(20),
      d    => d,
      q    => s_reg20
    );

    REGIS21: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(21),
      d    => d,
      q    => s_reg21
    );

    REGIS22: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(22),
      d    => d,
      q    => s_reg22
    );

    REGIS23: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(23),
      d    => d,
      q    => s_reg23
    );

    REGIS24: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(24),
      d    => d,
      q    => s_reg24
    );

    REGIS25: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(25),
      d    => d,
      q    => s_reg25
    );

    REGIS26: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(26),
      d    => d,
      q    => s_reg26
    );

    REGIS27: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(27),
      d    => d,
      q    => s_reg27
    );

    REGIS28: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(28),
      d    => d,
      q    => s_reg28
    );

    REGIS29: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(29),
      d    => d,
      q    => s_reg29
    );

    REGIS30: reg port map(
      clock => clock,
      reset => reset,
      load  => sel(30),
      d    => d,
      q    => s_reg30
    );
    

    end architecture regfile_arch;
