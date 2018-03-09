module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "0.0.0.0",
      port: 8545,
      gas: 550000, 
      network_id: "*" // Match any network id
    }
  }
};
