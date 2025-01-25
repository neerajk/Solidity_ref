// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract money{

    address alice = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function getmoney() public payable {}

    function Transfer() public {
        payable(alice).transfer(address(this).balance);
    }

    /*function TransferMoney(uint _amount) public {
        payable(alice).transfer(_amount);
    }*/

   //fallback() external payable{}
    }