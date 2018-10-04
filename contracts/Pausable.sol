pragma solidity ^0.4.21;

import"./Owned.sol";

contract Pausable is Owned {

    bool public status;

    constructor() public {
        status = true;
    }

    modifier isActive() {
        require(status == true);
        _;
    }

    function pauseContract() public onlyOwner returns(bool success) {
        status = false;
        return true;
    }

    function resumeContract() public onlyOwner returns(bool success) {
        status = true;
        return true;
    }
  }
