module SPI_tb();
reg  MOSI;
reg  SS_n,clk,rst_n;
reg  tx_valid;
reg  [7:0]tx_data;
wire MISO;
wire rx_valid;
wire [9:0]rx_data;
SPI DUT_SPI (.MOSI(MOSI),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.tx_valid(tx_valid),.tx_data(tx_data),.MISO(MISO),.rx_valid(rx_valid),.rx_data(rx_data));
integer i;
parameter TC=20;
initial begin
clk=1'b0;
forever     begin
                #(TC/2)
                clk=~clk;
            end
end
initial begin
            rst_n=0;  MOSI=0; SS_n=0; tx_valid=1; tx_data=8'b0000_1001;
            @(negedge clk)    rst_n=1;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end
            @(negedge clk)    SS_n=1;
            @(negedge clk)    MOSI=0;  SS_n=0;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)    SS_n=1; 
            @(negedge clk)    MOSI=1; SS_n=0;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)    SS_n=1;
            @(negedge clk)    MOSI=1; SS_n=0;  tx_data=$random;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)   tx_data=8'b1100_0001; 
              for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk) ;
            end                     
            @(negedge clk)    $stop;          
        end
endmodule
