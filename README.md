**SPI Slave with Single Port RAM**
This project implements a SPI (Serial Peripheral Interface) slave module with a single port RAM block. The SPI slave module receives data from a master device and communicates with the single port RAM to store and retrieve data.
![image](https://github.com/user-attachments/assets/605fae86-5ed6-4b09-8c24-39b1565ce3f5)
**Project Overview**
The project consists of the following:-

Codes folder: which contain the following
ram.dat: which represents the memory for the testbench
run.do: do file to run simulation in QuestaSim or ModelSim
RTL folder:
SPI.v: design of SPI block
RAM.v: design of RAM block
instantiation.v: top module
Testbench folder:
SPI.v: Verilog file represent SPI Slave block
RAM.v: Verilog file represent Single Port Async RAM
SystemLevel.v: Verilog file instantiate the two blocks RAM and SPI
ram.dat: memory for testbench
schematic pdf:
SPI schematic: schematic for the block after synthesis on Vivado
RAM schematic: schematic for the block after synthesis on Vivado
System Level schematic: schematic for the block after synthesis on Vivado
basys_master.xdc: a constrain file for the target FPGA
bitstream file: bitstream file
netlist file: netlist file from Vivado
**SPI Slave Module**
The SPI slave module is responsible for receiving data from the master device and interacting with the RAM module. It has the following ports:

Name	Type	Size	Description
clk	Input	1 bit	Clock signal
rst_n	Input	1 bit	Active low reset signal
SS_n	Input	1 bit	Slave Select signal
MOSI	Input	1 bit	Master-Out-Slave-In data signal
tx_data	Input	10 bit	Transfer data output signal, Takes MOSI for 10 clock cycles and stores it in tx_data to send it to the RAM
tx_valid	Input	1 bit	Indicates when tx_data is valid
MISO	Output	1 bit	Master-In-Slave-Out data signal
rx_data	Output	10 bit	Received data from the memory
rx_valid	Output	1 bit	Indicates when rx_data is valid
**Single Port sync RAM Module**
The single port asynchronous RAM module implements a memory block with a single data port.

It has the following parameters:

MEM_DEPTH (default: 256): Depth of the memory.
ADDR_SIZE (default: 8): Size of the memory address.
Ports:

Name	Type	Size	Description
clk	Input	1 bit	Clock signal
rst_n	Input	1 bit	Active low reset signal
din	Input	10 bit	Data input
rx_valid	Input	1 bit	If HIGH, accepts din[7:0] to save the write/read address internally or writes a memory word depending on the most significant 2 bits din[9:8]
dout	Output	8 bit	Data output
tx_valid	Output	1 bit	Whenever the command is a memory read, tx_valid should be HIGH
The most significant bits of din (din[9:8]) determine the operation to be performed:
Port	din[9:8]	Command	Description
din	00	Write	Holds din[7:0] internally as a write address
din	01	Write	Writes din[7:0] to the memory with the write address held previously
din	10	Read	Holds din[7:0] internally as a read address
din	11	Read	Reads the memory with the read address held previously. tx_valid should be HIGH, and dout holds the word read from the memory. din[7:0] is ignored
