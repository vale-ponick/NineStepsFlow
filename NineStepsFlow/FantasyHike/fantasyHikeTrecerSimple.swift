//
//  fantasyHikeTrecerSimple.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 11.10.2026.
//

import Foundation

// MARK: - 'Fantasy Hike Trecer' - Simple
// Technical Specification:
// MARK: - Project: Analytical Module for the FantasyHike Hike
/** Business logic: Converting steps taken into kilometers, calculating the delta to the target indicator (7 km), and determining the transition completion status. */


// MARK: - 🔗 WORKED LINKS (FROM 9 KEY SWIFT CONCEPTS)
// 1️⃣ «Моделирование состояния» (Struct + Stored Properties через let)
//      Изолируем жесткие входные параметры,      исключая их случайное изменение извне.
// 2️⃣ «Динамическая аналитика» (Computed Properties через var)
//      Вычисляем производные метрики             (расстояние, остаток) на лету без         выделения лишней памяти.
// 3️⃣ «Функциональные предикаты» (Computed Properties типа Bool в одну строку)
//      Заменяем громоздкие конструкции           if-else чистой математической логикой.

// MARK: - 🗺️ PROCESS BLOCKCHART (DATA FLOW & LOGIC)
/*
   [ВХОДНЫЕ ДАННЫЕ (Stored Properties)]
   ├── stepCount (Double)       -> Фактически сделанные шаги
   └── dailyTargetInKm (Double) -> Целевая дистанция (по умолчанию 7.0)
                 │
                 ▼
   [ДИНАМИЧЕСКИЙ ПЕРЕСЧЕТ (Computed Properties)]
   ├── distanceInKm ───────────► Формула: (stepCount * 0.7) / 1000
   └── remainingDistanceInKm ──► Формула: dailyTargetInKm - distanceInKm
                 │
                 ▼
   [ЛОГИЧЕСКИЙ ПРЕДИКАТ (isTargetAchieved)]
                 │
   /─────────────┴─────────────\
  /                             \
[distanceInKm < dailyTargetInKm] [distanceInKm >= dailyTargetInKm]
  │                               │
  ▼                               ▼
return false                    return true
(Продолжаем поход 🥾)           (Цель достигнута! 🎉)
*/

struct FantasyHike {
    let stepCount: Double
    let dailyTargetInKm: Double
    
    var distanceInKm: Double {
        (stepCount * 0.7) / 1000
    }
    
    var remainingDistanceInKm: Double {
        dailyTargetInKm - distanceInKm
    }
    
    var isTargetAchieved: Bool {
        distanceInKm >= dailyTargetInKm
    }
}

func runDisplay() {
    let monday = FantasyHike(stepCount: 5000, dailyTargetInKm: 7.0)
    print("Result for current day: is Target Achieved? - \(monday.isTargetAchieved)") // Result for current day: is Target Achieved? - false
}
