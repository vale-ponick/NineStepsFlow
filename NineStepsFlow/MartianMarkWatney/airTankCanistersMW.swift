//
//  airTankCanistersMW.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 10.11.2026.
//

import Foundation

// MARK: - '🛢️💨 Инвентаризация в Hab (Сол 6)'
// Марк Уотни готовит скафандр к выходу. В шкафу у шлюза — кислородный баллон (AirTank), заряженный на 100 единиц. Рядом на полке стоят канистры с кислородом (Canister). У каждой — бирка с номером (id) и запас кислорода (oxygen).bМарк не помнит, что где. Он берёт канистры по одной и подключает их к баллону. В скафандре стоят предохранители: если суммарный запас превысит 600 — разорвёт клапан; если запас упадёт ниже 30 — Марк задохнётся. Марк торопится и путает канистры: может схватить уже подключённую или попытаться отключить отсутствующую. Поэтому программа Хаба ведёт учёт подключённых канистр и отказывает в бессмысленных действиях.

struct CanisterAir {
    let id: Int // unique number
    let oxygen: Int // volume air
}

struct SpacesuitTank { // spacesuit tank
    var currentOxygen: Int = 100 // current stock, variable
    
    static let maxSafeOxygen = 600 // upper limit
    static let minSafeOxygen = 30 // inner limit
    
    var connectedCanisters: [Int] = [] // array of ID's of connected canisters
    /** Что означает connectedCanisters: это свойство экземпляра структуры. Оно хранится в памяти компьютера, пока живёт значение SpasesuitTank, и не сбрасывается между вызовами методов. Именно в нём записано, какие канистры сейчас подключены. */
    
    mutating func connect(_ canister: CanisterAir) {
        
        guard !connectedCanisters.contains(canister.id) else { // 1. есть/нет?
            print("❌ Stop! 🛢️ Canister \(canister.id) already connected.")
            return
        }
        let candidate = currentOxygen + canister.oxygen // 2. расчет
        guard candidate <= Self.maxSafeOxygen else { // 3. границы
            print("Stop! ❌ Valve rupture. Will be \(candidate) units.")
            return
        }
        connectedCanisters.append(canister.id)
        currentOxygen = candidate
        print("✅ OK! 💨 Oxygen: \(currentOxygen) units")
    }
    
    mutating func disconnect(_ canister: CanisterAir) {
        guard connectedCanisters.contains(canister.id) else { // check: canister is?
            print("❌ 🛢️ Canister \(canister.id) not connected.")
            return
        }
        let candidate = currentOxygen - canister.oxygen
        guard candidate >= Self.minSafeOxygen else {
            print("❌ Mark Watney is gasping for air. Will be \(candidate) units")
            return
        }
        connectedCanisters.removeAll { $0 == canister.id }
        currentOxygen = candidate
        print("✅ OK! 💨 Oxygen: \(currentOxygen) units")
    }
}

func checkAirTankCanistersSupply() {
    var airTankMW = SpacesuitTank()
    airTankMW.connect(CanisterAir(id: 1, oxygen: 250))
    airTankMW.connect(CanisterAir(id: 2, oxygen: 400))
    airTankMW.connect(CanisterAir(id: 1, oxygen: 250))
    airTankMW.disconnect(CanisterAir(id: 3, oxygen: 100))
    airTankMW.disconnect(CanisterAir(id: 1, oxygen: 250))
    airTankMW.disconnect(CanisterAir(id: 1, oxygen: 250))
}

/**
 ✅ OK! 💨 Oxygen: 350 units
 Stop! ❌ Valve rupture. Will be 750 units.
 ❌ Stop! 🛢️ Canister 1 already connected.
 ❌ 🛢️ Canister 3 not connected.
 ✅ OK! 💨 Oxygen: 100 units
 ❌ 🛢️ Canister 1 not connected.
 Program ended with exit code: 0
 */
/** TS: 📋
3. Метод connect(_ canister: Canister)

1. Проверка 1: connectedCanisters.contains(canister.id) == true?
     → ❌ print("Stop! 🛢️ Canister \(id) already connected.")
     → return
2. candidate = currentOxygen + canister.oxygen
3. Проверка 2: candidate > maxSafeOxygen?
     → ❌ print("Stop! Valve rupture. Will be \(candidate) units.")
     → return
4. connectedCanisters.append(canister.id)
5. currentOxygen = candidate
6. ✅ print("OK! 💨 Oxygen: \(currentOxygen) units")
Смысл проверок:

Проверка 1 читает свойство connectedCanisters и сравнивает с canister.id. Если id уже есть — метод завершается до любого изменения состояния.

Проверка 2 сравнивает candidate с константой maxSafeOxygen. Если превышен — метод завершается до записи.

4. Метод disconnect(_ canister: Canister)
text
1. Проверка 1: connectedCanisters.contains(canister.id) == false?
     → ❌ print("Stop! 🛢️ Canister \(id) not connected.")
     → return
2. candidate = currentOxygen - canister.oxygen
3. Проверка 2: candidate < minSafeOxygen?
     → ❌ print("Stop! Mark is gasping for air. Will be \(candidate) units.")
     → return
4. connectedCanisters.removeAll { $0 == canister.id }
5. currentOxygen = candidate
6. ✅ print("OK! 💨 Oxygen: \(currentOxygen) units")
5. Правило атомарности
При любой ошибке свойства currentOxygen и connectedCanisters не изменяются. Ошибка — это return до строк, которые пишут в свойства.

6. Тест checkAirSupply()
text
var tank = AirTank()

tank.connect(Canister(id: 1, oxygen: 250))    // шаг 1
tank.connect(Canister(id: 2, oxygen: 400))    // шаг 2
tank.connect(Canister(id: 1, oxygen: 250))    // шаг 3
tank.disconnect(Canister(id: 3, oxygen: 100)) // шаг 4
tank.disconnect(Canister(id: 1, oxygen: 250)) // шаг 5
tank.disconnect(Canister(id: 1, oxygen: 250)) // шаг 6 */
