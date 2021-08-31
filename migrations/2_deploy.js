const Token = artifacts.require("Token");
const dBank = artifacts.require("dBank");

module.exports = async function(deployer, network, accounts) {
	//deploy Token
	await deployer.deploy(Token)
	console.log(network)
	console.log(accounts)

	//assign token into variable to get it's address
	let token = await Token.deployed()

	//pass token address for dBank contract(for future minting)
	await deployer.deploy(dBank, token.address)

	//assign dBank contract into variable to get it's address
	const dbank = await dBank.deployed()

	//change token's owner/minter from deployer to dBank
	await token.passMinterRole(dbank.address)

};
