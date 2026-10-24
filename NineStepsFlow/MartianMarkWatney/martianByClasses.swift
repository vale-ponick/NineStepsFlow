//
//  martianByClasses.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 24.10.2026.
//

import Foundation

class MartianMW: CustomStringConvertible {
    var healthMW: MartianHealth
    var dietMW: MartianDiet
    var suppliesMW: MartianResource
    var log: [LogEntry]
    
    init(healthMW: MartianHealth, dietMW: MartianDiet, suppliesMW: MartianResource, log: [LogEntry]) {
        self.healthMW = healthMW
        self.dietMW = dietMW
        self.suppliesMW = suppliesMW
        self.log = log
    }
    
    func simulateDayMW(dayMW: Int) {
        switch dietMW {
        case .normal:
            suppliesMW.rationPacks -= 1
            log.append(LogEntry(
                day: dayMW, event: "Штатный режим. Полноценное питание.")
            )
        case .frugal:
            if let count = suppliesMW.potatoesCount {
                let eatenMW = min(3, count)
                suppliesMW.potatoesCount = count - eatenMW
                log.append(LogEntry(day: dayMW, event: "🚨 Пайки закончились. Съел \(eatenMW) картофелин(ы), осталось \(suppliesMW.potatoesCount ?? 0)."))
                if suppliesMW.rationPacks == 0 {
                    healthMW = .starving
                }
                if let ketcupCount = suppliesMW.ketchup, ketcupCount > 0 {
                    suppliesMW.ketchup = ketcupCount - 1
                }
            } else {
                log.append(LogEntry(day: dayMW, event: "⚠️ Картошки нет - голод"))
                healthMW = .starving
            }
            
        case .none:
            suppliesMW.rationPacks = 0
            suppliesMW.potatoesCount = nil
            suppliesMW.ketchup = nil
            
            log.append(LogEntry(
                day: dayMW, event: "Supplies are almost gone. The situation is critical.")
            )
            healthMW = .critical
        }
        
        let packsMW = suppliesMW.rationPacks // 2. Считываем актуальные данные на конец дня
        let potatoesMW = suppliesMW.potatoesCount ?? 0
        
        // 3. NOTA BENE: Автомат переключений (State Machine)
        if packsMW > 0 && dietMW != .normal {
            dietMW = .normal
            log.append(LogEntry(day: dayMW, event: "🔄 Пайки доступны — переключение на NORMAL"))
        } else if packsMW == 0 && potatoesMW > 0 && dietMW != .frugal {
            dietMW = .frugal
            healthMW = .starving
            log.append(LogEntry(day: dayMW, event: "🔄 Пайки на нуле — переключение на FRUGAL"))
        } else if packsMW == 0 && potatoesMW == 0 && dietMW != .none {
            dietMW = .none
            healthMW = .critical
            log.append(LogEntry(day: dayMW, event: "🔄 Ресурсы исчерпаны — переключение на NONE"))
        }
    } // 4. ВОТ ЗДЕСЬ метод simulateDayMW закрывается финальной скобкой '}'
    
    var description: String {
        "\(dietMW) | \(healthMW) | packs:\(suppliesMW.rationPacks) potatoes:\(suppliesMW.potatoesCount ?? 0) ketchup:\(suppliesMW.ketchup ?? 0) vitamin:\(suppliesMW.hasVitamins ? "yes" : "no")"
    }
}
func runMartianByClasses() { // create экземпляр класса Mark Wanney as 'let'
    let markWatney = MartianMW(
        healthMW: .stable,
        dietMW: .normal,
        suppliesMW: MartianResource(rationPacks: 6, potatoesCount: 15, ketchup: 4),
        log: []
    )
    
    print(" -- START SUPPLIES (CLASS-CONSTANT) --")
    print(markWatney) // print start panel
    
    for day in 1...12 {
        markWatney.simulateDayMW(dayMW: day)
        print("Sol \(day): \(markWatney)")
    }
    
    print(" --- LOGBOOK ---")
    for entry in markWatney.log {
        print("Sol \(entry.day): \(entry.event)")
    }
}
/**
 -- START SUPPLIES (CLASS-CONSTANT) --
🪐 | ✅ | packs:6 potatoes:15 ketchup:4 vitamin:yes
Sol 1: 🪐 | ✅ | packs:5 potatoes:15 ketchup:4 vitamin:yes
Sol 2: 🪐 | ✅ | packs:4 potatoes:15 ketchup:4 vitamin:yes
Sol 3: 🪐 | ✅ | packs:3 potatoes:15 ketchup:4 vitamin:yes
Sol 4: 🪐 | ✅ | packs:2 potatoes:15 ketchup:4 vitamin:yes
Sol 5: 🪐 | ✅ | packs:1 potatoes:15 ketchup:4 vitamin:yes
Sol 6: 🚨 | 🔥 | packs:0 potatoes:15 ketchup:4 vitamin:yes
Sol 7: 🚨 | 🔥 | packs:0 potatoes:12 ketchup:3 vitamin:yes
Sol 8: 🚨 | 🔥 | packs:0 potatoes:9 ketchup:2 vitamin:yes
Sol 9: 🚨 | 🔥 | packs:0 potatoes:6 ketchup:1 vitamin:yes
Sol 10: 🚨 | 🔥 | packs:0 potatoes:3 ketchup:0 vitamin:no
Sol 11: 📉 | 🆘 | packs:0 potatoes:0 ketchup:0 vitamin:no
Sol 12: 📉 | 🆘 | packs:0 potatoes:0 ketchup:0 vitamin:no
 --- LOGBOOK ---
Sol 1: Штатный режим. Полноценное питание.
Sol 2: Штатный режим. Полноценное питание.
Sol 3: Штатный режим. Полноценное питание.
Sol 4: Штатный режим. Полноценное питание.
Sol 5: Штатный режим. Полноценное питание.
Sol 6: Штатный режим. Полноценное питание.
Sol 6: 🔄 Пайки на нуле — переключение на FRUGAL
Sol 7: 🚨 Пайки закончились. Марк Уотни съел 3 картфелин(ы), осталось 12.
Sol 8: 🚨 Пайки закончились. Марк Уотни съел 3 картфелин(ы), осталось 9.
Sol 9: 🚨 Пайки закончились. Марк Уотни съел 3 картфелин(ы), осталось 6.
Sol 10: 🚨 Пайки закончились. Марк Уотни съел 3 картфелин(ы), осталось 3.
Sol 11: 🚨 Пайки закончились. Марк Уотни съел 3 картфелин(ы), осталось 0.
Sol 11: 🔄 Ресурсы исчерпаны — переключение на NONE
Sol 12: Supplies are almost gone. The situation is critical.
Program ended with exit code: 0
 */

