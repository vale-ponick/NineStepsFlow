//
//  markWatneySurvivalPro.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 19.10.2026.
//

import Foundation

/// MARK: - 'Martian: Survival Mark Watney: - level Pro
// 🎬 Сюжет: 'Ares III' эвакуирован. Марк Уотни остался один на Марсе. У него есть 300 базовых пайков. Чтобы протянуть 400 дней до прибытия 'Ares IV', он урезает дневной рацион до min. Он выращивает картошку, использует витамины и кетчуп. Данные опциональны: запасы — исчерпываются (nil).
// 🛠 Задача: Спроектировать надежную архитектуру модулей жизнеобеспечения на structs + enums, отработать безопасное развертывание опциональных значений всеми доступными в Swift способами. Вывести финальный отчет системы.

enum MartianHealth: String, CustomStringConvertible {
    case stable = "✅"
    case starving = "🔥"
    case critical = "🆘"
    
    var description: String { rawValue }
}
enum MartianDiet: String, CustomStringConvertible {
    case normal = "🪐"
    case frugal = "🚨"
    case none = "📉"
    
    var description: String { rawValue }
}

struct MartianResource {
    var rationPacks: Int
    var potatoesCount: Int? // на старте nil, потом - увеличиваются
    var ketchup: Int?
    
    var hasVitamins: Bool {
        (ketchup ?? 0) > 0 && (potatoesCount ?? 0) > 0
    }
}
struct MartianStatus: CustomStringConvertible {
    var diet: MartianDiet
    var health: MartianHealth
    var supplies: MartianResource
    var log: [String]
    
    mutating func simulateDay(day: Int) {
        switch diet {
        case .normal:
            supplies.rationPacks -= 1
            log.append("🪐 Day \(day): Normal — 1 pack (left: \(supplies.rationPacks))")
            
        case .frugal:
            if supplies.rationPacks > 0 {
                supplies.rationPacks -= 1
                log.append("🚨 Day \(day): Frugal — 1 pack (left: \(supplies.rationPacks)), potatoes: \(supplies.potatoesCount ?? 0)")
            } else {
                health = .starving
            }
            
            guard let count = supplies.potatoesCount else {
                log.append("⚠️ Day \(day): No potatoes — sensor broken, starving")
                health = .starving
                return
            }
            let eaten = min(3, count)
            supplies.potatoesCount = count - eaten
            
            if supplies.rationPacks == 0 { // 🔄 Лог ПОСЛЕ еды — показывает актуальные числа
                log.append("🚨 Day \(day): Only potatoes — packs: 0, ate \(eaten), left: \(supplies.potatoesCount ?? 0)")
            }
            if (supplies.potatoesCount ?? 0) < 3 {
                log.append("⚠️ Day \(day): Potatoes low — \(supplies.potatoesCount ?? 0) left, ate \(eaten)")
            }
            if let k = supplies.ketchup, k > 0 {
                supplies.ketchup = k - 1
            }
        case .none:
            if supplies.potatoesCount != nil {
                supplies.potatoesCount = nil
                log.append("📉 Day \(day): Critical — no potatoes, ketchup \(supplies.ketchup ?? 0) left but useless")
            }
        }
        
        // 🔄 ПРОВЕРКА ПЕРЕХОДА — в конце дня, для всех режимов
        let packs = supplies.rationPacks
        let potatoes = supplies.potatoesCount ?? 0
        
        if packs > 0 && diet != .normal {
            diet = .normal
            log.append("🔄 Day \(day): Packs available — switching to NORMAL")
        } else if packs == 0 && potatoes > 0 && diet != .frugal {
            diet = .frugal
            log.append("🔄 Day \(day): Only potatoes — switching to FRUGAL")
        } else if packs == 0 && potatoes == 0 && diet != .none {
            diet = .none
            health = .critical
            log.append("🔄 Day \(day): Nothing left — switching to NONE")
        }
    }
    var description: String {
         "Diet: \(diet), health: \(health), 📦 packs: \(supplies.rationPacks), 🥔 potatoesCount: \(supplies.potatoesCount ?? 0), 🍅 ketchup: \(supplies.ketchup ?? 0), vitamins: \(supplies.hasVitamins ? "yes" : "no")"
     }
}

    
func runMartianPro() {
    var watney = MartianStatus(
        diet: .normal,
        health: .stable,
        supplies: MartianResource(rationPacks: 6, potatoesCount: 15, ketchup: 4),
        log: []
    )
    print("--- START SUPPLIES ---")
       print(watney)
    for day in 1...12 {
        watney.simulateDay(day: day)
        print("Сол \(day): \(watney)")
    }
    
    print("=== FINAL DESCRIPTION ===")
       print(watney)
}
/**
 --- START SUPPLIES ---
 Diet: 🪐, health: ✅, 📦 packs: 6, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 1: Diet: 🪐, health: ✅, 📦 packs: 5, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 2: Diet: 🪐, health: ✅, 📦 packs: 4, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 3: Diet: 🪐, health: ✅, 📦 packs: 3, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 4: Diet: 🪐, health: ✅, 📦 packs: 2, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 5: Diet: 🪐, health: ✅, 📦 packs: 1, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 6: Diet: 🚨, health: ✅, 📦 packs: 0, 🥔 potatoesCount: 15, 🍅 ketchup: 12, vitamins: yes
 Сол 7: Diet: 🚨, health: 🔥, 📦 packs: 0, 🥔 potatoesCount: 12, 🍅 ketchup: 11, vitamins: yes
 Сол 8: Diet: 🚨, health: 🔥, 📦 packs: 0, 🥔 potatoesCount: 9, 🍅 ketchup: 10, vitamins: yes
 Сол 9: Diet: 🚨, health: 🔥, 📦 packs: 0, 🥔 potatoesCount: 6, 🍅 ketchup: 9, vitamins: yes
 Сол 10: Diet: 🚨, health: 🔥, 📦 packs: 0, 🥔 potatoesCount: 3, 🍅 ketchup: 8, vitamins: yes
 Сол 11: Diet: 📉, health: 🆘, 📦 packs: 0, 🥔 potatoesCount: 0, 🍅 ketchup: 7, vitamins: no
 Сол 12: Diet: 📉, health: 🆘, 📦 packs: 0, 🥔 potatoesCount: 0, 🍅 ketchup: 0, vitamins: no
 === FINAL DESCRIPTION ===
 Diet: 📉, health: 🆘, 📦 packs: 0, 🥔 potatoesCount: 0, 🍅 ketchup: 0, vitamins: no
 Program ended with exit code: 0
 */
