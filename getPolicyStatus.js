var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setFarmerData function for contract ", instance.address);
    return instance.getPolicyStatus.call('0x2831d0897d100e91c79902bc2c5a89cef590943741832b31f5dd97fa49870cc4',
    '0x2550ca57740eff7bae0a78a735f7e6ce4a89fca73f0fb70c52115a7a697f116a');
  }).then(function(result) {
    console.log("Policy Status", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
