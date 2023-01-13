// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// @title Stone, scissors, paper game.
contract Game {
    struct Sign {
        bytes32 name;
        bytes32 hash;
        bytes32 canBit;
    }

    Sign[] private signs;

    address public owner;

    constructor() {
        owner = msg.sender;

        signs.push(Sign({
            name: "stone",
            hash: keccak256(abi.encode("stone")),
            canBit: keccak256(abi.encode("scissors"))
        }));

        signs.push(Sign({
            name: "scissors",
            hash: keccak256(abi.encode("scissors")),
            canBit: keccak256(abi.encode("paper"))
        }));

        signs.push(Sign({
            name: "paper",
            hash: keccak256(abi.encode("paper")),
            canBit: keccak256(abi.encode("stone"))
        }));
    }

    function play(bytes32 signHash) public view
    returns (bool) {
        require(isAllowedSign(signHash), "Not allowed sign!");

        Sign memory randomSign = getRandomSign();

        if (randomSign.hash == signHash) {
            return false;
        } else if (randomSign.canBit == signHash) {
            return false;
        } else {
            return true;
        }
    }

    function isAllowedSign(bytes32 signHash) public view
    returns (bool) {
        for (uint i = 0; i < signs.length; i++) {
            if (signs[i].hash == signHash) {
                return true;
            }
        }

        return false;
    }

    // Temporary pseudo-random
    function getRandomSign() public view
    returns (Sign memory) {
        uint i = uint(keccak256(abi.encode(block.timestamp, block.difficulty, msg.sender))) % 3;

        return signs[i];
    }

    function getSignHashByIndex(uint i) public view
    returns (bytes32) {
        require(i < signs.length, "Sign not exist");
        return signs[i].hash;
    }
}