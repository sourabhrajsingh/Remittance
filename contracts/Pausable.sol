pragma solidity ^0.4.21;

import"./Owned.sol";

contract Pausable is Owned {

    bool private running;

    event LogPausedContract(address indexed contractPauser);
    event LogResumedContract(address indexed contractResumer);


    constructor() public {
        running = true;
    }

    modifier isActive() {
        require(running == true);
        _;
    }

    function pauseContract() public onlyOwner returns(bool success) {
        running = false;
        emit LogPausedContract(msg.sender);
        return true;
    }

    function resumeContract() public onlyOwner returns(bool success) {
        running = true;
        emit LogResumedContract(msg.sender);
        return true;
    }
  }
