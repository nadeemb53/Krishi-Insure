var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setFarmerData function for contract ", instance.address);
    return instance.getPolicyStatus.call('1000',
    '2000');
  }).then(function(result) {
    console.log("Policy Status", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
