module RAM (din,clk,rst_n,rx_valid,dout,tx_valid);
parameter MEM_DEPTH=256;
parameter ADDR_SIZE=8;
input [ADDR_SIZE+1:0]din;
input clk,rst_n,rx_valid;
output reg [ADDR_SIZE-1:0]dout;
output reg tx_valid;
reg [ADDR_SIZE-1:0]internal_WA,internal_RA;
reg [ADDR_SIZE-1:0] ram [MEM_DEPTH-1:0];
always @(posedge clk) begin
    if(~rst_n) begin
        dout<= {ADDR_SIZE{1'b0}};
        tx_valid<=1'b0;
    end
    else if(rx_valid) begin
        case (din[ADDR_SIZE+1:ADDR_SIZE])
            2'b00  :    begin
                            internal_WA<=din[ADDR_SIZE-1:0]; 
                            tx_valid<=1'b0;
                        end
            2'b01  :    begin
                            ram[internal_WA]<=din[ADDR_SIZE-1:0]; 
                            tx_valid<=1'b0; 
                        end
            2'b10  :    begin
                            internal_RA<=din[ADDR_SIZE-1:0]; 
                            tx_valid<=1'b0;  
                        end
            2'b11  :    begin
                            dout<=ram[internal_RA];  
                            tx_valid<=1'b1;
                        end
        endcase
    end
end
endmodule