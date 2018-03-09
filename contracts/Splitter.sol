pragma solidity ^0.4.17;

contract Splitter {
  
  address  public owner;
  address  public payeeOne;
  address  public payeeTwo;


  function Splitter() public {
      owner = msg.sender;
  }

  event LogSplitEther(address from, uint value, address payeeOne, address payeeTwo);
  
  function createPayeeOne(address currentPayee) public {
         payeeOne = currentPayee;
  }

  function createPayeeTwo(address currentPayee) public {
         payeeTwo = currentPayee;
  }

  function showPayeeOneBalance() public view returns(uint amount) {
       return payeeOne.balance;

  }

  function showPayeeTwoBalance() public view returns(uint amount) {
       return payeeTwo.balance;

  }


  function showCallerBalance() public view returns(uint amount) {
       return msg.sender.balance;
  }

  function contributeAndSplit() payable public returns(bool sucess) {
      require(msg.value>0);
          

         payeeOne.transfer((msg.value)/2);
         payeeTwo.transfer((msg.value)/2);
         LogSplitEther(msg.sender, msg.value, payeeOne, payeeTwo);
          
      return true;
  }

  function kill() public { 
   require(msg.sender == owner);
    selfdestruct(owner);       
}

}