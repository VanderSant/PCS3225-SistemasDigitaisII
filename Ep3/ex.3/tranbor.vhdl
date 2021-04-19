
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