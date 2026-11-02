//
//  coffeeMachine.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 02.11.2026.
//

import Foundation

// MARK: -📋 TS: 'CoffeeMachine Delonghi'
//  Есть чертеж кофемашины. Она должна уметь выполнять одно действие — варить кофе, уменьшая запас воды в ОЗУ.

struct CoffeeMachine {
    let name: String
    var waterTank: Int?
    static let capVolume = 50
    
    mutating func makeCoffee() {
        if let currentWater = waterTank {
            if currentWater >= Self.capVolume {
                waterTank = currentWater - Self.capVolume
                print("\(name): Coffee is ready")
                print("Water left: \(waterTank ?? 0) ml.")
            } else {
                print("Not enough water")
            }
        } else {
            print("Sensor is broken")
        }
    }
}

func runCoffeeProject() {
    var delonghi = CoffeeMachine(name: "Delonghi", waterTank: 121) // сущность
    delonghi.makeCoffee()
    
    var empty = CoffeeMachine(name: "Delonghi", waterTank: 25) // состояние
    empty.makeCoffee()
    
    var broken = CoffeeMachine(name: "Delonghi", waterTank: nil) // состояние
    broken.makeCoffee()
}
/**
 Delonghi: Coffee is ready
 Water left: 71 ml.
 Not enough water
 Sensor is broken
 Program ended with exit code: 0
 */
