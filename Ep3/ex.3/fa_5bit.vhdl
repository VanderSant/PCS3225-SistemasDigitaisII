-------------------------------------------------------
--! @file fa_5bit.vhd
--! @brief 4-bit full adder
--! @author Edson S. Gomi (gomi@usp.br)
--! @date 2020-03-21
-------------------------------------------------------
 
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

