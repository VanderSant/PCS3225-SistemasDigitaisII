--#7119
--#7173

entity alu1bit is
    port(
        a, b, less, cin             : in bit;
        ainvert, binvert            : in bit;
        operation                   : in bit_vector(1 downto 0);
        result, cout, set, overflow : out bit
    );
    end entity alu1bit;

    architecture alu1bit_arch of alu1bit is
        component fulladder is
            port (
              a,b  : in bit;       -- adends
              cin  : in bit;       -- carry-in
              s    : out bit;      -- sum
              cout : out bit      -- carry-out
              );
          end component fulladder;
          signal s_a, s_b, s_s, s_cout : bit;
          signal s_and, s_or, s_slt    : bit;
          signal s_of                  : bit;


          begin

            fsm: process (a, b, ainvert, binvert, operation)
            begin

            if    (ainvert='1') then s_a <= not a;
            elsif (ainvert='0') then s_a <= a;
            end if;

            if    (binvert='1') then s_b <= not b;
            elsif (binvert='0') then s_b <= b;
            end if;

            end process;
            

            set <= s_s;
            overflow <= s_of;
            cout <= s_cout;

            FULADD: fulladder port map(
                a    => s_a,
                b    => s_b,
                cin  => cin,
                s    => s_s,
                cout => s_cout
            );

            s_or <= s_a or s_b;

            s_and <= (s_a and s_b);

            s_slt <= less;
            
            s_of <= (s_a and s_b and (not s_s)) or 
                       ((not s_a) and (not s_b) and s_s); 

            with operation select result <=
                s_and  when "00",
                s_or   when "01",
                s_s    when "10",
                s_slt  when "11",
                '0'    when others;

        end architecture alu1bit_arch;