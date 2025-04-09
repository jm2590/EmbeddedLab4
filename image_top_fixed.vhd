library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity image_top is
    port (  clk: in std_logic;
         vga_hs, vga_vs: out std_logic;
         vga_r, vga_b: out std_logic_vector(4 downto 0);
         vga_g: out std_logic_vector(5 downto 0));
end image_top;

architecture Behavioral of image_top is

    signal div: std_logic;
    signal hcount, vcount: std_logic_vector(9 downto 0);
    signal vid, hs, vs: std_logic;
    signal bit_18_addr: std_logic_vector(17 downto 0); -- address
    signal data_out: std_logic_vector(7 downto 0); -- output of picture

    component clock_div
        port(   clk : in std_logic;
             div : out std_logic);
    end component;

    component picture
        port(   clka : IN STD_LOGIC;
                addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
                douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;

    component pixel_pusher
        port(   clk, clk_en, vs: in std_logic;
             pxl_sig:in std_logic_vector(7 downto 0);
             hcount: in std_logic_vector(9 downto 0);
             vid: in std_logic;
             R_Sig, B_Sig: out std_logic_vector(4 downto 0);
             G_Sig: out std_logic_vector(5 downto 0);
             addr: out std_logic_vector(17 downto 0)); -- address
    end component;

    component vga_ctrl
        port(   clk, clk_en: in std_logic;
             hcount, vcount: out std_logic_vector(9 downto 0);
             vid, hs, vs: out std_logic);
    end component;


begin

    u1: clock_div
        port map(   clk => clk,
                 div => div);

    u2: picture
        port map(   clka => clk,
                    addra => bit_18_addr,
                    douta => data_out);

    u3: pixel_pusher
        port map(   clk => clk,
                    clk_en => div,
                    vs => vs,
                    pxl_sig => data_out,
                    hcount => hcount,
                    vid => vid,
                    R_Sig => vga_r,
                    B_Sig => vga_b,
                    G_Sig => vga_g,
                    addr => bit_18_addr);

    u4: vga_ctrl
        port map(   clk => clk,
                 clk_en => div,
                 hcount => hcount,
                 vcount => vcount,
                 vid => vid,
                 hs => vga_hs,
                 vs => vs);

vga_vs <= vs;

end Behavioral;
