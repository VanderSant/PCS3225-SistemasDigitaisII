entity mux8_2to1 is
    port (
      SEL : in bit;    
      A :   in bit_vector  (7 downto 0);
      B :   in bit_vector  (7 downto 0);
      Y :   out bit_vector (7 downto 0)
      );
  end entity mux8_2to1;
  
  architecture with_select of mux8_2to1 is
  begin
    with SEL select
      Y <= A when '0',
           B when '1',
           "00000000" when others;
  end architecture with_select;
  