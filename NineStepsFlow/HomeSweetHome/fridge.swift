//
//  fridge.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 03.11.2026.
//

import Foundation

// '🧊 Fridge'
// TS: The fridge has a temp in fridge(Int? - sensor may be broken). The normal temp is between 2 and 8°C. Any higher neans - 'food will spoil', any lower means - 'everything is frozen'. Method checkTemp() reports the status.

enum FridgeStatus {
    case normal, lower, higher, noData
    
    init(temp: Int?) {
        guard let temp else {
            self = .noData
            return
        }
        switch temp {
        case 2...8:
            self = .normal
        case ...1:
            self = .lower
        default:
            self = .higher
        }
    }
    var description: String {
        switch self {
        case .normal:
            return "🧊 The fridge is working perfectly 🥦 / 🍎 (Normal)."
        case .lower:
            return "⚠️ Temperature is too low! ❄️ Everything is frozen"
        case .higher:
            return "⚠️ Temperature is too high! 🔥 Food will spoil"
        case .noData:
            return "📵 Sensor is broken"
        }
    }
}

/* struct Fridge: TempFridge {
    static let minTemp = 2
    static let maxTemp = 8
    
    let name: String
    var temp: Int? // nil <- fridge is broken
    
    // mutating func checkTemp() не нужна! он не меняет свойства структуры - он их описывает! а если бы он их переключал как в совр. холодильниках - менял темп-ру в отд. секциях - вот тогда нужен мутирующий/меняющий значение?/свойства сами? метод
} */
func runFridgeStatus() {
    let currentStatus = FridgeStatus(temp: 7)
    print(currentStatus.description)
    
    let lower = FridgeStatus(temp: -3)
    print(lower.description)
    
    let higher = FridgeStatus(temp: 12)
    print(higher.description)
    
    let noData = FridgeStatus(temp: nil)
    print(noData.description)
}

/**
 🧊 The fridge is working perfectly 🥦 / 🍎 (Normal).
 ⚠️ Temperature is too low! ❄️ Everything is frozen
 ⚠️ Temperature is too high! 🔥 Food will spoil
 📵 Sensor is broken
 Program ended with exit code: 0
 */
