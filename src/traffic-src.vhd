library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY traffic_fsm IS
    PORT (
        clk: IN std_logic;
        rst: IN std_logic;
        pedisterian_button:IN std_logic;
        west_traffic_light:OUT std_logic_vector( 1 DOWNTO 0);
        east_traffic_light:OUT std_logic_vector( 1 DOWNTO 0);
        north_traffic_light:OUT std_logic_vector( 1 DOWNTO 0);
        south_traffic_light:OUT std_logic_vector( 1 DOWNTO 0)
        );
END traffic_fsm;



ARCHITECTURE traffic_fsm_arch OF traffic_fsm IS
CONSTANT red_light_const: std_logic_vector (1 downto 0) := "01";
CONSTANT green_light_const: std_logic_vector (1 downto 0) := "10";
CONSTANT yellow_light_const: std_logic_vector (1 downto 0) := "11";
TYPE traffic_state IS ( s0, s1,s2,s3,s4,s5,s6,s7);
SIGNAL state_reg, state_next: traffic_state;

BEGIN

-- sequential section

PROCESS ( rst,clk)
BEGIN
    IF ( rst = '1') THEN
        state_reg <= s0;
    ELSIF ( rising_edge(clk) ) THEN
        state_reg <= state_next;
    END IF;
END PROCESS;

-- combinational section

PROCESS(state_reg,pedisterian_button)

BEGIN
    CASE state_reg IS
        WHEN s0 =>
            state_next <= s1;
            
            west_traffic_light <= red_light_const ;
            east_traffic_light <= red_light_const ;
            north_traffic_light <=red_light_const ;
            south_traffic_light <=red_light_const ;
        WHEN s1 =>
            IF ( pedisterian_button = '1') THEN
                state_next <= s5;
            ELSE
                state_next <= s2;
            END IF;

            west_traffic_light <= green_light_const ;
            east_traffic_light <= green_light_const ;
            north_traffic_light <=red_light_const ;
            south_traffic_light <=red_light_const ;

        WHEN s2 =>
            IF ( pedisterian_button = '1') THEN
                state_next <= s6;
            ELSE
                state_next <= s3;
            END IF;

            west_traffic_light <= yellow_light_const ;
            east_traffic_light <= yellow_light_const ;
            north_traffic_light <=red_light_const ;
            south_traffic_light <=red_light_const ;

        WHEN s3 =>
            IF ( pedisterian_button = '1') THEN
                state_next <= s7;
            ELSE
                state_next <= s4;
            END IF;

            west_traffic_light <= red_light_const ;
            east_traffic_light <= red_light_const ;
            north_traffic_light <=green_light_const ;
            south_traffic_light <=green_light_const ;

        WHEN s4 =>
            IF ( pedisterian_button = '1') THEN
                state_next <= s0;
            ELSE
                state_next <= s1;
            END IF;

            west_traffic_light <= red_light_const ;
            east_traffic_light <= red_light_const ;
            north_traffic_light <=yellow_light_const ;
            south_traffic_light <=yellow_light_const ;

        WHEN s5 =>
            state_next <= s6;

            west_traffic_light <= yellow_light_const ;
            east_traffic_light <= yellow_light_const ;
            north_traffic_light <=red_light_const ;
            south_traffic_light <=red_light_const ;

        WHEN s6 =>
            state_next <= s7;

            west_traffic_light <= red_light_const ;
            east_traffic_light <= red_light_const ;
            north_traffic_light <=green_light_const ;
            south_traffic_light <=green_light_const ;

        WHEN s7 =>
            state_next <= s0;

            west_traffic_light <= red_light_const ;
            east_traffic_light <= red_light_const ;
            north_traffic_light <=yellow_light_const ;
            south_traffic_light <=yellow_light_const ;

    END CASE;

END PROCESS; 

END traffic_fsm_arch;
