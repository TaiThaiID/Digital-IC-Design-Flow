# Full-Flow Digital & Custom IC Design (45nm Technology)

## Project Overview
This repository demonstrates a comprehensive **VLSI Design Flow**, ranging from **RTL Design** to **Physical Layout** using the **GPDK 45nm** process technology.

The project simulates the complete lifecycle of standard cell design and digital system implementation, focusing on **Timing Analysis (STA)**, **Low-Power techniques (Clock Gating)**, and **Physical Verification (DRC/LVS)**.

**Key Achievements:**
* Designed and verified a multi-function **ALU** and **Accumulator** using SystemVerilog.
* Synthesized designs using **Cadence Genus** and optimized timing constraints (SDC).
* Implemented **Clock Gating** reducing dynamic power consumption significantly.
* Designed Custom Schematics and Layouts for Standard Cells (Inverter, NAND, NOR, XOR, MUX).
* Achieved **DRC/LVS Clean** layouts using **Cadence Virtuoso Layout Suite XL**.

---

## Tools & Technologies
* **Front-end:** Cadence Xcelium (Simulation), SimVision (Debug), Cadence Genus (Synthesis).
* **Back-end:** Cadence Virtuoso Schematic Editor, Virtuoso Layout Suite XL, ADE L (Analog Design Environment).
* **Verification:** PVS (Physical Verification System) for DRC/LVS.
* **Language:** SystemVerilog, Tcl (Scripting).

---

## Front-End: RTL to Synthesis & STA

### RTL Design & Verification
Designed an 8-bit Registered ALU capable of Addition, Subtraction, AND, XOR operations.
* **Feature:** Synchronous Reset, Flag generation (Overflow, Carry).
* **Verification:** Verified using constrained-random testbenches in Xcelium.

### Logic Synthesis & Optimization
Performed logic synthesis mapping RTL to the **45nm Standard Cell Library**.
* **Corner Analysis:** Analyzed Timing/Power/Area across multiple PVT corners (Process: Slow/Fast, Temp: -40°C to 125°C).
* **Static Timing Analysis (STA):**
    * Defined clock constraints and I/O delays using SDC files.
    * Analyzed Critical Paths and Setup/Hold violations.

<img width="766" height="622" alt="image" src="https://github.com/user-attachments/assets/591887df-67f8-4c4e-8179-9bf21c23a22f" />


### Low Power Implementation (Clock Gating)
Implemented integrated **Clock Gating (ICG)** cells to disable clock signals for inactive logic blocks.
* **Result:** Reduced dynamic power consumption compared to the non-gated baseline design.

*[Insert Image: Comparison Table of Power Consumption (Gated vs. Non-Gated) from Lab 3 Report]*

---

## Back-End: Custom Circuit Design & Layout

### Transistor-Level Design (Schematic)
Designed CMOS schematics for fundamental logic gates: **Inverter, NAND, NOR, XOR, and 2:1 MUX**.
* Calculated W/L ratios to achieve symmetric Rise/Fall times ($t_r \approx t_f$) and $V_M \approx V_{DD}/2$.
* Performed DC Analysis (Voltage Transfer Characteristic) and Transient Simulation.

*[Insert Image: Schematic of the XOR or MUX Gate from Lab 4 Report]*

### Physical Layout (The "Art" of IC Design)
Converted schematics into physical layouts adhering to **GPDK 45nm Design Rules**.
* **Strategy:** Minimized parasitic capacitance, shared diffusion areas (Euler paths), and ensured standard cell height compliance.
* **Verification:**
    * **DRC:** 100% Clean (No Design Rule Violations).
    * **LVS:** Matched (Layout matches Schematic netlist).

## Performance Metrics (Example: Inverter)
* **Propagation Delay ($t_{pd}$):** ~15ps (at Typical Corner).
* **Rise/Fall Time:** Optimized for symmetry.
* **Power:** Measured Static (Leakage) and Dynamic Power dissipation.
---
