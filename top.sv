module top (
    input logic clk_50mhz,
    input logic n_reset,

    input logic dat,
    output logic cmd,
    output logic n_sel,
    output logic sclk,
    input logic n_ack,

    input logic n_vibrate_sub_on,
    input logic n_vibrate_on,
    input logic [7:0] vibrate,
    input logic analog_mode,
    input logic check_left_stick,

    output logic [6:0] hex0,
    output logic [6:0] hex1,
    output logic [6:0] hex2,
    output logic [6:0] hex3,
    output logic [6:0] hex4,
    output logic [6:0] hex5,
    output logic [9:0] led
);

    logic [15:0] pad_buttons;
    logic [7:0] pad_right_hori, pad_right_vert, pad_left_hori, pad_left_vert;
    logic pad_connect;

    logic pad_clk; // 500kHz

    assign led[9:4] =
        {pad_connect, ~n_vibrate_on, ~n_vibrate_sub_on, 3'h0};

    pad_clk_generator pad_clk_generator(
        .clk_50mhz,
        .pad_clk
    );

    // Dualshock Driver
    pad_driver pad_driver(
        .clk(pad_clk),
        .reset(~n_reset),

        .analog_mode,
        .vibrate_sub(~n_vibrate_sub_on),
        .vibrate(n_vibrate_on ? 8'h0 : vibrate),

        .dat,
        .cmd,
        .n_sel,
        .sclk,
        .n_ack,

        .pad_connect,

        .pad_buttons,
        .pad_right_hori,
        .pad_right_vert,
        .pad_left_hori,
        .pad_left_vert
    );

    buttons_decoder buttons_decoder(
        .pad_buttons,
        .hex_left(hex1),
        .hex_right(hex0),
        .leds(led[3:0])
    );

    seg7 seg7_2(
        .idat(check_left_stick ? pad_left_hori[3:0] : pad_right_hori[3:0]),
        .odat(hex2)
    );

    seg7 seg7_3(
        .idat(check_left_stick ? pad_left_hori[7:4] : pad_right_hori[7:4]),
        .odat(hex3)
    );

    seg7 seg7_4(
        .idat(check_left_stick ? pad_left_vert[3:0] : pad_right_vert[3:0]),
        .odat(hex4)
    );

    seg7 seg7_5(
        .idat(check_left_stick ? pad_left_vert[7:4] : pad_right_vert[7:4]),
        .odat(hex5)
    );
    
endmodule
