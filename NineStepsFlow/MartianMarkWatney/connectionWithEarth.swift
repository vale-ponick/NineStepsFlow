//
//  connectionWithEarth.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 31.10.2026.
//

import Foundation

// MARK: - 5️⃣: «📡 Connection with the Earth»
// Mark Watney wants to contact Earth. He has a rover. The rover has an antenna. The antenna has a frequency (String?, for example, "437.5 MHz"). But anything could be missing: the rover is lost or broken (nil), the antenna is not installed (nil), the frequency is unknown (nil) - the sensor is silent. Task: get the frequency. If nil at any level - return default: "⚠️ no connection with Earth", if everything is present - return "📡 Frequency: 437.5 MHz"

struct Antenna {
    let frequency: String?
}
struct Rover {
    let antenna: Antenna?
}
struct MarkWatneyStatus {
    let rover: Rover?
}

func getFrequency(from mark: MarkWatneyStatus) -> String {
    if let freq = mark.rover?.antenna?.frequency {
        return "📡 Frequency: \(freq)"
    }
    return "⚠️ no connection with Earth"
}

func runMarkConnection() {
    let mark = MarkWatneyStatus(rover: Rover(antenna: Antenna(frequency: "437.5 MHz")))
    print(getFrequency(from: mark))
    
    let noRover = MarkWatneyStatus(rover: nil)
    print(getFrequency(from: noRover))

    let noAntenna = MarkWatneyStatus(rover: Rover(antenna: nil))
    print(getFrequency(from: noAntenna))

    let noFreq = MarkWatneyStatus(rover: Rover(antenna: Antenna(frequency: nil)))
    print(getFrequency(from: noFreq))

}

/**
 📡 Frequency: 437.5 MHz
 ⚠️ no connection with Earth
 ⚠️ no connection with Earth
 ⚠️ no connection with Earth
 Program ended with exit code: 0
 
 📌 Одна фраза — весь синтаксис
 «Функция принимает Марка. Идёт по цепочке ?. три уровня. Если всё есть — возвращает строку с частотой. Если где-то nil — возвращает строку ошибки.»
 */
