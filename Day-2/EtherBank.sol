// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract EtherBank {
    struct Account {
        string AccountHolderName;
        bool isActive;
        uint256 balance;
    }
    
    mapping(address => Account) public accounts;

    // Function to create an account
    function createAccount(string memory _accountHolder) public {
        require(accounts[msg.sender].isActive, "Account is not active");
        accounts[msg.sender] = Account(_accountHolder, true, 0);
    }

    // Function to deposit Ether into the contract
    function deposit() public payable {
        require(accounts[msg.sender].isActive, "Account is not active");
        accounts[msg.sender].balance += msg.value;
        // Ether is automatically transferred to the contract with the payable modifier
    }

    // Function to withdraw Ether from the contract to the account holder
    function withdraw(uint256 _amount) public {
        require(accounts[msg.sender].isActive, "Account is not active");
        require(accounts[msg.sender].balance >= _amount, "Insufficient balance");
        accounts[msg.sender].balance -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed.");
    }

    // Function to get the balance of the account
    function getBalance() public view returns (uint256) {
        require(accounts[msg.sender].isActive, "Account is not active");
        return accounts[msg.sender].balance;
    }
}
