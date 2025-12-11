// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address[] public senders;
    uint[] public timestamps;
    
    // Return the complete numbers array
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }
    
    // Reset numbers to 1-10 (gas efficient - no push)
    function resetNumbers() public {
        numbers = [1,2,3,4,5,6,7,8,9,10];
    }
    
    // Append an array to numbers
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }
    
    // Save caller address and timestamp
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }
    
    // Filter timestamps after Y2K (Jan 1, 2000)
    // Returns timestamps > 946702800 and their corresponding senders
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        
        // First pass: count how many timestamps are after Y2K
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }
        
        // Create arrays with correct size
        uint[] memory recentTimestamps = new uint[](count);
        address[] memory recentSenders = new address[](count);
        
        // Second pass: populate the arrays
        uint index = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                recentTimestamps[index] = timestamps[i];
                recentSenders[index] = senders[i];
                index++;
            }
        }
        
        return (recentTimestamps, recentSenders);
    }
    
    // Reset senders array
    function resetSenders() public {
        delete senders;
    }
    
    // Reset timestamps array
    function resetTimestamps() public {
        delete timestamps;
    }
}
