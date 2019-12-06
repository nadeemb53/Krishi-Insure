var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling getPolicy function for contract ", instance.address);
    return instance.getPolicy.call('0x209dd304aac436264794d8117db195c9ea79db32dd19be70c0acd2675bfd056d');
  }).then(function(result) {
    console.log("Policy Details", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
