//
//  foodSuppliesMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 28.10.2026.
//

import Foundation

// MARK: - '🥔 ЕSupplies Of Mark Watney:  is that enough?'
// '📋: Mark Watney has packs and potatoes. The packs are 2,000 kcal each. The potatoes are 770 kcal per kg. He's saving: 1,500 kcal per day. Question: how many days will that last? And will he survive until Ares 4 (400 days)? Is that enough?'

struct FoodSupply {
    static let dailyMinCalories = 1500 // экономный режим
    static let daysUntilAres4 = 400
    static let caloriesPerPack = 2000
    static let caloriesPerKgPotato = 770
    
    var rationPacks: Int // кол-во пайков
    var potatoesKg: Int // картошка в кг
    
    var totalCalories: Int { // общее кол-во калорий
        rationPacks * Self.caloriesPerPack + potatoesKg * Self.caloriesPerKgPotato
    }
    
    var daysLeft: Int { // кол-во дней с пищей
        totalCalories / Self.dailyMinCalories
    }
    
    var willSurvive: Bool {
        daysLeft >= Self.daysUntilAres4
    }
}

extension FoodSupply: CustomStringConvertible {
    var description: String {
        "🎒 \(rationPacks) 🥫 + \(potatoesKg) 🥔 = \(totalCalories) kcal"
    }
}

func calcDays() {
    let suppliesMW = FoodSupply(rationPacks: 285, potatoesKg: 55)
    print("Supplies of Mark Watney: \(suppliesMW) | Days left: \(suppliesMW.daysLeft) | Survive: \(suppliesMW.willSurvive ? "✅" : "🆘")")
    let hungryMW = FoodSupply(rationPacks: 13, potatoesKg: 21)
    print("Hungry Mark Watney: \(hungryMW) | Days left: \(hungryMW.daysLeft) | Survive: \(hungryMW.willSurvive ? "✅" : "🆘")")
}
/**
 Total calories: 🎒 285 🥫 + 55 🥔 = 612350 kcal | Days left: 408 | Survive: ✅
 Hungry Mark Watney: 🎒 13 🥫 + 21 🥔 = 42170 kcal | Days left: 28 | Survive: 🆘
 Program ended with exit code: 0
 */
