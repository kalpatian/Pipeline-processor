library verilog;
use verilog.vl_types.all;
entity shiftv is
    port(
        d               : in     vl_logic_vector(31 downto 0);
        sa              : in     vl_logic_vector(31 downto 0);
        sign            : in     vl_logic_vector(3 downto 0);
        sh              : out    vl_logic_vector(31 downto 0)
    );
end shiftv;
