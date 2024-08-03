# Oven-FSM-RTL-to-GDS-II-design-using-Qflow
 RTL to GDS II flow for a custom "Oven FSM" ASIC design utilising Qflow, an Open Source Physical Design toolchain.


<br>

## Steps in RTL to GDS II flow in Qflow toolchain
1. **Preparation :** The preparation stage in the RTL to GDSII flow involves setting up the necessary environment, tools, and inputs required to start the design process. This stage ensures that all prerequisites are in place for a smooth and efficient design flow. Here the completeness of the RTL design code is checked , whether it has all the required module definitions which are instantiated in the code. Also technology mapping is done which includes mapping a particular technology (like 90nm, 180nm , 350nm etc) for the process.<br>

2. **Synthesis :** In this process, the RTL code is converted to a Gate Level Netlist. Yosys is the tool used for this process. This netlist consists of standard cells (logic gates) that are interconnected to perform the desired operations. <br>

3. **Floor Planning & Placement :** In this process, the physical regions on the chip are defined where various functional blocks will be placed. Also power planning is done  to design the power distribution network to ensure all parts of the chip receive adequate power. Finally, the standard cell placement is done to position the standard cells on the chip in accordance with the floorplan, minimizing wire length and optimizing performance. GrayWolf is the tool used in Qflow toolchain for this puropose. <br>

4. **Clock Tree Synthesis and Static Timing analysis :** In this processs, CTS is done to ensure the clock signal reaches all sequential elements (flip-flops) with minimal skew and latency. STA is done to verify that the design meets the required timing constraints and there are no timing violations. QFlow includes scripts for running STA using tools like VPR. <br>

5. **Routing :**  Routing is done to layout wires to connect the standard cells and other components, adhering to design rules. QRouter is the tool used in Qflow toolchain for this puropose. <br>

6. **Post Route STA :** Its just another STA check after the routing process to check for delay in signals after routing. <br>

7. **DRC :** It stands for Design Rule Check. DRC verification checks that the layout adheres to the manufacturing design rules to ensure it can be fabricated without issues. <br>

8. **LVS :** It stands for Layout VS Schematic. LVS verification ensures that the layout matches the original schematic/netlist to confirm that the physical design correctly implements the intended circuit.<br>

9. **GDSII :** This process generates the final GDSII file, which is the industry-standard format for IC layout data used for chip fabrication. <br><br>

