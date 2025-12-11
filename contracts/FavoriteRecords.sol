// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    
    // Custom error
    error NotApproved(string albumName);
    
    // State variables
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;
    
    // Array to keep track of approved album names (for getApprovedRecords)
    string[] private approvedRecordsList;
    
    // Constructor to load approved records
    constructor() {
        // Load the 9 approved albums
        string[9] memory albums = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];
        
        for (uint i = 0; i < albums.length; i++) {
            approvedRecords[albums[i]] = true;
            approvedRecordsList.push(albums[i]);
        }
    }
    
    // Get list of all approved records
    function getApprovedRecords() public view returns (string[] memory) {
        return approvedRecordsList;
    }
    
    // Add a record to user's favorites (only if approved)
    function addRecord(string memory _albumName) public {
        if (!approvedRecords[_albumName]) {
            revert NotApproved(_albumName);
        }
        userFavorites[msg.sender][_albumName] = true;
    }
    
    // Get a user's favorite records
    function getUserFavorites(address _user) public view returns (string[] memory) {
        uint count = 0;
        
        // First pass: count how many favorites the user has
        for (uint i = 0; i < approvedRecordsList.length; i++) {
            if (userFavorites[_user][approvedRecordsList[i]]) {
                count++;
            }
        }
        
        // Create array with correct size
        string[] memory favorites = new string[](count);
        
        // Second pass: populate the array
        uint index = 0;
        for (uint i = 0; i < approvedRecordsList.length; i++) {
            if (userFavorites[_user][approvedRecordsList[i]]) {
                favorites[index] = approvedRecordsList[i];
                index++;
            }
        }
        
        return favorites;
    }
    
    // Reset the sender's favorites
    function resetUserFavorites() public {
        for (uint i = 0; i < approvedRecordsList.length; i++) {
            delete userFavorites[msg.sender][approvedRecordsList[i]];
        }
    }
}
