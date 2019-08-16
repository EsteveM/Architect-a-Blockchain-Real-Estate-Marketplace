# Architect a Blockchain Real Estate Marketplace

This project is intended to create a DApp that implements a decentralized housing product powered by Ethereum. The main idea is that the system makes it possible to mint tokens representing people's entitlement to the properties. Zk-SNARKs are used to prove that people own the property without revealing that information on the property. The verified token can then be listed on a blockchain marketplace ([OpenSea](https://opensea.io/)) where it can bought by others.

## Table of Contents

* [Some key data](#some-key-data)
* [Description of the Project](#description-of-the-project)
* [Testing smart contract code coverage](#testing-smart-contract-code-coverage)
* [Getting Started](#getting-started)
* [Resources](#resources)
* [Contributing](#contributing)

## Some key data

In this section, some key data is provided:

* *Contract address for SolnSquareVerifier on Rinkeby* is 0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38. It can be accessed at Etherscan at https://rinkeby.etherscan.io/address/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38.
* *ABI/JSON Interface* can be obtained from the *SolnSquareVerifier.json* file at the */eth-contracts/build/contracts/* folder. 
* *URL of the OpenSea Marketplace Storefront* is https://rinkeby.opensea.io/assets/realestatemarketplace.
* *URL of the five properties listed at the [OpenSea](https://opensea.io/) storefront are*:
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/1.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/2.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/3.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/4.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/5.
* Address of the original owner of the five properties listed: 0x0B05E528B92c2C7A155fca34D376d8cA6D2ddc93.
* Address of the buyer of the five properties: 0x1F7552E7fB8264Ba85AC9127B81B65Eef70a6385.
* Versions used for a number of tools: 
    * [Node](https://nodejs.org/es/) v10.15.3    
    * [Truffle](https://www.trufflesuite.com/) v5.0.31 (core: 5.0.31)
    * [Solidity](https://solidity.readthedocs.io/en/v0.5.10/) v0.5.2 (solc-js)
    * [web3](https://web3js.readthedocs.io/en/1.0/) v1.2.1
    * [truffle-hdwallet-provider](https://www.npmjs.com/package/truffle-hdwallet-provider) @1.0.5
    * [Ganache CLI](https://github.com/trufflesuite/ganache-cli) v6.4.3 (ganache-core: 2.5.5)
    * [Metamask](https://metamask.io/) Version 7.0.1

## Description of the Project

As has already been mentioned, this project develops a Dapp which implements a decentralized housing product based on Ethereum. Most notably, [OpenSea](https://opensea.io/), a decentralized marketplace, is used to sell crypto assets. Moreover, [ZoKrates](https://github.com/Zokrates/ZoKrates) is used to implement zkSnarks on Ethereum. The work that has been done is best described by explaining its main steps:

* The contract ERC721Mintable.sol has been filled out, and then test cases have been written and passed in the TestERC721Mintable.js file.
* Zokrates has been implemented, producing a Verifier.sol contract. Then, test cases have been written and passed in the TestSquareVerifier.js file to ensure the Verifier.sol contract executes successfully.
* The contract SolnSquareVerifier.sol has been filled out, and then test cases have been written and passed in the TestSolnSquareVerifier.js file. The main goal of this contract is to integrate ZK and ERC721.
* Both Verifier.sol and SolnSquareVerifier.sol are deployed to Rinkeby.
* Ten tokens are minted using [MyEtherWallet](https://www.myetherwallet.com/).
* The [OpenSea](https://opensea.io/) marketplace is generated.
* Five SolnSquareVerifier tokens are listed on the marketplace, and are then purchased by a different address from the one that owns them.
* The documentation you are reading right now is completed.

## Testing smart contract code coverage

In this section, the eleven tests covered are listed:

* Contract TestERC721Mintable:
    * Match ERC721 specification:
        * Should return total supply.
        * Should get token balance.
        * Should return token URI.
        * Should transfer token from one owner to another.
    * Have ownership properties:
        * Should fail when minting when address is not contract owner.
        * Should return contract owner.
* Contract TestSquareVerifier:
    * Test verification:
        * Test verification with correct proof.
        * Test verification with incorrect proof.
* Contract TestSolnSquareVerifier:
    * Test SolnSquareVerifier:
        * Test if a new solution can be added for contract.
        * Test if an ERC721 token can be minted for contract.
        * Test if the same solution can be used twice.

## Getting Started

The procedure to obtain functional a copy of the project on your local machine so that you can further develop and/or test it is explained in this section. It is assumed that you have already installed [Truffle](https://www.trufflesuite.com/), [Ganache CLI](https://github.com/trufflesuite/ganache-cli), and the [Metamask](https://metamask.io/) extension in your browser. These are the steps to be followed:

* Firstly, you have to download/clone the project files from this repository onto your local machine. Then, cd into the root folder where the project files are located.
* Secondly, type `npm install` so that all required npm packages are installed.
* Thirdly, run Ganache. This will start Ganache at *http://127.0.0.1:8545/*. This project has been developed assuming that block gas limit is set at 9999999, the number of accounts to generate at startup is 200, and the amount of ether to be assigned to each account is 50000. This can be accomplished by typing `ganache-cli -l 9999999 -a 200 -e 50000`. However, you might prefer to set some other values.
* In the fourth place, to run the supporting unit tests on Ganache, you have to:
    * Open a new terminal shell window, cd to the same root folder of the project, from there to the eth-contracts folder, and then type `truffle compile` to compile the smart contracts.
    ![trufflecompile](/ScreenShots/trufflecompile.png)
    * Once the contracts have been successfully compiled, type `truffle migrate --reset`, to deploy them to Ganache.
    ![trufflemigrateganache](/ScreenShots/trufflemigrateganache.png)
    * Now, you can run `truffle test test/TestERC721Mintable.js`, `truffle test test/TestSquareVerifier.js`, and then `truffle test test/TestSolnSquareVerifier.js` to run all tests.
    ![truffletests](/ScreenShots/truffletests.png)
* In the fifth place, you have to set up a *secret-parameters.js* file at the eth-contracts folder of this project, where you are located just now. For convenience, one such file has been provided for you, so that you just have to fill out the data into the corresponding fields. This is a secret parameters file where you have to type two parameters for the application:
    * Firstly, *your Metamask seed (mnemonic)*.
    * Secondly, *your Infura PROJECT ID (infuraKey)*.
* In the sixth place, both Verifier and SolnSquareVerifier contracts are deployed to the public test network Rinkeby. If you wanted to do that yourself, you should go back to the terminal shell window, and type the command `truffle migrate --reset --network rinkeby`. Nevertheless, this is not necessary to test the project.
![trufflemigraterinkeby](/ScreenShots/trufflemigraterinkeby.png)
After successful deployment of the SolnSquareVerifier contract on Rinkeby, as can be observed, the contract assigned contract address is 0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38. It can be accessed at Etherscan at https://rinkeby.etherscan.io/address/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38.
![contractRinkeby](/ScreenShots/contractRinkeby.png)
* In the seventh place, a number of tokens are minted using the [MyEtherWallet](https://www.myetherwallet.com/) tool. To this end, the tool is provided with the corresponding contract address and ABI/JSON Interface. As already mentioned, the former is 0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38, and the latter can be obtained from the *SolnSquareVerifier.json* file at the */eth-contracts/build/contracts/* folder. The tokens are minted so that its owner is the 0x0B05E528B92c2C7A155fca34D376d8cA6D2ddc93 address.
![mew](/ScreenShots/mew.png)
* In the eight place, the [OpenSea](https://opensea.io/) marketplace is generated. OpenSea is provided with the contract address, and it automatically loads the data for the contract. The URL of the OpenSea Marketplace Storefront is https://rinkeby.opensea.io/assets/realestatemarketplace. Five tokens are listed.
![openseastorefront](/ScreenShots/openseastorefront.png)
* In the ninth place, the owner of the five properties, 0x0B05E528B92c2C7A155fca34D376d8cA6D2ddc93, makes them available for sell.
![openseasell1](/ScreenShots/openseasell1.png)
![openseasell2](/ScreenShots/openseasell2.png)
![openseasell3](/ScreenShots/openseasell3.png)
![openseasell4](/ScreenShots/openseasell4.png)
* The URL of the five properties listed at the [OpenSea](https://opensea.io/) storefront are:
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/1.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/2.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/3.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/4.
    * https://rinkeby.opensea.io/assets/0x8e88accDD01cb9F3FA12f3e7e59ff40Abc84cB38/5.
* In the tenth place, the five properties (tokens) are bought using a different address, 0x1F7552E7fB8264Ba85AC9127B81B65Eef70a6385.
![openseabuy1](/ScreenShots/openseabuy1.png)
![openseabuy2](/ScreenShots/openseabuy2.png)
![openseabuy3](/ScreenShots/openseabuy3.png)
![openseabuy4](/ScreenShots/openseabuy4.png)
* Finally, it can be seen that out of ten minted tokens, five belong to 0x0B05E528B92c2C7A155fca34D376d8cA6D2ddc93, and five to 0x1F7552E7fB8264Ba85AC9127B81B65Eef70a6385.
![etherscanfinal](/ScreenShots/etherscanfinal.png)

## Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates)

## Contributing

This repository contains all the work that makes up the project. Individuals and I myself are encouraged to further improve this project. As a result, I will be more than happy to consider any pull requests.