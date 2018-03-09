pragma solidity ^0.4.17;

contract Splitter {
  
  address  public alice;
  address  public bob;
  address  public carol;

  function Splitter() public {
      alice = msg.sender;
  }
  
  function createBob(address currentBob) public {
         bob = currentBob;
  }

  function createCarol(address currentCarol) public {
         carol = currentCarol;
  }

  function contributeAndSplit() payable public returns(bool sucess) {
      require(alice.balance>=msg.value);
          
         bob.transfer((msg.value)/2);
         carol.transfer((msg.value)/2);
          
      return true;
  }

  function kill() public { 
   require(msg.sender == alice);
    selfdestruct(alice);       
}

}