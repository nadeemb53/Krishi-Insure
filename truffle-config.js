const HDWalletProvider = require('truffle-hdwallet-provider');
const fs = require('fs');
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    abs_icertis_insurance_insurance: {
      network_id: "*",
      gas: 0,
      gasPrice: 0,
      provider: new HDWalletProvider(fs.readFileSync('c:\\Users\\nadee\\Desktop\\icertis_hack\\sampleDeployment.env', 'utf-8'), "https://insurance.blockchain.azure.com:3200/HuJBfM6K5IR3-3eLM5-iylep")
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.5.0"
    }
  }
};
