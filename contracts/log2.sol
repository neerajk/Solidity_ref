// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntellectualPropertyRegistry {

    // Define types of IP rights
    enum IPType { Patent, Copyright, Trademark }

    // Struct to store each IP's details
    struct IntellectualProperty {
        uint id;
        IPType ipType;
        string description;
        address currentOwner;
        address[] ownershipHistory;
        bool verified;
    }

    // Owner of the contract (admin, e.g. patent office)
    address public contractOwner;
    uint public ipCounter = 0;

    // Mapping from IP ID to IP record
    mapping(uint => IntellectualProperty) public ipRecords;

    // Events for logging actions on blockchain
    event IPRegistered(uint indexed id, address indexed owner);
    event OwnershipTransferred(uint indexed id, address indexed from, address indexed to);
    event IPVerified(uint indexed id, address indexed verifier);

    constructor() {
        contractOwner = msg.sender;
    }

    // Modifier to restrict access to current IP owner
    modifier onlyOwner(uint _ipId) {
        require(msg.sender == ipRecords[_ipId].currentOwner, "Not the owner of this IP");
        _;
    }

    // Modifier to restrict access to contract admin
    modifier onlyAdmin() {
        require(msg.sender == contractOwner, "Only admin allowed");
        _;
    }

    // 🔹 Task 1: Register a new IP
    function registerIP(uint8 _ipType, string memory _description) public {
        require(_ipType <= uint8(IPType.Trademark), "Invalid IP type");

        ipCounter++;
        address[] memory history;
        history = new address ;
        history[0] = msg.sender;

        ipRecords[ipCounter] = IntellectualProperty(
            ipCounter,
            IPType(_ipType),
            _description,
            msg.sender,
            history,
            false // Not verified initially
        );

        emit IPRegistered(ipCounter, msg.sender);
    }

    // 🔹 Task 2: Transfer ownership to another address
    function transferOwnership(uint _ipId, address _newOwner) public onlyOwner(_ipId) {
        require(_newOwner != address(0), "Invalid new owner");

        ipRecords[_ipId].ownershipHistory.push(_newOwner);
        address oldOwner = ipRecords[_ipId].currentOwner;
        ipRecords[_ipId].currentOwner = _newOwner;

        emit OwnershipTransferred(_ipId, oldOwner, _newOwner);
    }

    // 🔹 Task 3: Verify an IP (can only be done by admin/verifier)
    function verifyIP(uint _ipId) public onlyAdmin {
        ipRecords[_ipId].verified = true;
        emit IPVerified(_ipId, msg.sender);
    }

    // 🔹 Task 4: View IP details
    function getIPDetails(uint _ipId) public view returns (
        uint id,
        IPType ipType,
        string memory description,
        address currentOwner,
        bool verified
    ) {
        IntellectualProperty storage ip = ipRecords[_ipId];
        return (
            ip.id,
            ip.ipType,
            ip.description,
            ip.currentOwner,
            ip.verified
        );
    }

    // 🔹 Task 5: View ownership history
    function getOwnershipHistory(uint _ipId) public view returns (address[] memory) {
        return ipRecords[_ipId].ownershipHistory;
    }
}
