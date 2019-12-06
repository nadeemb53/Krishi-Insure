var insurance = artifacts.require("insurance");
module.exports = deployer => {
    deployer.deploy(insurance);
};