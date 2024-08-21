module RAM_tb();
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
reg [ADDR_SIZE+1:0]din;
reg clk,rst_n,rx_valid;
wire [ADDR_SIZE-1:0]dout;
wire tx_valid;
RAM #(.MEM_DEPTH(MEM_DEPTH),.ADDR_SIZE(ADDR_SIZE)) DUT_RAM(.din(din),.clk(clk),.rst_n(rst_n),.rx_valid(rx_valid),.dout(dout),.tx_valid(tx_valid));
parameter TC=20;
initial begin
clk=1'b0;
forever     begin
                #(TC/2)
                clk=~clk;
            end
end
initial begin
            $readmemb("ram.dat",DUT_RAM.ram,0,MEM_DEPTH-1);
            rst_n=0; rx_valid=1; din=10'b00_0000_0000;
            @(negedge clk)    rst_n=1;
            @(negedge clk)    din=10'b00_0010_1000;  
            @(negedge clk)    din=10'b01_0001_1000; 
            @(negedge clk)    din=10'b10_0010_1000; 
            @(negedge clk)    din=10'b11_0100_1000;
            @(negedge clk)    rx_valid=0; 
            @(negedge clk)    din=10'b00_0010_1000;  
            @(negedge clk)    din=10'b01_0100_1000; 
            @(negedge clk)    din=10'b10_0010_1000; 
            @(negedge clk)    din=10'b11_0001_1000;
            repeat(4) @(negedge clk);  
            @(negedge clk)    $stop;          
        end
endmodule
