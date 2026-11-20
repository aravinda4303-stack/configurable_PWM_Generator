## Artix-7 PWM Generator constraints template
##
## IMPORTANT:
## This is intentionally a TEMPLATE. Artix-7 development boards use
## different FPGA part numbers and different package pin assignments.
## Replace the placeholders below using the master XDC for your exact board.
##
## Example clock constraint for a 100 MHz onboard oscillator:
## set_property -dict { PACKAGE_PIN <CLOCK_PIN> IOSTANDARD LVCMOS33 } [get_ports clk]
## create_clock -name sys_clk -period 10.000 [get_ports clk]
##
## Example user LED / PWM output:
## set_property -dict { PACKAGE_PIN <PWM_LED_PIN> IOSTANDARD LVCMOS33 } [get_ports pwm_out]
##
## Example reset push-button:
## set_property -dict { PACKAGE_PIN <RESET_PIN> IOSTANDARD LVCMOS33 } [get_ports reset]
##
## Do not program the FPGA until all used ports have valid pin assignments.
