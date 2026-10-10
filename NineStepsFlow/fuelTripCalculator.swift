//
//  fuelTripCalculator.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 10.10.2026.
//

import Foundation

// MARK: - 'Fuel Trip Calculator' - Simple
// TS: Krasnoyarsk-Belokurikha Road: Calculating the Distance to a Gas Station by Car

// MARK: - Engineering logic for this file:
// 1️⃣ Связка «Моделирование состояния» (Struct + Stored Properties через let)
//    Храним только жесткие, неизменяемые базовые данные автомобиля.
// 2️⃣ Связка «Динамическая аналитика» (Computed Properties через var)
//    Вычисляем остаток топлива и запас хода на лету, не забивая память.
// 3️⃣ Связка «Инкапсуляция логики» (Computed Property/Метод с входящим параметром)
//    Блок сам сопоставляет внутреннее состояние с внешним фактором (расстоянием) и принимает решение по правилу безопасности (запас 75 км).

struct Car {
    let tankVolume: Double // полный объем бака
    let averageFuelConsumption: Double
    let fuelSpent: Double // сколько литров потрачено
    
    var remainingFuel: Double {
        return tankVolume - fuelSpent
    }
    
    var possibleDistance: Double {
        return (remainingFuel / averageFuelConsumption) * 100
    }
    
    func canReachGasStation(distanceToGasStation: Double) -> Bool {
        
        if possibleDistance - distanceToGasStation >= 75 {
            return true
        } else {
            return false
        }
    }
}

func runCalculation() {
    let car = Car(tankVolume: 50, averageFuelConsumption: 8.5, fuelSpent: 21.5)
    let result = car.canReachGasStation(distanceToGasStation: 121.5)
    print("Result: \(result)") // Result: true
}

