//
//  lamp.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 03.11.2026.
//

import Foundation

// MARK: - '💡 Lamp'
// TS:📋 У лампы есть яркость (Int? — от 0 до 100, датчик может быть сломан). Метод toggle(): Состояние датчик broken  "📵 Sensor is broken", яркость 0    выключена → включить    brightness = 100, "💡 Light ON", brightness = 0, "🌑 Light OFF"

struct Lamp {
    static let maxBrightness = 100

    let name: String
    var brightness: Int?   // nil — sensor broken

    mutating func toggle() {
        guard let currentBrightness = brightness else {
            print("📵 Sensor is broken")
            return
        }
        if currentBrightness == 0 {
            print("💡 Light ON")
            brightness = Self.maxBrightness
            
        } else {
            print("🌑 Light OFF")
            brightness = 0
        }
    }
}

// MARK: - ✅ TESTS
func runLamp() {
    var off = Lamp(name: "Desk", brightness: 0)      // → 💡 Light ON, brightness = 100
    off.toggle()
    print("off.brightness after: \(off.brightness ?? 0)")
    var on = Lamp(name: "Desk", brightness: 50)      // → 🌑 Light OFF, brightness = 0
    on.toggle()
    print("on.brightness after: \(on.brightness ?? 0)")
    var broken = Lamp(name: "Desk", brightness: nil) // → 📵 Sensor is broken
    // После каждого вызова — проверь brightness (изменилось или нет).
    broken.toggle()
    print("broken.brightness after: \(String(describing: broken.brightness))")
}
/**
 💡 Light ON
 off.brightness after: 100
 🌑 Light OFF
 on.brightness after: 0
 📵 Sensor is broken
 broken.brightness after: nil
 Program ended with exit code: 0
 */




