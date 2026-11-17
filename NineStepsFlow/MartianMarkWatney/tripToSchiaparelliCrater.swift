//
//  tripToSchiaparelliCrater.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 16.11.2026.
//

import Foundation

// MARK: - 'Mark Watney's trip to the Schiaparelli crater(sol 10)'
// 📖 Mark Watney is preparing the rover for a multi-day trek to Schiaparelli Crater (3,200 km), where the Ares 4 rocket awaits. This is the last chance to leave Mars. Mark plans the route in short, daytime hops (the distance in kilometers is recorded on the odometer, and each kilometer drains the battery). The rover is old, so the onboard computer strictly blocks any dangerous commands:

// Driving:
// You can't set zero or negative range or energy consumption, and you can't start a journey if the battery level drops below the emergency reserve (15%).

// Charging:
// Solar panels can't charge to zero or negative, and you can't recharge the battery above 100%.
// Cargo Compartment:
// The rover can hold a maximum of five pieces of equipment and rations (empty tracks and overloading are prohibited).
// Playlist:
// To avoid going crazy on the road, Mark sings out loud, but the system only allows you to add three unique songs (empty titles and repeats are blocked).

enum RoverError: LocalizedError {
    case batteryTooLow(charge: Int, required: Int) //  charge - cost < required
    case batteryFull(charge: Int, maxCharge: Int) //  charge + amount > maxCharge (overcharge) - can't recharge above 100%
    case notTwiceSameSong(song: String) // can't sing the same song twice - playlist.contains
    case songsFull(current: Int, maxSongs: Int) // playlist.count >= maxSongs
    case songEmpty // song is empty
    case cargoEmpty // cargo is empty
    case cargoFull(current: Int, maxCargo: Int)
    case distanceIncorrect(distance: Int) // <= 0
    case dischargeIncorrect(discharge: Int) // discharge <= 0
    case amountIncorrect(amount: Int) //  amount <= 0
    
    var errorDescription: String? {
        switch self {
        case .batteryTooLow(charge: let charge, required: let required):
            return "Заряда батареи ровера недостаточно: \(charge), необходимо: \(required)"
        case .batteryFull(charge: let charge, maxCharge: let maxCharge):
            return "Текущий заряд батареи ровера: \(charge), max заряд: \(maxCharge)"
        case .notTwiceSameSong(song: let song):
            return "Can't sing the same song twice: \(song)"
        case .songsFull(let current, let max):
            return "Playlist is full: three songs. Songs in playlist: \(current), max: \(max)"
        case .songEmpty:
            return "Song title is empty"
        case .cargoEmpty:
            return "Cargo item name is empty"
        case .cargoFull(current: let current, maxCargo: let max):
            return "Cargo is full: \(current)/\(max)"
        case .dischargeIncorrect(discharge: let discharge):
            return "Разряд батареи: \(discharge)"
        case .distanceIncorrect(distance: let distance):
            return "Дистанция некорректна <= 0: \(distance)"
        case .amountIncorrect(amount: let amount):
            return "Подзарядка батареи не может быть <= 0: \(amount)"
        }
    }
}

struct OldRover {
    var charge: Int = 100 // текущий заряд батареи
    let minCharge: Int = 15
    let maxCharge: Int = 100
    var odometer: Int = 0 // расчет пути в км до кратера
    let distanceToCrater: Int = 3200
    var cargo: [String] = [] // груз
    let maxCargo: Int = 5
    var playlist: [String] = []
    let maxSongs: Int = 3
    var daysInTrip: Int = 0
    
    var remainingDistance: Int {
        distanceToCrater - odometer
    }
    
    var averageDistancePerDay: Int {
        daysInTrip != 0 ? odometer / daysInTrip : 0
    }
    
    var canReachCrater: Bool {
        odometer >= distanceToCrater
    }
    
    mutating func drive(distance: Int, discharge: Int) throws {
        guard distance > 0 else {
            throw RoverError.distanceIncorrect(distance: distance)
        }
        guard discharge > 0 else {
            throw RoverError.dischargeIncorrect(discharge: discharge)
        }
        guard charge - discharge >= minCharge else { // проверь нехватку заряда батареи
            throw RoverError.batteryTooLow(charge: charge, required: minCharge + discharge)
        }
        charge -= discharge
        odometer += distance
        daysInTrip += 1
        print("Ок! Перегон успешен!")
    }
    
    mutating func recharge(amount: Int) throws { // проверь границы зарядки батареи
        guard amount > 0 else {
            throw RoverError.amountIncorrect(amount: amount)
        }
        guard charge + amount <= maxCharge else {
            throw RoverError.batteryFull(charge: charge, maxCharge: maxCharge)
        }
        charge += amount
        print("🔋 Ok!Батарея ровера успешно подзаряжена")
    }
    
    mutating func load(_ item: String) throws { // проверь груз
        guard !item.isEmpty else {
            throw RoverError.cargoEmpty
        }
        guard cargo.count < maxCargo else {
            throw RoverError.cargoFull(current: cargo.count, maxCargo: maxCargo)
        }
        cargo.append(item)
        print("📦 Груз ровера \(item) не превышает max допустимого: \(cargo.count)/\(maxCargo)")
    }
    
    mutating func sing(_ song: String) throws {
        guard !song.isEmpty else {
            throw RoverError.songEmpty
        }
        guard !playlist.contains(song) else {
            throw RoverError.notTwiceSameSong(song: song)
        }
        guard playlist.count < maxSongs else {
            throw RoverError.songsFull(current: playlist.count, maxSongs: maxSongs)
        }
        playlist.append(song)
        print("🎵 В плейлист добавлена новая песня: \(song)")
    }
    
    func report() -> String {
       let canReach = canReachCrater ? "🏆 МАРК ДОЕХАЛ ДО КРАТЕРА! 🚀🎵" : "no"
        return "Состояние батареи: \(charge), пройденный путь: \(odometer), в пути проведено дней: \(daysInTrip), количество груза: \(cargo.count), состояние плейлиста: \(playlist.count). Оставшаяся дистанция до кратера: \(remainingDistance), в день пройдено в среднем: \(averageDistancePerDay), сможет Марк Уотни достичь кратера Скиапарелли: \(canReach)."
    }
}
func getTripToSchiaparelliCrater() {
    var roverMW = OldRover()
    
    print(roverMW.report())
    
    do { try roverMW.drive(distance: 80, discharge: 12)
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try roverMW.drive(distance: 10, discharge: 20) }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try  roverMW.drive(distance: 0, discharge: -12)
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try  roverMW.drive(distance: 60, discharge: 55)
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try roverMW.recharge(amount: 0)
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try  roverMW.recharge(amount: -12)
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try roverMW.recharge(amount: 10) }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try  roverMW.load("")
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    do { try  roverMW.sing("")
    }
    catch { print("❌ \(error.localizedDescription)") }
    
    let songs: [String] = ["'Hot Stuff' - Donna Summer", "'I Will Survive' — Gloria Gaynor", "'Stayin' Alive' — Bee Gees", "'Starman' - David Bowie"]
    
    for song in songs {
        do { try  roverMW.sing(song)
        }
        catch { print("❌ \(error.localizedDescription)") }
    }
        
        do { try  roverMW.sing("'Hot Stuff' - Donna Summer")
    }
        catch { print("❌ \(error.localizedDescription)") }
        
        do { try  roverMW.recharge(amount: 88)
        }
        catch { print("❌ \(error.localizedDescription)") }
        
        do { try  roverMW.drive(distance: -2, discharge: 3)
        }
        catch { print("❌ \(error.localizedDescription)") }
        
        let items = ["RTG", "Solar panels", "Oxygenator", "Water reclaimer", "Potatoes", "Spare wheel"]
        for item in items {
            do { try  roverMW.load(item)
            }
            catch { print("❌ \(error.localizedDescription)") }
        }
        
        print(roverMW.report())
    
    var roverMarkWatney = OldRover()
    var attempts = 0
    let maxAttempts = 20

    while !roverMarkWatney.canReachCrater && attempts < maxAttempts {
        attempts += 1
        
        do {
            try roverMarkWatney.drive(distance: 400, discharge: 90)
        } catch RoverError.batteryTooLow(let charge, let required) {
            print("❌ Критический разряд: \(charge) из \(required) единиц. Миссия прервана.")
            break // Выходим из цикла только при этой конкретной ошибке
        } catch {
            print("❌ Иная ошибка движения: \(error.localizedDescription)")
            break
        }
        
        do {
            try roverMarkWatney.recharge(amount: 10)
        } catch {
            print("⚠️ Зарядка пропущена: \(error.localizedDescription)")
        }
    }

    print(roverMarkWatney.report())
    
    var roverMulti = OldRover()
    while !roverMulti.canReachCrater {
        do { try roverMulti.drive(distance: 400, discharge: 10) }
        catch { print("❌ \(error.localizedDescription)") }
        do { try roverMulti.recharge(amount: 10) }
        catch { print("❌ \(error.localizedDescription)") }
    }
    
    print(roverMulti.report())
}
/**
 Состояние батареи: 100, пройденный путь: 0, в пути проведено дней: 0, количество груза: 0, состояние плейлиста: 0. Оставшаяся дистанция до кратера: 3200, в день пройдено в среднем: 0, сможет Марк Уотни достичь кратера Скиапарелли: no.
 Ок! Перегон успешен!
 Ок! Перегон успешен!
 ❌ Дистанция некорректна <= 0: 0
 ❌ Заряда батареи ровера недостаточно: 68, необходимо: 70
 ❌ Подзарядка батареи не может быть <= 0: 0
 ❌ Подзарядка батареи не может быть <= 0: -12
 🔋 Ok!Батарея ровера успешно подзаряжена
 ❌ Cargo item name is empty
 ❌ Song title is empty
 🎵 В плейлист добавлена новая песня: 'Hot Stuff' - Donna Summer
 🎵 В плейлист добавлена новая песня: 'I Will Survive' — Gloria Gaynor
 🎵 В плейлист добавлена новая песня: 'Stayin' Alive' — Bee Gees
 ❌ Playlist is full: three songs. Songs in playlist: 3, max: 3
 ❌ Can't sing the same song twice: 'Hot Stuff' - Donna Summer
 ❌ Текущий заряд батареи ровера: 78, max заряд: 100
 ❌ Дистанция некорректна <= 0: -2
 📦 Груз ровера RTG не превышает max допустимого: 1/5
 📦 Груз ровера Solar panels не превышает max допустимого: 2/5
 📦 Груз ровера Oxygenator не превышает max допустимого: 3/5
 📦 Груз ровера Water reclaimer не превышает max допустимого: 4/5
 📦 Груз ровера Potatoes не превышает max допустимого: 5/5
 ❌ Cargo is full: 5/5
 Состояние батареи: 78, пройденный путь: 90, в пути проведено дней: 2, количество груза: 5, состояние плейлиста: 3. Оставшаяся дистанция до кратера: 3110, в день пройдено в среднем: 45, сможет Марк Уотни достичь кратера Скиапарелли: no.
 ❌ Критический разряд (100% из 105%). Миссия прервана.
 Состояние батареи: 100, пройденный путь: 0, в пути проведено дней: 0, количество груза: 0, состояние плейлиста: 0. Оставшаяся дистанция до кратера: 3200, в день пройдено в среднем: 0, сможет Марк Уотни достичь кратера Скиапарелли: no.
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Ок! Перегон успешен!
 🔋 Ok!Батарея ровера успешно подзаряжена
 Состояние батареи: 100, пройденный путь: 3200, в пути проведено дней: 8, количество груза: 0, состояние плейлиста: 0. Оставшаяся дистанция до кратера: 0, в день пройдено в среднем: 400, сможет Марк Уотни достичь кратера Скиапарелли: 🏆 МАРК ДОЕХАЛ ДО КРАТЕРА! 🚀🎵.
 Program ended with exit code: 0
 */
