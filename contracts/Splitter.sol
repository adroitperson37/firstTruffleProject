pragma solidity ^0.4.17;

contract Splitter {
  
 address public owner; 
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
  event WithDrawal(address withdrawAddress,uint value);
  

  function splitAmount (address firstPayee, address secondPayee)  public  payable {
      require(msg.value>0 && firstPayee!=0 && secondPayee!=0);
    
         payees.push(firstPayee);
        payees.push(secondPayee);
       uint dividedValue = msg.value/2;

        //Checking for even amount. If not return.
        if (2*dividedValue == msg.value) {
         payeesRecord[firstPayee] += dividedValue;
         payeesRecord[secondPayee] += dividedValue;
        }else {
        //TODO: distribution of  1 wei left in the contract account
         payeesRecord[firstPayee] += dividedValue;
         payeesRecord[secondPayee] += dividedValue;

        }

       
        

        LogSplitEther(msg.sender, msg.value, firstPayee, secondPayee);
          
  }
//Withraw Pull pattern
  function withdraw() public {
      //Check if the amount is present and greater than zero.
    require(payeesRecord[msg.sender]>0);
    uint amount = payeesRecord[msg.sender];

    //Change state before transer
    payeesRecord[msg.sender] = 0;
    //Send the amount
    msg.sender.transfer(amount);
    //Emit event
    WithDrawal(msg.sender,amount);

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