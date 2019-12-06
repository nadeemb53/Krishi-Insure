var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setFarmerData function for contract ", instance.address);
    return instance.createClaim('0x81520565db6be328ee6dbcd1a49be2782df656734fe4d78af28f344b919a3908');
  }).then(function(result) {
    console.log("Response ", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
