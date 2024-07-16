// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank{

    //struct for holding account details
    struct Account{
        string name;
        bool isActive;
        uint256 balance;
    }
    //mapping for holding all events
    mapping(address => Account) public accounts;

    //events
    event NewAccount(address indexed accountAddress, uint256 openingBalance);
    event Deposit(address indexed senderAccount, address indexed receiverAccount, uint256 amount);
    event Withdraw(address indexed receiverAccount, uint256 amount);
    event AccountDeleted(address indexed accountAddress);

    //function for creating a account
    function createAccount(string memory name, uint256 openingBalance) external {
        require(!accounts[msg.sender].isActive, "account is already created");
        Account memory newAccount = Account(name, true, openingBalance);
        accounts[msg.sender] = newAccount;
        emit NewAccount(msg.sender, openingBalance);
    }

    //function for depositing funds
    function deposit(uint256 amount, address toAccount) external {
        require(amount > 0, "amount should be greater than zero");
        require(amount < accounts[msg.sender].balance, "amount should be less than balance");
        accounts[msg.sender].balance -= amount;
        accounts[toAccount].balance += amount;
        emit Deposit(msg.sender, toAccount, amount);
    }

    //function for withdrawing funds
    function withdraw(uint256 amount) external {
        require(amount > 0, "amount should be greater than zero");
        require(amount < accounts[msg.sender].balance, "amount should be less than balance");
        accounts[msg.sender].balance -= amount;
        emit Withdraw(msg.sender, amount);
    }

    //function for deleting account
    function DeleteAccount() external{
        accounts[msg.sender].isActive = false;
        emit AccountDeleted(msg.sender);
    }

    //function for getting balance of the account
    function getAccountBalance() external view returns (uint256){
        return accounts[msg.sender].balance;
    }

}