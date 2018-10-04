pragma solidity ^0.4.21;

import"./Pausable.sol";

contract Remittance is Pausable{

    bytes32 private password;
    uint public escrowBalance;

    event LogFundingEscrow(uint amountFunded);
    event LogWippingEscrow(address fundReceiver, uint amountReceived);


    function createPassword(uint a) public isActive onlyOwner returns(bool success) {
        password = keccak256(abi.encodePacked(a));
        return true;
    }

    function fundEscrow(uint amount) payable public isActive returns(bool success) {
        require(msg.value == amount);
        escrowBalance = msg.value;
        emit LogFundingEscrow(msg.value);
        return true;
    }

    function wipeEscrow(uint OTP) public isActive returns(bool success) {
        require(keccak256(abi.encodePacked(OTP)) == password);
        emit LogWippingEscrow(msg.sender, escrowBalance);
        msg.sender.transfer(escrowBalance);
        escrowBalance = 0;
        return true;
    }

}
