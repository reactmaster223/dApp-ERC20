const NeatBit = artifacts.require("NeatBit.sol");
const NeatBitSale = artifacts.require("NeatBitSale.sol");

module.exports = function (deployer) {
  deployer.deploy(NeatBit, 1000000).then(function () {
    // Token price is 0.001 Ether
    var tokenPrice = 1000000000000000;
    return deployer.deploy(NeatBitSale, NeatBit.address, tokenPrice);
  });
};
