-- #9606

entity controlunit is
    port(
        -- To Datapath
        reg2loc:      out bit;
        uncondBranch: out bit;
        branch:       out bit;
        memRead:      out bit;
        memToReg:     out bit;
        aluOp:        out bit_vector(1 downto 0);
        memWrite:     out bit;
        aluSrc:       out bit;
        regWrite:     out bit;

        --From Datapath
        opcode:       in bit_vector(10 downto 0)
    );
    end entity controlunit;

    architecture controlunit_arch of controlunit is
        signal instr: bit_vector(9 downto 0);

        begin
            reg2loc      <= instr(9);
            aluSrc       <= instr(8);
            memToReg     <= instr(7);
            regWrite     <= instr(6);
            memRead      <= instr(5);
            memWrite     <= instr(4);
            branch       <= instr(3);
            aluOp(1)     <= instr(2);
            aluOp(0)     <= instr(1);
            uncondBranch <= instr(0);

            instr <=
            "0001000100" when (opcode(10)='1')                  and    --R-type(1xx0101x000)
                              (opcode(7 downto 4)="0101")       and
                              (opcode(2 downto 0)="000")        else
            "1100010000" when (opcode ="11111000000")           else    --STUR
            "0111100000" when (opcode ="11111000010")           else   --LDUR
            "1000001010" when (opcode(10 downto 3) ="10110100") else   --CBZ
            "1000001001" when (opcode(10 downto 5) ="000101")   else   --B
            (others=>'0');

        end architecture controlunit_arch;