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
  

  function splitAmount (address firstPayee, address secondPayee)  public  payable {
      require(msg.value>0);
    
    //TODO: Check for valid address

         payees.push(firstPayee);
        payees.push(secondPayee);


       uint dividedValue = msg.value/2;

        //Checking for even amount. If not return.
        if (2*dividedValue == msg.value) {
         payeesRecord[firstPayee] += dividedValue;
         payeesRecord[secondPayee] += dividedValue;
        }else {
            
        uint remainingBalance = (this.balance - (2*dividedValue));
        //TODO: In solidity documentation it says 0.5 will be taken but in code its not taking
         uint actualAmount = dividedValue+remainingBalance/2;
         payeesRecord[firstPayee] += actualAmount;
         payeesRecord[secondPayee] += actualAmount;

        }

       
        

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