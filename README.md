# DUALSHOCK and DUALSHOCK 2 Driver for FPGAs

This is HDL code to make an FPGA communicate with DUALSHOCK (SCPH-1200), which was developed for the original PlayStation.
Also compatible with DUALSHOCK 2 (SCPH-10010) for PlayStation 2.

`pad_driver.sv` is the main circuit, and by connecting each DUALSHOCK terminals (DAT, CMD, SEL, CLK) to it, the button press status (*pad_buttons*) and analog stick values (*pad_right_hori*, etc.) can be read from here.
