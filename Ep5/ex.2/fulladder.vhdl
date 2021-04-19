entity fulladder is
    port (
      a,b  : in bit;       -- adends
      cin  : in bit;       -- carry-in
      s    : out bit;      -- sum
      cout : out bit      -- carry-out
      );
  end entity fulladder;
  
  architecture wakerly of fulladder is
  begin
    s <= (a xor b) xor cin;
    cout <= (a and b) or (cin and a) or (cin and b);
  end architecture wakerly;