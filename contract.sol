pragma solidity ^0.4.17;

contract DecentralizedElectionSystem {

    // Store Candidate Count
    uint public candidateCount = 0;

    mapping(uint => Candidate) public candidates;

    // Address of the creator
    address public manager;

    struct Candidate {
        uint _id;
        string _name;
        uint age;
        string sex;
        uint candidateVotes;
    }

    // Store Voter Status
    mapping(address => uint) public status;

    function addCandidate(string memory _name, uint age, string memory sex) private {
        candidates[candidateCount] = Candidate(candidateCount, _name, age, sex, 0);
        candidateCount += 1;
    }

    constructor() public {
        manager=msg.sender;
        addCandidate("Ameer Talha", 24, "Male");
        addCandidate("Monjure Mowla Abir", 24, "Male");
        addCandidate("Nipun Paul", 24, "Male");
        addCandidate("Mutakabbirul Islam Pranto", 24, "Male");
    }

    // Casting Vote
    function castVote(uint index) public payable {
        require(status[msg.sender] == 0, "You have already voted!!");
        Candidate storage candidate = candidates[index];
        candidate.candidateVotes++;
        status[msg.sender] = 1;
    }

    function showCount(uint _id) view public returns (uint) {
        return candidates[_id].candidateVotes;
    }

    function showStatus(address _address) view public returns (uint) {
        return status[_address];
    }

    // Add Candidate through Button
    function addCandidateButton(string memory _name, uint _age, string memory _sex) public {
        require(msg.sender==manager, "You must be the Election Commissioner!!");
        addCandidate(_name, _age, _sex);
    }

}
