# LMCV-Study
# LCMV and MVDR Wireless Simulation Study

## Overview

This repository contains a modular simulation framework for evaluating **LCMV (Linearly Constrained Minimum Variance)** and **MVDR (Minimum Variance Distortionless Response)** beamforming strategies across diverse wireless communication scenarios, including:

- **Terrestrial base station communications**
- **Reconfigurable Intelligent Surface (RIS) assisted links**
- **Unmanned Aerial Vehicle (UAV) relays**
- **High-Altitude Platform (HAP) communications**
- **Low Earth Orbit (LEO) satellite links**

The goal is to systematically compare performance, robustness, and spatial selectivity of classical and constrained beamforming algorithms under varying channel, interference, and mobility conditions.

---

## Motivation

Next-generation wireless networks — including **B5G and 6G architectures** — are increasingly heterogeneous, integrating:

- Terrestrial cellular links  
- Aerial platforms  
- Non-terrestrial satellite systems  
- Reconfigurable surfaces  

Evaluating and optimizing beamforming behavior in such diverse environments is critical for:

- Interference suppression  
- Mobility resilience  
- Latency-sensitive communication  
- Reliable performance under dynamic propagation

---

## Scenarios Included

This framework supports multiple simulation scenarios:

1. **Terrestrial BS:** Baseline multi-antenna communication  
2. **RIS-assisted:** Spatial reconfiguration via intelligent surfaces  
3. **UAV relays:** Elevated communications with mobility  
4. **HAP communications:** High-altitude wireless platforms  
5. **LEO satellite links:** High-mobility, wide-coverage scenarios

---

## Beamforming Methods

- **MVDR**  
  Minimizes output variance while maintaining gain toward the desired signal.

- **LCMV**  
  Introduces explicit linear constraints for spatial filtering, suitable for multi-objective scenarios.

---


---

## How to Run

### Requirements

- MATLAB (R2019b or later recommended)
- Communications System Toolbox (optional)
- Basic understanding of beamforming and array signal processing

### Run a Scenario

1. Change directory to the scenario:
   ```bash
   cd scenarios/leo_satellite
2. Run the corresponding script: 
  ```bash
  run_LEO_simulation.m ```
3. Results are saved in the results/figures directory,

## Citation

### If you use this, please cite, Modi, T. (2026). LCMV and MVDR Wireless Simulation Study. GitHub repository. https://github.com/modi0903/LCMV-and-MVDR-Sim-Study

### Contact : Tanmay Modi, tanmay.p.k.modi@gmail.com

