var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setFarmerData function for contract ", instance.address);
    return instance.setFarmerData.call('foo','bar','1000',
    'uttarpradesh',340000,'mh/ngp/ngp/vl/1','some-coordinates');
  }).then(function(result) {
    console.log("Farmer ID: ", result);
    console.log("Request complete");
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};
