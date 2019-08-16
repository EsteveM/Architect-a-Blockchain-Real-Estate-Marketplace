var ERC721MintableComplete = artifacts.require('CustomERC721Token');

contract('TestERC721Mintable', accounts => {

    const account_one = accounts[0];
    const account_two = accounts[1];

    describe('Match ERC721 specification', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});

            // TODO: mint multiple tokens
            await this.contract.mint(account_two, 1, {from: account_one});
            await this.contract.mint(account_two, 2, {from: account_one});
            await this.contract.mint(account_two, 3, {from: account_one});
            await this.contract.mint(account_two, 4, {from: account_one});
            await this.contract.mint(account_two, 5, {from: account_one});
            await this.contract.mint(account_two, 6, {from: account_one});
            await this.contract.mint(account_two, 7, {from: account_one});
            await this.contract.mint(account_two, 8, {from: account_one});
            await this.contract.mint(account_two, 9, {from: account_one});
            await this.contract.mint(account_two, 10, {from: account_one});
        })

        it('Should return total supply', async function () { 
            let totalSupply = await this.contract.totalSupply.call({from: account_one});
            assert.equal(totalSupply, 10, "Incorrect total amount of tokens stored by the contract");
        })

        it('Should get token balance', async function () {
            let tokenBalance = await this.contract.balanceOf.call(account_two, {from: account_one});
            assert.equal(tokenBalance, 10, "Incorrect token balance of given address");
        })

        // token uri should be complete i.e: https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1
        it('Should return token URI', async function () { 
            let tokenURI = await this.contract.tokenURI.call(1, {from: account_one});
            assert.equal(tokenURI, "https://s3-us-west-2.amazonaws.com/udacity-blockchain/capstone/1", "Incorrect token URI of given token ID");
        })

        it('Should transfer token from one owner to another', async function () { 
            let totalSupplyBefore = await this.contract.totalSupply.call({from: account_one});
            let tokenBalanceAccountFromBefore = await this.contract.balanceOf.call(account_two, {from: account_one});
            let tokenBalanceAccountToBefore = await this.contract.balanceOf.call(account_one, {from: account_one});
            
            await this.contract.safeTransferFrom(account_two, account_one, 1, {from: account_two});
            
            let totalSupplyAfterwards = await this.contract.totalSupply.call({from: account_one});
            let tokenBalanceAccountFromAfterwards = await this.contract.balanceOf.call(account_two, {from: account_one});
            let calculatedTokenBalanceAccountFromAfterwards = tokenBalanceAccountFromBefore - 1;
            let tokenBalanceAccountToAfterwards = await this.contract.balanceOf.call(account_one, {from: account_one});
            let calculatedTokenBalanceAccountToAfterwards = tokenBalanceAccountToBefore + 1;

            assert.equal(totalSupplyBefore.toNumber(), totalSupplyAfterwards.toNumber(), "Incorrect total supply. Transferring tokens should not have any effect on the total supply");
            assert.equal(tokenBalanceAccountFromAfterwards.toNumber(), calculatedTokenBalanceAccountFromAfterwards, "Incorrect token balance of given from address");
            assert.equal(tokenBalanceAccountToAfterwards.toNumber(), calculatedTokenBalanceAccountToAfterwards, "Incorrect token balance of given to address");
            
            let newOwner = await this.contract.ownerOf.call(1, {from: account_one});

            assert.equal(account_one, newOwner, "New token owner should be account one");
        })
    });

    describe('Have ownership properties', function () {
        beforeEach(async function () { 
            this.contract = await ERC721MintableComplete.new({from: account_one});
        })

        it('Should fail when minting when address is not contract owner', async function () { 
            // Ensure that access is denied for non-Contract Owner account
            let accessDenied = false;
            try 
            {
                await this.contract.mint(account_two, 11, {from: account_two});
            }
            catch(e) {
                accessDenied = true;
            }
            assert.equal(accessDenied, true, "Access not restricted to Contract Owner");    
        })

        it('Should return contract owner', async function () { 
            let owner = await this.contract.owner.call({from: account_one});
            let isOwner = await this.contract.isOwner.call({from: owner});
            assert.equal(isOwner, true, "Contract Owner has not been returned");  
        })
    });
})