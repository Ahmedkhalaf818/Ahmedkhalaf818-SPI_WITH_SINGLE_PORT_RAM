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
**Contact info**
www.linkedin.com/in/ahmed-khalaf-mohamed-ali
**this project from Eng.Kareem Waseem diploma**
https://www.linkedin.com/in/kareem-waseem/
