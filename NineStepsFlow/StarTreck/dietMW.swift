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
        "🥫 \(daysLeft) days in food mode \(dietMW)"
    }
}

func calcDaysPerEachDiet() {
    let normal = Packs(dietMW: .normal)
    let frugal = Packs(dietMW: .frugal)
    let none = Packs(dietMW: .none)

    print(normal)
    print(frugal)
    print(none)
}
/**
 🥫 300 days in food mode normal
 🥫 400 days in food mode frugal
 🥫 0 days in food mode none
 Program ended with exit code: 0
 */
