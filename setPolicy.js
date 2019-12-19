var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setPolicy function for contract ", instance.address);
    //return instance.setPolicy();
    return instance.setPolicy.call(10000, 100, "12/12/2019", "12/12/2020");
  }).then(function(result) {
    console.log("Policy ID: ", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
