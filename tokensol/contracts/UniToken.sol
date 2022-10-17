//contracts/UniToken.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../node_modules/@openzeppelin/contracts/token/ERC20";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract UniToken is ERC20Capped, ERC20Burnable {
    address payable public owner;
    uint256 public blockReward;

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner cal all this function");
    }

    constructor(uint256 cap, uint256 reward) ERC20("UniToken", "UNT") ERC20Capped(cap * (10**decimals())){
        owner = msg.sender;
        _mint(owner, 70000000 * (10 ** decimals()));
        blockReward = reward * (10 ** decimals());
    }

    function _mintMinerReward() internal {
        _mint(block.coinbase, blockReward);
    }

    function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override{
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
            _mintMinerReward();
        }
        spuer._beforeTokenTransfer(from, to, value);
    }
    
    function destroy() public onlyOwner{
        selfdestruct(owner);
    }

    function setBlockReward(uint256 reward) public onlyOwner {
        blockreward = reward * (10**decimals());
    }
}