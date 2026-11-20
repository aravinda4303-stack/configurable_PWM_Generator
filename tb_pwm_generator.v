`timescale 1ns / 1ps

module tb_pwm_generator;

    // Simulation clock: 100 MHz => 10 ns period
    reg clk = 1'b0;
    reg reset = 1'b1;
    wire pwm_out;

    // Use a shorter period for quick simulation:
    // 100 MHz / 1 MHz = 100 clock cycles per PWM period.
    pwm_generator #(
        .CLK_FREQ_HZ(100_000_000),
        .PWM_FREQ_HZ(1_000_000),
        .DUTY_CYCLE(25)
    ) dut (
        .clk(clk),
        .reset(reset),
        .pwm_out(pwm_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("pwm_generator.vcd");
        $dumpvars(0, tb_pwm_generator);

        repeat (4) @(posedge clk);
        reset = 1'b0;

        // Observe several PWM periods.
        repeat (350) @(posedge clk);

        $display("PWM test completed.");
        $finish;
    end

endmodule
