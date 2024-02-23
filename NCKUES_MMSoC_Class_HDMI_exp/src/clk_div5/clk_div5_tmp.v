//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.9 Beta-6
//Part Number: GW2A-LV18PG256C8/I7
//Device: GW2A-18
//Device Version: C
//Created Time: Wed Nov 29 10:42:04 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    clk_div5 your_instance_name(
        .clkout(clkout_o), //output clkout
        .hclkin(hclkin_i), //input hclkin
        .resetn(resetn_i), //input resetn
        .calib(calib_i) //input calib
    );

//--------Copy end-------------------
