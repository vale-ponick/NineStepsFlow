//
//  martianWaterTank.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 27.10.2026.
//

import Foundation

// MARK: - Задача: «Сколько дней протянет Mark Watney?»
// 📋 ТЗ Сюжет: у Марка есть запас воды. Он тратит 3 литра в день. Вопрос: на сколько дней хватит? И выживет ли до Ares 4 (400 дней)?

struct WaterTank {
    var liters: Int
    
    func daysLeft() -> Int { // вернуть: сколько дней хватит (liters / 3)
        liters / 3
    }
    
    func willSurvive() -> Bool {
        daysLeft() >= 400
        // вернуть: true, если дней >= 400, иначе false
    }
}

func displayWaterTank() {
    let waterTankMW = WaterTank(liters: 1221)
    let daysMW = waterTankMW.daysLeft()
    let isSurvive = waterTankMW.willSurvive()
    print("💧 Water: \(waterTankMW) l., Days: \(daysMW), is survive: \(isSurvive)")
}
/**
 💧 Water: WaterTank(liters: 1221) l., Days: 407, is survive: true
 Program ended with exit code: 0
 */
