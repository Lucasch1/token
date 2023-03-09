// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.4.0/utils/Strings.sol";

contract Subscribe {
    
    address[] public subscriberAddr;
    string[] public subscriberName;
    string public name;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function submit(string memory _name) public {
        subscriberAddr.push(msg.sender);
        subscriberName.push(_name);
    }

    function getList() public view returns (address[] memory, string [] memory) {
        require(msg.sender == owner, "Only owner can call this function");
        require(subscriberAddr.length == subscriberName.length, "The lists must have the same size");
        address[] memory todosAddr = new address[](subscriberAddr.length);
        string[] memory todosNomes = new string[](subscriberName.length);
        
        for (uint i = 0; i < subscriberAddr.length; i++) {
            todosAddr[i] = subscriberAddr[i];
            todosNomes[i] = subscriberName[i];
        }

        return (todosAddr, todosNomes);
    }

}
