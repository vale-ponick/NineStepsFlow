//
//  temperatureInHab.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 30.10.2026.
//

import Foundation

// MARK: - 4️⃣: «🌡 Temperature in Hab»
// : Mark Watney lives in the Hub. The climate control system is working inside. The temperature sensor displays the current temperature in °C. But on Mars, it's -80°C at night and +20°C during the day. The system should return an error^ if the temperature in the living space goes beyond safe limits: <= -60°C — error (Mark Watney is  frozen), >= +30°C — danger (system overheating). Question: whenever the temperature rises, notify if it's critical. If normal, keep silent (or reliably quiet). Conclusion: normal → 🌡 20°C — normal < below -60 → ❄️ -80°C — CRITICAL! Cold! above +30 → 🔥 35°C — CRITICAL! Overheat!

enum TempState { // все ясно
    case normal
    case hot
    case cold
}

struct Hab {
    static let minTemp = -60
    static let maxTemp = 30
    
    var currentTemp: Int = 20 {
        didSet {
            switch state {
            case .normal:
                print("🌡 \(currentTemp)°C — normal for Mark Watney")
            case .hot:
                print("🔥 \(currentTemp)°C — Danger! Climate system will overheat!")
            case .cold:
                print("❄️ \(currentTemp)°C — Danger! Mark Watney will freeze...")
            }
        }
    }
    
    var state: TempState { // вычисляемое свойство
        if currentTemp <= Self.minTemp {
            return .cold
        } else if currentTemp >= Self.maxTemp {
            return .hot
        } else {
            return .normal
        }
    }
}

func runTempInHab() {
    var hab = Hab()
    hab.currentTemp = 21
    hab.currentTemp = 32
    hab.currentTemp = -66
    hab.currentTemp = 0
    
    print( hab.currentTemp)
}
/**
 🌡 21°C — normal for Mark Watney
 🔥 32°C — Danger! Climate system will overheat!
 ❄️ -66°C — Danger! Mark Watney will freeze...
 🌡 0°C — normal for Mark Watney

 Для didSet карточка-памятка:
 ┌─────────────────────────────┐
 │ didSet на X:                │
 │ 1. X — ОДНО свойство        │
 │ 2. Срабатывает на X = ...   │
 │    (не на init)             │
 │ 3. Внутри — реакция         │
 │    (print, switch, if)      │
 │ 4. НЕ внутри — X, state     │
 └─────────────────────────────┘
 Мелочь, которая поможет
 Пиши didSet последним. Сначала:
    enum
    struct + static let
    currentTemp (без didSet — просто var)
    state (computed)
    Только потом — didSet
 */
        
