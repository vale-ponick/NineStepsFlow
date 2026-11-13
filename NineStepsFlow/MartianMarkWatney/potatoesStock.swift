//
//  potatoesStock.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 13.11.2026.
//

import Foundation

// MARK: - Mark Watney has a PotatoStore in the Hab. It stores his supply of potatoes—the foundation of his survival. The warehouse has a capacity: it can't physically hold more than 400 potatoes. Mark periodically harvests and consumes part of the supply. But he's in a hurry and can make mistakes: Trying to harvest zero or a negative amount is pointless; Harvesting more than he can hold means the potatoes will spill onto the floor; Eating more than he can eat means there's nothing left to eat. Therefore, the Hub program checks every action and rejects it if it would lead to a pointless or dangerous state. Sometimes Mark just needs to see how many potatoes he has (stock)—without changing anything, just reading the number.

struct PotatoesStore {
    var potatoes: Int = 0 // instance property (состояние)
    let capacity: Int = 400
    
    mutating func harvest(amount: Int) {
        guard amount > 0 else {
            print("❌ amount must be > 0")
            return
        }
        
        let current = potatoes + amount // check parameter + instance property = нужен РАСЧЕТ
        guard current <= capacity else {
            print("❌ not enough space: \(current) > \(capacity)")
            return
        }
        potatoes = current
        print("✅ OK! Potatoes: \(potatoes) of \(capacity)")
    }
    
    mutating func consume(amount: Int) {
        guard amount > 0 else {
            print("❌ amount must be > 0")
            return
        }
        let current = potatoes - amount
        guard current >= 0 else {
            print("❌ not enough potatoes: \(potatoes) < \(amount)")
            return
        }
        potatoes = current
        print("✅ OK! Ate \(amount). Potatoes: \(potatoes) of \(capacity)")
    }
    
    func stock() -> String {
        return "Картофелин: \(potatoes) из \(capacity)"
    }
}

func getPotatoesStore() {
    var storeMW = PotatoesStore(potatoes: 333)
    storeMW.harvest(amount: 120)
    storeMW.harvest(amount: 52)
    storeMW.consume(amount: 333)
    storeMW.consume(amount: 52)
    storeMW.consume(amount: 1)
    print(storeMW.stock())
}
/**
 ❌ not enough space: 453 > 400
 ✅ OK! Potatoes: 385 of 400
 ✅ OK! Ate 333. Potatoes: 52 of 400
 ✅ OK! Ate 52. Potatoes: 0 of 400
 ❌ not enough potatoes: 0 < 1
 Картофелин: 0 из 400
 Program ended with exit code: 0
 */
