// SPDX-FileCopyrightText: © 2021 USDC Foundation <www.daifoundation.org>
// SPDX-License-Identifier: AGPL-3.0-or-later
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity ^0.8.14;

import {PsmAbstract} from "dss-interfaces/dss/PsmAbstract.sol";
import {ID3MPool} from "./ID3MPool.sol";

interface VatLike {
    function live() external view returns (uint256);
    function hope(address) external;
    function nope(address) external;
}

interface D3mHubLike {
    function vat() external view returns (address);
    function end() external view returns (EndLike);
}

interface EndLike {
    function Art(bytes32) external view returns (uint256);
}

// yvUSDC - https://etherscan.io/token/0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE
interface YvErc20Like {
    function totalAssets() external view returns (uint256);
    function maxAvailableShares() external view returns (uint256);
    function pricePerShare() external view returns (uint256);
    function decimals() external view returns (uint8);
    function balanceOf(address) external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function approve(address, uint256) external returns (bool);
    function increaseAllowance(address, uint256) external returns (bool);
    function decreaseAllowance(address, uint256) external returns (bool);
    function deposit(uint256, address) external returns (uint256);
    function withdraw(uint256, address) external returns (uint256);
}

contract D3MyvUSDCPool is ID3MPool {
    bytes32 public immutable ilk;
    PsmAbstract public immutable psm;
    YvErc20Like public immutable yvUsdc;

    mapping (address => uint256) public wards;

    event Rely(address indexed usr);
    event Deny(address indexed usr);

    modifier auth {
        require(wards[msg.sender] == 1, "D3MCompoundPool/not-authorized");
        _;
    }

    constructor(bytes32 ilk_, address psm_, address yvUsdc_) {
        ilk = ilk_;
        psm = PsmAbstract(psm_);
        yvUsdc = YvErc20Like(yvUsdc_);
    }

    // --- Admin ---
    function rely(address usr) external auth {
        wards[usr] = 1;
        emit Rely(usr);
    }

    function deny(address usr) external auth {
        wards[usr] = 0;
        emit Deny(usr);
    }

    /**
        @notice Deposit assets (USDC) in the external pool.
        @dev If the external pool requires a different amount to be passed in, the
        conversion should occur here as the Hub passes USDC amounts.
        msg.sender must be the hub.
        @param amt amount in asset (USDC) terms that we want to deposit
    */
    function deposit(uint256 amt) external {}

    /**
        @notice Withdraw assets (USDC) from the external pool.
        @dev If the external pool requires a different amount to be passed in
        the conversion should occur here as the Hub passes USDC amounts.
        msg.sender must be the hub.
        @param amt amount in asset (USDC) terms that we want to withdraw
    */
    function withdraw(uint256 amt) external {}

     /**
        @notice Exit proportional amount of shares.
        @dev If the external pool/token contract requires a different amount to be
        passed in the conversion should occur here as the Hub passes Gem
        amounts. msg.sender must be the hub.
        @param dst address that should receive the redeemable tokens
        @param amt amount in Gem terms that we want to withdraw
    */
    function exit(address dst, uint256 amt) external {}

    /**
        @notice Transfer all shares from this pool.
        @dev msg.sender must be authorized.
        @param dst address that should receive the shares.
    */
    function quit(address dst) external {}

    /**
        @notice Some external pools require actions before debt changes
    */
    function preDebtChange() external {}

    /**
        @notice Some external pools require actions after debt changes
    */
    function postDebtChange() external {}

    /**
        @notice Balance of assets this pool "owns".
        @dev This could be greater than the amount the pool can withdraw due to
        lack of liquidity.
        @return uint256 number of assets in USDC
    */
    function assetBalance() external view returns (uint256) {}

    /**
        @notice Maximum number of assets the pool could deposit at present.
        @return uint256 number of assets in USDC
    */
    function maxDeposit() external view returns (uint256) {}

    /**
        @notice Maximum number of assets the pool could withdraw at present.
        @return uint256 number of assets in USDC
    */
    function maxWithdraw() external view returns (uint256) {}

    /// @notice returns address of redeemable tokens (if any)
    function redeemable() external view returns (address) {}
}
