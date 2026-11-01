//
//  roverMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 01.11.2026.
//

import Foundation

// MARK: - 6: Mark's Rover Project

/// Blueprint describing the structure and behavior of the Mars rover.
/// Placed in Stack memory as a Value Type (struct).
struct RoverMW {
    
    // Type Property: A fixed constant shared across all instances.
    static let fuelPerKm = 2 // 2% fuel tank on 1 km
    
    // Instance Properties: Represent the unique state allocated inside each instance in memory.
    var fuel: Int? // Optional Type: Contains an Int value, or nil if the sensor is broken.
    var name: String
    
    var isBroken: Bool {
        fuel == nil
    }
    
    
    /// Mutating Instance Method: Modifies the internal state of the Value Type allocated in the Stack.
    /// - Parameter distance: Input parameter representing the kilometers driven.
    mutating func check(distance: Int) {
        
        // Optional Unwrapping via Optional Binding: Safely extracts the value from the container.
        if let currentFuel = fuel {
            
            // Calculating the total resource cost for the journey based on the Type Property.
            let spentFuel = distance * Self.fuelPerKm
            
            // Conditional Logic: Validating if the instance possesses enough resources.
            if currentFuel >= spentFuel {
                // Mutating the instance: Directly updating the property inside the Stack memory allocation.
                fuel = currentFuel - spentFuel
                print("Rover \(name) is effective")
            } else {
                print("Not enough fuel")
            }
            
        } else {
            // Nil Handling: Executed strictly when the Optional container holds no value.
            print("Sensor is broken!")
        }
    }
}

func reportRover(_ rover: RoverMW) -> String {
    rover.isBroken ? "⛽ no data" : "🚜 \(rover.name): \(rover.fuel ?? 0)%"
}

func runMarkRoverProject() {
    var rover = RoverMW(fuel: 25, name: "Rover 1")
    print(reportRover(rover))
    rover.check(distance: 32)
    print(reportRover(rover))
    
    let broken = RoverMW(fuel: nil, name: "Ghost")
    print(reportRover(broken))
}
/**
 🚜 Rover 1: 25%
 Not enough fuel
 🚜 Rover 1: 25%
 ⛽ no data
 Program ended with exit code: 0
 */
