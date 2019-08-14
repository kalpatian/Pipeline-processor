library verilog;
use verilog.vl_types.all;
entity addsub32 is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        sub             : in     vl_logic;
        s               : out    vl_logic_vector(31 downto 0)
    );
end addsub32;
