pragma solidity ^0.6.7;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract PauserRole is AccessControl {

    event PauserAdded(address indexed account);
    event PauserRemoved(address indexed account);

    constructor () internal {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        emit PauserAdded(_msgSender());
    }

    modifier onlyPauser() {
        require(isPauser(_msgSender()), "PauserRole: caller does not have the Pauser role");
        _;
    }

    function isPauser(address account) public view returns (bool) {
        require(account != address(0));
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    function addPauser(address account) public onlyPauser {
        require(!isPauser(account));
        grantRole(DEFAULT_ADMIN_ROLE, account);
        emit PauserAdded(account);
    }

    function renouncePauser() public {
        require(isPauser(_msgSender()));
        renounceRole(DEFAULT_ADMIN_ROLE, _msgSender());
        emit PauserRemoved(_msgSender());
    }

}
