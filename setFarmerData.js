var insurance = artifacts.require("insurance");

module.exports = function(done) {
  console.log("Getting the deployed version of the Insurance smart contract")
  insurance.deployed().then(function(instance) {
    console.log("Calling setFarmerData function for contract ", instance.address);
    return instance.setFarmerData.call('foo','bar','0x2831d0897d100e91c79902bc2c5a89cef590943741832b31f5dd97fa49870cc4',
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
