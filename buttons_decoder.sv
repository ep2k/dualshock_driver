module buttons_decoder (
    input logic [15:0] pad_buttons,
    output logic [6:0] hex_left,
    output logic [6:0] hex_right,
    output logic [3:0] leds
);

    assign hex_left = {
        pad_buttons[4],     // ↑
        pad_buttons[10],    // L1
        pad_buttons[7],     // ←
        pad_buttons[6],     // ↓
        pad_buttons[5],     // →
        1'b1,
        pad_buttons[8]      // L2
    };

    assign hex_right = {
        pad_buttons[12],    // △
        1'b1,
        pad_buttons[15],    // □
        pad_buttons[14],    // ×
        pad_buttons[13],    // ○
        pad_buttons[11],    // R1
        pad_buttons[9]      // R2
    };

    assign leds = ~{
        pad_buttons[1],     // Left SW
        pad_buttons[2],     // Right SW
        pad_buttons[0],     // Select
        pad_buttons[3]      // Start
    };
    
endmodule
