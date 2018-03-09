var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter',function(accounts){
    
    var instance;
    var first = accounts[1];
    var second = accounts[2];

    beforeEach('setup contract for each test', function () {
        return Splitter.new().then(function(_instance) {
            console.log("created new contract");
            instance = _instance;
        });
    });


    it("should create PayeeOne",function(){

   return instance.createPayeeOne(first)
 .then(txObj => {
    assert.strictEqual(txObj.receipt.status, 1, "Only one");
 })
});

it("should create PayeeTwo",function(){
    return instance.createPayeeOne(first)
    .then(txObj => {
       assert.strictEqual(txObj.receipt.status, 1, "Only one");
    })
   });
   

   it("should split amount between PayeeOne and PayeeTwo",function(){
    return instance.contributeAndSplit({value:web3.toWei(1,"ether")})
    .then(txObj => {
       assert.strictEqual(txObj.logs.length, 1, "Only one event");
    })
   });

});