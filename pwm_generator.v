`timescale 1ns / 1ps

// PWM Generator for Xilinx Artix-7 FPGA
// Default assumptions: 100 MHz input clock, 1 kHz PWM, 50% duty cycle.
// Change CLK_FREQ_HZ, PWM_FREQ_HZ, and DUTY_CYCLE as required.
module pwm_generator #(
    parameter integer CLK_FREQ_HZ = 100_000_000,
    parameter integer PWM_FREQ_HZ = 1_000,
    parameter integer DUTY_CYCLE  = 50
)(
    input  wire clk,
    input  wire reset,       // Active-high synchronous reset
    output reg  pwm_out
);

    localparam integer PERIOD_COUNT =
        (CLK_FREQ_HZ / PWM_FREQ_HZ);

    localparam integer HIGH_COUNT =
        ((PERIOD_COUNT * DUTY_CYCLE) / 100);

    localparam integer COUNTER_WIDTH =
        (PERIOD_COUNT <= 2) ? 1 : $clog2(PERIOD_COUNT);

    reg [COUNTER_WIDTH-1:0] counter;

    initial begin
        if (CLK_FREQ_HZ <= 0)
            $error("CLK_FREQ_HZ must be greater than zero");
        if (PWM_FREQ_HZ <= 0)
            $error("PWM_FREQ_HZ must be greater than zero");
        if (PWM_FREQ_HZ > CLK_FREQ_HZ)
            $error("PWM_FREQ_HZ cannot exceed CLK_FREQ_HZ");
        if ((DUTY_CYCLE < 0) || (DUTY_CYCLE > 100))
            $error("DUTY_CYCLE must be between 0 and 100");
        if ((CLK_FREQ_HZ % PWM_FREQ_HZ) != 0)
            $error("For this simple implementation, CLK_FREQ_HZ must be divisible by PWM_FREQ_HZ");
    end

    always @(posedge clk) begin
        if (reset) begin
            counter <= {COUNTER_WIDTH{1'b0}};
            pwm_out <= 1'b0;
        end else begin
            if (counter == PERIOD_COUNT - 1)
                counter <= {COUNTER_WIDTH{1'b0}};
            else
                counter <= counter + 1'b1;

            if (counter < HIGH_COUNT)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;
        end
    end

endmodule
