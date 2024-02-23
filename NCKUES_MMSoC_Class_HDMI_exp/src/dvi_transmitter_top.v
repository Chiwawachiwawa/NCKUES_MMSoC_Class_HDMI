//****************************************Copyright (c)****************************************//
//Created by    : Rei_Fu_Zhang
//Copyright     : NCKU_ES_MMNLAB(only for education)
//Descriptions  : transmitter_top
//
//---------------------------------------------------------------------------------------------
//*********************************************************************************************// 

module dvi_transmitter_top(
    input        pclk,           // pixel clock
    input        pclk_x5,        // pixel clock x5
    input        reset_n,        // reset
    
    input [23:0] video_din,      // RGB888 video in
    input        video_hsync,    // hsync data
    input        video_vsync,    // vsync data
    input        video_de,       // data enable
    
    output       tmds_clk_p,     // TMDS clk
    output       tmds_clk_n,
    output [2:0] tmds_data_p,    // TMDS data
    output [2:0] tmds_data_n
   );
    
//wire define
wire        reset;
    
wire [9:0]  red_10bit;
wire [9:0]  green_10bit;
wire [9:0]  blue_10bit;
wire [9:0]  clk_10bit;


wire [2:0] tmds_data;
wire tmds_clk;

//*****************************************************
//**                    main code
//***************************************************** 

assign clk_10bit = 10'b1111100000;


asyn_rst_syn reset_syn(
    .reset_n    (reset_n),
    .clk        (pclk),
    
    .syn_reset  (reset)    //高有效
    );
  

dvi_encoder encoder_b (
    .clkin      (pclk),
    .rstin      (reset),
    
    .din        (video_din[7:0]),
    .c0         (video_hsync),
    .c1         (video_vsync),
    .de         (video_de),
    .dout       (blue_10bit)
    );

dvi_encoder encoder_g (
    .clkin      (pclk),
    .rstin      (reset),
    
    .din        (video_din[15:8]),
    .c0         (1'b0),
    .c1         (1'b0),
    .de         (video_de),
    .dout       (green_10bit)
    );
    
dvi_encoder encoder_r (
    .clkin      (pclk),
    .rstin      (reset),
    
    .din        (video_din[23:16]),
    .c0         (1'b0),
    .c1         (1'b0),
    .de         (video_de),
    .dout       (red_10bit)
    );

serializer_10_to_1 serializer_b(
    .paralell_clk       (pclk),                  
    .serial_clk_5x      (pclk_x5),               
    .paralell_data      (blue_10bit),            
    .reset              (reset),
    .serial_data        (tmds_data[0])           
    );
TLVDS_OBUF u_TLVDS_B(
    .O  (tmds_data_p[0]),
    .OB (tmds_data_n[0]),
    .I  (tmds_data[0])
);
serializer_10_to_1 serializer_g(
    .paralell_clk       (pclk),                  
    .serial_clk_5x      (pclk_x5),               
    .paralell_data      (green_10bit),           
    .reset              (reset),
    .serial_data        (tmds_data[1])           
    );

TLVDS_OBUF u_TLVDS_G(
    .O  (tmds_data_p[1]),
    .OB (tmds_data_n[1]),
    .I  (tmds_data[1])
);

serializer_10_to_1 serializer_r(
    .paralell_clk       (pclk),                 
    .serial_clk_5x      (pclk_x5),               
    .paralell_data      (red_10bit),             
    .reset              (reset),
    .serial_data        (tmds_data[2])           
    );

TLVDS_OBUF u_TLVDS_R(
    .O  (tmds_data_p[2]),
    .OB (tmds_data_n[2]),
    .I  (tmds_data[2])
);

serializer_10_to_1 serializer_clk(
    .paralell_clk       (pclk),                  
    .serial_clk_5x      (pclk_x5),
    .paralell_data      (clk_10bit),
    .reset              (reset),
    .serial_data        (tmds_clk)             
    );

TLVDS_OBUF u_TLVDS_CLK(
    .O  (tmds_clk_p),
    .OB (tmds_clk_n),
    .I  (tmds_clk)
);

endmodule