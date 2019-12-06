var HelloBlockchain = artifacts.require("HelloBlockchain");

module.exports = function(done) {
  console.log("Getting the deployed version of the HelloBlockchain smart contract")
  HelloBlockchain.deployed().then(function(instance) {
    console.log("Calling getMessage function for contract ", instance.address);
    return instance.getMessage();
  }).then(function(result) {
    console.log("Request message value: ", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};