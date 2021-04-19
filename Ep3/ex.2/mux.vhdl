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