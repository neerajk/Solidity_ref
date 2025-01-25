// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// contract name
contract SimpleStorage{
    //define variables 
uint public storeddata; //datatype access modifier(public, private) variable name
//this is the program to store the data into blockchain
function set(uint x) public{
storeddata = x;
}
function get() public view returns(uint){
return storeddata;
}
}
