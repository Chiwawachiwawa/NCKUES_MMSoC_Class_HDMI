//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: V1.9.9 Beta-6
//Created Time: 2023-11-20 09:59:07
create_clock -name sys_clk -period 27 -waveform {0 10} [get_ports {sys_clk}]
