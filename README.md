# Mock Omni Guard Trap 🛡️

A multi-vector security trap for the Drosera Network (Hoodi Testnet).

## 💡 Concept: Simulated Data Template
Because reliable external dApps (like bridges or lending protocols) do not exist on the Hoodi testnet, this trap uses a **Simulated Data Template**.

Instead of querying external contracts, the trap reads internal state variables that **simulate** real-world security threats. This allows us to verify the trap's logic and the Drosera Network's response mechanics without needing a complex mainnet fork.

## 🔍 What It Monitors
This trap guards against three distinct threat vectors simultaneously:

1.  **Bridge Pause:** Detects if a bridge has triggered an emergency pause.
    * *Simulation:* Checks internal `isPaused` boolean.
2.  **Blacklist Interaction:** Detects if funds are sent to a known malicious address.
    * *Simulation:* Checks internal `lastRecipient` against a hardcoded `BAD_ADDRESS`.
3.  **Rate Limit Breach:** Detects if a function is called too frequently (spam/DDoS).
    * *Simulation:* Checks internal `txCount` against `MAX_COUNT` (10).

## 🛠 How to Manually Trigger (Test)
You can trigger the trap using these helper functions on the deployed contract:

* `setPaused(true)` -> Triggers **BRIDGE_PAUSED** alert.
* `setRecipient(0x...dead)` -> Triggers **BLACKLIST_INTERACTION** alert.
* `incrementCount()` (call 11 times) -> Triggers **RATE_LIMIT_BREACH** alert.

## 📍 Deployed Addresses (Hoodi Testnet)
* **Trap Logic Contract:** `0x55cE5A36f665781fDe7e1b427751CE00Fcef9D92`
* **Response Contract:** `0x75B74767d77678613879fFbfEaCb2DAf22D426bd`
* **Drosera Config Address:** `0x1D880D83Ce107C6961495Ef767b8E4099A94F72E`
