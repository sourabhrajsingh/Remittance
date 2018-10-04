pragma solidity ^0.4.21;

contract Owned {
  address public newOwner;
  event LogNewOwner(address currentOwner);

  constructor() public {
      newOwner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == newOwner);
    _;
  }

  function newOwnerIs(address a) public onlyOwner returns(bool success){
    newOwner = a;
    emit LogNewOwner(newOwner);
    return true;
  }
}
