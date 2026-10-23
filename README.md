<!-- # Proveably Random Raffle Contracts

## About

This code is to creat a proveably random smart contract lottery.

## What we want it to do?

1. Users should be able to enter the raffle by paying for a ticket. The ticket fees are giong to be the prize the winner receives.
2. The lottery should automatically and programmatically draw a winner after a certain period.
3. Chainlink VRF should generate a provably random number.
4. Chainlink Automation should trigger draw regularly.

## Tests!

1. Write deploy script
   1. Note, these will now work on zkSync
1. Write tests
   1. Local cahin
   2. Forked testnet
   3. Forked mainnet -->

# Foundry Smart Contract Lottery

A decentralized lottery smart contract built with Solidity and Foundry. The project demonstrates automated raffle execution, Chainlink VRF-based randomness, and smart contract testing.

## Overview

This project implements an on-chain raffle in which participants enter by sending ETH. The raffle can be checked for upkeep, requests randomness from Chainlink VRF, selects a winner, and transfers the contract balance to the winner.

The project is intended for learning and experimentation with Solidity, Foundry, Chainlink VRF, and automated smart contract testing.

## Features

- ETH-based raffle entry
- Minimum entrance fee validation
- Raffle state management
- Chainlink VRF integration for random winner selection
- Chainlink Automation-compatible upkeep checks
- Winner selection and prize payout
- Unit tests using Foundry
- Local development configuration with mock contracts

## Tech Stack

- Solidity
- Foundry (`forge`, `cast`, `anvil`)
- Chainlink VRF v2.5
- Chainlink Automation
- Git and GitHub

## Project Structure

```text
src/       Smart contracts
script/    Deployment and interaction scripts
test/      Automated tests
lib/       Dependencies
```

## Prerequisites

Install Foundry and configure a Solidity development environment.

For Sepolia-related operations, configure an RPC endpoint and the required Chainlink contracts, subscriptions, and network settings.

## Installation

Clone the repository:

```bash
git clone https://github.com/radman-24/foundry-smart-contract-lottery-f26.git
cd foundry-smart-contract-lottery-f26
```

Install dependencies if they are not included in the repository:

```bash
forge install
```

Build the contracts:

```bash
forge build
```

Run the local test suite:

```bash
forge test
```

## Configuration

Create a local `.env` file for any required environment variables.

For example:

```bash
SEPOLIA_RPC_URL=
PRIVATE_KEY=
```

Never commit `.env` or expose private keys, API keys, or other secrets.

The exact environment variables required depend on the deployment and interaction scripts.

## Testing

Run the local test suite:

```bash
forge test -vvv
```

To run tests against a Sepolia fork:

```bash
forge test --fork-url "$SEPOLIA_RPC_URL" -vvvv
```

Fork testing executes against a local simulation of a selected network state. It does not, by itself, deploy contracts or send transactions to the live network.

## Known Issues and Limitations

### Sepolia Fork Test Setup

The command below has not yet been confirmed to pass in the current development environment:

```bash
forge test --fork-url "$SEPOLIA_RPC_URL" -vvvv
```

The failure occurs during test setup. The exact root cause must be confirmed from the complete Forge error output.

Potential causes include an invalid or unset RPC URL, RPC connectivity problems, network-specific configuration, or dependencies on contract addresses and Chainlink subscription state that are unavailable or unsuitable for the forked test environment.

This issue is separate from whether the contracts compile and whether the local unit tests pass.

## Security Notice

This repository is for educational and development purposes. It has not been presented as independently audited production software.

Do not use real funds without a thorough security review, appropriate testing, and an understanding of the risks associated with smart contracts and randomness integrations.

## License

Specify the license that applies to this project. If the source code uses the MIT license, include an MIT `LICENSE` file.
