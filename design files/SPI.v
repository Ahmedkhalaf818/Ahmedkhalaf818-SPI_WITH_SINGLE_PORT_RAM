module SPI(MOSI,SS_n,clk,rst_n,tx_valid,tx_data,MISO,rx_valid,rx_data);
input  MOSI;
input  SS_n,clk,rst_n;
input  tx_valid;
input  [7:0]tx_data;
output reg MISO;
output reg rx_valid;
output reg [9:0]rx_data;
parameter IDLE=5'b00001;
parameter CHK_CMD=5'b00010;
parameter WRITE=5'b00011;
parameter READ_ADD=5'b00100;
parameter READ_DATA=5'b00101;
reg transmition_read;
reg [3:0]counter;
(*fsm_encoding ="sequential"*)reg [4:0] cs,ns;
// state logic
always @(posedge clk) begin
if(~rst_n)  begin
                cs<=IDLE;
            end
else
                cs<=ns;
end
//next state
always @(*) begin
case(cs)
IDLE:   begin
        if (SS_n==0)    begin
                                ns=CHK_CMD;
                        end
        else            begin
                                ns=IDLE;
                        end              
        end
CHK_CMD:   begin
                if(SS_n==0) begin
                            if (~MOSI)  begin
                                                ns=WRITE;   
                                         end
                            else 
                             if(transmition_read==1)
                                   ns=READ_DATA;
                             else  ns=READ_ADD;
                           
                            end
                else        begin
                                ns=IDLE;
                            end            
           end
WRITE:   begin
                if(SS_n)        begin
                                     ns=IDLE;   
                                end
                else            begin
                                ns=WRITE;
                                end
        end
READ_DATA:      begin
                if(SS_n)        begin
                                     ns=IDLE;   
                                end
                else             begin
                                ns=READ_DATA;
                                end
                end
READ_ADD:       begin
                if(SS_n)        begin
                                     ns=IDLE;   
                                end
                else             begin
                                ns=READ_ADD;
                                end
                end
                default :   ns=IDLE;
endcase
end
//output stage
always @(posedge clk) begin
if(~rst_n)  begin
                rx_data<=0;
                MISO<=0;
                rx_valid<=0;
                counter<=0; 
                transmition_read<=0;
            end
else
case(cs)
IDLE :    begin 
             MISO<=0;
             counter<=0;
           end

CHK_CMD:   begin
             counter<=0;
             rx_valid<=0;
           end
WRITE:   begin
                        rx_data[9-counter]<=MOSI;             
                        if(counter==9)  begin
                                 rx_valid<=1;
                                 counter<=0;   
                                         end
                        else 
                        counter<=counter+1;
         end
 READ_ADD:   begin
                        rx_data[9-counter]<=MOSI;
                        rx_valid<=0;             
                        if(counter==9)  begin
                                 rx_valid<=1;
                                 counter<=0;  
                                         end
                        else  begin
                        transmition_read<=1;
                        counter<=counter+1;
                        end
         end               
READ_DATA:       begin
                        rx_data[9-counter]<=MOSI;
                        rx_valid<=0;
                        if(counter==9)  begin
                                 rx_valid<=1;
                                 counter<=0;  
                                         end 
                        else if(tx_valid==1) begin
                        MISO<=tx_data[counter];
                        if(counter==7)  begin
                                         counter<=0;   
                                         end
                         else
                         counter<=counter+1;
                        end 
                         else
                        counter<=counter+1;        
                        transmition_read<=0;
                        
                                             
                end
endcase
end
endmodule
