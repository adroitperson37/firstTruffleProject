pragma solidity ^0.4.17;

contract Splitter {
  
 address owner; 
 mapping(address => uint) public payeesRecord;
 address[] payees;
 
  function Splitter() public {
      owner = msg.sender;
  }

  modifier onlyOwner () {
        require(msg.sender == owner);
        _;
    }

  event LogSplitEther(address from, uint value, address payeeOne, address payeeTwo);
  

  function splitAmount (address firstPayee, address secondPayee)  public  payable{
      require(msg.value>0);
        
       uint dividedValue = msg.value/2;

        //Checking for even amount. If not return.
        require(2*dividedValue == msg.value);

        payees.push(firstPayee);
        payees.push(secondPayee);
        payeesRecord[firstPayee] += dividedValue;
        payeesRecord[secondPayee] += dividedValue;

        LogSplitEther(msg.sender, msg.value, firstPayee, secondPayee);
          
  }
//Withraw Pull pattern
  function withdraw() public {
      //Check if the amount is present and greater than zero.
    require(payeesRecord[msg.sender]>0);
    //Send the amount
    msg.sender.transfer(payeesRecord[msg.sender]);
    //Once sent successfully deduct the amount.
    payeesRecord[msg.sender] = 0;

  }

  function kill() public onlyOwner() {
       //return all funds and then destruct
    sendFunds();
    selfdestruct(owner);       
}

function sendFunds() private {

    uint length = payees.length;

   for (uint i = 0; i<=length; i++) {
       require(payeesRecord[payees[i]]>0);
      payees[i].transfer(payeesRecord[payees[i]]);
   }
}

}