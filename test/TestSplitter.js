var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter',function(accounts){
    

    it("should create PayeeOne",function(){
 let instance;

 return Splitter.deployed().then( _instance => {
     instance = _instance;
     return instance.createPayeeOne("0x22A41BFF5186295789DecD900048f23FFED22979");
 })
 .then(txObj => {
    assert.strictEqual(txObj.receipt.status, 1, "Only one");
 })
});

it("should create PayeeTwo",function(){
    let instance;
   
    return Splitter.deployed().then( _instance => {
        instance = _instance;
        return instance.createPayeeTwo("0xe23E93fe863e0de0BC0A24c7d3B4eCb7a3299524");
    })
    .then(txObj => {
       assert.strictEqual(txObj.receipt.status, 1, "Only one");
    })
   });
   

   it("should split amount between PayeeOne and PayeeTwo",function(){
    let instance;
   
    return Splitter.deployed().then( _instance => {
        instance = _instance;
        return instance.contributeAndSplit({value:web3.toWei(1,"ether")});
    })
    .then(txObj => {
       assert.strictEqual(txObj.receipt.status, 1, "Only one");
    })
   });

});