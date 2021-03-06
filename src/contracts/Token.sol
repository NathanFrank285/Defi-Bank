// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //add minter variable
  address public minter;


  //add minter changed event


  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    //asign initial minter
    minter = msg.sender;
  }

  event MinterChanged(address indexed from, address to);

  //Add ability to change who is the minter
  function passMinterRole(address dBank) public returns(bool){
    require(msg.sender == minter, "Error, only owner can call this function");
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }


  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender == minter, 'You do not have authority to mint new DBC');
		_mint(account, amount);
	}
}
