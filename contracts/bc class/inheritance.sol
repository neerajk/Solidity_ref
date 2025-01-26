//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract parent{

    string name;
    uint8 age;

    function setAge(string memory _name, uint8 _age) public {
        name = _name;
        age = _age;
    }

    function getAge() public view returns(uint8){
        return age;
    }
}

contract child is parent{

    function getName() public view returns(string memory){
        return name;
    }

}

contract functionVisibility{
    string name;
    function getName() internal view returns(string memory){
        return name;
    }
}