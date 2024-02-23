//****************************************Copyright (c)****************************************//
//Created by    : Rei_Fu_Zhang
//Copyright     : N96111150 NCKU_ES_MMNLAB
//Descriptions  : Asynchronous reset, synchronous release, and conversion to active high level.
//
//All rights reserved
//---------------------------------------------------------------------------------------------
//*********************************************************************************************//

module asyn_rst_syn(
    input clk,          
    input reset_n,      //negedge active
    
    output syn_reset    //posedge active
    );

//reg define
reg rst_1;
reg rst_2;

//*****************************************************
//**                    main code
//***************************************************** 
assign syn_reset  = rst_2;
always @ (posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        rst_1 <= 1'b1;
        rst_2 <= 1'b1;
    end
    else begin
        rst_1 <= 1'b0;
        rst_2 <= rst_1;
    end
end
    
endmodule