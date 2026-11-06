//
//  waterSuppliesMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 28.10.2026.
//

import Foundation

// MARK: - '🪐 Water supplies for Mark Watney'
// TS 2️⃣: Марк на Марсе. Датчик уровня воды сломан — показывает либо число, либо nil (неизвестно, есть ли вода). Он тратит 3 литра в день. Вопрос: сколько дней протянет Maрк Уотни? Если датчик мёртв (нет данных) — сообщить, что неизвестно. Если данные есть — «💧 N л, ⚠️ хватит на M дней». Если нет — «📵 датчик сломан, 🆘 данных нет».

struct WaterSupplies {
    static let waterPerDay = 3
    let waterTank: Int?
    
    var report: String {
        guard let waterDays = waterTank else {
            return "📵 The sensor is broken, 🆘 there is no data"
        }
        return "💧 \(waterDays) l., ⚠️ enough for \(waterDays / Self.waterPerDay) days."
    }
}
    
func calcWaterSupplies() {
    let tank = WaterSupplies(waterTank: 1221)
    print(tank.report)   // 💧 1221 l., ⚠️ хватит на 407 days.

    let broken = WaterSupplies(waterTank: nil)
    print(broken.report) // 📵 датчик сломан, 🆘 данных нет
}
/**
 💧 1221 l., ⚠️ enough for 407 days.
 📵 The sensor is broken, 🆘 there is no data
 Program ended with exit code: 0
 */
