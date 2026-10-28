//
//  dietMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 28.10.2026.
//

import Foundation

// MARK: - '3️⃣ 🥫 Food mode for Mark Watney'
// TS: У Марка осталось 300 пайков. Каждый паек — 2000 ккал. Он меняет режим: .normal — ест 2000 ккал/день (норма) .frugal — ест 1500 ккал/день (экономия) .none — ест 0 ккал/день (голодовка). Вопрос: сколько дней протянет в каждом режиме? Вывод: для каждого режима — « N дней в режиме X».

enum Diet: Int {
    case normal = 2000
    case frugal = 1500
    case none = 0
}

struct Packs {
    static let caloriesPerPack = 2000
    let packsCount = 300
    let dietMW: Diet

    var totalCalories: Int {
        packsCount * Self.caloriesPerPack // 600 000
    }
    var daysLeft: Int {
        switch dietMW {
        case .normal: return totalCalories / 2000
        case .frugal: return totalCalories / 1500
        case .none: return 0
        }
    }
}
extension Packs: CustomStringConvertible {
    var description: String {
        "\(daysLeft) дней в режиме \(dietMW)"
    }
}

func calcDaysPerEachDiet() {
    let normal = Packs(dietMW: .normal)
    print("🥫 \(normal.daysLeft) days in diet \(normal.dietMW)")

    let frugal = Packs(dietMW: .frugal)
    print("🥫 \(frugal.daysLeft) days in diet \(frugal.dietMW)")

    let none = Packs(dietMW: .none)
    print("\(none.daysLeft) days in diet \(none.dietMW)")
}
/**
 🥫 300 days in diet normal
 🥫 400 days in diet frugal
 0 days in diet none
 Program ended with exit code: 0
 */
