# Hexadecimal Keypad Scanner and Encoder – Verilog

## Overview
This project implements a **4×4 hexadecimal keypad scanner and encoder** using Verilog. The system detects keypresses from a 16-key matrix and encodes them into 4-bit hexadecimal outputs. The design uses an **FSM-based scanning approach** along with signal synchronization and row-column logic.

This project demonstrates low-level hardware interfacing and sequential control logic and is verified using a comprehensive testbench.

---

## Module Structure

### `hex_keypad.v` – RTL Design (All Modules)
- **`rowsignal`**  
  Generates row signals based on current column select lines and pressed key positions (one-hot encoded input).

- **`synchronizer`**  
  Synchronizes asynchronous row signals to the system clock and ensures clean transitions for FSM logic.

- **`hex_keypad_scanner`**  
  Main FSM-based module that cycles through columns, detects row activations, and encodes the pressed key into a 4-bit hex value.

---

### `hex_keypad_tb.v` – Testbench
- Simulates one-hot key inputs for all 16 hexadecimal keys (0–F).
- Loops through each key, applies keypress timing, and monitors encoded outputs.
- Dumps waveform using `$dumpfile` and `$dumpvars` for GTKWave analysis.

---

## Features
- **Detects and encodes all 16 keys (0–F)** from a standard 4×4 keypad.
- **FSM-based control** to sequence column scanning and decode row inputs.
- Synchronization of asynchronous input signals for stability.
- Fully modular RTL design with reusable components.
- Comprehensive **testbench** to validate detection and encoding.

---

## ▶How to Run
1. Open `hex_keypad.v` and `hex_keypad_tb.v` in a simulator like EDA Playground or ModelSim.
2. Set `test_Hex_Keypad` as the top-level module.
3. Run the simulation and observe `code` and `valid` outputs for each keypress.
4. Analyze the output waveform using GTKWave.

---

## Tools Used
- **Language**: Verilog HDL  
- **Simulation**: EDA Playground, GTKWave  
- **Testbench**: One-hot simulation for all 16 keys

---

## Project Learning Objectives
- Understand **matrix keypad interfacing** using RTL design.
- Practice **FSM-based design** for scanning and encoding.
- Gain exposure to **synchronization**, **testbench writing**, and **waveform validation**.

---

## Author
**Sarath Srinivasan**  
B.Tech in Electrical Engineering  
Aspiring VLSI Engineer

---

## Tags
`verilog` `FSM` `digital-design` `keypad-scanner` `encoder` `hexadecimal` `rtl` `testbench`
