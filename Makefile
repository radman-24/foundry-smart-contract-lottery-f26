-include .env

.PHONY: all test deploy

build :; forge build

test :; forge test

install :; forge install cyfrin/foundry-devops && forge install smartcontractkit/chainlink-brownie-contracts && forge install foundry-rs/forge-std && forge install transmissions11/solmate@v6