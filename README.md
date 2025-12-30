# Omni Guard Trap 🛡️

**Status:** Ready for Mainnet Deployment
**Network:** Ethereum  
**Target:** Beacon Chain Deposit Contract (`0x00000000219ab540356cBB839Cbe05303d7705Fa`)

## Overview
The **Omni Guard** is a "Canary" monitor designed to detect catastrophic failure at the protocol level. It serves as a decentralized "Dead Man's Switch" for L2s, bridges, or protocols that rely on the integrity of the Ethereum consensus layer.

It monitors the balance of the official Ethereum Beacon Chain Deposit contract. If this balance ever drops below a safety threshold (indicating a critical consensus failure or theoretical drainage event), the trap triggers an automated emergency pause.

## Operational Logic
* **Target:** `0x00...219ab540` (Beacon Chain Deposit Contract)
* **Safety Threshold:** `10,000,000 ETH` (Current Balance: ~33M+ ETH)
* **Trigger:** If `Target Balance < Safety Threshold`.
* **Response:** Calls `emergencyPause("CRITICAL: BEACON DRAINED")` on the responder contract.

## Technical Specifications
* **Type:** `ITrap` (Standard Drosera Interface)
* **Sample Size:** 1 Block
* **Security Model:** Uses a "Canary Vault" pattern—monitoring a high-value public target to infer network health.

## Directory Structure
* `src/OmniGuardTrap.sol`: The monitoring logic.
* `src/OmniGuardResponse.sol`: The emergency brake mechanism.
