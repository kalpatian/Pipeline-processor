library verilog;
use verilog.vl_types.all;
entity shift is
    port(
        d               : in     vl_logic_vector(31 downto 0);
        sa              : in     vl_logic_vector(4 downto 0);
        right           : in     vl_logic;
        arith           : in     vl_logic;
        sh              : out    vl_logic_vector(31 downto 0)
    );
end shift;
