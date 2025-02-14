// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BasicERC20 is ERC20, Ownable, ERC20Permit {
    constructor(address initialOwner)
        ERC20("BasicERC20", "BERC")
        Ownable(initialOwner)
        ERC20Permit("BasicERC20")
    {
        _mint(initialOwner, 10000000000 * 10**decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}