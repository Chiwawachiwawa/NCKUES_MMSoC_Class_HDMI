vlib work
vmap work work

vlog  -work work ./prim_sim.v
vlog  -work work ./tb/tb_hdmi_colorbar.v
vlog  -work work ../src/*.v
vlog  -work work ../src/clk_div5/clk_div5.v
vlog  -work work ../src/rpll_pixel_clk_5x/rpll_pixel_clk_5x.v

vsim -voptargs=+acc work.tb_hdmi_colorbar

add wave tb_hdmi_colorbar/*

view wave
view structure
view signals

run 200000ns