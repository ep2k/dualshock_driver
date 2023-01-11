module pad_clk_generator (
    input logic clk_50mhz,
    output logic pad_clk = 1'b0 // 500kHz
);

    logic [5:0] divider = 6'd0; // 0 ~ 49

    always_ff @(posedge clk_50mhz) begin
        divider <= (divider == 6'd49) ? 6'd0 : (divider + 6'd1);
    end

    always_ff @(posedge clk_50mhz) begin
        if (divider == 6'd49) begin
            pad_clk <= ~pad_clk;
        end
    end
    
endmodule
