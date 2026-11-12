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
    airTankMW.disconnect(CanisterAir(id: 4, oxygen: 80)) // если была подключе
}

/**
 ✅ OK! 💨 Oxygen: 350 units
 Stop! ❌ Valve rupture. Will be 750 units.
 ❌ Stop! 🛢️ Canister 1 already connected.
 ❌ 🛢️ Canister 3 not connected.
 ✅ OK! 💨 Oxygen: 100 units
 ❌ 🛢️ Canister 1 not connected.
 Program ended with exit code: 0
 ❌ 🛢️ Canister 4 not connected.
 */
/*
одна фраза -> весь синтаксис
 connect проверяет: id уже в массиве? → отказ; иначе считает candidate = current + oxygen; candidate > max? → отказ; иначе append(id) и current = candidate. disconnect — зеркально: id есть в массиве? → нет: отказ; иначе candidate = current - oxygen; candidate < min? → отказ; иначе removeAll(id) и current = candidate.

 Это и есть весь синтаксис: проверка наличия → расчёт → проверка границ → изменение состояния.
 
 [вызов]
    │
    ▼
 {проверка НАЛИЧИЯ в массиве}
    │ отказ ──────────────► return
    │ пропуск
    ▼
 [расчёт candidate]
    │
    ▼
 {проверка ГРАНИЦ}
    │ отказ ──────────────► return
    │ пропуск
    ▼
 [изменение состояния: массив + currentOxygen]
    │
    ▼
 [✅ print]
 
 [вызов connect]
    │
    ▼
 {contains(id)?}  ── ДА ──► ❌ return
    │ НЕТ
    ▼
 [candidate = current + oxygen]
    │
    ▼
 {candidate > max?} ── ДА ──► ❌ return
    │ НЕТ
    ▼
 [append(id); current = candidate]
    │
    ▼
 [✅ print]
 
 */


