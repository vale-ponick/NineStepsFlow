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
    let capVolume = 50
    
    mutating func makeCoffee() {
        if let currentWater = waterTank {
            if currentWater >= capVolume {
                waterTank = currentWater - capVolume
                print("Coffee is ready")
            }
        }
    }
}

func runCoffeeProject() {
    var delonghi = CoffeeMachine(name: "Delonghi", waterTank: 121)
    delonghi.makeCoffee()
}
/**
 Coffee is ready
 Program ended with exit code: 0
 */
