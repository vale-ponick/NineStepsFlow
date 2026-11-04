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

    mutating func startCycle() {
        print("проверка автосохранения Xcode!")
        print("добавила строку - изменила файл - для проверки автосохранения")
    }
}
/**
 LOGIC:
 
 «Dishwasher — value type, экземпляр в Stack. Size = 16 (String) + 8 (Int) + 1 (Bool?) + 7 (padding) = 32 stride, 25 size. static let —  НЕ в экземпляре. computed — 0 байт.»
 */
func  runStartDishwasher() {
    print("проверка автосохранения Xcode!")
}
