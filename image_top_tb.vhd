library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity image_top_tb is
end image_top_tb;

architecture Behavioral of image_top_tb is
signal tb_clk : std_logic := '0';
signal r_tb,b_tb : std_logic_vector(4 downto 0);
signal g_tb : std_logic_vector(5 downto 0);
signal vs_tb, hs_tb : std_logic;

component image_top is
    port(
        clk : in std_logic;
        vga_r, vga_b : out std_logic_vector(4 downto 0);
        vga_g : out std_logic_vector(5 downto 0);
        vga_vs, vga_hs : out std_logic
    );


end component;

component picture IS
    port (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end component;

component clock_div is
    port (
        clk : in std_logic;
        div : out std_logic
    );
end component;

component vga_ctrl is
    port (
        clk, clk_en : in std_logic;
        hcount, vcount: out std_logic_vector(9 downto 0);
        vid,hs,vs: out std_logic
    );
end component;

component pixel_pusher is
    Port (
        clk, clk_en, vid, vs: in std_logic;
        hcount: in std_logic_vector(9 downto 0);
        pxl_sig: in std_logic_vector(7 downto 0);
        R_sig, B_sig : out std_logic_vector(4 downto 0);
        G_sig : out std_logic_vector(5 downto 0);
        addr: out std_logic_vector(17 downto 0));
end component;

begin

    clk_gen_proc:
 process
    begin

        wait for 4 ns;
        tb_clk <= '1';

        wait for 4 ns;
        tb_clk <= '0';

    end process clk_gen_proc;

    dut : image_top
        port map (
            clk  => tb_clk,
            vga_r => r_tb,
            vga_b => b_tb,
            vga_g => g_tb,
            vga_vs => vs_tb,
            vga_hs => hs_tb
        );


end Behavioral;
