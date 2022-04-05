// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Don't forget to add this import
import { StringUtils } from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
  // Here's our domain njangi!
  string public njangi;

  mapping(string => address) public domains;
  mapping(string => string) public records;
		
  // We make the contract "payable" by adding this to the constructor
  constructor(string memory _njangi) payable {
    njangi = _njangi;
    console.log("%s name service deployed", _njangi);
  }
		
  // This function will give us the price of a domain based on length
  function price(string calldata name) public pure returns(uint) {
    uint len = StringUtils.strlen(name);
    require(len > 0);
    if (len == 3) {
      return 5 * 10**18; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
    } else if (len == 4) {
      return 3 * 10**18; // To charge smaller amounts, reduce the decimals. This is 0.3
    } else {
      return 1 * 10**18;
    }
  }

  function register(string calldata name) public payable{
    require(domains[name] == address(0));
    
    uint _price = price(name);

    // Check if enough Matic was paid in the transaction
    require(msg.value >= _price, "Not enough Matic paid");

    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }
  // Other functions unchanged
}