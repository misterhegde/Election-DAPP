pragma solidity ^0.4.19;

//@title A simple election DApp
//@author Aditya Hegde
//@dev this piece does not have an event yet
//@notice add events while attaching with client side

contract Election {

	struct Candidate {   //candidate attributes
		uint id;
		string name;
		uint vote;
		
	}

	mapping (uint => Candidate) public candidates;   //a mapping to store the candidates
	mapping (address => bool) voters;    //a mapping to keep track of voters by their address
	
	uint public candidateCount;   //to track the number of candidates

	constructor() public {      // add 2 candidates when the smart contract is deployed
		_addCandidate("candi1");
		_addCandidate("candi2");
		
	}
	
	//@warning if this function is called, contract has to be deployed again
	function _addCandidate(string _name) private {    //function to add more candidates
		candidateCount ++;							 
			
		candidates[candidateCount] = Candidate(candidateCount, _name, 0);
	}

	function vote(uint candidateId) external {

		//requires that the voter has not voted yet
		require(!voters[msg.sender]);

		//requires that the voter to enter the correct candidate Id
		require(candidateId > 0 && candidateId <= candidateCount);
		
		//record the voter in a mapping 
		voters[msg.sender] = true;
		//add a vote to the candidate
		candidates[candidateId].vote ++;
		
	}
	}
	
