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