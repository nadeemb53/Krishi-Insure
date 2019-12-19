var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling getPolicy function for contract ", instance.address);
    return instance.getInsuranceList.call();
  }).then(function(result) {
    console.log("Insurance IDs", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
