//
//  disgwasher.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 04.11.2026.
//

import Foundation

// MARK: - '🍽️ Dishwasher'
// 📋 ТЗ Dishwasher + static + computed

struct Dishwasher {
    static let maxTabs = 10          // свойство доступное/const во всей структуре
    static let waterPerCycle = 12
    
    let model: String
    var tabsCount: Int
    var isWaterSupplyOk: Bool?    // nil - sensor broken, true - there is woter, false - water is absent
    
    var cyclesLeft: Int {            // computed — сколько циклов осталось
        tabsCount
    }

    mutating func startCycle() { // 1. датчик воды
    guard let sensorWaterSupply = isWaterSupplyOk else { // гарантируй, что isWaterSupplyOk НЕ nil! сли nil → print + выход
        print ("📵 Water sensor is broken")
        return
    }
        if sensorWaterSupply == false { // 2. нет воды
            print("❌ No water supply")
            return
        }
        if tabsCount == 0 { // 3. нет таблеток
            print("❌ No tabs left!")
            return
        }
        if tabsCount > Self.maxTabs { // 4. слишком много таблеток
            print("⚠️ Too many tabs")
            return
        }
        tabsCount -= 1
        print("🧼 Washing cycle started. Tabs left: \(tabsCount)")
    }
}

func runDishwasher() {
    var dish = Dishwasher(model: "Bosh", tabsCount: 7, isWaterSupplyOk: true)
    dish.startCycle()
    
    var noTabs = Dishwasher(model: "Bosh", tabsCount: 0, isWaterSupplyOk: true)
    noTabs.startCycle()
    
    var noWater = Dishwasher(model: "Bosh", tabsCount: 6, isWaterSupplyOk: false)
    noWater.startCycle()
    
    var overload = Dishwasher(model: "Bosh", tabsCount: 13, isWaterSupplyOk: true)
    overload.startCycle()
    
    var broken = Dishwasher(model: "Bosh", tabsCount: 5, isWaterSupplyOk: nil)
   broken.startCycle()
}
/**
 🧼 Washing cycle started. Tabs left: 6
 ❌ No tabs left!
 ❌ No water supply
 ⚠️ Too many tabs
 📵 Water sensor is broken
 Program ended with exit code: 0
 
  LOGIC:
  
  «Dishwasher — value type, экземпляр в Stack. Size = 16 (String) + 8 (Int) + 1 (Bool?) + 7 (padding) = 32 stride, 25 size. static let —  НЕ в экземпляре. computed — 0 байт.»
 */
