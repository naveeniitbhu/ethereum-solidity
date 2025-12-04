// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract WillThrow {
    error NotAllowedError(string);
    function aFunction() public pure {
        // require(false, "Error msg");
        // assert(false);
        revert NotAllowedError("You are not allowed");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);

    function catchTheError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // code
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {
            emit ErrorLogCode(errorCode);
        } catch (bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }
    }
}

// lowLeveldata - has signature and data - web3.utils.toAscii("...."