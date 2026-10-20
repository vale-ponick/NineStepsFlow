//
//  markWatneySurvival.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 18.10.2026.
//

import Foundation

/// MARK: - 'Марсианин' — Выживание Марка Уотни: структурная телеметрия
// 🎬 Сюжет: 'Ares III' эвакуирован. Марк Уотни остался один на Марсе. У него есть 300 базовых пайков. Чтобы протянуть 400 дней до прибытия 'Ares IV', он урезает дневной рацион до min. Он выращивает картошку, использует витамины и специи. Данные опциональны: сенсоры в жилом модуле могут отказывать, а запасы — исчерпываться (приводить к nil).
// 🛠 Задача: Спроектировать надежную архитектуру модулей жизнеобеспечения на structs + enums, отработать безопасное развертывание опциональных значений всеми доступными в Swift способами. Вывести финальный отчет системы.

/**
1️⃣ Создать архитектуру данных:
   - enum HealthCondition (.stable, .starving, .injured, .critical, .rescued)
   - enum DailyCaloricIntake (.normal, .frugal, .none)
   - struct Resource (инвентарь с опциональными полями: potatoes: Int?, ketchup: Int?, vitamin: Int?, а также rationPacks: Int и др.)
   - struct LogEntry (day: Int, event: String)
   - struct WatneyStatus (diet: DailyCaloricIntake, health: HealthCondition, supplies: Resource, log: [LogEntry])

2️⃣ Расширить структуру WatneyStatus через CustomStringConvertible — реализовать свойство description, использующее switch по текущему статусу здоровья (health) или режиму питания (diet) для вывода «богатых» инженерных логов ("Caloric Reserve Nominal", "Hydroponic Crop Critical").

3️⃣ Создать метод func survivalReport() -> String внутри WatneyStatus:
   - Посчитать калорийность урожая, безопасно развернув potatoes через оператор nil-coalescing (?? 0).
   - Безопасно проверить и развернуть запасы кетчупа через конструцию if let.
   - Проверить наличие жизненно важных витаминов через guard let (если nil — возвращать отчет о цинге).
   - Получить последнее событие из бортового журнала, используя optional chaining: log.last?.event.
   - Сформировать финальный вердикт с помощью тернарного оператора: "Will survive 400 days: YES/NO".

4️⃣ Создать функцию выполнения симуляции runMartian():
   - Инициализировать экземпляр WatneyStatus с заполненными (или частично nil) припасами.
   - Использовать switch по опциональному свойству витаминов, обрабатывая три явных кейса: .some(true), .some(false) и .none (ошибка сенсора).
   - Распечатать отчет о телеметрии, используя созданный ранее CustomStringConvertible.

5️⃣ Создать функцию явного риска func unsafeEat(status: WatneyStatus):
   - Продемонстрировать force unwrap (восклицательный знак !), попытавшись принудительно достать значение из status.supplies.potatoes.
   - Добавить в комментарии техническое объяснение, почему это приводит к рантайм-крашу приложения при nil и почему в промышленной разработке это категорически запрещено.
*/
// Связки: 1️⃣ (struct + enum + nested optionals) · 2️⃣ (CustomStringConvertible + switch по состояниям) · 3️⃣ (guard let, if let, ??, optional chaining) · 4️⃣ (switch паттерн-матчинг .some/.none) · 5️⃣ (force unwrap crash-test) + тернарный оператор.

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
