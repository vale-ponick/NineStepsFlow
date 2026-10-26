//
//  spaceStation.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 25.10.2026.
//

import Foundation

// MARK: - 📋 ТЗ: SpaceStation
/**
# 📋 ТЗ: «SpaceStation — бортовой компьютер»

## 🎬 Сюжет
Ты — бортовой компьютер орбитальной станции. Метеориты бьют по щиту.
Нужно отслеживать нагрузку и подавать сигнал тревоги при перегрузе.

## 🛠 Модель: struct SpaceStation

1. static let maxEnergy: Double = 100.0 // свойство типа

2. var meteoriteLoad: Double = 0.0 + didSet // хранимое, наблюдатель
   — если meteoriteLoad > maxEnergy → print("⚠️ КРИТИЧЕСКИЙ ПЕРЕГРУЗ ЩИТА!")

3. var isDangerZone: Bool — computed
   — true/false по превышению лимита
   — памяти не занимает

4. Два mutating func:
   - smallMeteorHit() → += 15.0
   - bigMeteorHit() → += 40.0

## ✅ Критерий «готово»
- smallMeteorHit() ×3 → load = 45 (норм)
- bigMeteorHit() ×2 → load = 125 → didSet печатает «⚠️ ПЕРЕГРУЗ»
- isDangerZone → true после перегруза
- Всё в консоль

## 💡 Вопросы (ответить в комментарии)
1. Почему maxEnergy — static let, а не var?
2. Почему isDangerZone — computed, а не хранимое?
3. Почему методы — mutating?
4. Сколько байт занимает SpaceStation в Stack?
*/

struct SpaceStation {
    static let maxEnergy: Double = 100.0 // // 1. Свойство типа (глобальная константа для всех станций)
    
    var airSupplyPercent: Int? = 100 // Опциональный паёк с пломбой
    var meteoriteLoad: Double = 0.0 { // 2. Хранимое свойство с наблюдателем
        didSet { // Сигнализация шлюза. Как только давление упало, сирена сразу завыла.
        if meteoriteLoad > SpaceStation.maxEnergy {
            print("⚠️ КРИТИЧЕСКИЙ ПЕРЕГРУЗ ЩИТА!")
        }
    }
}
    // 3. Вычисляемое свойство (памяти не занимает)
    var isDangerZone: Bool { // Запрос телеметрии. Пока Хьюстон не спросит «Где ровер?», процессор координаты не считает.
        return meteoriteLoad > SpaceStation.maxEnergy
    }
    // 4. Модифицирующие методы (изменяют байты структуры в Stack)
    mutating func smallMeteorHit() {
        meteoriteLoad += 15.0
    }
    
    mutating func bigMeteorHit() {
        meteoriteLoad += 40.0
    }
    mutating func emergencyEvacuation() {
        if isDangerZone {
            print("🚨 ЗАПУСК СИСТЕМЫ ЭВАКУАЦИИ! МАРК, БЕГИ К MAV!")
        }
    }
}
// MARK: - Проверка сценария ТЗ
func displaySpaceStation() {
    print("--- 🛰️ ЗАПУСК БОРТОВОГО КОМПЬЮТЕРА ---")
    var starTreck = SpaceStation()
    
    // Сценарий 1: Три мелких удара
    print("\n[Симуляция]: ☄️ Три мелких метеорита бьют по щиту...")
    starTreck.smallMeteorHit()
    starTreck.smallMeteorHit()
    starTreck.smallMeteorHit()
    print("Текущая нагрузка: 🔋 \(starTreck.meteoriteLoad) ГВт")
    print("Критическая зона? — 🚨 \(starTreck.isDangerZone)")
    
    // Сценарий 2: Два крупных удара (вызовут didSet)
    print("\n[Симуляция]: Внимание! ☄️ Два крупных метеорита на встречном курсе!")
    starTreck.bigMeteorHit()
    starTreck.bigMeteorHit()
    
    print("Итоговая нагрузка щита: 🛡️ \(starTreck.meteoriteLoad) ГВт")
    print("Startreck in danger zone? — 🚨 \(starTreck.isDangerZone)")
    print("Размер станции в Стеке: \(MemoryLayout<SpaceStation>.size) байт")
}
/**
 --- 🛰️ ЗАПУСК БОРТОВОГО КОМПЬЮТЕРА ---

 [Симуляция]: ☄️ Три мелких метеорита бьют по щиту...
 Текущая нагрузка: 🔋 45.0 ГВт
 Критическая зона? — 🚨 false

 [Симуляция]: Внимание! ☄️ Два крупных метеорита на встречном курсе!
 ⚠️ КРИТИЧЕСКИЙ ПЕРЕГРУЗ ЩИТА!
 Итоговая нагрузка щита: 🛡️ 125.0 ГВт
 Startreck in danger zone? — 🚨 true
 Размер станции в Стеке: 24 байт
 Program ended with exit code: 0

  💡 ОТВЕТЫ НА ИНЖЕНЕРНЫЕ ВОПРОСЫ:

  1️⃣ Почему maxEnergy — static let, а не var?
     — `static let` объявляет глобальную константу типа. Лимит прочности щита одинаков для любой
       станции этого класса во Вселенной. Выделять под эту константу память на Стеке внутри каждого
       отдельного экземпляра структуры неэффективно. Она хранится отдельно в глобальном сегменте данных.

  2️⃣ Почему isDangerZone — computed, а не хранимое?
     — Хранимое свойство дублировало бы данные и занимало лишнюю память. `isDangerZone` — это флаг,
       который полностью зависит от `meteoriteLoad`. Делать его вычисляемым (`computed`) логичнее:
       он не расходует ОЗУ, а процессор быстро вычисляет выражение «на лету» только при запросе.

  3️⃣ Почему методы — mutating?
     — `SpaceStation` — это структура (`struct`), то есть тип значения (Value Type). По умолчанию методы
       структур не могут изменять свои свойства. Ключевое слово `mutating` дает процессору легальное
       право перезаписать биты текущей структуры (`self`) прямо внутри выделенной ячейки Стека.

  4️⃣ Сколько байт занимает SpaceStation в Stack?
     — Физически структура занимает **8 байт** памяти на Стеке. Внутри неё хранится только одно
       собственное поле данных — `var meteoriteLoad: Double` (Double весит 8 байт).
       Свойство `maxEnergy` уведено в глобальную статическую память, а вычисляемое свойство
       `isDangerZone` весит 0 байт, так как является скрытой функцией.
*/
