pragma solidity ^0.5.0;

contract insurance {

    address owner;
    address regulator;
    address bank;

    struct farmer {
        bool isUidGenerated;
        string firstName;
        string lastName;
        uint farmerId;
        string residence;
        uint landArea; //in square metres
        string landNumber; //string with a format of 'state/district/tehsil/village/section/number'
        string landCoordinates;
    }

    struct policy {
        uint insuranceId;
        bool isUidGenerated;
        uint premiumAmount;
        string startDate;
        string expiryDate;
        uint totalCoverAmount;
        bool isClaimed;
        bool isSigned;
        bool paid;
    }

    uint[] insuranceIDs;
    uint[] farmerIDs;
    uint insuranceCoverCount;
    uint farmerCount;

    mapping (uint => farmer) public farmermapping;
    mapping (uint => policy) public policymapping;

    event PolicyClaimed( address indexed _farmerId, address indexed _policyId);
    //event PolicyVerified();

    constructor() public {
        owner = msg.sender;
        insuranceCoverCount = 0;
        farmerCount = 0;
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
    ) public payable returns(uint) {
        uint insuranceId = (insuranceCoverCount++)+1000;
        insuranceIDs.push(insuranceId);
        policy memory newPolicy;

        // Set all values of the new contract
        newPolicy.insuranceId = insuranceId;
        //require(!policymapping[insuranceId].isUidGenerated,
        //"insurance id already exists!");
        newPolicy.isUidGenerated = true;
        newPolicy.premiumAmount = _premiumAmount;
        newPolicy.totalCoverAmount = _totalCoverAmount;
        newPolicy.startDate = _startDate;
        newPolicy.expiryDate = _expiryDate;
        policymapping[insuranceId] = newPolicy;

        return insuranceId;
    }

    function getInsuranceList() public view returns (uint[] memory){
        return insuranceIDs;
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
        uint _uniqueId,
        string memory _residence,
        uint _landArea,
        string memory _landNumber,
        string memory _landCoordinates
    ) public returns(uint) {
       // bytes32 uniqueId = sha256(abi.encodePacked(msg.sender, now));
       //uint uniqueId = farmerCount++;
       // address uniqueId = test(uniqueIdBytes);
        //require(!farmermapping[uniqueId].isUidGenerated,
        //"unique id already exists!");
        uint uniqueId = (farmerCount++)+2000;
        farmerIDs.push(uniqueId);
        farmer memory newFarmer;
        newFarmer.isUidGenerated = true;
        newFarmer.firstName = _firstName;
        newFarmer.lastName = _lastName;
        //newFarmer.insuranceId = _insuranceId;
        newFarmer.farmerId = _uniqueId;
        newFarmer.residence = _residence;
        newFarmer.landArea = _landArea;
        newFarmer.landNumber = _landNumber;
        newFarmer.landCoordinates = _landCoordinates;
        farmermapping[uniqueId] = newFarmer;

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
        //emit PolicyVerified();
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