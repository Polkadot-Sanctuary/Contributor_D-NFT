// SPDX-License-Identifier: Apache-2.0
// Author: Bali Sanctuary Team
pragma solidity ^0.8.17;

contract DNFT {

    mapping (address => uint256) NFT_score;
    mapping (address => uint256) LastContribution;
    mapping (address => bool) Provers;

    modifier onlyProvers {
        require(Provers[msg.sender] = true);
        _;
    }

    constructor () {
        Provers[msg.sender] = true;
    }

    function mint() external {
        require(NFT_score[msg.sender] < 1, "Your NFT is already minted.");
        NFT_score[msg.sender] = 1;
    }

    function my_score() external view returns (uint256) {
        return NFT_score[msg.sender];
    }

    function redeem_reward(uint256 _number_of_petals) external returns (uint256){
        require(_number_of_petals < 63);
        require(NFT_score[msg.sender] > _number_of_petals);
        NFT_score[msg.sender] = NFT_score[msg.sender] - _number_of_petals;
        return (_number_of_petals);
    }

    function add_1_petal(address _contributor) external onlyProvers returns (uint256) {
        require(NFT_score[_contributor] >= 1, "User needs to mint the NFT first.");
        require(NFT_score[_contributor] < 64, "WOW! Max was already level reached!");
        NFT_score[_contributor] = NFT_score[_contributor] + 1;
        LastContribution[_contributor] = block.timestamp;
        return NFT_score[_contributor];
    }

    function add_prover(address _new_prover) external onlyProvers returns (address) {
        Provers[_new_prover] = true;
        return _new_prover;
    }
}
