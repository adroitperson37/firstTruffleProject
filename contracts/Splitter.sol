pragma solidity ^0.4.17;

contract Splitter {
  
  address  public owner;
  address  public payeeOne;
  address  public payeeTwo;

  function Splitter() public {
      owner = msg.sender;
  }
  
  function createPayeeOne(address currentPayee) public {
         payeeOne = currentPayee;
  }

  function createPayeeTwo(address currentPayee) public {
         payeeTwo = currentPayee;
  }

  function contributeAndSplit() payable public returns(bool sucess) {
      require(owner.balance>=msg.value);
          
         payeeOne.transfer((msg.value)/2);
         payeeTwo.transfer((msg.value)/2);
          
      return true;
  }

  function kill() public { 
   require(msg.sender == owner);
    selfdestruct(owner);       
}

}