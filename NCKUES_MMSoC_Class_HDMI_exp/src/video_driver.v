//****************************************Copyright (c)****************************************//
//Created by    : Rei_Fu_Zhang
//Copyright     : NCKU_ES_MMNLAB(only for education)
//Descriptions  : Driver
//
//---------------------------------------------------------------------------------------------
//*********************************************************************************************// 

module video_driver(
    input           	pixel_clk	,
    input           	sys_rst_n	,
		
    	
    output          	video_hs	,    
    output          	video_vs	,    
    output          	video_de	,    
    output  	[23:0]  video_rgb	,    
    output	reg			data_req 	,
	
    input   	[23:0]  pixel_data	,   
    output  reg	[10:0]  pixel_xpos	,   
    output  reg	[10:0]  pixel_ypos      
);


parameter  H_SYNC   =  11'd40;  
parameter  H_BACK   =  11'd220;  
parameter  H_DISP   =  11'd1280; 
parameter  H_FRONT  =  11'd110;   
parameter  H_TOTAL  =  11'd1650; 

parameter  V_SYNC   =  11'd5;    
parameter  V_BACK   =  11'd20;   
parameter  V_DISP   =  11'd720;  
parameter  V_FRONT  =  11'd5;    
parameter  V_TOTAL  =  11'd750;  


//reg define
reg  [11:0] cnt_h;
reg  [11:0] cnt_v;
reg       	video_en;

//*****************************************************
//**                    main code
//*****************************************************

assign video_de  = video_en;
assign video_hs  = ( cnt_h < H_SYNC ) ? 1'b0 : 1'b1;  
assign video_vs  = ( cnt_v < V_SYNC ) ? 1'b0 : 1'b1;  


always @(posedge pixel_clk or negedge sys_rst_n) begin
	if(!sys_rst_n)
		video_en <= 1'b0;
	else
		video_en <= data_req;
end


assign video_rgb = video_de ? pixel_data : 24'd0;


always @(posedge pixel_clk or negedge sys_rst_n) begin
	if(!sys_rst_n)
		data_req <= 1'b0;
	else if(((cnt_h >= H_SYNC + H_BACK - 2'd2) && (cnt_h < H_SYNC + H_BACK + H_DISP - 2'd2))
                  && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK+V_DISP)))
		data_req <= 1'b1;
	else
		data_req <= 1'b0;
end


always@ (posedge pixel_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        pixel_xpos <= 11'd0;
    else if(data_req)
        pixel_xpos <= cnt_h + 2'd2 - H_SYNC - H_BACK ;
    else 
        pixel_xpos <= 11'd0;
end
    
	
always@ (posedge pixel_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        pixel_ypos <= 11'd0;
    else if((cnt_v >= (V_SYNC + V_BACK)) && (cnt_v < (V_SYNC + V_BACK + V_DISP)))
        pixel_ypos <= cnt_v + 1'b1 - (V_SYNC + V_BACK) ;
    else 
        pixel_ypos <= 11'd0;
end


always @(posedge pixel_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_h <= 12'd0;
    else begin
        if(cnt_h < H_TOTAL - 1'b1)
            cnt_h <= cnt_h + 1'b1;
        else 
            cnt_h <= 12'd0;
    end
end


always @(posedge pixel_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        cnt_v <= 11'd0;
    else if(cnt_h == H_TOTAL - 1'b1) begin
        if(cnt_v < V_TOTAL - 1'b1)
            cnt_v <= cnt_v + 1'b1;
        else 
            cnt_v <= 11'd0;
    end
end

endmodule