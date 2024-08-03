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


## Project Screenshots

![Screenshot from 2024-08-03 14-41-45](https://github.com/user-attachments/assets/b5e0dffc-0a51-4d39-852c-cfeceb1a8e85) <br> Fig 1: All Steps completed successfully in Qflow tool <br><br>

![Screenshot from 2024-08-03 14-39-15](https://github.com/user-attachments/assets/38587073-91de-462a-a0a1-4618b5e9063b) <br> Fig 2: Syntesis Statistics <br><br>

![Screenshot from 2024-03-28 19-02-18](https://github.com/user-attachments/assets/0814bf4d-62ac-41d2-bf23-24f3c8a19a26) <br> Fig 3: Routing Layers <br><br>

![Screenshot from 2024-08-03 14-34-57](https://github.com/user-attachments/assets/cb2ea688-7f1b-49f9-a759-1aa5d984e02f) <br> Fig 4: Finished Chip Layout <br><br>






