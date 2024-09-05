# DP-RAM
Dual-Port RAM (2048x16) 

Overview

This project implements a Dual-Port RAM (DPRAM) with a memory size of 2048x16 in Verilog. The design supports simultaneous read/write operations on two different ports, allowing efficient memory access from two different sources concurrently. Additionally, this implementation includes a solution for handling simultaneous writes to the same memory location, ensuring that the last write wins.

Features

Memory Size: 2048 locations, each 16 bits wide.
Dual-Port Access: Supports simultaneous read/write from two different ports.
Last Write Wins: In the event of both ports writing to the same memory location, the design ensures that the last write is prioritized and stored.
Simultaneous Write Handling

One of the key aspects of this implementation is the handling of simultaneous writes to the same memory address by both ports. In such scenarios, a "last write wins" technique is used, where the data from the most recent write is stored in the memory. This ensures data consistency without introducing additional complexity in the design.

Usage

Dual-Port RAMs are widely used in systems that require concurrent access to memory, such as:

Multicore processors
Graphics Processing Units (GPUs)
Network routers and switches
FPGA-based designs
By allowing simultaneous read/write operations, DPRAM designs help improve system performance and efficiency in these applications.
