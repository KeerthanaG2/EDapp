pragma solidity ^0.5.0;

/*Contract to allow users to vote for their preferred candidate in an election.*/
contract Election {

    struct Candidate {
        uint id;                         //Struct to represent a candidate
        string name;
        uint voteCount;                  //Number of votes received by the candidate
    }

    mapping(address => bool) public voters; //Mapping to keep track of voters who have already voted
                                            // bool- Whether the voter has already voted

 
    mapping(uint => Candidate) public candidates; //Mapping to store candidate information
                                                  //uint Candidate ID
                                                  //Candidate Struct containing candidate information

    
    uint public candidatesCount;                   //Total number of candidates

    event votedEvent (                             
        uint indexed _candidateId      
    );                                         //Event emitted when a vote is cast
                                               //_candidateId- ID of the candidate voted for

   
    constructor () public {
        addCandidate("Candidate1");
        addCandidate("Candidate2");
    }                                          //Constructor to initialize the contract, // Add two initial candidates

  

    function addCandidate (string memory _name) private {
        /**
         * Example:
         * addCandidate("Candidate3") would add a new candidate with name "Candidate3"
         */
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    

    function vote (uint _candidateId) public {
        /**
         * Example:
         * vote(1) would cast a vote for the candidate with ID 1
         */
        require(!voters[msg.sender], "Voter has already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        emit votedEvent(_candidateId);
    }
}