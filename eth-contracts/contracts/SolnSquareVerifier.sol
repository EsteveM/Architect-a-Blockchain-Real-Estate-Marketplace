pragma solidity >=0.4.21 <0.6.0;
// TODO define a contract call to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
// TODO define another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
import "./ERC721Mintable.sol";

contract SolnSquareVerifier is CustomERC721Token {

    // EMG - Variable that references the Verifier contract
    Verifier verifier;
    // TODO define a solutions struct that can hold an index & an address
    struct Solution {
        bool isSubmitted;
        uint256 tokenId;
        address owner;
    }
    // TODO define an array of the above struct
    Solution[] mintedTokens;

    // TODO define a mapping to store unique solutions submitted
    mapping(bytes32 => Solution) private solutions;

    // TODO Create an event to emit when a solution is added
    event SolutionAdded(uint256 indexed tokenId, address indexed owner);

/********************************************************************************************/
/*                                       CONSTRUCTOR                                        */
/********************************************************************************************/
    // EMG - address where this contract can find the Verifier contract
    constructor
                                (
                                    address verifierContract
                                )
                                public
    {
        verifier = Verifier(verifierContract);
    }

/********************************************************************************************/
/*                                       UTILITY FUNCTIONS                                  */
/********************************************************************************************/

    // EMG - This function returns whether a solution has already been submitted
    function solutionHasBeenSubmitted
                            (
                                uint[2] memory a,
                                uint[2] memory a_p,
                                uint[2][2] memory b,
                                uint[2] memory b_p,
                                uint[2] memory c,
                                uint[2] memory c_p,
                                uint[2] memory h,
                                uint[2] memory k,
                                uint[2] memory input
                            )
                            public
                            view
                            returns(bool)
    {
        bytes32 solutionKey = getSolutionKey(a, a_p, b, b_p, c, c_p, h, k, input);
        return (solutions[solutionKey].isSubmitted);
    }


/********************************************************************************************/
/*                                     SMART CONTRACT FUNCTIONS                             */
/********************************************************************************************/
    // TODO Create a function to add the solutions to the array and emit the event
    function registerSolution
                                (
                                    uint[2] memory a,
                                    uint[2] memory a_p,
                                    uint[2][2] memory b,
                                    uint[2] memory b_p,
                                    uint[2] memory c,
                                    uint[2] memory c_p,
                                    uint[2] memory h,
                                    uint[2] memory k,
                                    uint[2] memory input,
                                    address to,
                                    uint256 tokenId
                                )
                        public
    {
        mintedTokens.push(Solution({
            isSubmitted: true,
            tokenId: tokenId,
            owner: to
        }));

        // EMG - Register Solution
        bytes32 solutionKey = getSolutionKey(a, a_p, b, b_p, c, c_p, h, k, input);
        solutions[solutionKey] = Solution({
            isSubmitted: true,
            tokenId: tokenId,
            owner: to
        });

        emit SolutionAdded(tokenId, to);
    }
    // TODO Create a function to mint new NFT only after the solution has been verified
    function mintNFT
                                (
                                    uint[2] memory a,
                                    uint[2] memory a_p,
                                    uint[2][2] memory b,
                                    uint[2] memory b_p,
                                    uint[2] memory c,
                                    uint[2] memory c_p,
                                    uint[2] memory h,
                                    uint[2] memory k,
                                    uint[2] memory input,
                                    address to,
                                    uint256 tokenId
                                )
                                public
                                returns (bool)
    {
        // Mint new NFT only after the solution has been verified
        bool verificationResult = verifier.verifyTx(a, a_p, b, b_p, c, c_p, h, k, input);
        require(verificationResult, "The solution has not been successfully verified");

        //  - make sure the solution is unique (has not been used before)
        bytes32 solutionKey = getSolutionKey(a, a_p, b, b_p, c, c_p, h, k, input);
        require(!solutions[solutionKey].isSubmitted, "The solution has already been used");

        //  - make sure you handle metadata as well as tokenSuply
        bool mintCompleted = super.mint(to, tokenId);
        require(mintCompleted, "Mint has not been successfully completed");

        registerSolution(a, a_p, b, b_p, c, c_p, h, k, input, to, tokenId);

        // returns a true boolean upon completion of the function
        return true;
    }

    function getSolutionKey
                                (
                                    uint[2] memory a,
                                    uint[2] memory a_p,
                                    uint[2][2] memory b,
                                    uint[2] memory b_p,
                                    uint[2] memory c,
                                    uint[2] memory c_p,
                                    uint[2] memory h,
                                    uint[2] memory k,
                                    uint[2] memory input
                                )
                        internal
                        pure
                        returns(bytes32)
    {
        return keccak256(abi.encodePacked(a, a_p, b, b_p, c, c_p, h, k, input));
    }

}
// EMG - Declaration of an interface that allows the SolnSquareVerifier contract to call
// functions from the Verifier contract
contract Verifier {
    function verifyTx
                        (
                            uint[2] memory a,
                            uint[2] memory a_p,
                            uint[2][2] memory b,
                            uint[2] memory b_p,
                            uint[2] memory c,
                            uint[2] memory c_p,
                            uint[2] memory h,
                            uint[2] memory k,
                            uint[2] memory input
                        )
                        public
                        returns (bool);
}


























