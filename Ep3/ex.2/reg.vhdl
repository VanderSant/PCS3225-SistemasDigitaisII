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