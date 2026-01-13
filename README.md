# Hexadecimal Keypad Interface (Basys-3 FPGA)

## Overview
This project implements a **4×4 hexadecimal keypad interface** on the **Basys-3 FPGA board** using **Verilog HDL**.  
The design scans keypad rows and columns, decodes key presses into a **4-bit hexadecimal value**, and displays the result on the onboard LEDs.

The implementation emphasizes **robust hardware interfacing**, including **clock-domain synchronization** and an **FSM-based keypad scanning mechanism**.

---

## Hardware Platform

- **FPGA Board:** Digilent Basys-3 (Artix-7)
- **Clock:** 100 MHz onboard oscillator

### Inputs
- 4×4 matrix keypad  
  - `ROW[3:0]` – Row inputs  
  - `COL[3:0]` – Column outputs
- Center push button (`btnC`) used as **reset**

### Outputs
- Onboard LEDs to display the detected **hexadecimal key**
- **Valid signal LED** indicating an active key press

---

## Design Architecture

### 1. Top Module  
**`top_keypad_basys3_nodebounce`**

- Integrates all submodules
- Connects keypad rows and columns to the scanning logic
- Displays the decoded **4-bit key value** on LEDs
- Uses a **synchronized reset** derived from the onboard push button
- Operates **without debounce** to clearly demonstrate raw keypad scanning behavior

---

### 2. Row Signal Synchronizer

- Uses a **two-stage flip-flop synchronizer**
- Applied to the **OR-combined row inputs**
- Prevents **metastability** when asynchronous keypad signals enter the FPGA clock domain
- Ensures stable key-press detection before scanning begins

---

### 3. Keypad Scanner (FSM-Based)

- Implements a **finite state machine (FSM)** to:
  - Sequentially drive each column line
  - Read row inputs to detect the pressed key
- Generates:
  - A **4-bit hexadecimal code**
  - A **valid signal** during an active key press
- Scanning continues until the key is released, preventing repeated false detections

---

### 4. Hexadecimal Key Mapping

- Decodes key presses based on **row–column combinations**
- Supports all **16 hexadecimal keys (0–F)**
- Implemented using **combinational logic** for fast decoding

---

### 5. Optional Debounce Module

- A **parameterized debounce module** is included for future use
- Designed for **mechanical key stabilization** using a counter-based approach
- Can be enabled if **single-pulse, stable key detection** is required

---

## Key Features

- FSM-based keypad scanning
- Metastability-safe input synchronization
- Real-time hexadecimal key decoding
- Modular and readable Verilog design
- Fully compatible with **Basys-3 FPGA hardware constraints**

---

##  Applications

- FPGA-based human–machine interfaces
- Embedded input systems
- Digital design and FSM learning projects
- Verilog HDL practice with real hardware

---

##  Notes

- External pull-down resistors (or internal pull-downs) should be used on keypad row inputs
- Debounce logic is intentionally excluded in the top module for clarity and educational purposes

---

## Author
**Sarath Srinivasan**


