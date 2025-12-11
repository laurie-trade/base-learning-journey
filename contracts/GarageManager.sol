// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GarageManager {
    
    // Custom error
    error BadCarIndex(uint index);
    
    // Car struct
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }
    
    // Mapping of address to array of Cars
    mapping(address => Car[]) public garage;
    
    // Add a car to sender's garage
    function addCar(
        string memory _make, 
        string memory _model, 
        string memory _color, 
        uint _numberOfDoors
    ) public {
        garage[msg.sender].push(Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        }));
    }
    
    // Get all cars owned by the calling user
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }
    
    // Get all cars for any user
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }
    
    // Update a car at a specific index
    function updateCar(
        uint _index,
        string memory _make,
        string memory _model,
        string memory _color,
        uint _numberOfDoors
    ) public {
        // Check if the index exists
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }
        
        // Update the car
        garage[msg.sender][_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }
    
    // Reset sender's garage (delete all cars)
    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}
