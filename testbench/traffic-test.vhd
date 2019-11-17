LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY traffic_fsm_test IS

END traffic_fsm_test;


ARCHITECTURE traffic_fsm_test_arch OF traffic_fsm_test IS

CONSTANT CLK_PERIOD: time :=10 ns;

SIGNAL clk,rst,button: std_logic;
SIGNAL west_out,east_out,north_out,south_out: std_logic_vector ( 1 DOWNTO 0);

BEGIN
traffic_component: entity work.traffic_fsm(traffic_fsm_arch) port map (clk=>clk, rst=>rst, pedisterian_button =>button, west_traffic_light=>west_out,east_traffic_light=>east_out,north_traffic_light=>north_out,south_traffic_light=>south_out);


clock: PROCESS
BEGIN
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;

END PROCESS;


io_test:PROCESS
BEGIN
    rst <= '0';
    button <= '0';

    rst <= '1';
    wait until falling_edge(clk);
    rst <= '0';

    wait for CLK_PERIOD * 6;
    button <= '1';
    wait until rising_edge(clk);
    button <= '0';
    wait until rising_edge(clk);
    wait for CLK_PERIOD * 6;


END PROCESS;

END traffic_fsm_test_arch;

