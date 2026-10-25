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

1. static let maxEnergy: Double = 100.0
   — свойство типа, константа, лимит энергии

2. var meteoriteLoad: Double = 0.0 + didSet
   — хранимое, наблюдатель
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
