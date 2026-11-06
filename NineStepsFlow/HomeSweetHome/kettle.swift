//
//  kettle.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 03.11.2026.
//

import Foundation

// MARK: - '🫖 Kettle'
// TS: There's water in the kattle(Int? - sensor might be wrong). To boil it, your need at least 200 ml. func boil(): нет данных (nil) → "📵 Sensor is broken", мало воды (< 200) → "⚠️ Not enough water", достаточно (≥ 200) → уменьшить воду на 200 (испарилась), "🫖 Tea is ready", вывести остаток.

struct Kettle {
    let name: String
    var waterMl: Int?
    
    static let cupVolume = 150 // Rule: константа предметной области (объём чашки, норма температуры) → static сразу.
    static let minWaterMl = 200
    static let maxWaterMl = 1000 // это реально - пригодится, если захочу задачу чуть усложнить
    
    mutating func boil() {
        guard let currentWater = waterMl else {
            print("📵 Sensor is broken")
            return
        }
        if currentWater >= Self.minWaterMl {
            waterMl = currentWater - Self.cupVolume
            print("🫖 Tea is ready")
            print("Remainder water: \(waterMl ?? 0) ml.")
        } else {
            print("Not enough water")
        }
    }
}

func runKettleBoil() {
    var kettle = Kettle(name: "Broun", waterMl: 250)
    kettle.boil()
    
    var notEnough = Kettle(name: "Broun", waterMl: 120)
    notEnough.boil()
    
    var empty = Kettle(name: "Broun", waterMl: nil)
    empty.boil()
}
/**
 🫖 Tea is ready
 Remainder water: 100 ml.
 Not enough water
 📵 Sensor is broken
 Program ended with exit code: 0
 */
