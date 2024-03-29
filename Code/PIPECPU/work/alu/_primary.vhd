library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        aluc            : in     vl_logic_vector(3 downto 0);
        r               : out    vl_logic_vector(31 downto 0);
        z               : out    vl_logic
    );
end alu;
