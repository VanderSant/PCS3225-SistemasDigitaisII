#9464

entity signExtend is
    port(
        i: in   bit_vector( 31 downto 0 );
        o: out  bit_vector( 63 downto 0 )
    );
    end signExtend;

architecture signExtend_arch of signExtend is

    signal sCBZ_address : bit_vector(18 downto 0);
    signal LDUR_address, iLDUR_address: bit_vector(63 downto 0);
    signal STUR_address, iSTUR_address: bit_vector(63 downto 0);
    signal CBZ_address, iCBZ_address  : bit_vector(63 downto 0);
    signal B_address, iB_address      : bit_vector(63 downto 0);
    signal LDUR, STUR, CBZ, B         : bit_vector(63 downto 0);
    signal s_saida: bit_vector(63 downto 0);

    begin
        o <= 
        LDUR when (i(31 downto 21)="11111000010") else
        STUR when (i(31 downto 21)="11111000000") else
        CBZ  when (i(31 downto 24)="10110100")    else
        B    when (i(31 downto 26)="000101")      else 
        (others=>'0');


        --LDUR
        -- caso o endereço STUR seja positivo:
        LDUR_address(63 downto 9) <= (others=>'0');
        LDUR_address(8 downto 0 ) <= i(20 downto 12); 

        -- caso o endereço STUR seja negativo:
        iLDUR_address(63 downto 9) <= (others=>'1');
        iLDUR_address(8 downto 0 ) <= i(20 downto 12);

        with i(20) select LDUR <=
            LDUR_address  when '0',
            iLDUR_address  when '1',
            (others=>'0') when others;


        --STUR
        -- caso o endereço STUR seja positivo:
        STUR_address(63 downto 9) <= (others=>'0');
        STUR_address(8 downto 0 ) <= i(20 downto 12); 

        -- caso o endereço STUR seja negativo:
        iSTUR_address(63 downto 9) <= (others=>'1');
        iSTUR_address(8 downto 0 ) <= i(20 downto 12);

        with i(20) select STUR <=
            STUR_address  when '0',
            iSTUR_address  when '1',
            (others=>'0') when others;


        --CBZ
        -- caso o endereço CBZ seja positivo:
        CBZ_address(63 downto 19) <= (others=>'0');
        CBZ_address(18 downto 0 ) <= i(23 downto 5); 

        -- caso o endereço CBZ seja negativo:
        iCBZ_address(63 downto 19) <= (others=>'1');
        iCBZ_address(18 downto 0 ) <= i(23 downto 5);

        with i(23) select CBZ <=
            CBZ_address  when '0',
            iCBZ_address  when '1',
            (others=>'0') when others;


        --B
        -- caso o endereço B seja positivo:
        B_address(63 downto 26) <= (others=>'0');
        B_address(25 downto 0 ) <= i(25 downto 0); 

        -- caso o endereço B seja negativo:
        iB_address(63 downto 26) <= (others=>'1');
        iB_address(25 downto 0 ) <= i(25 downto 0);

        with i(25) select B <=
            B_address  when '0',
            iB_address  when '1',
            (others=>'0') when others;

        

end architecture signExtend_arch;
