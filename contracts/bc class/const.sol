//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract structSample {
    address public Simplilearn;
    constructor() {
        Simplilearn = msg.sender;
    }
    modifier onlySimplilearn(){
        require(msg.sender == Simplilearn);
        _;
    }

    //event
    //event newLearner(string name, uint8 age);
    event newLearner(bool returnvalue);

    struct learner{
        string name;
        uint8 age;
    }
    //mapping (key => value) mapping name
    mapping (uint => learner) public learners;
    //1 => ("Alice", 40)
    //2 => ("Tom", 25)
    //3 => ("Jerry", 34)
    
    function setLearnerDetails(uint _key, string memory _name, uint8 _age ) public onlySimplilearn {
        //learners[1].name="Alice";
        //learners[1].age=40
        learners[_key].name =_name;
        learners[_key].age =_age;

        //emit newLearner(_name, _age);

        if(_age > 21){
            emit newLearner(true);
        }
       
    }
    function getLearnerdetails(uint _key) public view returns(string memory){
        return(learners[_key].name);
    }
}