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
    static let dailyConsumption = 3 // одна константа на весь тип WaterTank, не на экземпляр
    static let daysUntilAres4 = 400
    
    var liters: Int
    
    var daysLeft: Int {
        liters / Self.dailyConsumption // Self — обращение к типу изнутри метода (свифтовее, чем WaterTank.dailyConsumption)
    }
    
    var willSurvive: Bool {
        daysLeft >= Self.daysUntilAres4 // Self. — читается как «этот тип»
    }
}
extension WaterTank: CustomStringConvertible {
    var description: String {
        "\(liters) l."
    }
}

func displayWaterTank() {
    let waterTankMW = WaterTank(liters: 1221)
    print("💧 Water: \(waterTankMW), Days: \(waterTankMW.daysLeft), will survive: \(waterTankMW.willSurvive)")
}
/**
 💧 Water: WaterTank(liters: 1221) l., Days: 407, will survive: true
 Program ended with exit code: 0
 */
