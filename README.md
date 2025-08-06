# Logic BIST (Built-In Self-Test) using Gate-Level Verilog
This project demonstrates a **Logic Built-In Self-Test (BIST)** architecture designed using **strict gate-level modeling** in Verilog. It avoids any behavioral constructs like assign or always and instead relies solely on gate instantiations and flip-flop modules.
## Overview
The design performs logic BIST on an 8-bit ALU using internally generated test patterns via an **LFSR** and captures output responses using a **MISR**. An **FSM** module controls the test sequence by coordinating reset, enable, and mode signals.
## Flow
- LFSR generates random patterns (A, B) as input to ALU
- ALU processes inputs and sends output to MISR
- MISR compresses output into a final signature
- FSM controls reset, enable, and mode for LFSR, MISR, and ALU
