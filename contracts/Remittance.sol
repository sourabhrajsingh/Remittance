pragma solidity ^0.4.21;

import"./Pausable.sol";

contract Remittance is Pausable{

    bytes32 public password;
    address public carol;
    mapping(address => uint) public balances;

    event LogFundingEscrow(uint amountFunded);
    event LogWippingEscrow(address fundReceiver, uint amountReceived);

    function createPassword(uint passphrase, address _carol) public isActive onlyOwner returns(bool success) {
        carol = _carol;
        password = keccak256(abi.encodePacked(passphrase, carol));
        return true;
    }

    function fundEscrow() payable public isActive returns(bool success) {
         balances[carol] += msg.value;
        emit LogFundingEscrow(msg.value);
        return true;
    }

    function wipeEscrow(uint _passphrase, address exchangeAgent) public isActive returns(bool success) {
        require(keccak256(abi.encodePacked(_passphrase, msg.sender)) == password);
        emit LogWippingEscrow(msg.sender, balances[msg.sender]);
        exchangeAgent.transfer(balances[msg.sender]);
        balances[carol] = 0;
        return true;
    }

}
