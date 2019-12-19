pragma solidity ^0.5.0;

contract icertisHack {
    address owner;

    struct Farmer {
        string firstName;
        string lastName;
        uint farmerId;
        string residence;
        uint landArea; //in square metres
        string landNumber; //string with a format of 'state/district/tehsil/village/section/number'
        string landCoordinates;
        
    }

    struct Policy {
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

    constructor() public {
        owner = msg.sender;
    }

    Farmer[] public farmers;
    Policy[] public policies;

    mapping(address => Farmer) private insuranceHolders;
    mapping(address => Policy) private premiumHolders;

    

    

}