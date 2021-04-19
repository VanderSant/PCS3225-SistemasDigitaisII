entity fa_1bit is
    port (
      A,B : in bit;       -- adends
      CIN : in bit;       -- carry-in
      SUM : out bit;      -- sum
      COUT : out bit      -- carry-out
      );
  end entity fa_1bit;
  
  architecture sum_minterm of fa_1bit is
  -- Canonical sum solution (sum of minterms)
  begin
    -- SUM = m1 + m2 + m4 + m7
    SUM <= (not(CIN) and not(A) and B) or
           (not(CIN) and A and not(B)) or
           (CIN and not(A) and not(B)) or
           (CIN and A and B);
    -- COUT = m3 + m5 + m6 + m7
    COUT <= (not(CIN) and A and B) or
            (CIN and not(A) and B) or
            (CIN and A and not(B)) or
            (CIN and A and B);
  end architecture sum_minterm;
  
  architecture product_maxterm of fa_1bit is
  -- Canonical product solution (product of maxterms)
  begin
    -- SUM = M0 . M3 . M5 . M6
    SUM <= (CIN or A or B) and
           (CIN or not(A) or not(B)) and
           (not(CIN) or A or not(B)) and
           (not(CIN) or not(A) or B);
  
    -- COUT = M0 . M1 . M2 . M4
    COUT <= (CIN or A or B) and
           (CIN or A or not(B)) and
           (CIN or not(A) or B) and
           (not(CIN) or A or B);
  end architecture product_maxterm;
    
  architecture wakerly of fa_1bit is
  -- Solution Wakerly's Book (4th Edition, page 475)
  begin
    SUM <= (A xor B) xor CIN;
    COUT <= (A and B) or (CIN and A) or (CIN and B);
  end architecture wakerly;
  
  architecture bug1 of fa_1bit is
  -- Canonical sum solution with bug
  begin
    -- SUM = m1 + m2 + m4 + m7
    SUM <= (CIN and not(A) and B) or
           (not(CIN) and A and not(B)) or
           (CIN and not(A) and not(B)) or
           (CIN and A and B);
    -- COUT = m3 + m5 + m6 + m7
    COUT <= (not(CIN) and A and B) or
            (CIN and not(A) and B) or
            (CIN and A and not(B)) or
            (CIN and A and B);
  end architecture bug1;
  
  architecture bug2 of fa_1bit is
  -- Canonical product solution with bug
  begin
    -- SUM = M0 . M3 . M5 . M6
    SUM <= (CIN or A or B) and
           (CIN or not(A) or not(B)) and
           (not(CIN) or A or not(B)) and
           (not(CIN) or not(A) or B);
  
    -- COUT = M0 . M1 . M2 . M4
    COUT <= (CIN or A or B) and
           (CIN or A or not(B)) and
           (CIN or not(A) or not(B)) and
           (not(CIN) or A or B);
  end architecture bug2;

  entity bit5_to_bit16_C2 is
    port(
    A: in bit_vector(4 downto 0);
    B: out bit_vector(15 downto 0)
    );
end entity bit5_to_bit16_C2;

architecture bit5_to_bit16_C2_arch of bit5_to_bit16_C2 is
    signal s_a: bit_vector(4 downto 0);
    begin
        s_a <= A;
        B(15) <= '0'; 
        B(14) <= '0'; B(13) <= '0'; B(12) <= '0'; B(11) <= '0'; B(10) <= '0';
        B(9) <= '0';  B(8) <= '0';  B(7) <= '0';  B(6) <= '0';  B(5) <= '0';
        B(4) <= s_a(4); B(3) <= s_a(3); B(2) <= s_a(2); B(1) <= s_a(1); B(0) <= s_a(0); 

        
    end architecture bit5_to_bit16_C2_arch;

    library ieee;
use ieee.numeric_bit.rising_edge;

entity compl2_5bit is
    port(
        A : in  bit_vector(4 downto 0);
        B : out bit_vector(4 downto 0)
    );
    end entity compl2_5bit;

architecture acompl2_5bit of compl2_5bit is

    component fa_5bit is
        port (
          A,B  : in  bit_vector(4 downto 0);
          CIN  : in  bit;
          SUM  : out bit_vector(4 downto 0);
          COUT : out bit
          );
      end component;

        signal i_a: bit_vector(4 downto 0);
        signal s_sum: bit_vector(4 downto 0);

    begin
        i_a <= not A;
        coml2: fa_5bit port map (
            A   =>  i_a,
            B   =>  "00001",
            CIN =>  '0',
            SUM =>  s_sum,
            COUT=>  open 
            );

        with A(4) select
            B   <= A when '0',
                   s_sum when '1',
                   "00000" when others;

    end architecture acompl2_5bit;

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
    
                     entity fa_5bit is
                        port (
                          A,B : in bit_vector(4 downto 0);    -- adends
                          CIN : in bit;                       -- carry-in
                          SUM : out bit_vector(4 downto 0);   -- sum
                          COUT : out bit                      -- carry-out
                          );
                      end entity fa_5bit;
                      
                      architecture ripple of fa_5bit is
                      -- Ripple adder solution
                      
                        --  Declaration of the 1 bit adder.  
                        component fa_1bit
                          port (
                            A,B : in bit;       -- adends
                            CIN : in bit;       -- carry-in
                            SUM : out bit;      -- sum
                            COUT : out bit      -- carry-out
                          );
                        end component fa_1bit;
                      
                        signal x,y :   bit_vector(4 downto 0);
                        signal s :     bit_vector(4 downto 0);
                        signal cin0 :  bit;
                        signal cin1 :  bit;
                        signal cin2 :  bit;
                        signal cin3 :  bit;
                        signal cin4 :  bit;
                        signal cout0 : bit;  
                        signal cout1 : bit;
                        signal cout2 : bit;
                        signal cout3 : bit;
                        signal cout4 : bit;
                      
                        
                      begin
                        
                        -- Components instantiation
                        ADDER0: entity work.fa_1bit(wakerly) port map (
                          A => x(0),
                          B => y(0),
                          CIN => cin0,
                          SUM => s(0),
                          COUT => cout0
                          );
                      
                        ADDER1: entity work.fa_1bit(wakerly) port map (
                          A => x(1),
                          B => y(1),
                          CIN => cout0,
                          SUM => s(1),
                          COUT => cout1
                          );
                      
                        ADDER2: entity work.fa_1bit(wakerly) port map (
                          A => x(2),
                          B => y(2),
                          CIN => cout1,
                          SUM => s(2),
                          COUT => cout2
                          );  
                      
                        ADDER3: entity work.fa_1bit(wakerly) port map (
                          A => x(3),
                          B => y(3),
                          CIN => cout2,
                          SUM => s(3),
                          COUT => cout3
                          );
                      
                      
                          ADDER4: entity work.fa_1bit(wakerly) port map (
                          A => x(4),
                          B => y(4),
                          CIN => cout3,
                          SUM => s(4),
                          COUT => cout4
                          );  
                      
                        x <= A;
                        y <= B;
                        cin0 <= CIN;
                        SUM <= s;
                        COUT <= cout4;
                        
                      end architecture ripple;

                      library ieee;
use ieee.numeric_bit.rising_edge;

entity fa_16bit is
    port (
      A,B  : in  bit_vector(15 downto 0);
      CIN  : in  bit;
      SUM  : out bit_vector(15 downto 0);
      COUT : out bit
      );
  end entity;

  architecture ripple of fa_16bit is

      --  Declaration of the 1-bit adder.  
      component fa_1bit
        port (
          A, B : in  bit;   -- adends
          CIN  : in  bit;   -- carry-in
          SUM  : out bit;   -- sum
          COUT : out bit    -- carry-out
        );
      end component fa_1bit;
    
      signal x,y    : bit_vector(15 downto 0);
      signal s      : bit_vector(15 downto 0);
      signal cin0   : bit;
      signal cout0  : bit;  
      signal cout1  : bit;
      signal cout2  : bit;
      signal cout3  : bit;
      signal cout4  : bit;  
      signal cout5  : bit;
      signal cout6  : bit;
      signal cout7  : bit;
      signal cout8  : bit;
      signal cout9  : bit;
      signal cout10 : bit;
      signal cout11 : bit;
      signal cout12 : bit;
      signal cout13 : bit;
      signal cout14 : bit;
      signal cout15 : bit;
      
    begin
      
      -- Components instantiation
      ADDER0: entity work.fa_1bit(wakerly) port map (
        A => x(0),
        B => y(0),
        CIN => cin0,
        SUM => s(0),
        COUT => cout0
        );
    
      ADDER1: entity work.fa_1bit(wakerly) port map (
        A => x(1),
        B => y(1),
        CIN => cout0,
        SUM => s(1),
        COUT => cout1
        );
    
      ADDER2: entity work.fa_1bit(wakerly) port map (
        A => x(2),
        B => y(2),
        CIN => cout1,
        SUM => s(2),
        COUT => cout2
        );  
    
      ADDER3: entity work.fa_1bit(wakerly) port map (
        A => x(3),
        B => y(3),
        CIN => cout2,
        SUM => s(3),
        COUT => cout3
        );
    
      ADDER4: entity work.fa_1bit(wakerly) port map (
        A => x(4),
        B => y(4),
        CIN => cout3,
        SUM => s(4),
        COUT => cout4
        );
    
      ADDER5: entity work.fa_1bit(wakerly) port map (
        A => x(5),
        B => y(5),
        CIN => cout4,
        SUM => s(5),
        COUT => cout5
        );
    
      ADDER6: entity work.fa_1bit(wakerly) port map (
        A => x(6),
        B => y(6),
        CIN => cout5,
        SUM => s(6),
        COUT => cout6
        );  
    
      ADDER7: entity work.fa_1bit(wakerly) port map (
        A => x(7),
        B => y(7),
        CIN => cout6,
        SUM => s(7),
        COUT => cout7
        );

        ADDER8: entity work.fa_1bit(wakerly) port map (
        A => x(8),
        B => y(8),
        CIN => cout7,
        SUM => s(8),
        COUT => cout8
        );

        ADDER9: entity work.fa_1bit(wakerly) port map (
        A => x(9),
        B => y(9),
        CIN => cout8,
        SUM => s(9),
        COUT => cout9
        );

        ADDER10: entity work.fa_1bit(wakerly) port map (
        A => x(10),
        B => y(10),
        CIN => cout9,
        SUM => s(10),
        COUT => cout10
        );

        ADDER11: entity work.fa_1bit(wakerly) port map (
        A => x(11),
        B => y(11),
        CIN => cout10,
        SUM => s(11),
        COUT => cout11
        );

        ADDER12: entity work.fa_1bit(wakerly) port map (
        A => x(12),
        B => y(12),
        CIN => cout11,
        SUM => s(12),
        COUT => cout12
        );

        ADDER13: entity work.fa_1bit(wakerly) port map (
        A => x(13),
        B => y(13),
        CIN => cout12,
        SUM => s(13),
        COUT => cout13
        );

        ADDER14: entity work.fa_1bit(wakerly) port map (
        A => x(14),
        B => y(14),
        CIN => cout13,
        SUM => s(14),
        COUT => cout14
        );

        ADDER15: entity work.fa_1bit(wakerly) port map (
        A => x(15),
        B => y(15),
        CIN => cout14,
        SUM => s(15),
        COUT => cout15
        );
        
      x <= A;
      y <= B;
      cin0 <= CIN;
      SUM <= s;
      COUT <= cout15;
      
    end architecture ripple;

    entity mux is
        port (
          rr    :   in bit_vector  (4 downto 0);    
          reg0  :   in bit_vector  (15 downto 0);
          reg1  :   in bit_vector  (15 downto 0);
          reg2  :   in bit_vector  (15 downto 0);
          reg3  :   in bit_vector  (15 downto 0);
          reg4  :   in bit_vector  (15 downto 0);
          reg5  :   in bit_vector  (15 downto 0);
          reg6  :   in bit_vector  (15 downto 0);
          reg7  :   in bit_vector  (15 downto 0);
          reg8  :   in bit_vector  (15 downto 0);
          reg9  :   in bit_vector  (15 downto 0);
          reg10 :   in bit_vector  (15 downto 0);
          reg11 :   in bit_vector  (15 downto 0);
          reg12 :   in bit_vector  (15 downto 0);
          reg13 :   in bit_vector  (15 downto 0);
          reg14 :   in bit_vector  (15 downto 0);
          reg15 :   in bit_vector  (15 downto 0);
          reg16 :   in bit_vector  (15 downto 0);
          reg17 :   in bit_vector  (15 downto 0);
          reg18 :   in bit_vector  (15 downto 0);
          reg19 :   in bit_vector  (15 downto 0);
          reg20 :   in bit_vector  (15 downto 0);
          reg21 :   in bit_vector  (15 downto 0);
          reg22 :   in bit_vector  (15 downto 0);
          reg23 :   in bit_vector  (15 downto 0);
          reg24 :   in bit_vector  (15 downto 0);
          reg25 :   in bit_vector  (15 downto 0);
          reg26 :   in bit_vector  (15 downto 0);
          reg27 :   in bit_vector  (15 downto 0);
          reg28 :   in bit_vector  (15 downto 0);
          reg29 :   in bit_vector  (15 downto 0);
          reg30 :   in bit_vector  (15 downto 0);
          reg31 :   in bit_vector  (15 downto 0);
    
          q :   out bit_vector (15 downto 0)
    
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

      entity mux16_2to1 is
        port (
          SEL : in bit;    
          A :   in bit_vector  (15 downto 0);
          B :   in bit_vector  (15 downto 0);
          Y :   out bit_vector (15 downto 0)
          );
      end entity mux16_2to1;
      
      architecture with_select of mux16_2to1 is
      begin
        with SEL select
          Y <= A when '0',
               B when '1',
               "0000000000000000" when others;
      end architecture with_select;
      

      entity reg is
        generic (
          wordSize    : natural := 16
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
     end entity regfile;




architecture regfile_arch of regfile is

  component reg is
    generic (
      wordSize    : natural := 16
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
      reg0  :   in bit_vector  (15 downto 0);
      reg1  :   in bit_vector  (15 downto 0);
      reg2  :   in bit_vector  (15 downto 0);
      reg3  :   in bit_vector  (15 downto 0);
      reg4  :   in bit_vector  (15 downto 0);
      reg5  :   in bit_vector  (15 downto 0);
      reg6  :   in bit_vector  (15 downto 0);
      reg7  :   in bit_vector  (15 downto 0);
      reg8  :   in bit_vector  (15 downto 0);
      reg9  :   in bit_vector  (15 downto 0);
      reg10 :   in bit_vector  (15 downto 0);
      reg11 :   in bit_vector  (15 downto 0);
      reg12 :   in bit_vector  (15 downto 0);
      reg13 :   in bit_vector  (15 downto 0);
      reg14 :   in bit_vector  (15 downto 0);
      reg15 :   in bit_vector  (15 downto 0);
      reg16 :   in bit_vector  (15 downto 0);
      reg17 :   in bit_vector  (15 downto 0);
      reg18 :   in bit_vector  (15 downto 0);
      reg19 :   in bit_vector  (15 downto 0);
      reg20 :   in bit_vector  (15 downto 0);
      reg21 :   in bit_vector  (15 downto 0);
      reg22 :   in bit_vector  (15 downto 0);
      reg23 :   in bit_vector  (15 downto 0);
      reg24 :   in bit_vector  (15 downto 0);
      reg25 :   in bit_vector  (15 downto 0);
      reg26 :   in bit_vector  (15 downto 0);
      reg27 :   in bit_vector  (15 downto 0);
      reg28 :   in bit_vector  (15 downto 0);
      reg29 :   in bit_vector  (15 downto 0);
      reg30 :   in bit_vector  (15 downto 0);
      reg31 :   in bit_vector  (15 downto 0);

      q :   out bit_vector (15 downto 0)

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
      reg31 => "0000000000000000",
      q => qq1
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
      reg31 => "0000000000000000",
      q => qq2
    );

    MUXQ3: mux port map(
      rr    => wr,    
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
      reg31 => "0000000000000000",
      q => qwr
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

    entity transbor is
        port(
            A: in bit;
            B: in bit;
            C: in bit;
            D: out bit
    
        );
        end entity transbor;
    
        architecture transbor_arch of transbor is
            begin
                D <= (A and B and (not C)) or 
                ((not A) and (not B) and C); 
    
            end architecture transbor_arch;

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
                      

                      