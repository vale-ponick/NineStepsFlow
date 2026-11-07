//
//  airTankMarkWatney.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 07.11.2026.
//

import Foundation

// MARK: - 'система кислорода Марка Уотни'
// В Hab есть кислородный баллон - AirTank. У него есть: currentAir: Int — текущий запас кислорода, стартует со 100 единиц; maxSafeAir: Int — верхний предел, 600 (выше — разрыв клапана); minSafeAir: Int — нижний предел, 30 (ниже — Марк задыхается). Есть канистра (Canister) с одним свойством: oxygen: Int — сколько кислорода в ней.

struct Canister {
    let oxygen: Int
}

struct AirTank {
    var currentAir: Int = 100
    
    static let maxSafeAir: Int = 600 // выше -> разрыв клапана
    static let minSafeAir: Int = 30 // ниже -> Марк Уотни задыхается
    
    mutating func refill(_ canister: Canister) { // метод
        let totalAir = currentAir + canister.oxygen // создай let - всего кислорода у Марка Уотни
        
        guard totalAir <= Self.maxSafeAir else {
            print("❌ Stop! Valve rupture. Will be \(totalAir) units") // оставляем как есть
            return // early exit
        }
        currentAir = totalAir
        print("✅ OK! Oxygen: \(currentAir) units")
    }
    
    mutating func consume(_ canister: Canister) {
        let remainderAir = currentAir - canister.oxygen // отключение/расход канистры
        guard remainderAir >= Self.minSafeAir else {
            print("❌ Stop! Mark is gasping for air. Will be \(remainderAir) units")
            return
        }
        currentAir = remainderAir
        print("✅ OK! Oxygen: \(currentAir) units")
    }
}

func checkAirSupply() {
    var airTankMW = AirTank(currentAir: 100)
    airTankMW.refill(Canister(oxygen: 250))
    airTankMW.refill(Canister(oxygen: 400))
    airTankMW.consume(Canister(oxygen: 250))
    airTankMW.consume(Canister(oxygen: 90))
}
/**
 ✅ OK! Oxygen: 350 units
 ❌ Stop! Valve rupture. Will be 750 units
 ✅ OK! Oxygen: 100 units
 ❌ Stop! Mark is gasping for air. Will be 10 units
 Program ended with exit code: 0
 */
