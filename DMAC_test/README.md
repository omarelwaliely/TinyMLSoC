# Voice Detection on FRV-SoC

## Introduction
This project implements a voice detection system on the FRV-SoC platform. The system leverages a TinyML-capable SoC to detect audio input through an I2S microphone. Upon detecting a voice, the system triggers an interrupt, processes the audio data using a DMA controller, and displays the results via UART. Additionally, an LED lights up to indicate voice detection.

The architecture integrates key modules such as a CPU, a DMA controller, a crossbar, and AHB-Lite/APB buses to connect various peripherals including I2S, RAM, ROM, and UART.

## Installations
To set up the project, ensure the following tools are installed:

- **RISCV32 Toolchain**: For compiling firmware.
- **Yosys**: For synthesis.
- **nextpnr**: For placement and routing.
- **icepack**: For generating bitstreams.

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/omarelwaliely/TinyMLSoC.git
   cd TinyMLSoC/DMAC_test
   ```

2. Run the Makefile
   ```bash
   make clean
   make
   make runfpga
   ```


## Module Descriptions
### 1. CPU
- Central controller that processes audio data after DMA transfer.
- Interfaces with the UART to display results.

### 2. DMA Controller
- Handles data transfer from the I2S FIFO to the CPU.
- Reduces CPU overhead by automating memory access.

### 3. Crossbar
- Connects the CPU, DMA controller, and peripherals via AHB-Lite and APB buses.
- Ensures efficient data flow between modules.

### 4. Peripherals
- **I2S Microphone**: Captures audio samples.
- **RAM**: Temporary storage for intermediate data.
- **ROM**: Stores firmware and configuration.
- **UART**: Outputs detection results to a terminal.

## Architecture
The architecture consists of the following key components:

- **Controllers**:
  - CPU: Main processor for control and data processing.
  - DMA Controller: Transfers data from peripherals to memory.

- **Crossbar**:
  - Connects the controllers to AHB-Lite and APB buses.

- **Peripherals**:
  - I2S for audio input. Includes a vad module for efficient voice signal detection.
  - RAM and ROM for memory operations.
  - UART for communication.

### Data Flow
1. **Audio Detection**: I2S captures audio samples and fills the FIFO.
2. **Interrupt Trigger**: FIFO generates an interrupt when full.
3. **DMA Transfer**: DMA controller moves data to RAM for CPU processing.
4. **CPU Processing**: CPU processes the data and sends results over UART.
5. **LED Indicator**: LED lights up upon voice detection.

## Results
- **Voice Detection**: Accurate detection of audio signals using the I2S microphone.
- **Efficient Data Transfer**: Minimal CPU overhead due to DMA controller.
- **User Feedback**: Clear indication of detection via LED and UART output.

---
For further details, refer to the [GitHub repository](https://github.com/omarelwaliely/TinyMLSoC/tree/main/DMAC_test).

