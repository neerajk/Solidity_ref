// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract arraySample{

    //array --> fixed and dynamic

    //fixed array

    uint8[50] age;

    // input index and Values
    function setData(uint8 _index, uint8 _value) public {
        age[_index] = _value;
    }

    // output values based on index
    function getData(uint8 _index) public view returns(uint8) {
        return age[_index];
    }

    //dynamic array

    uint[] phoneNumber;

    function setDynamicArray (uint _phoneno) public {
        phoneNumber.push(_phoneno);
    }

    function getPhone (uint _index) public view returns(uint) {
        return phoneNumber[_index];

    }
}