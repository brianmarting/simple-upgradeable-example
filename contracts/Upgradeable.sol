pragma solidity 0.8.4;

contract Upgradeable {
    address storageContract;

    constructor(address _storageContract) {
        storageContract = _storageContract;
    }

    function buyTokens() public {
        Storage(storageContract).setTokens(10);
    }
}

contract Storage {
    uint number;

    function setTokens(uint _number) public {
        number = _number;
    }
}
