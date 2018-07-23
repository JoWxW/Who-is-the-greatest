pragma solidity ^0.4.24;

contract WhoIsGreatest {

  mapping(uint => address) public choice;
  mapping(uint => uint) public values;
  address owner;
  uint number;

  constructor (address[] _address, uint[] _value) {
    require(_address.length == _value.length);
    owner = msg.sender;
    number = _value.length;
    for(uint i=0; i<_value.length; i++){
      uint value = _value[i];
      choice[value] = _address[i];
      values[i] = value;
    }
  }

  function kill() {
    if(msg.sender == owner){
        selfdestruct(owner);
    }
  }

  //ignore the situation that the values are all in pair
  function theGreatest() returns (uint) {
    uint temp;
    bool isUnique = false;
    uint idActual = number-1;
    for(uint i=0; i<number; i++){
      for(uint j=number-1; j<i; j++){
        if(values[j]<values[j-1]){
          temp = values[j];
          values[j] = values[j-1];
          values[j-1] = temp;
        }
      }
    }
    while(!isUnique){
      if(values[idActual] != values[idActual-1]){
        isUnique = true;
      } else{
        idActual--;
      }
    }
    return values[idActual];
  }

  //who has proposed the least value will get a refund. The amount is the value that he proposed himself.
  function giveResult() payable {
    uint discount = theGreatest();
    address winner = choice[discount];
    winner.transfer(msg.value);
  }
}
