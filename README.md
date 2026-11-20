# PWM Generator – Artix-7 FPGA (Vivado)

A parameterized Verilog PWM (Pulse Width Modulation) generator intended for an
Artix-7 FPGA board and Xilinx Vivado.

## Default configuration

- Input clock: 100 MHz
- PWM frequency: 1 kHz
- Duty cycle: 50%
- Reset: synchronous, active-high
- Output: `pwm_out`

The default period is 100,000 clock cycles. The output remains HIGH for 50,000
cycles and LOW for 50,000 cycles.

## Project structure

```text
PWM_Generator_Artix7/
├── rtl/
│   └── pwm_generator.v
├── sim/
│   └── tb_pwm_generator.v
├── constraints/
│   └── Artix7_Master.xdc
├── scripts/
│   └── create_project.tcl
├── README.md
└── .gitignore
```

## Open in Vivado

1. Extract this project folder.
2. Open the Vivado Tcl Console.
3. Change directory to this folder, then run:
   `source scripts/create_project.tcl`
4. Confirm that the FPGA part in `scripts/create_project.tcl` matches your board.
5. Open `constraints/Artix7_Master.xdc` and add the correct package pins from
   your board's master XDC.
6. Run **Run Synthesis**, **Run Implementation**, and **Generate Bitstream**.

## Change PWM frequency and duty cycle

Edit the parameters in the module instantiation or set them in your own top-level
wrapper:

```verilog
pwm_generator #(
    .CLK_FREQ_HZ(100_000_000),
    .PWM_FREQ_HZ(1_000),
    .DUTY_CYCLE(75)
) pwm_inst (
    .clk(clk),
    .reset(reset),
    .pwm_out(pwm_out)
);
```

`DUTY_CYCLE` is an integer percentage from 0 to 100. This simple version expects
`CLK_FREQ_HZ` to be exactly divisible by `PWM_FREQ_HZ`.

## Simulation

In Vivado:
1. Set `tb_pwm_generator` as the simulation top (the Tcl script does this for
   the simulation fileset).
2. Click **Run Simulation → Run Behavioral Simulation**.
3. Inspect `pwm_out` in the waveform window.

The testbench uses a 1 MHz PWM frequency and 25% duty cycle to keep simulation
short. The synthesizable module's default settings remain 1 kHz and 50%.

## Important board-specific note

"Artix-7" identifies the FPGA family, not the exact development board. The XDC
file is a template and intentionally contains no guessed package pins. Before
implementation, use the master XDC supplied for your exact board and assign:
- `clk` to the onboard clock pin
- `reset` to a push-button or switch pin
- `pwm_out` to an LED, PMOD pin, or other output pin

Also confirm the oscillator frequency and FPGA part number printed in your
board documentation.

## GitHub

Commit the complete folder. Do not commit generated Vivado output folders
unless your project specifically requires them.
