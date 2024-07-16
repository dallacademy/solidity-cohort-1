// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract calculator{
    int256 public a;
    int256 public b;

    error DivideByZero();

    constructor(int256 _a, int256 _b){
        a = _a;
        b = _b;
    }

    modifier checkZeroDivision(){
        require(b != 0, DivideByZero());
        _;
    }


    function add() public view returns(int256){
        unchecked{
            return a + b;
        }
    } 


    function sub() public view returns(int256){
        return a - b;
    } 


    function mul() public view returns(int256){
        return a * b;
    } 


    function div() public view checkZeroDivision() returns(int256){
       return a/b;
    } 

    function mod() public view returns(int256){
        return a % b;
    }


}