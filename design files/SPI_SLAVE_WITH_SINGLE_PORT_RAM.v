module SPI_SLAVE_WITH_SINGLE_PORT_RAM( MOSI,SS_n,clk,rst_n,MISO);
input MOSI,SS_n,clk,rst_n;
output MISO;
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8; 
wire [9:0]rx_data;
wire rx_valid;
wire  tx_valid;
wire  [7:0]tx_data;
RAM #(.MEM_DEPTH(MEM_DEPTH),.ADDR_SIZE(ADDR_SIZE)) INS_RAM(.din(rx_data),.clk(clk),.rst_n(rst_n),.rx_valid(rx_valid),.dout(tx_data),.tx_valid(tx_valid));
SPI INS_SPI (.MOSI(MOSI),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.tx_valid(tx_valid),.tx_data(tx_data),.MISO(MISO),.rx_valid(rx_valid),.rx_data(rx_data));
endmodule