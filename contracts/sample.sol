pragma solidity ^0.5.0;

contract CarInsurance {
    address contractOwner;

    struct PolicyHolder {
        string name;
        string vehiclePlateNumber;
        address policyOwnerAddress;
        address premium;

    }

    struct Premium {
        address premiumOwnerAddress;
        uint amountOfEther;
        string name;
        uint duration;
        string description;
    }

    // set contract owner on first deploy contract
    constructor() public {
        contractOwner = msg.sender;
    }

    PolicyHolder[] public policyHolders;
    Premium[] public premiumArHolders;

    // mapping structs with address as key
    mapping(address => PolicyHolder) private insuranceHolders;
    mapping(address => Premium) private premiumHodlers;

    // policy holder length
    function getInsuranceHolders() public view returns (uint) {
        return policyHolders.length;
    }

    // insurance offer array length
    function getPremiumHolders() public view returns (uint) {
        return premiumArHolders.length;
    }

    // import new insurance offer
    function addPremiumHolders(string memory _name, uint _amount, uint _duration, string memory _description) public payable returns (uint){

        require(msg.value > .01 ether);

        premiumHodlers[msg.sender].premiumOwnerAddress = msg.sender;
        premiumHodlers[msg.sender].amountOfEther = _amount;
        premiumHodlers[msg.sender].name = _name;
        premiumHodlers[msg.sender].duration = _duration;
        premiumHodlers[msg.sender].description = _description;

        //contractOwner.transfer(msg.value);

        premiumArHolders.length++;
        premiumArHolders[premiumArHolders.length-1].premiumOwnerAddress = msg.sender;
        premiumArHolders[premiumArHolders.length-1].amountOfEther = _amount;
        premiumArHolders[premiumArHolders.length-1].name = _name;
        premiumArHolders[premiumArHolders.length-1].duration = _duration;
        premiumArHolders[premiumArHolders.length-1].description = _description;

        return premiumArHolders.length;
    }

    // claim new insurance package
    function requestInsurance(string memory _name, string memory _plate, uint index ) public payable {

        require(msg.value >= premiumArHolders[index].amountOfEther);

        insuranceHolders[msg.sender].name = _name;
        insuranceHolders[msg.sender].vehiclePlateNumber = _plate;
        insuranceHolders[msg.sender].policyOwnerAddress = msg.sender;
        insuranceHolders[msg.sender].premium = premiumArHolders[index].premiumOwnerAddress;
        policyHolders.length++;
        policyHolders[policyHolders.length-1].name = _name;
        policyHolders[policyHolders.length-1].vehiclePlateNumber = _plate;
        policyHolders[policyHolders.length-1].policyOwnerAddress = msg.sender;
        policyHolders[policyHolders.length-1].premium = premiumArHolders[index].premiumOwnerAddress;

       // premiumArHolders[index].premiumOwnerAddress.transfer(this.balance);
    }

    // check if address is insured
    function isInsured() public view returns (bool) {
        return insuranceHolders[msg.sender].policyOwnerAddress == msg.sender;
    }

    // returns insured info
    function getInsuranceInfo() public view returns (string memory, string memory, uint, string memory, uint, string memory) {  // name, plate, amountOfEther, brokername, duration, description

        return(insuranceHolders[msg.sender].name,
                insuranceHolders[msg.sender].vehiclePlateNumber,
                premiumHodlers[insuranceHolders[msg.sender].premium].amountOfEther,
                premiumHodlers[insuranceHolders[msg.sender].premium].name,
                premiumHodlers[insuranceHolders[msg.sender].premium].duration,
                premiumHodlers[insuranceHolders[msg.sender].premium].description);
    }

}