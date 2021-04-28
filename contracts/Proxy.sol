pragma solidity 0.8.4;

// Lets say the imports work

contract Proxy {
    address storageAddress;
    address upgradeableAddress;
    address owner;

    address[] storageList;
    address[] upgradebleList;

    constructor() {
        owner = msg.sender;
        storageAddress = address(new Storage());
        upgradeableAddress = address(new Upgradeable(storageAddress));
        storageList.push(storageAddress);
        upgradebleList.push(upgradeableAddress);
    }

    receive() external payable {
    }

    function () external {
        // This could be done to call another address its fn
        (success,) = upgradeableAddress.delegateCall(msg.data);
        require(success);
        // Could also be done if fn is always the same
        //address(upgradeableAddress).call{value: msg.value}(abi.encodeWithSignature("someFn(someType)", "data"));
    }

    function upgradeStorage(address _address) public onlyOwner {
        require(storageAddress != _address);
        storageAddress = _address;
        storageList.push(storageAddress);
    }

    function upgradeUpgradeable(address _address) public onlyOwner {
        require(upgradeableAddress != _address);
        upgradeableAddress = _address;
        upgradebleList.push(upgradeableAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


}
