pragma solidity ^0.4.21;

import"./Pausable.sol";

contract Remittance is Pausable{

    address[] public receiver;
    mapping(address => uint) public balances;
    mapping(address => bytes32) public password;
    address public exchangeAgent;

    event LogFundingEscrow(uint amountFunded);
    event LogWippingEscrow(address fundReceiver, uint amountReceived);

    function createPassword(uint passphrase, address _receiver) public isActive onlyOwner returns(bool success) {
        receiver.push(_receiver);
        password[_receiver] = (keccak256(abi.encodePacked(passphrase, _receiver)));
        return true;
    }

    function exchangeAddress(address assign_exchangeAddress) public isActive onlyOwner returns(bool success) {
        exchangeAgent = assign_exchangeAddress;
        return true;
    }

    function fundEscrow(address _receiver) payable public isActive returns(bool success) {
        require(balances[_receiver] == 0);
         balances[_receiver] += msg.value;
        emit LogFundingEscrow(msg.value);
        return true;
    }

    function wipeEscrow(uint _passphrase) public isActive returns(bool success) {
        require(keccak256(abi.encodePacked(_passphrase, msg.sender)) == password[msg.sender]);
        emit LogWippingEscrow(msg.sender, balances[msg.sender]);

        exchangeAgent.transfer(balances[msg.sender]);
        balances[msg.sender] = 0;
        return true;
    }

}
