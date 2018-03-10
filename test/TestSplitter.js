var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter',function(accounts){
    
    var instance;
    var sender = accounts[0];
    var first = accounts[1];
    var second = accounts[2];

    before('setup contract for each test', function () {
        return Splitter.new({from :sender}).then(function(_instance) {
            console.log("created new contract");
            instance = _instance;
        });
    });
   

   it("should split amount between PayeeOne and PayeeTwo",function(){
    return instance.splitAmount(first,second,{from:sender , value:11} )
    .then(txObj => {
       assert.strictEqual(txObj.logs.length, 1, "Only one event");
    })
   });

   it("should verify PayeeOne Amount",function(){
    return instance.payeesRecord.call(first)
    .then(value => {
       assert.strictEqual(value.c[0], 5,"Exactly half");
    })
   });

   it("should verify PayeeTwo Amount",function(){
    return instance.payeesRecord.call(second)
    .then(value => {
       assert.strictEqual(value.c[0], 5, "Exactly half");
    })
   });

});