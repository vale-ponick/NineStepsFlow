//
//  oxygenSuppliesMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 28.10.2026.
//

import Foundation

// MARK: - '1️⃣ 💨 Кислород — static let + computed'. TS: баллон даёт 120 часов. Баллонов — 85. Сол = 24 часа. До Ares 4 — 400 солов.

struct OxygenSupply {
    static let hoursPerCanister = 121
    static let canisters = 87
    static let hoursPerSol = 24
    static let solsUntilAres4 = 400
    
    var totalHours: Int {
        Self.hoursPerCanister * Self.canisters
    }
    
    var daysLeft: Int {
        totalHours / Self.hoursPerSol
    }
    var willSurvive: Bool {
        daysLeft >= Self.solsUntilAres4
    }
}

func calcOxygenSupplies() {
    let suppliesOxygenMW = OxygenSupply()
    print("Oxygen supplies: \(suppliesOxygenMW.totalHours) | Days: \(suppliesOxygenMW.daysLeft) | Survive: \(suppliesOxygenMW.willSurvive ? "✅" : "🆘")")
}
/**
 Oxygen supplies: 10527 | Days: 438 | Survive: ✅
 Program ended with exit code: 0
 */
