pragma solidity ^0.5.0;

contract insurance {

    address owner;
    address regulator;
    address bank;
    uint insuranceCount = 0;
    uint farmerCount = 0;

    struct farmer {
        bool isUidGenerated;
        string firstName;
        string lastName;
        uint insuranceId;
        string residence;
        uint landArea; //in square metres
        string landNumber; //string with a format of 'state/district/tehsil/village/section/number'
        string landCoordinates;
    }

    struct policy {
        uint farmerId;
        bool isUidGenerated;
        uint premiumAmount;
        string startDate;
        string expiryDate;
        uint totalCoverAmount;
        bool isClaimed;
        bool isSigned;
        bool paid;
    }

    mapping (uint => farmer) public farmermapping;
    mapping (uint => policy) public policymapping;

    event PolicyClaimed( address indexed _farmerId, address indexed _policyId);
    event PolicyVerified();

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender,
        "Sender not authorized"
        );
        _;
    }

    modifier signed(){
        require(msg.sender == regulator,
        "Not an authorized regulator"
        );
        _;
    }



    //function test(bytes32 data) public pure returns (address) {
   //     return address(uint160(uint256(data)));
   // }


    function setPolicy(
        uint _totalCoverAmount,
        uint _premiumAmount,
        string memory _startDate,
        string memory _expiryDate
    ) public returns(uint) {
        uint insuranceId = insuranceCount++;
       // address insuranceId = test(insuranceIdBytes);
        require(!policymapping[insuranceId].isUidGenerated,
        "insurance id already exists!");
        policymapping[insuranceId].isUidGenerated = true;
        policymapping[insuranceId].premiumAmount = _premiumAmount;
        policymapping[insuranceId].totalCoverAmount = _totalCoverAmount;
        policymapping[insuranceId].startDate = _startDate;
        policymapping[insuranceId].expiryDate = _expiryDate;

        return insuranceId;
    }

    function getPolicy(uint _insuranceId) public view returns(uint, uint, string memory, string memory) {
        policy storage p = policymapping[_insuranceId];
        return (
            p.totalCoverAmount,
            p.premiumAmount,
            p.startDate,
            p.expiryDate

        );
    }

    function setFarmerData(
        string memory _firstName,
        string memory _lastName,
        uint _insuranceId,
        string memory _residence,
        uint _landArea,
        string memory _landNumber,
        string memory _landCoordinates
    ) public returns(uint) {
       // uint uniqueId = sha256(abi.encodePacked(msg.sender, now));
       uint uniqueId = farmerCount++;
       // address uniqueId = test(uniqueIdBytes);
        require(!farmermapping[uniqueId].isUidGenerated,
        "unique id already exists!");
        farmermapping[uniqueId].isUidGenerated = true;
        farmermapping[uniqueId].firstName = _firstName;
        farmermapping[uniqueId].lastName = _lastName;
        farmermapping[uniqueId].insuranceId = _insuranceId;
        farmermapping[uniqueId].residence = _residence;
        farmermapping[uniqueId].landArea = _landArea;
        farmermapping[uniqueId].landNumber = _landNumber;
        farmermapping[uniqueId].landCoordinates = _landCoordinates;
        policymapping[_insuranceId].farmerId = uniqueId;

        return uniqueId;
    }

    function createClaim(uint _insuranceId) public returns(string memory ) {
        policymapping[_insuranceId].isClaimed = true;
       // emit PolicyClaimed(policymapping[_insuranceId].farmerId, _insuranceId);
        string memory  response = "Your claim is sent for verification";
        return response;
    }

    function verifyClaim(uint _insuranceId) public returns(string memory ) {
        require(!policymapping[_insuranceId].isSigned,
        "policy is already verified by a regulator");
        policymapping[_insuranceId].isSigned = true;
        emit PolicyVerified();
        string memory  response = "Claimed verified by regulator";
        return response;
    }

    function payClaim(uint _insuranceId) public returns (string memory){
        require(!policymapping[_insuranceId].paid,
        "claim has been settled already");
        policymapping[_insuranceId].paid = true;
        string memory response = "Claim is now paid";
        return response;
    }

    function getPolicyStatus(uint _insuranceId, uint _farmerId) public view returns(
        string memory, string memory, uint, bool, bool, bool
     ) {
        policy storage p = policymapping[_insuranceId];
        farmer storage f = farmermapping[_farmerId];
        return(
            f.firstName,
            f.lastName,
            p.totalCoverAmount,
            p.isClaimed,
            p.isSigned,
            p.paid
        );
    }

}