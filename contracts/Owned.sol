pragma solidity ^0.4.21;

contract Owned {
  address private owner;

  event LogOwnerAddress(address indexed currentOwner, address indexed previousOwner);

  constructor() public {
      owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function getOwner() public view returns(address){
      return owner;
  }

  function changeOwner(address newOwner) public onlyOwner returns(bool success){
    require(newOwner != owner);
    owner = newOwner;
    emit LogOwnerAddress(owner, msg.sender);
    return true;
  }
}
