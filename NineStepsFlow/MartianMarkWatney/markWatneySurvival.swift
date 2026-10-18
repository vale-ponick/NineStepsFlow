//
//  markWatneySurvival.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 18.10.2026.
//

import Foundation

/// MARK: - 'Марсианин' — Выживание Уотни: математика 1500 ккал
// 🎬 Сюжет: Ares 3 эвакуирован, Марк Уотни остался один на Марсе. У него 300 пайков. Чтобы протянуть 400 дней до прибытия 'Ares IV', он урезает дневной рацион с 2000 ккал до min 1500 ккал. Он сажает картошку, чтобы добрать калории, используя витамины и оставшийся кетчуп. Часть данных опциональна — сенсоры могут молчать, запасы могут быть израсходованы.
// 🛠 Задача: Создать enum Resource, enum Status (для сенсоров), struct LogEntry и struct WatneyStatus с опциональными полями. Написать функцию, которая безопасно разворачивает урожай картошки через ??, обрабатывает кетчуп через if let и проверяет витамины через guard let. Вывести финальный отчёт о выживании.
/**
1️⃣ Создать enum и struct: Resource (.calories, .potatoes, .ketchup, .vitamins), Status (.nominal, .depleted, .unknown), LogEntry (day: Int, event: String), WatneyStatus (mealPacks: Int, harvestedPotatoes: Int?, ketchupBottles: Int?, hasVitamins: Bool?, log: [LogEntry]).

2️⃣ Расширить Resource через CustomStringConvertible — свойство description со switch для «богатых» технических логов ("Caloric Reserve", "Hydroponic Potato Crop").

3️⃣ Создать func survivalReport() -> String в WatneyStatus: посчитать суммарные дни через ?? 0 для картошки (770 ккал/кг). Безопасно развернуть кетчуп через if let и проверить витамины через guard let. Последнее событие в журнале — через log.last?.event (optional chaining). Завершить тернарником: "Will survive 400 days: yes/no".

4️⃣ Создать экземпляр WatneyStatus внутри runMartian(). Использовать if let для проверки статуса перед печатью. Использовать switch по hasVitamins — три кейса: .some(true) / .some(false) / .none. Использовать CustomStringConvertible для WatneyStatus, чтобы напечатать чистый блок телеметрии.

5️⃣ Создать func unsafeEat(status:) с status.harvestedPotatoes! без проверки. В комментарии — почему краш при nil и почему так нельзя.
*/
// Связки: 1️⃣ (struct + enum + optionals) · 2️⃣ (CustomStringConvertible) · 3️⃣ (guard let, if let, ??, ?.) · 4️⃣ (switch .some/.none) · 5️⃣ (force unwrap) + новые методы: тернарник, if let, optional chaining.

enum HealthCondition {
    case stable, starving, injured, critical, rescued
}

enum DailyCaloricIntake { // установленный лимит калорий на один день
    case normal, frugal, none
}
struct Resource {
    // 1. Жизненно важные нутриенты и добавки
    var vitamin: Int
    var proteinPowder: Int // избыток протеина в пайках
    // 2. Основная еда
    var rationPacks: Int // стандартные суточные наборы
    var potatoes: Int
    var coffee: Int
    // 3. Специи и вкусовые добавки
    var ketchup: Int
    var oliveOil: Int
    var salt: Int
    var pepper: Int
}

struct LogEntry { // запись в журнале
    let day: Int
    let event: String
}
struct WatneyStatus {
    let diet: DailyCaloricIntake // режим питания
    var log: [LogEntry] // записи в журнале
    var health: HealthCondition
    var supplies: Resourse
    
    
    
}
