//****************************************Copyright (c)****************************************//
//Created by    : Rei_Fu_Zhang
//Copyright     : NCKU_ES_MMNLAB(only for education)
//Descriptions  : 
//
//---------------------------------------------------------------------------------------------
//*********************************************************************************************// 

`timescale 1ns / 1ps

module serializer_10_to_1(
    input           paralell_clk,       
    input           serial_clk_5x,      
    input   [9:0]   paralell_data,      
    input           reset,

    output          serial_data         
    );
  
//*****************************************************
//**                    main code
//*****************************************************

OSER10 u_OSER10(
 .Q(serial_data), 
 .D0(paralell_data[0]), 
 .D1(paralell_data[1]),
 .D2(paralell_data[2]), 
 .D3(paralell_data[3]), 
 .D4(paralell_data[4]), 
 .D5(paralell_data[5]),
 .D6(paralell_data[6]), 
 .D7(paralell_data[7]), 
 .D8(paralell_data[8]), 
 .D9(paralell_data[9]), 
 .PCLK(paralell_clk), 
 .FCLK(serial_clk_5x),
 .RESET(reset)
);
defparam u_OSER10.GSREN="false";
defparam u_OSER10.LSREN ="true";

endmodule