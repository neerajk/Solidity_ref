// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract intellectualPropertyRegistry {

    //types of IP rights
    enum IPType{ Patent, Copyright, Trademark}

    // struct to store IP details
    struct intellectualProperty {
        uint id;
        IPType ipType;
        string description;
        address currentOwner;
        address[] ownershipHistory;
        bool verified;
    }

    //onwer of the contract (admin / patent offoice)
    address public contractOwner;
    uint public ipCounter = 0;

    //mapping from IP ID to IP records
    mapping(uint => intellectualProperty) public ipRecords;

    //events for logging actions on blockchain
    event IPRegistered(uint indexed id, address indexed owner);
    event OwnershipTransferred(uint indexed id, address indexed from, address indexed to);
    
    event IPVerified(uint indexed id, address indexed verifier);

    constructor() {
        contractOwner = msg.sender;
    }

    //restrict access to current IP Owner
    modifier onlyOwner(uint _ipID){
        require(msg.sender == ipRecords[_ipID].currentOwner,"Not the owner of this IP");
        _;
    }

    //restrict access to contract admin
    modifier onlyAdmin(){
        require(msg.sender==contractOwner, "Not authorized.");
        _;
    }
    
    // 1.
    //function to register intellectual property
    function registerIP(uint8 _ipType, string memory _description) public {
         require(_ipType <= uint8(IPType.Trademark),"Invalid IP Type");
        ++ipCounter;
        address[] memory history = new address[](1);
        history[0] = msg.sender;
        ipRecords[ipCounter] = intellectualProperty(
            ipCounter,
            IPType(_ipType),
            _description,
            msg.sender,
            history,
            false
        );

        emit IPRegistered(ipCounter, msg.sender);
    }

    // 2.
    // transfer ownership to another address
    function transferOwnership(uint _ipID, address _newOwner) public onlyOwner(_ipID) {
        require(_newOwner != address(0), 'Invalid new owner');
        ipRecords[_ipID].ownershipHistory.push(_newOwner);
        address oldOwner = ipRecords[_ipID].currentOwner;
        ipRecords[_ipID].currentOwner = _newOwner;

        emit OwnershipTransferred(_ipID, oldOwner, _newOwner);
    }

    // 3.
    // Verify IP (done by admin/verifier)
    function verifyIP(uint _ipID) public onlyAdmin{
        ipRecords[_ipID].verified = true;
        emit IPVerified(_ipID, msg.sender);
    }

    // 4.
    // View IP details
    function getIPDetails(uint _ipID) public view returns(
        uint id,
        IPType ipType,
        string memory description,
        address currentOwner,
        bool verified
    ) {
        intellectualProperty storage ip = ipRecords[_ipID];
        return (id, ip.ipType, ip.description, ip.currentOwner, ip.verified);
    }

    // 5.
    // View owernship history
    function getOwnershipHistory(uint _ipID) public view returns (address[] memory){
        return ipRecords[_ipID].ownershipHistory;
    }

}