//
//  markWatneySurvival.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 18.10.2026.
//

import Foundation

// MARK: - 'The Martian' - Mark Watney's Survival: Structural Telemetry
// 🎬 Plot: 'Ares III' has been evacuated. Mark Watney is alone on Mars. He has 300 ration packs. To survive the 400 days until 'Ares IV' arrives, he cuts his daily rations to the minimum. He grows potatoes and uses vitamins and spices. The data is optional: sensors in the Hab can fail, and supplies can be depleted (resulting in nil).
// 🛠 Task: Design a robust life-support module architecture using structs and enums, and practice safe unwrapping of optional values using all available Swift methods. Print the final system report.

/**
1️⃣ Создать архитектуру данных:
   - enum HealthCondition (.stable, .starving, .injured, .critical, .rescued)
   - enum DailyCaloricIntake (.normal, .frugal, .none)
   - struct Resource (инвентарь с опциональными полями: potatoes: Int?, ketchup: Int?, vitamin: Int?, а также rationPacks: Int и др.)
   - struct LogEntry (day: Int, event: String)
   - struct WatneyStatus (diet: DailyCaloricIntake, health: HealthCondition, supplies: Resource, log: [LogEntry])

2️⃣ Extend the WatneyStatus structure via CustomStringConvertible — implement a description property that uses a switch on the current diet or health status to output "rich" engineering logs ("Caloric Reserve Nominal", "Hydroponic Crop Critical").
 
3️⃣ Create a func survivalReport() -> String method within WatneyStatus:
 - Calculate the caloric value of the harvest, safely unwrapping potatoes using the nil-coalescing operator (?? 0).
 - Safely check and unwrap ketchup reserves using the if-let construct.
 - Check for the presence of vital vitamins using the guard-let construct (if nil, return a scurvy report).
 - Get the last event from the log using optional chaining: log.last?.event.
 - Generate a final verdict using the ternary operator: "Will survive 400 days: YES/NO".

4️⃣ Create a simulation execution function, runMartian():
 - Initialize a WatneyStatus instance with full (or partially nil) supplies.
 - Use a switch statement on the optional vitamin property, handling three explicit cases: .some(count) where count > 0, .some(_) when empty, and .none (sensor error).
 - Print a telemetry report using the previously created CustomStringConvertible.

5️⃣ Create an explicit risk function, func unsafeEat(status: WatneyStatus):
 - Demonstrate force unwrap (exclamation point !) by attempting to forcibly retrieve a value from status.supplies.potatoes.
 - Add a technical explanation in the comments why this leads to a runtime crash of the application when nil and why it is strictly prohibited in production.
*/
// Concepts practiced: 1️⃣ (struct + enum + nested optionals) · 2️⃣ (CustomStringConvertible + switch по состояниям) · 3️⃣ (guard let, if let, ??, optional chaining) · 4️⃣ (switch паттерн-матчинг .some/.none) · 5️⃣ (force unwrap crash-test) + тернарный оператор. · 2️⃣ (CustomStringConvertible + switch по состояниям) · 3️⃣ (guard let, if let, ??, optional chaining) · 4️⃣ (switch паттерн-матчинг .some/.none) · 5️⃣ (force unwrap crash-test) + тернарный оператор.

enum HealthCondition {
    case stable, starving, injured, critical, rescued // стабильное состояние, голодающий, раненый, критическое состояние, спасенный
}

enum DailyCaloricIntake { // установленный лимит калорий на один день
    case normal, frugal, none
}
struct Resource {
    // 1. Жизненно важные нутриенты и добавки
    var vitamin: Int?
    var proteinPowder: Int // избыток протеина в пайках
    // 2. Основная еда
    var rationPacks: Int? // стандартные суточные наборы
    var potatoes: Int?
    var coffee: Int?
    // 3. Специи и вкусовые добавки
    var ketchup: Int?
    var oliveOil: Int?
    var salt: Int?
    var pepper: Int?
}

struct LogEntry { // запись в журнале
    let day: Int
    let event: String
}
struct WatneyStatus: CustomStringConvertible {
    let diet: DailyCaloricIntake // режим питания
    var log: [LogEntry] // записи в журнале
    var health: HealthCondition
    var supplies: Resource
    
    var description: String {
        switch diet { // режим питания
        case .normal: return "Режим Ares-3. Доступны стандартные пайки: \(supplies.rationPacks ?? 0). Избыток протеина \(supplies.proteinPowder) "
        case .frugal: return "Экономный режим выживания. Пайки: \(supplies.rationPacks ?? 0). Собранный урожай картофеля: \(supplies.potatoes ?? 0) шт. Кетчуп: \(supplies.ketchup ?? 0) шт."
            
        case .none: return "Критическая ситуация. Ресурсы исчерпаны."
        }
    }
    
    func survivalReport() -> String {
        let potatoCalories = (supplies.potatoes ?? 0) * 770 // расчет калорий картошки
        guard let vitamin = supplies.vitamin else {
            return "There are no vitamins. Mark will get scurvy. There is no point in counting the days of survival."
        }
        var ketchupStatus = ""
        if let ketchup = supplies.ketchup {
            ketchupStatus = "Ketchup left: \(ketchup) pcs."
        } else {
            ketchupStatus = "The ketchup is gone, Mark is choking on dry potatoes (up) pcs."
        }
        let lastLog = log.last?.event ?? "Log entry"
        
        let totalCalories = potatoCalories + (supplies.rationPacks ?? 0) * 2000
        let result = "Will survive 400 days: \((totalCalories / 1500) >= 400  ? "YES" : "NO")"
        
        return "Mark Watney \(lastLog): \(result), supplies enoth \(ketchupStatus)"
    }
}
    
func runMartian() {
    var watney = WatneyStatus(
        diet: DailyCaloricIntake.normal,
        log: [LogEntry(day: 1, event: "wounded, antenna pierced side")],
        health: .injured,
        supplies: Resource(
            vitamin: 300,
            proteinPowder: 4000,
            rationPacks: 300,
            potatoes: nil,
            coffee: 300,
            ketchup: 350,
            oliveOil: 50,
            salt: 300,
            pepper: 300))
    switch watney.supplies.vitamin {
    case .some(let count) where count > 0:
        print("Телеметрия: Витамины в норме, осталось \(count) шт.")
    case .some(_):
        print("Телеметрия КРИТИЧЕСКАЯ: Коробка из-под витаминов пуста!")
    case .none:
        print("Телеметрия ОШИБКА: Датчик витаминов не отвечает (nil)")
    }
    
    print(watney)
    print(watney.survivalReport())
}
func unsafeEat(status: WatneyStatus) {
    // ⚠️ FORCE UNWRAP: при potatoes = nil → runtime crash (fatalError)
    // ! игнорирует флаг .none, Swift runtime вызывает fatalError
    // В продакшене запрещено: падение на живом пользователе
    let potatoes = status.supplies.potatoes!
    print("Mark eats \(potatoes) potatoes")
}

// в runMartian() в конце:
// unsafeEat(status: watney)  // ← раскомментируй, когда захочешь увидеть краш
/**
 Телеметрия: Витамины в норме, осталось 300 шт.
 Режим Ares-3. Доступны стандартные пайки: 300. Избыток протеина 4000
 Mark Watney wounded, antenna pierced side: Will survive 400 days: YES, supplies enoth Ketchup left: 350 pcs.
 Program ended with exit code: 0
 */
