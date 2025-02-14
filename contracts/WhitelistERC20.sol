// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract WhitelistERC20 is ERC20, AccessControl, Ownable, ERC20Permit {
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant WIPER_ROLE = keccak256("WIPER_ROLE");
    bytes32 public constant KYC_ROLE = keccak256("KYC_ROLE");
    bytes32 public constant BLACKLISTED_ROLE = keccak256("BLACKLISTED_ROLE");
    bool private _isKYCable;
    bool private _isBlacklistable;
    uint8 private _decimals;

    event KYCableStatusChanged(bool enabled);
    event BlacklistableStatusChanged(bool enabled);

    error KYCableStatusUnchanged(bool currentStatus);
    error BlacklistableStatusUnchanged(bool currentStatus);
    error BlacklistedError(address account);
    error KYCNotApprovedError(address account);

    constructor(
        address initialOwner
    )
        ERC20("USD WT TEST", "USDWT")
        Ownable(initialOwner)
        ERC20Permit("USD WT TEST")
    {
        _mint(msg.sender, 10000000 * 10 ** decimals());
        _mint(
            0x7a2d40F9c3B4c5ff1f6a7549E24aaA3F94c1b3BE,
            10000000 * 10 ** decimals()
        );

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(WIPER_ROLE, msg.sender);
        _grantRole(KYC_ROLE, msg.sender);
        _grantRole(UPGRADER_ROLE, msg.sender);

        _isKYCable = true;
        _isBlacklistable = true;
        _decimals = 2;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function isKYCable() public view virtual returns (bool) {
        return _isKYCable;
    }

    function isBlacklistable() public view virtual returns (bool) {
        return _isBlacklistable;
    }

    function setKYCableStatus(
        bool enabled
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        if (_isKYCable == enabled) {
            revert KYCableStatusUnchanged(enabled);
        }
        _isKYCable = enabled;
        emit KYCableStatusChanged(enabled);
    }

    function setBlacklistableStatus(
        bool enabled
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        if (_isBlacklistable == enabled) {
            revert BlacklistableStatusUnchanged(enabled);
        }
        _isBlacklistable = enabled;
        emit BlacklistableStatusChanged(enabled);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        _canTransfer(_msgSender(), to);
        return super.transfer(to, amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        _canTransfer(from, to);
        return super.transferFrom(from, to, amount);
    }

    function _checkBlacklistStatus(address account) internal view {
        if (_isBlacklistable && hasRole(BLACKLISTED_ROLE, account)) {
            revert BlacklistedError(account);
        }
    }

    function _checkKYCStatus(address account) internal view {
        if (_isKYCable && !hasRole(KYC_ROLE, account)) {
            revert KYCNotApprovedError(account);
        }
    }

    function _canTransfer(address from, address to) internal view {
        _checkBlacklistStatus(from);
        _checkBlacklistStatus(to);
        _checkKYCStatus(from);
        _checkKYCStatus(to);
    }
}
