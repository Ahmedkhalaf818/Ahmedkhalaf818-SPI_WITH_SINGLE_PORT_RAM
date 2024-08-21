module SPI_SLAVE_WITH_SINGLE_PORT_RAM_tb();
reg MOSI,SS_n,clk,rst_n;
wire MISO;
SPI_SLAVE_WITH_SINGLE_PORT_RAM DUT_SPI_SLAVE( .MOSI(MOSI),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.MISO(MISO));
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
            $readmemb("ram.dat",DUT_SPI_SLAVE.INS_RAM.ram,0,255);
   rst_n=0;  MOSI=0; SS_n=0; 
            @(negedge clk)    rst_n=1;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end
            @(negedge clk)    SS_n=1;
            @(negedge clk)    SS_n=0;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)    SS_n=1; 
            @(negedge clk)    SS_n=0;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)    SS_n=1;
            @(negedge clk)    SS_n=0; 
            @(negedge clk)    MOSI=1;  
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end
            @(negedge clk);
            for(i=0 ; i<10 ;i=i+1) begin
            @(negedge clk); 
            end
             @(negedge clk)   SS_n=1;
             @(negedge clk)   SS_n=0;
             @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end
            @(negedge clk)    SS_n=1;
            @(negedge clk)    SS_n=0;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=0;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk)    SS_n=1; 
            @(negedge clk)    SS_n=0;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=1;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end 
            @(negedge clk);
            for(i=0 ; i<10 ;i=i+1) begin
            @(negedge clk); 
            end
            @(negedge clk)    SS_n=1;
            @(negedge clk)    SS_n=0; 
            @(negedge clk)    MOSI=1;  
            @(negedge clk)    MOSI=1;
            @(negedge clk)    MOSI=0;
            for(i=0 ; i<8 ;i=i+1) begin
            @(negedge clk)    MOSI=$random; 
            end
            @(negedge clk);
            for(i=0 ; i<10 ;i=i+1) begin
            @(negedge clk); 
            end

            @(negedge clk)    $stop;          
        end
endmodule
