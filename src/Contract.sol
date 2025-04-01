// SPDX-License-Identifier: Unlicense
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
pragma solidity ^0.8.13;

contract Contract is ERC20{ 
    constructor() ERC20("MyToken", "MTK")  {
       
        
    }
    function mint(address owner,uint amount) public{
        _mint(owner,amount);
    }
}
