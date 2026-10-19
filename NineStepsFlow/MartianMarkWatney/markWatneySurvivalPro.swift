//
//  markWatneySurvivalPro.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 19.10.2026.
//

import Foundation

/// MARK: - 'Марсианин' — Выживание Марка Уотни:  level Pro - структурная телеметрия
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
