// SPDX-FileCopyrightText: © 2022 Dai Foundation <www.daifoundation.org>
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
import {ID3MPlan} from "./ID3MPlan.sol";

contract D3MyvUSDCPlan is ID3MPlan {
    PsmAbstract public immutable psm;

    constructor(address psm_) {
        psm = PsmAbstract(psm_);
    }

    /**
        @notice Determines what the position should be based on current assets
        and the custom plan rules.
        @param currentAssets asset balance from a specific pool in Dai [wad]
        denomination
        @return uint256 target assets the Hub should wind or unwind to in Dai
    */
    function getTargetAssets(uint256 currentAssets) external view returns (uint256) {

    }

    /// @notice Reports whether the plan is active
    function active() external view returns (bool) {

    }

    /**
        @notice Disables the plan so that it would instruct the Hub to unwind
        its entire position.
        @dev Implementation should be permissioned.
    */
    function disable() external {

    }
}
